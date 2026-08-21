return {
	Play420011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = 1.274527234522
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_4_10 = 0
			local var_4_11 = 0.2

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "music"

				arg_1_1:AudioAction(var_4_12, var_4_13, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = ""
				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_15 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 0.579204597510398
			local var_4_17 = 1

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_18 = "play"
				local var_4_19 = "music"

				arg_1_1:AudioAction(var_4_18, var_4_19, "bgm_activity_4_0_story_intro", "bgm_activity_4_0_story_intro", "bgm_activity_4_0_story_intro.awb")

				local var_4_20 = ""
				local var_4_21 = manager.audio:GetAudioName("bgm_activity_4_0_story_intro", "bgm_activity_4_0_story_intro")

				if var_4_21 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = manager.ui.mainCamera.transform
			local var_4_23 = 1.13333333333333

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				local var_4_24 = arg_1_1.var_.effect01
				local var_4_25
				local var_4_26 = var_4_22

				if not var_4_24 then
					var_4_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_4_26)
					var_4_24.name = "01"
					arg_1_1.var_.effect01 = var_4_24
				else
					var_4_24.transform:SetParent(var_4_26)
				end

				var_4_24.transform.localPosition = Vector3.New(0, 0, -0.1)
				var_4_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_27 = "ST0509"

			if arg_1_1.bgs_[var_4_27] == nil then
				local var_4_28 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_28:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_27)
				var_4_28.name = var_4_27
				var_4_28.transform.parent = arg_1_1.stage_.transform
				var_4_28.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_27] = var_4_28
			end

			local var_4_29 = arg_1_1.bgs_.ST0509.transform
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPosST0509 = var_4_29.localPosition
			end

			local var_4_31 = 0.1

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, 1, 10)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST0509, var_4_33, var_4_32)
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_34 = arg_1_1.bgs_.ST0509.transform
			local var_4_35 = 0.433333333333333

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.var_.moveOldPosST0509 = var_4_34.localPosition
			end

			local var_4_36 = 1.56666666666567

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_35) / var_4_36
				local var_4_38 = Vector3.New(0, 1, 8)

				var_4_34.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST0509, var_4_38, var_4_37)
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				var_4_34.localPosition = Vector3.New(0, 1, 8)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_39 = 1.999999999999
			local var_4_40 = 0.125

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_41 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_41:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_42 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_42

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

				local var_4_43 = arg_1_1:GetWordFromCfg(420011001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 5
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_40 or var_4_40 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_40 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_39 = var_4_39 + 0.3

					if var_4_47 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_39 + 0.3
			local var_4_49 = math.max(var_4_40, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.56666666666567,
				className = "StoryMoveNode",
				startTime = 0.433333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420011002
		arg_9_1.duration_ = 1.57

		local var_9_0 = {
			zh = 1.566,
			ja = 1
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
				arg_9_0:Play420011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = manager.ui.mainCamera.transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				local var_12_2 = arg_9_1.var_.effect01

				if var_12_2 then
					Object.Destroy(var_12_2)

					arg_9_1.var_.effect01 = nil
				end
			end

			local var_12_3 = 0
			local var_12_4 = 0.166666666666667

			if var_12_3 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_5 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_6 = arg_9_1:GetWordFromCfg(420011002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 3
				local var_12_9 = utf8.len(var_12_7)
				local var_12_10 = var_12_8 <= 0 and var_12_4 or var_12_4 * (var_12_9 / var_12_8)

				if var_12_10 > 0 and var_12_4 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011002", "story_v_out_420011.awb") ~= 0 then
					local var_12_11 = manager.audio:GetVoiceLength("story_v_out_420011", "420011002", "story_v_out_420011.awb") / 1000

					if var_12_11 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_11 + var_12_3
					end

					if var_12_6.prefab_name ~= "" and arg_9_1.actors_[var_12_6.prefab_name] ~= nil then
						local var_12_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_6.prefab_name].transform, "story_v_out_420011", "420011002", "story_v_out_420011.awb")

						arg_9_1:RecordAudio("420011002", var_12_12)
						arg_9_1:RecordAudio("420011002", var_12_12)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_420011", "420011002", "story_v_out_420011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_420011", "420011002", "story_v_out_420011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_13 and arg_9_1.time_ < var_12_3 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play420011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.9

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

				local var_16_2 = arg_13_1:GetWordFromCfg(420011003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 36
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
	Play420011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420011004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.725

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

				local var_20_2 = arg_17_1:GetWordFromCfg(420011004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 29
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
	Play420011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420011005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play420011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.85

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

				local var_24_2 = arg_21_1:GetWordFromCfg(420011005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 33
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
	Play420011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420011006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play420011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.925

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(420011006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 37
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play420011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.55

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(420011007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 22
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420011008
		arg_33_1.duration_ = 1.37

		local var_33_0 = {
			zh = 1.366,
			ja = 0.999999999999
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
				arg_33_0:Play420011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.075

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(420011008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011008", "story_v_out_420011.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_420011", "420011008", "story_v_out_420011.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_420011", "420011008", "story_v_out_420011.awb")

						arg_33_1:RecordAudio("420011008", var_36_9)
						arg_33_1:RecordAudio("420011008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420011", "420011008", "story_v_out_420011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420011", "420011008", "story_v_out_420011.awb")
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
	Play420011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play420011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.325

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

				local var_40_3 = arg_37_1:GetWordFromCfg(420011009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 13
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
	Play420011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420011010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play420011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.85

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

				local var_44_2 = arg_41_1:GetWordFromCfg(420011010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 34
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
	Play420011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420011011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play420011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.05
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_140", "se_story_140_footstep_run02", "")
			end

			local var_48_4 = 0.933333333333333
			local var_48_5 = 1

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				local var_48_6 = "play"
				local var_48_7 = "effect"

				arg_45_1:AudioAction(var_48_6, var_48_7, "ui_system", "sign_in", "")
			end

			local var_48_8 = 0
			local var_48_9 = 1.475

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(420011011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 59
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_9 or var_48_9 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_9 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_15 and arg_45_1.time_ < var_48_8 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420011012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play420011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.45

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(420011012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 18
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play420011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_1 = 0.2

			if arg_53_1.time_ >= var_56_0 + var_56_1 and arg_53_1.time_ < var_56_0 + var_56_1 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_2 = 0
			local var_56_3 = 0.2

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_4 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_4

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

				local var_56_5 = arg_53_1:GetWordFromCfg(420011013)
				local var_56_6 = arg_53_1:FormatText(var_56_5.content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 2
				local var_56_8 = utf8.len(var_56_6)
				local var_56_9 = var_56_7 <= 0 and var_56_3 or var_56_3 * (var_56_8 / var_56_7)

				if var_56_9 > 0 and var_56_3 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play420011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play420011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.1

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(420011014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 44
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play420011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420011015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play420011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.175

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

				local var_64_3 = arg_61_1:GetWordFromCfg(420011015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 7
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
	Play420011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 420011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play420011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.825

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(420011016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 33
				local var_68_5 = utf8.len(var_68_3)
				local var_68_6 = var_68_4 <= 0 and var_68_1 or var_68_1 * (var_68_5 / var_68_4)

				if var_68_6 > 0 and var_68_1 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_7 and arg_65_1.time_ < var_68_0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play420011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 420011017
		arg_69_1.duration_ = 7

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play420011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_1 = 2

			if arg_69_1.time_ >= var_72_0 + var_72_1 and arg_69_1.time_ < var_72_0 + var_72_1 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_2 = 0
			local var_72_3 = 0.2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_4 = "play"
				local var_72_5 = "music"

				arg_69_1:AudioAction(var_72_4, var_72_5, "ui_battle", "ui_battle_stopbgm", "")

				local var_72_6 = ""
				local var_72_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_72_7 ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_7 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_7

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_7
						arg_69_1.bgmTxt2_.text = var_72_7
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_72_8 = arg_69_1.bgs_.ST0509.transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPosST0509 = var_72_8.localPosition
			end

			local var_72_10 = 0.1

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10
				local var_72_12 = Vector3.New(0, 1, 8)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPosST0509, var_72_12, var_72_11)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, 1, 8)
			end

			local var_72_13 = arg_69_1.bgs_.ST0509.transform
			local var_72_14 = 0.233333333333333

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.var_.moveOldPosST0509 = var_72_13.localPosition
			end

			local var_72_15 = 0.333333333333333

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 then
				local var_72_16 = (arg_69_1.time_ - var_72_14) / var_72_15
				local var_72_17 = Vector3.New(3, 1, 6)

				var_72_13.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPosST0509, var_72_17, var_72_16)
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 then
				var_72_13.localPosition = Vector3.New(3, 1, 6)
			end

			local var_72_18 = arg_69_1.bgs_.ST0509.transform
			local var_72_19 = 0.733333333333333

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1.var_.moveOldPosST0509 = var_72_18.localPosition
			end

			local var_72_20 = 0.333333333333333

			if var_72_19 <= arg_69_1.time_ and arg_69_1.time_ < var_72_19 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_19) / var_72_20
				local var_72_22 = Vector3.New(-1, 1, 6)

				var_72_18.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPosST0509, var_72_22, var_72_21)
			end

			if arg_69_1.time_ >= var_72_19 + var_72_20 and arg_69_1.time_ < var_72_19 + var_72_20 + arg_72_0 then
				var_72_18.localPosition = Vector3.New(-1, 1, 6)
			end

			local var_72_23 = arg_69_1.bgs_.ST0509.transform
			local var_72_24 = 1.16666666666667

			if var_72_24 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				arg_69_1.var_.moveOldPosST0509 = var_72_23.localPosition
			end

			local var_72_25 = 0.0666666666666667

			if var_72_24 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_25 then
				local var_72_26 = (arg_69_1.time_ - var_72_24) / var_72_25
				local var_72_27 = Vector3.New(0.5, 1, 6)

				var_72_23.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPosST0509, var_72_27, var_72_26)
			end

			if arg_69_1.time_ >= var_72_24 + var_72_25 and arg_69_1.time_ < var_72_24 + var_72_25 + arg_72_0 then
				var_72_23.localPosition = Vector3.New(0.5, 1, 6)
			end

			local var_72_28 = 2
			local var_72_29 = 0.366666666666667

			if var_72_28 < arg_69_1.time_ and arg_69_1.time_ <= var_72_28 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_30 = arg_69_1:GetWordFromCfg(420011017)
				local var_72_31 = arg_69_1:FormatText(var_72_30.content)

				arg_69_1.text_.text = var_72_31

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_32 = 13
				local var_72_33 = utf8.len(var_72_31)
				local var_72_34 = var_72_32 <= 0 and var_72_29 or var_72_29 * (var_72_33 / var_72_32)

				if var_72_34 > 0 and var_72_29 < var_72_34 then
					arg_69_1.talkMaxDuration = var_72_34

					if var_72_34 + var_72_28 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_34 + var_72_28
					end
				end

				arg_69_1.text_.text = var_72_31
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_35 = math.max(var_72_29, arg_69_1.talkMaxDuration)

			if var_72_28 <= arg_69_1.time_ and arg_69_1.time_ < var_72_28 + var_72_35 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_28) / var_72_35

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_28 + var_72_35 and arg_69_1.time_ < var_72_28 + var_72_35 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0.233333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play420011018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 420011018
		arg_74_1.duration_ = 4

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play420011019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "STblack"

			if arg_74_1.bgs_[var_77_0] == nil then
				local var_77_1 = Object.Instantiate(arg_74_1.paintGo_)

				var_77_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_77_0)
				var_77_1.name = var_77_0
				var_77_1.transform.parent = arg_74_1.stage_.transform
				var_77_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.bgs_[var_77_0] = var_77_1
			end

			local var_77_2 = 0

			if var_77_2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				local var_77_3 = manager.ui.mainCamera.transform.localPosition
				local var_77_4 = Vector3.New(0, 0, 10) + Vector3.New(var_77_3.x, var_77_3.y, 0)
				local var_77_5 = arg_74_1.bgs_.STblack

				var_77_5.transform.localPosition = var_77_4
				var_77_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_6 = var_77_5:GetComponent("SpriteRenderer")

				if var_77_6 and var_77_6.sprite then
					local var_77_7 = (var_77_5.transform.localPosition - var_77_3).z
					local var_77_8 = manager.ui.mainCameraCom_
					local var_77_9 = 2 * var_77_7 * Mathf.Tan(var_77_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_77_10 = var_77_9 * var_77_8.aspect
					local var_77_11 = var_77_6.sprite.bounds.size.x
					local var_77_12 = var_77_6.sprite.bounds.size.y
					local var_77_13 = var_77_10 / var_77_11
					local var_77_14 = var_77_9 / var_77_12
					local var_77_15 = var_77_14 < var_77_13 and var_77_13 or var_77_14

					var_77_5.transform.localScale = Vector3.New(var_77_15, var_77_15, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "STblack" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_17 = 2

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_17 then
				local var_77_18 = (arg_74_1.time_ - var_77_16) / var_77_17
				local var_77_19 = Color.New(0, 0, 0)

				var_77_19.a = Mathf.Lerp(1, 0, var_77_18)
				arg_74_1.mask_.color = var_77_19
			end

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 then
				local var_77_20 = Color.New(0, 0, 0)
				local var_77_21 = 0

				arg_74_1.mask_.enabled = false
				var_77_20.a = var_77_21
				arg_74_1.mask_.color = var_77_20
			end

			local var_77_22 = 0

			if var_77_22 < arg_74_1.time_ and arg_74_1.time_ <= var_77_22 + arg_77_0 then
				arg_74_1.cswbg_:SetActive(true)

				local var_77_23 = arg_74_1.cswt_:GetComponent("RectTransform")

				arg_74_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_77_23.offsetMin = Vector2.New(0, 0)
				var_77_23.offsetMax = Vector2.New(0, 130)

				local var_77_24 = arg_74_1:GetWordFromCfg(419138)
				local var_77_25 = arg_74_1:FormatText(var_77_24.content)

				arg_74_1.cswt_.text = var_77_25

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.cswt_)

				arg_74_1.cswt_.fontSize = 120
				arg_74_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_74_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_74_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_77_26 = 0

			if var_77_26 < arg_74_1.time_ and arg_74_1.time_ <= var_77_26 + arg_77_0 then
				arg_74_1.fswbg_:SetActive(true)
				arg_74_1.dialog_:SetActive(false)

				arg_74_1.fswtw_.percent = 0

				local var_77_27 = arg_74_1:GetWordFromCfg(420011018)
				local var_77_28 = arg_74_1:FormatText(var_77_27.content)

				arg_74_1.fswt_.text = var_77_28

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.fswt_)

				arg_74_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_74_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_74_1.fswtw_:SetDirty()

				arg_74_1.typewritterCharCountI18N = 0

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_29 = 1

			if var_77_29 < arg_74_1.time_ and arg_74_1.time_ <= var_77_29 + arg_77_0 then
				arg_74_1.var_.oldValueTypewriter = arg_74_1.fswtw_.percent

				SetActive(arg_74_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_74_1:ShowNextGo(false)
			end

			local var_77_30 = 10
			local var_77_31 = 0.666666666666667
			local var_77_32 = arg_74_1:GetWordFromCfg(420011018)
			local var_77_33 = arg_74_1:FormatText(var_77_32.content)
			local var_77_34, var_77_35 = arg_74_1:GetPercentByPara(var_77_33, 1)

			if var_77_29 < arg_74_1.time_ and arg_74_1.time_ <= var_77_29 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				local var_77_36 = var_77_30 <= 0 and var_77_31 or var_77_31 * ((var_77_35 - arg_74_1.typewritterCharCountI18N) / var_77_30)

				if var_77_36 > 0 and var_77_31 < var_77_36 then
					arg_74_1.talkMaxDuration = var_77_36

					if var_77_36 + var_77_29 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_36 + var_77_29
					end
				end
			end

			local var_77_37 = 0.666666666666667
			local var_77_38 = math.max(var_77_37, arg_74_1.talkMaxDuration)

			if var_77_29 <= arg_74_1.time_ and arg_74_1.time_ < var_77_29 + var_77_38 then
				local var_77_39 = (arg_74_1.time_ - var_77_29) / var_77_38

				arg_74_1.fswtw_.percent = Mathf.Lerp(arg_74_1.var_.oldValueTypewriter, var_77_34, var_77_39)
				arg_74_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_74_1.fswtw_:SetDirty()
			end

			if arg_74_1.time_ >= var_77_29 + var_77_38 and arg_74_1.time_ < var_77_29 + var_77_38 + arg_77_0 then
				arg_74_1.fswtw_.percent = var_77_34

				arg_74_1.fswtw_:SetDirty()
				arg_74_1:ShowNextGo(true)

				arg_74_1.typewritterCharCountI18N = var_77_35
			end

			local var_77_40 = 0

			if var_77_40 < arg_74_1.time_ and arg_74_1.time_ <= var_77_40 + arg_77_0 then
				local var_77_41 = arg_74_1.fswbg_.transform:Find("textbox/adapt/content") or arg_74_1.fswbg_.transform:Find("textbox/content")
				local var_77_42 = arg_74_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_77_43 = var_77_41:GetComponent("Text")
				local var_77_44 = var_77_41:GetComponent("RectTransform")

				var_77_43.alignment = UnityEngine.TextAnchor.LowerCenter
				var_77_44.offsetMin = Vector2.New(0, -70)
				var_77_44.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play420011019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 420011019
		arg_78_1.duration_ = 3.85

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play420011020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_1 = manager.ui.mainCamera.transform.localPosition
				local var_81_2 = Vector3.New(0, 0, 10) + Vector3.New(var_81_1.x, var_81_1.y, 0)
				local var_81_3 = arg_78_1.bgs_.STblack

				var_81_3.transform.localPosition = var_81_2
				var_81_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_4 = var_81_3:GetComponent("SpriteRenderer")

				if var_81_4 and var_81_4.sprite then
					local var_81_5 = (var_81_3.transform.localPosition - var_81_1).z
					local var_81_6 = manager.ui.mainCameraCom_
					local var_81_7 = 2 * var_81_5 * Mathf.Tan(var_81_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_8 = var_81_7 * var_81_6.aspect
					local var_81_9 = var_81_4.sprite.bounds.size.x
					local var_81_10 = var_81_4.sprite.bounds.size.y
					local var_81_11 = var_81_8 / var_81_9
					local var_81_12 = var_81_7 / var_81_10
					local var_81_13 = var_81_12 < var_81_11 and var_81_11 or var_81_12

					var_81_3.transform.localScale = Vector3.New(var_81_13, var_81_13, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "STblack" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_15 = 1

			if var_81_14 <= arg_78_1.time_ and arg_78_1.time_ < var_81_14 + var_81_15 then
				local var_81_16 = (arg_78_1.time_ - var_81_14) / var_81_15
				local var_81_17 = Color.New(0, 0, 0)

				var_81_17.a = Mathf.Lerp(1, 0, var_81_16)
				arg_78_1.mask_.color = var_81_17
			end

			if arg_78_1.time_ >= var_81_14 + var_81_15 and arg_78_1.time_ < var_81_14 + var_81_15 + arg_81_0 then
				local var_81_18 = Color.New(0, 0, 0)
				local var_81_19 = 0

				arg_78_1.mask_.enabled = false
				var_81_18.a = var_81_19
				arg_78_1.mask_.color = var_81_18
			end

			local var_81_20 = 1.11022302462516e-16

			if var_81_20 < arg_78_1.time_ and arg_78_1.time_ <= var_81_20 + arg_81_0 then
				arg_78_1.fswbg_:SetActive(true)
				arg_78_1.dialog_:SetActive(false)

				arg_78_1.fswtw_.percent = 0

				local var_81_21 = arg_78_1:GetWordFromCfg(420011019)
				local var_81_22 = arg_78_1:FormatText(var_81_21.content)

				arg_78_1.fswt_.text = var_81_22

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.fswt_)

				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_78_1.fswtw_:SetDirty()

				arg_78_1.typewritterCharCountI18N = 0

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_23 = 0.733333333333333

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.var_.oldValueTypewriter = arg_78_1.fswtw_.percent

				SetActive(arg_78_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_78_1:ShowNextGo(false)
			end

			local var_81_24 = 34
			local var_81_25 = 2.26666666666667
			local var_81_26 = arg_78_1:GetWordFromCfg(420011019)
			local var_81_27 = arg_78_1:FormatText(var_81_26.content)
			local var_81_28, var_81_29 = arg_78_1:GetPercentByPara(var_81_27, 1)

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				local var_81_30 = var_81_24 <= 0 and var_81_25 or var_81_25 * ((var_81_29 - arg_78_1.typewritterCharCountI18N) / var_81_24)

				if var_81_30 > 0 and var_81_25 < var_81_30 then
					arg_78_1.talkMaxDuration = var_81_30

					if var_81_30 + var_81_23 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_30 + var_81_23
					end
				end
			end

			local var_81_31 = 2.26666666666667
			local var_81_32 = math.max(var_81_31, arg_78_1.talkMaxDuration)

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_32 then
				local var_81_33 = (arg_78_1.time_ - var_81_23) / var_81_32

				arg_78_1.fswtw_.percent = Mathf.Lerp(arg_78_1.var_.oldValueTypewriter, var_81_28, var_81_33)
				arg_78_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_78_1.fswtw_:SetDirty()
			end

			if arg_78_1.time_ >= var_81_23 + var_81_32 and arg_78_1.time_ < var_81_23 + var_81_32 + arg_81_0 then
				arg_78_1.fswtw_.percent = var_81_28

				arg_78_1.fswtw_:SetDirty()
				arg_78_1:ShowNextGo(true)

				arg_78_1.typewritterCharCountI18N = var_81_29
			end

			local var_81_34 = 0

			if var_81_34 < arg_78_1.time_ and arg_78_1.time_ <= var_81_34 + arg_81_0 then
				arg_78_1.cswbg_:SetActive(false)
			end

			local var_81_35 = 0.733333333333333
			local var_81_36 = 1

			if var_81_35 < arg_78_1.time_ and arg_78_1.time_ <= var_81_35 + arg_81_0 then
				local var_81_37 = "play"
				local var_81_38 = "effect"

				arg_78_1:AudioAction(var_81_37, var_81_38, "se_story_140", "se_story_140_door", "")
			end

			local var_81_39 = 0

			if var_81_39 < arg_78_1.time_ and arg_78_1.time_ <= var_81_39 + arg_81_0 then
				local var_81_40 = arg_78_1.fswbg_.transform:Find("textbox/adapt/content") or arg_78_1.fswbg_.transform:Find("textbox/content")
				local var_81_41 = arg_78_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_81_42 = var_81_40:GetComponent("Text")
				local var_81_43 = var_81_40:GetComponent("RectTransform")

				var_81_42.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_81_43.offsetMin = Vector2.New(0, -70)
				var_81_43.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play420011020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 420011020
		arg_82_1.duration_ = 7

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play420011021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "ST67"

			if arg_82_1.bgs_[var_85_0] == nil then
				local var_85_1 = Object.Instantiate(arg_82_1.paintGo_)

				var_85_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_85_0)
				var_85_1.name = var_85_0
				var_85_1.transform.parent = arg_82_1.stage_.transform
				var_85_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.bgs_[var_85_0] = var_85_1
			end

			local var_85_2 = 0

			if var_85_2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				local var_85_3 = manager.ui.mainCamera.transform.localPosition
				local var_85_4 = Vector3.New(0, 0, 10) + Vector3.New(var_85_3.x, var_85_3.y, 0)
				local var_85_5 = arg_82_1.bgs_.ST67

				var_85_5.transform.localPosition = var_85_4
				var_85_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_85_6 = var_85_5:GetComponent("SpriteRenderer")

				if var_85_6 and var_85_6.sprite then
					local var_85_7 = (var_85_5.transform.localPosition - var_85_3).z
					local var_85_8 = manager.ui.mainCameraCom_
					local var_85_9 = 2 * var_85_7 * Mathf.Tan(var_85_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_85_10 = var_85_9 * var_85_8.aspect
					local var_85_11 = var_85_6.sprite.bounds.size.x
					local var_85_12 = var_85_6.sprite.bounds.size.y
					local var_85_13 = var_85_10 / var_85_11
					local var_85_14 = var_85_9 / var_85_12
					local var_85_15 = var_85_14 < var_85_13 and var_85_13 or var_85_14

					var_85_5.transform.localScale = Vector3.New(var_85_15, var_85_15, 0)
				end

				for iter_85_0, iter_85_1 in pairs(arg_82_1.bgs_) do
					if iter_85_0 ~= "ST67" then
						iter_85_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_85_16 = 2

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			local var_85_17 = 0.466666666666667

			if arg_82_1.time_ >= var_85_16 + var_85_17 and arg_82_1.time_ < var_85_16 + var_85_17 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_18 = 0

			if var_85_18 < arg_82_1.time_ and arg_82_1.time_ <= var_85_18 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_19 = 2

			if var_85_18 <= arg_82_1.time_ and arg_82_1.time_ < var_85_18 + var_85_19 then
				local var_85_20 = (arg_82_1.time_ - var_85_18) / var_85_19
				local var_85_21 = Color.New(0, 0, 0)

				var_85_21.a = Mathf.Lerp(1, 0, var_85_20)
				arg_82_1.mask_.color = var_85_21
			end

			if arg_82_1.time_ >= var_85_18 + var_85_19 and arg_82_1.time_ < var_85_18 + var_85_19 + arg_85_0 then
				local var_85_22 = Color.New(0, 0, 0)
				local var_85_23 = 0

				arg_82_1.mask_.enabled = false
				var_85_22.a = var_85_23
				arg_82_1.mask_.color = var_85_22
			end

			local var_85_24 = 0

			if var_85_24 < arg_82_1.time_ and arg_82_1.time_ <= var_85_24 + arg_85_0 then
				arg_82_1.fswbg_:SetActive(false)
				arg_82_1.dialog_:SetActive(false)
				SetActive(arg_82_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_82_1:ShowNextGo(false)
			end

			local var_85_25 = 0

			if var_85_25 < arg_82_1.time_ and arg_82_1.time_ <= var_85_25 + arg_85_0 then
				arg_82_1.cswbg_:SetActive(false)
			end

			local var_85_26 = 0.05
			local var_85_27 = 1

			if var_85_26 < arg_82_1.time_ and arg_82_1.time_ <= var_85_26 + arg_85_0 then
				local var_85_28 = "play"
				local var_85_29 = "effect"

				arg_82_1:AudioAction(var_85_28, var_85_29, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_85_30 = 2.56666666666667
			local var_85_31 = 1

			if var_85_30 < arg_82_1.time_ and arg_82_1.time_ <= var_85_30 + arg_85_0 then
				local var_85_32 = "play"
				local var_85_33 = "effect"

				arg_82_1:AudioAction(var_85_32, var_85_33, "se_story_140", "se_story_140_foley_situp", "")
			end

			local var_85_34 = manager.ui.mainCamera.transform
			local var_85_35 = 1.4

			if var_85_35 < arg_82_1.time_ and arg_82_1.time_ <= var_85_35 + arg_85_0 then
				arg_82_1.var_.shakeOldPos = var_85_34.localPosition
			end

			local var_85_36 = 0.833333333333333

			if var_85_35 <= arg_82_1.time_ and arg_82_1.time_ < var_85_35 + var_85_36 then
				local var_85_37 = (arg_82_1.time_ - var_85_35) / 0.066
				local var_85_38, var_85_39 = math.modf(var_85_37)

				var_85_34.localPosition = Vector3.New(var_85_39 * 0.13, var_85_39 * 0.13, var_85_39 * 0.13) + arg_82_1.var_.shakeOldPos
			end

			if arg_82_1.time_ >= var_85_35 + var_85_36 and arg_82_1.time_ < var_85_35 + var_85_36 + arg_85_0 then
				var_85_34.localPosition = arg_82_1.var_.shakeOldPos
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_40 = 2
			local var_85_41 = 1.3

			if var_85_40 < arg_82_1.time_ and arg_82_1.time_ <= var_85_40 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_42 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_42:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_43 = arg_82_1:GetWordFromCfg(420011020)
				local var_85_44 = arg_82_1:FormatText(var_85_43.content)

				arg_82_1.text_.text = var_85_44

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_45 = 52
				local var_85_46 = utf8.len(var_85_44)
				local var_85_47 = var_85_45 <= 0 and var_85_41 or var_85_41 * (var_85_46 / var_85_45)

				if var_85_47 > 0 and var_85_41 < var_85_47 then
					arg_82_1.talkMaxDuration = var_85_47
					var_85_40 = var_85_40 + 0.3

					if var_85_47 + var_85_40 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_47 + var_85_40
					end
				end

				arg_82_1.text_.text = var_85_44
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_48 = var_85_40 + 0.3
			local var_85_49 = math.max(var_85_41, arg_82_1.talkMaxDuration)

			if var_85_48 <= arg_82_1.time_ and arg_82_1.time_ < var_85_48 + var_85_49 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_48) / var_85_49

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_48 + var_85_49 and arg_82_1.time_ < var_85_48 + var_85_49 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play420011021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 420011021
		arg_88_1.duration_ = 2

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play420011022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "1061ui_story"

			if arg_88_1.actors_[var_91_0] == nil then
				local var_91_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_91_1) then
					local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_88_1.stage_.transform)

					var_91_2.name = var_91_0
					var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_0] = var_91_2

					local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

					var_91_3.enabled = true

					local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

					if var_91_4 then
						var_91_4:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_3.transform, false)

					arg_88_1.var_[var_91_0 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_0 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_0 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_5 = arg_88_1.actors_["1061ui_story"].transform
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.var_.moveOldPos1061ui_story = var_91_5.localPosition

				local var_91_7 = "1061ui_story"

				arg_88_1:ShowWeapon(arg_88_1.var_[var_91_7 .. "Animator"].transform, false)
			end

			local var_91_8 = 0.001

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_8 then
				local var_91_9 = (arg_88_1.time_ - var_91_6) / var_91_8
				local var_91_10 = Vector3.New(0, -1.18, -6.15)

				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1061ui_story, var_91_10, var_91_9)

				local var_91_11 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_11.x, var_91_11.y, var_91_11.z)

				local var_91_12 = var_91_5.localEulerAngles

				var_91_12.z = 0
				var_91_12.x = 0
				var_91_5.localEulerAngles = var_91_12
			end

			if arg_88_1.time_ >= var_91_6 + var_91_8 and arg_88_1.time_ < var_91_6 + var_91_8 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_91_13 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_13.x, var_91_13.y, var_91_13.z)

				local var_91_14 = var_91_5.localEulerAngles

				var_91_14.z = 0
				var_91_14.x = 0
				var_91_5.localEulerAngles = var_91_14
			end

			local var_91_15 = arg_88_1.actors_["1061ui_story"]
			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 and not isNil(var_91_15) and arg_88_1.var_.characterEffect1061ui_story == nil then
				arg_88_1.var_.characterEffect1061ui_story = var_91_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_17 = 0.200000002980232

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_17 and not isNil(var_91_15) then
				local var_91_18 = (arg_88_1.time_ - var_91_16) / var_91_17

				if arg_88_1.var_.characterEffect1061ui_story and not isNil(var_91_15) then
					arg_88_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 and not isNil(var_91_15) and arg_88_1.var_.characterEffect1061ui_story then
				arg_88_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_20 = 0

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_91_21 = 0
			local var_91_22 = 0.2

			if var_91_21 < arg_88_1.time_ and arg_88_1.time_ <= var_91_21 + arg_91_0 then
				local var_91_23 = "play"
				local var_91_24 = "music"

				arg_88_1:AudioAction(var_91_23, var_91_24, "ui_battle", "ui_battle_stopbgm", "")

				local var_91_25 = ""
				local var_91_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_91_26 ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_26 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_26

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_26
						arg_88_1.bgmTxt2_.text = var_91_26
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_91_27 = 0.333333333333333
			local var_91_28 = 1

			if var_91_27 < arg_88_1.time_ and arg_88_1.time_ <= var_91_27 + arg_91_0 then
				local var_91_29 = "play"
				local var_91_30 = "music"

				arg_88_1:AudioAction(var_91_29, var_91_30, "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab.awb")

				local var_91_31 = ""
				local var_91_32 = manager.audio:GetAudioName("bgm_activity_4_0_story_lab", "bgm_activity_4_0_story_lab")

				if var_91_32 ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_32 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_32

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_32
						arg_88_1.bgmTxt2_.text = var_91_32
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_91_33 = 0
			local var_91_34 = 0.125

			if var_91_33 < arg_88_1.time_ and arg_88_1.time_ <= var_91_33 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_35 = arg_88_1:FormatText(StoryNameCfg[612].name)

				arg_88_1.leftNameTxt_.text = var_91_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_36 = arg_88_1:GetWordFromCfg(420011021)
				local var_91_37 = arg_88_1:FormatText(var_91_36.content)

				arg_88_1.text_.text = var_91_37

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_38 = 5
				local var_91_39 = utf8.len(var_91_37)
				local var_91_40 = var_91_38 <= 0 and var_91_34 or var_91_34 * (var_91_39 / var_91_38)

				if var_91_40 > 0 and var_91_34 < var_91_40 then
					arg_88_1.talkMaxDuration = var_91_40

					if var_91_40 + var_91_33 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_40 + var_91_33
					end
				end

				arg_88_1.text_.text = var_91_37
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011021", "story_v_out_420011.awb") ~= 0 then
					local var_91_41 = manager.audio:GetVoiceLength("story_v_out_420011", "420011021", "story_v_out_420011.awb") / 1000

					if var_91_41 + var_91_33 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_41 + var_91_33
					end

					if var_91_36.prefab_name ~= "" and arg_88_1.actors_[var_91_36.prefab_name] ~= nil then
						local var_91_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_36.prefab_name].transform, "story_v_out_420011", "420011021", "story_v_out_420011.awb")

						arg_88_1:RecordAudio("420011021", var_91_42)
						arg_88_1:RecordAudio("420011021", var_91_42)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_420011", "420011021", "story_v_out_420011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_420011", "420011021", "story_v_out_420011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_43 = math.max(var_91_34, arg_88_1.talkMaxDuration)

			if var_91_33 <= arg_88_1.time_ and arg_88_1.time_ < var_91_33 + var_91_43 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_33) / var_91_43

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_33 + var_91_43 and arg_88_1.time_ < var_91_33 + var_91_43 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play420011022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 420011022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play420011023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1061ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1061ui_story == nil then
				arg_94_1.var_.characterEffect1061ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.0166666666666667

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1061ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1061ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1061ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1061ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.85

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(420011022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 34
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play420011023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 420011023
		arg_98_1.duration_ = 5.03

		local var_98_0 = {
			zh = 3.033,
			ja = 5.033
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
				arg_98_0:Play420011024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1061ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1061ui_story == nil then
				arg_98_1.var_.characterEffect1061ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1061ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1061ui_story then
				arg_98_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_101_4 = 0
			local var_101_5 = 0.375

			if var_101_4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_6 = arg_98_1:FormatText(StoryNameCfg[612].name)

				arg_98_1.leftNameTxt_.text = var_101_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:GetWordFromCfg(420011023)
				local var_101_8 = arg_98_1:FormatText(var_101_7.content)

				arg_98_1.text_.text = var_101_8

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 15
				local var_101_10 = utf8.len(var_101_8)
				local var_101_11 = var_101_9 <= 0 and var_101_5 or var_101_5 * (var_101_10 / var_101_9)

				if var_101_11 > 0 and var_101_5 < var_101_11 then
					arg_98_1.talkMaxDuration = var_101_11

					if var_101_11 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_11 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_8
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011023", "story_v_out_420011.awb") ~= 0 then
					local var_101_12 = manager.audio:GetVoiceLength("story_v_out_420011", "420011023", "story_v_out_420011.awb") / 1000

					if var_101_12 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_4
					end

					if var_101_7.prefab_name ~= "" and arg_98_1.actors_[var_101_7.prefab_name] ~= nil then
						local var_101_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_7.prefab_name].transform, "story_v_out_420011", "420011023", "story_v_out_420011.awb")

						arg_98_1:RecordAudio("420011023", var_101_13)
						arg_98_1:RecordAudio("420011023", var_101_13)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_420011", "420011023", "story_v_out_420011.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_420011", "420011023", "story_v_out_420011.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_14 and arg_98_1.time_ < var_101_4 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play420011024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420011024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play420011025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1061ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.0666666666666667

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1061ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1061ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1061ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 1.15

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_9 = arg_102_1:GetWordFromCfg(420011024)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 46
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play420011025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420011025
		arg_106_1.duration_ = 2.2

		local var_106_0 = {
			zh = 2.066,
			ja = 2.2
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
				arg_106_0:Play420011026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1061ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_109_4 = 0
			local var_109_5 = 0.325

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_6 = arg_106_1:FormatText(StoryNameCfg[612].name)

				arg_106_1.leftNameTxt_.text = var_109_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(420011025)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 13
				local var_109_10 = utf8.len(var_109_8)
				local var_109_11 = var_109_9 <= 0 and var_109_5 or var_109_5 * (var_109_10 / var_109_9)

				if var_109_11 > 0 and var_109_5 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011025", "story_v_out_420011.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_420011", "420011025", "story_v_out_420011.awb") / 1000

					if var_109_12 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_4
					end

					if var_109_7.prefab_name ~= "" and arg_106_1.actors_[var_109_7.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_7.prefab_name].transform, "story_v_out_420011", "420011025", "story_v_out_420011.awb")

						arg_106_1:RecordAudio("420011025", var_109_13)
						arg_106_1:RecordAudio("420011025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420011", "420011025", "story_v_out_420011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420011", "420011025", "story_v_out_420011.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_14 and arg_106_1.time_ < var_109_4 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play420011026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420011026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play420011027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1061ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1061ui_story == nil then
				arg_110_1.var_.characterEffect1061ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1061ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1061ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1061ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1061ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.15

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(420011026)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 6
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play420011027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420011027
		arg_114_1.duration_ = 2

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420011028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1061ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_117_4 = 0

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_117_6 = 0

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			local var_117_7 = 1

			if arg_114_1.time_ >= var_117_6 + var_117_7 and arg_114_1.time_ < var_117_6 + var_117_7 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_8 = 0
			local var_117_9 = 0.1

			if var_117_8 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_10 = arg_114_1:FormatText(StoryNameCfg[612].name)

				arg_114_1.leftNameTxt_.text = var_117_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_11 = arg_114_1:GetWordFromCfg(420011027)
				local var_117_12 = arg_114_1:FormatText(var_117_11.content)

				arg_114_1.text_.text = var_117_12

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_13 = 4
				local var_117_14 = utf8.len(var_117_12)
				local var_117_15 = var_117_13 <= 0 and var_117_9 or var_117_9 * (var_117_14 / var_117_13)

				if var_117_15 > 0 and var_117_9 < var_117_15 then
					arg_114_1.talkMaxDuration = var_117_15

					if var_117_15 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_8
					end
				end

				arg_114_1.text_.text = var_117_12
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011027", "story_v_out_420011.awb") ~= 0 then
					local var_117_16 = manager.audio:GetVoiceLength("story_v_out_420011", "420011027", "story_v_out_420011.awb") / 1000

					if var_117_16 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_16 + var_117_8
					end

					if var_117_11.prefab_name ~= "" and arg_114_1.actors_[var_117_11.prefab_name] ~= nil then
						local var_117_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_11.prefab_name].transform, "story_v_out_420011", "420011027", "story_v_out_420011.awb")

						arg_114_1:RecordAudio("420011027", var_117_17)
						arg_114_1:RecordAudio("420011027", var_117_17)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420011", "420011027", "story_v_out_420011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420011", "420011027", "story_v_out_420011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_18 = math.max(var_117_9, arg_114_1.talkMaxDuration)

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_18 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_8) / var_117_18

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_8 + var_117_18 and arg_114_1.time_ < var_117_8 + var_117_18 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play420011028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420011028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play420011029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1061ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1061ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, 100, 0)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1061ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, 100, 0)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = 0.766666666666
			local var_121_10 = 1

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				local var_121_11 = "play"
				local var_121_12 = "effect"

				arg_118_1:AudioAction(var_121_11, var_121_12, "se_story_140", "se_story_140_metal", "")
			end

			local var_121_13 = 0
			local var_121_14 = 1.575

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_15 = arg_118_1:GetWordFromCfg(420011028)
				local var_121_16 = arg_118_1:FormatText(var_121_15.content)

				arg_118_1.text_.text = var_121_16

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_17 = 63
				local var_121_18 = utf8.len(var_121_16)
				local var_121_19 = var_121_17 <= 0 and var_121_14 or var_121_14 * (var_121_18 / var_121_17)

				if var_121_19 > 0 and var_121_14 < var_121_19 then
					arg_118_1.talkMaxDuration = var_121_19

					if var_121_19 + var_121_13 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_13
					end
				end

				arg_118_1.text_.text = var_121_16
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = math.max(var_121_14, arg_118_1.talkMaxDuration)

			if var_121_13 <= arg_118_1.time_ and arg_118_1.time_ < var_121_13 + var_121_20 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_13) / var_121_20

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_13 + var_121_20 and arg_118_1.time_ < var_121_13 + var_121_20 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play420011029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420011029
		arg_122_1.duration_ = 16.73

		local var_122_0 = {
			zh = 12.633,
			ja = 16.733
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
				arg_122_0:Play420011030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1061ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1061ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, -1.18, -6.15)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1061ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = arg_122_1.actors_["1061ui_story"]
			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = var_125_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_11 = 0.200000002980232

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_11 and not isNil(var_125_9) then
				local var_125_12 = (arg_122_1.time_ - var_125_10) / var_125_11

				if arg_122_1.var_.characterEffect1061ui_story and not isNil(var_125_9) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_10 + var_125_11 and arg_122_1.time_ < var_125_10 + var_125_11 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_125_13 = 0

			if var_125_13 < arg_122_1.time_ and arg_122_1.time_ <= var_125_13 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_125_14 = 0
			local var_125_15 = 1.675

			if var_125_14 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_16 = arg_122_1:FormatText(StoryNameCfg[612].name)

				arg_122_1.leftNameTxt_.text = var_125_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_17 = arg_122_1:GetWordFromCfg(420011029)
				local var_125_18 = arg_122_1:FormatText(var_125_17.content)

				arg_122_1.text_.text = var_125_18

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_19 = 67
				local var_125_20 = utf8.len(var_125_18)
				local var_125_21 = var_125_19 <= 0 and var_125_15 or var_125_15 * (var_125_20 / var_125_19)

				if var_125_21 > 0 and var_125_15 < var_125_21 then
					arg_122_1.talkMaxDuration = var_125_21

					if var_125_21 + var_125_14 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_21 + var_125_14
					end
				end

				arg_122_1.text_.text = var_125_18
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011029", "story_v_out_420011.awb") ~= 0 then
					local var_125_22 = manager.audio:GetVoiceLength("story_v_out_420011", "420011029", "story_v_out_420011.awb") / 1000

					if var_125_22 + var_125_14 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_14
					end

					if var_125_17.prefab_name ~= "" and arg_122_1.actors_[var_125_17.prefab_name] ~= nil then
						local var_125_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_17.prefab_name].transform, "story_v_out_420011", "420011029", "story_v_out_420011.awb")

						arg_122_1:RecordAudio("420011029", var_125_23)
						arg_122_1:RecordAudio("420011029", var_125_23)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_420011", "420011029", "story_v_out_420011.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_420011", "420011029", "story_v_out_420011.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_24 = math.max(var_125_15, arg_122_1.talkMaxDuration)

			if var_125_14 <= arg_122_1.time_ and arg_122_1.time_ < var_125_14 + var_125_24 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_14) / var_125_24

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_14 + var_125_24 and arg_122_1.time_ < var_125_14 + var_125_24 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play420011030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420011030
		arg_126_1.duration_ = 15

		local var_126_0 = {
			zh = 11.166,
			ja = 15
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
				arg_126_0:Play420011031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.3

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[612].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:GetWordFromCfg(420011030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 52
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011030", "story_v_out_420011.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_420011", "420011030", "story_v_out_420011.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_420011", "420011030", "story_v_out_420011.awb")

						arg_126_1:RecordAudio("420011030", var_129_9)
						arg_126_1:RecordAudio("420011030", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_420011", "420011030", "story_v_out_420011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_420011", "420011030", "story_v_out_420011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play420011031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 420011031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play420011032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1061ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1061ui_story == nil then
				arg_130_1.var_.characterEffect1061ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1061ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1061ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1061ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1061ui_story.fillRatio = var_133_5
			end

			local var_133_6 = 0
			local var_133_7 = 0.35

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_8 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_9 = arg_130_1:GetWordFromCfg(420011031)
				local var_133_10 = arg_130_1:FormatText(var_133_9.content)

				arg_130_1.text_.text = var_133_10

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 14
				local var_133_12 = utf8.len(var_133_10)
				local var_133_13 = var_133_11 <= 0 and var_133_7 or var_133_7 * (var_133_12 / var_133_11)

				if var_133_13 > 0 and var_133_7 < var_133_13 then
					arg_130_1.talkMaxDuration = var_133_13

					if var_133_13 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_13 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_10
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play420011032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 420011032
		arg_134_1.duration_ = 10.4

		local var_134_0 = {
			zh = 7.233,
			ja = 10.4
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
				arg_134_0:Play420011033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1061ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_137_4 = 0
			local var_137_5 = 0.875

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_6 = arg_134_1:FormatText(StoryNameCfg[612].name)

				arg_134_1.leftNameTxt_.text = var_137_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_7 = arg_134_1:GetWordFromCfg(420011032)
				local var_137_8 = arg_134_1:FormatText(var_137_7.content)

				arg_134_1.text_.text = var_137_8

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 35
				local var_137_10 = utf8.len(var_137_8)
				local var_137_11 = var_137_9 <= 0 and var_137_5 or var_137_5 * (var_137_10 / var_137_9)

				if var_137_11 > 0 and var_137_5 < var_137_11 then
					arg_134_1.talkMaxDuration = var_137_11

					if var_137_11 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_8
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011032", "story_v_out_420011.awb") ~= 0 then
					local var_137_12 = manager.audio:GetVoiceLength("story_v_out_420011", "420011032", "story_v_out_420011.awb") / 1000

					if var_137_12 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_12 + var_137_4
					end

					if var_137_7.prefab_name ~= "" and arg_134_1.actors_[var_137_7.prefab_name] ~= nil then
						local var_137_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_7.prefab_name].transform, "story_v_out_420011", "420011032", "story_v_out_420011.awb")

						arg_134_1:RecordAudio("420011032", var_137_13)
						arg_134_1:RecordAudio("420011032", var_137_13)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_420011", "420011032", "story_v_out_420011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_420011", "420011032", "story_v_out_420011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_14 and arg_134_1.time_ < var_137_4 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play420011033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 420011033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play420011034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1061ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1061ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1061ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1061ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.3

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(420011033)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 12
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play420011034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 420011034
		arg_142_1.duration_ = 5.23

		local var_142_0 = {
			zh = 4.166,
			ja = 5.233
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
				arg_142_0:Play420011035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1061ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1061ui_story == nil then
				arg_142_1.var_.characterEffect1061ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1061ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1061ui_story then
				arg_142_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_145_4 = 0
			local var_145_5 = 0.575

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_6 = arg_142_1:FormatText(StoryNameCfg[612].name)

				arg_142_1.leftNameTxt_.text = var_145_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_7 = arg_142_1:GetWordFromCfg(420011034)
				local var_145_8 = arg_142_1:FormatText(var_145_7.content)

				arg_142_1.text_.text = var_145_8

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 23
				local var_145_10 = utf8.len(var_145_8)
				local var_145_11 = var_145_9 <= 0 and var_145_5 or var_145_5 * (var_145_10 / var_145_9)

				if var_145_11 > 0 and var_145_5 < var_145_11 then
					arg_142_1.talkMaxDuration = var_145_11

					if var_145_11 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_8
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011034", "story_v_out_420011.awb") ~= 0 then
					local var_145_12 = manager.audio:GetVoiceLength("story_v_out_420011", "420011034", "story_v_out_420011.awb") / 1000

					if var_145_12 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_4
					end

					if var_145_7.prefab_name ~= "" and arg_142_1.actors_[var_145_7.prefab_name] ~= nil then
						local var_145_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_7.prefab_name].transform, "story_v_out_420011", "420011034", "story_v_out_420011.awb")

						arg_142_1:RecordAudio("420011034", var_145_13)
						arg_142_1:RecordAudio("420011034", var_145_13)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_420011", "420011034", "story_v_out_420011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_420011", "420011034", "story_v_out_420011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_14 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_14 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_14

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_14 and arg_142_1.time_ < var_145_4 + var_145_14 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play420011035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 420011035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play420011036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1061ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1061ui_story = var_149_0.localPosition

				local var_149_2 = "1061ui_story"

				arg_146_1:ShowWeapon(arg_146_1.var_[var_149_2 .. "Animator"].transform, false)
			end

			local var_149_3 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_3 then
				local var_149_4 = (arg_146_1.time_ - var_149_1) / var_149_3
				local var_149_5 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1061ui_story, var_149_5, var_149_4)

				local var_149_6 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_6.x, var_149_6.y, var_149_6.z)

				local var_149_7 = var_149_0.localEulerAngles

				var_149_7.z = 0
				var_149_7.x = 0
				var_149_0.localEulerAngles = var_149_7
			end

			if arg_146_1.time_ >= var_149_1 + var_149_3 and arg_146_1.time_ < var_149_1 + var_149_3 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_8 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_8.x, var_149_8.y, var_149_8.z)

				local var_149_9 = var_149_0.localEulerAngles

				var_149_9.z = 0
				var_149_9.x = 0
				var_149_0.localEulerAngles = var_149_9
			end

			local var_149_10 = 0.034000001847744
			local var_149_11 = 1

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				local var_149_12 = "play"
				local var_149_13 = "effect"

				arg_146_1:AudioAction(var_149_12, var_149_13, "se_story_140", "se_story_140_foley_clap", "")
			end

			local var_149_14 = 0
			local var_149_15 = 1.35

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_16 = arg_146_1:GetWordFromCfg(420011035)
				local var_149_17 = arg_146_1:FormatText(var_149_16.content)

				arg_146_1.text_.text = var_149_17

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_18 = 54
				local var_149_19 = utf8.len(var_149_17)
				local var_149_20 = var_149_18 <= 0 and var_149_15 or var_149_15 * (var_149_19 / var_149_18)

				if var_149_20 > 0 and var_149_15 < var_149_20 then
					arg_146_1.talkMaxDuration = var_149_20

					if var_149_20 + var_149_14 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_14
					end
				end

				arg_146_1.text_.text = var_149_17
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_21 = math.max(var_149_15, arg_146_1.talkMaxDuration)

			if var_149_14 <= arg_146_1.time_ and arg_146_1.time_ < var_149_14 + var_149_21 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_14) / var_149_21

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_14 + var_149_21 and arg_146_1.time_ < var_149_14 + var_149_21 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play420011036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 420011036
		arg_150_1.duration_ = 10.13

		local var_150_0 = {
			zh = 8.1,
			ja = 10.133
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
				arg_150_0:Play420011037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1061ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1061ui_story = var_153_0.localPosition

				local var_153_2 = "1061ui_story"

				arg_150_1:ShowWeapon(arg_150_1.var_[var_153_2 .. "Animator"].transform, false)
			end

			local var_153_3 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_3 then
				local var_153_4 = (arg_150_1.time_ - var_153_1) / var_153_3
				local var_153_5 = Vector3.New(0, -1.18, -6.15)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1061ui_story, var_153_5, var_153_4)

				local var_153_6 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_6.x, var_153_6.y, var_153_6.z)

				local var_153_7 = var_153_0.localEulerAngles

				var_153_7.z = 0
				var_153_7.x = 0
				var_153_0.localEulerAngles = var_153_7
			end

			if arg_150_1.time_ >= var_153_1 + var_153_3 and arg_150_1.time_ < var_153_1 + var_153_3 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_153_8 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_8.x, var_153_8.y, var_153_8.z)

				local var_153_9 = var_153_0.localEulerAngles

				var_153_9.z = 0
				var_153_9.x = 0
				var_153_0.localEulerAngles = var_153_9
			end

			local var_153_10 = arg_150_1.actors_["1061ui_story"]
			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 and not isNil(var_153_10) and arg_150_1.var_.characterEffect1061ui_story == nil then
				arg_150_1.var_.characterEffect1061ui_story = var_153_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_12 = 0.200000002980232

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_12 and not isNil(var_153_10) then
				local var_153_13 = (arg_150_1.time_ - var_153_11) / var_153_12

				if arg_150_1.var_.characterEffect1061ui_story and not isNil(var_153_10) then
					arg_150_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_11 + var_153_12 and arg_150_1.time_ < var_153_11 + var_153_12 + arg_153_0 and not isNil(var_153_10) and arg_150_1.var_.characterEffect1061ui_story then
				arg_150_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_153_14 = 0
			local var_153_15 = 1.025

			if var_153_14 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_16 = arg_150_1:FormatText(StoryNameCfg[612].name)

				arg_150_1.leftNameTxt_.text = var_153_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_17 = arg_150_1:GetWordFromCfg(420011036)
				local var_153_18 = arg_150_1:FormatText(var_153_17.content)

				arg_150_1.text_.text = var_153_18

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_19 = 41
				local var_153_20 = utf8.len(var_153_18)
				local var_153_21 = var_153_19 <= 0 and var_153_15 or var_153_15 * (var_153_20 / var_153_19)

				if var_153_21 > 0 and var_153_15 < var_153_21 then
					arg_150_1.talkMaxDuration = var_153_21

					if var_153_21 + var_153_14 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_21 + var_153_14
					end
				end

				arg_150_1.text_.text = var_153_18
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011036", "story_v_out_420011.awb") ~= 0 then
					local var_153_22 = manager.audio:GetVoiceLength("story_v_out_420011", "420011036", "story_v_out_420011.awb") / 1000

					if var_153_22 + var_153_14 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_22 + var_153_14
					end

					if var_153_17.prefab_name ~= "" and arg_150_1.actors_[var_153_17.prefab_name] ~= nil then
						local var_153_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_17.prefab_name].transform, "story_v_out_420011", "420011036", "story_v_out_420011.awb")

						arg_150_1:RecordAudio("420011036", var_153_23)
						arg_150_1:RecordAudio("420011036", var_153_23)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_420011", "420011036", "story_v_out_420011.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_420011", "420011036", "story_v_out_420011.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_24 = math.max(var_153_15, arg_150_1.talkMaxDuration)

			if var_153_14 <= arg_150_1.time_ and arg_150_1.time_ < var_153_14 + var_153_24 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_14) / var_153_24

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_14 + var_153_24 and arg_150_1.time_ < var_153_14 + var_153_24 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play420011037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 420011037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play420011038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1061ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1061ui_story == nil then
				arg_154_1.var_.characterEffect1061ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1061ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1061ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1061ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1061ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.6

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_9 = arg_154_1:GetWordFromCfg(420011037)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 24
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_14 and arg_154_1.time_ < var_157_6 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play420011038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 420011038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play420011039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.425

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(420011038)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 17
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_8 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_8 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_8

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_8 and arg_158_1.time_ < var_161_0 + var_161_8 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play420011039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 420011039
		arg_162_1.duration_ = 9.83

		local var_162_0 = {
			zh = 5.6,
			ja = 9.833
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
				arg_162_0:Play420011040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1061ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1061ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_165_4 = 0
			local var_165_5 = 0.575

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_6 = arg_162_1:FormatText(StoryNameCfg[612].name)

				arg_162_1.leftNameTxt_.text = var_165_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:GetWordFromCfg(420011039)
				local var_165_8 = arg_162_1:FormatText(var_165_7.content)

				arg_162_1.text_.text = var_165_8

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 23
				local var_165_10 = utf8.len(var_165_8)
				local var_165_11 = var_165_9 <= 0 and var_165_5 or var_165_5 * (var_165_10 / var_165_9)

				if var_165_11 > 0 and var_165_5 < var_165_11 then
					arg_162_1.talkMaxDuration = var_165_11

					if var_165_11 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_8
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011039", "story_v_out_420011.awb") ~= 0 then
					local var_165_12 = manager.audio:GetVoiceLength("story_v_out_420011", "420011039", "story_v_out_420011.awb") / 1000

					if var_165_12 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_4
					end

					if var_165_7.prefab_name ~= "" and arg_162_1.actors_[var_165_7.prefab_name] ~= nil then
						local var_165_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_7.prefab_name].transform, "story_v_out_420011", "420011039", "story_v_out_420011.awb")

						arg_162_1:RecordAudio("420011039", var_165_13)
						arg_162_1:RecordAudio("420011039", var_165_13)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_420011", "420011039", "story_v_out_420011.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_420011", "420011039", "story_v_out_420011.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_14 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_14 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_14

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_14 and arg_162_1.time_ < var_165_4 + var_165_14 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play420011040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 420011040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play420011041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1061ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1061ui_story == nil then
				arg_166_1.var_.characterEffect1061ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1061ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1061ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1061ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1061ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_7 = 0.075

			if arg_166_1.time_ >= var_169_6 + var_169_7 and arg_166_1.time_ < var_169_6 + var_169_7 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_8 = 0
			local var_169_9 = 0.075

			if var_169_8 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_10 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_11 = arg_166_1:GetWordFromCfg(420011040)
				local var_169_12 = arg_166_1:FormatText(var_169_11.content)

				arg_166_1.text_.text = var_169_12

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 3
				local var_169_14 = utf8.len(var_169_12)
				local var_169_15 = var_169_13 <= 0 and var_169_9 or var_169_9 * (var_169_14 / var_169_13)

				if var_169_15 > 0 and var_169_9 < var_169_15 then
					arg_166_1.talkMaxDuration = var_169_15

					if var_169_15 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_15 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_12
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_16 and arg_166_1.time_ < var_169_8 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play420011041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 420011041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play420011042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1061ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1061ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1061ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = 0
			local var_173_10 = 1.325

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_11 = arg_170_1:GetWordFromCfg(420011041)
				local var_173_12 = arg_170_1:FormatText(var_173_11.content)

				arg_170_1.text_.text = var_173_12

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 53
				local var_173_14 = utf8.len(var_173_12)
				local var_173_15 = var_173_13 <= 0 and var_173_10 or var_173_10 * (var_173_14 / var_173_13)

				if var_173_15 > 0 and var_173_10 < var_173_15 then
					arg_170_1.talkMaxDuration = var_173_15

					if var_173_15 + var_173_9 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_9
					end
				end

				arg_170_1.text_.text = var_173_12
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_10, arg_170_1.talkMaxDuration)

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_9) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_9 + var_173_16 and arg_170_1.time_ < var_173_9 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play420011042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 420011042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play420011043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 0.55

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:GetWordFromCfg(420011042)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 22
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
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_8 and arg_174_1.time_ < var_177_0 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play420011043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 420011043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play420011044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1.025

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(420011043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 41
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play420011044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 420011044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play420011045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.05
			local var_185_1 = 1

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				local var_185_2 = "play"
				local var_185_3 = "effect"

				arg_182_1:AudioAction(var_185_2, var_185_3, "se_story_140", "se_story_140_foley_clap", "")
			end

			local var_185_4 = 0
			local var_185_5 = 0.35

			if var_185_4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(420011044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_8 = 14
				local var_185_9 = utf8.len(var_185_7)
				local var_185_10 = var_185_8 <= 0 and var_185_5 or var_185_5 * (var_185_9 / var_185_8)

				if var_185_10 > 0 and var_185_5 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_11 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_11 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_11

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_11 and arg_182_1.time_ < var_185_4 + var_185_11 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play420011045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 420011045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play420011046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.525

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[7].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(420011045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 21
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play420011046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 420011046
		arg_190_1.duration_ = 13.93

		local var_190_0 = {
			zh = 9.466,
			ja = 13.933
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play420011047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1061ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1061ui_story == nil then
				arg_190_1.var_.characterEffect1061ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1061ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1061ui_story then
				arg_190_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["1061ui_story"].transform
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.var_.moveOldPos1061ui_story = var_193_4.localPosition
			end

			local var_193_6 = 0.001

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6
				local var_193_8 = Vector3.New(0, -1.18, -6.15)

				var_193_4.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1061ui_story, var_193_8, var_193_7)

				local var_193_9 = manager.ui.mainCamera.transform.position - var_193_4.position

				var_193_4.forward = Vector3.New(var_193_9.x, var_193_9.y, var_193_9.z)

				local var_193_10 = var_193_4.localEulerAngles

				var_193_10.z = 0
				var_193_10.x = 0
				var_193_4.localEulerAngles = var_193_10
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 then
				var_193_4.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_193_11 = manager.ui.mainCamera.transform.position - var_193_4.position

				var_193_4.forward = Vector3.New(var_193_11.x, var_193_11.y, var_193_11.z)

				local var_193_12 = var_193_4.localEulerAngles

				var_193_12.z = 0
				var_193_12.x = 0
				var_193_4.localEulerAngles = var_193_12
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			local var_193_14 = 0

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_15 = 0
			local var_193_16 = 1

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[612].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(420011046)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 40
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420011", "420011046", "story_v_out_420011.awb") ~= 0 then
					local var_193_23 = manager.audio:GetVoiceLength("story_v_out_420011", "420011046", "story_v_out_420011.awb") / 1000

					if var_193_23 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_15
					end

					if var_193_18.prefab_name ~= "" and arg_190_1.actors_[var_193_18.prefab_name] ~= nil then
						local var_193_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_18.prefab_name].transform, "story_v_out_420011", "420011046", "story_v_out_420011.awb")

						arg_190_1:RecordAudio("420011046", var_193_24)
						arg_190_1:RecordAudio("420011046", var_193_24)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_420011", "420011046", "story_v_out_420011.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_420011", "420011046", "story_v_out_420011.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_25 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_25 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_25

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_25 and arg_190_1.time_ < var_193_15 + var_193_25 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play420011047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 420011047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play420011048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1061ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1061ui_story == nil then
				arg_194_1.var_.characterEffect1061ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1061ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1061ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1061ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1061ui_story.fillRatio = var_197_5
			end

			local var_197_6 = 0
			local var_197_7 = 0.2

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_9 = arg_194_1:GetWordFromCfg(420011047)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 8
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
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_14 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_14 and arg_194_1.time_ < var_197_6 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play420011048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 420011048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play420011049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1061ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1061ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, 100, 0)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1061ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, 100, 0)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = 0
			local var_201_10 = 0.825

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_11 = arg_198_1:GetWordFromCfg(420011048)
				local var_201_12 = arg_198_1:FormatText(var_201_11.content)

				arg_198_1.text_.text = var_201_12

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 33
				local var_201_14 = utf8.len(var_201_12)
				local var_201_15 = var_201_13 <= 0 and var_201_10 or var_201_10 * (var_201_14 / var_201_13)

				if var_201_15 > 0 and var_201_10 < var_201_15 then
					arg_198_1.talkMaxDuration = var_201_15

					if var_201_15 + var_201_9 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_15 + var_201_9
					end
				end

				arg_198_1.text_.text = var_201_12
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_10, arg_198_1.talkMaxDuration)

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_9) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_9 + var_201_16 and arg_198_1.time_ < var_201_9 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play420011049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 420011049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play420011050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.566666666666667
			local var_205_1 = 1

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				local var_205_2 = "play"
				local var_205_3 = "effect"

				arg_202_1:AudioAction(var_205_2, var_205_3, "se_story_140", "se_story_140_foley_tear", "")
			end

			local var_205_4 = 0
			local var_205_5 = 1.1

			if var_205_4 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(420011049)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_8 = 44
				local var_205_9 = utf8.len(var_205_7)
				local var_205_10 = var_205_8 <= 0 and var_205_5 or var_205_5 * (var_205_9 / var_205_8)

				if var_205_10 > 0 and var_205_5 < var_205_10 then
					arg_202_1.talkMaxDuration = var_205_10

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_11 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_11 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_11

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_11 and arg_202_1.time_ < var_205_4 + var_205_11 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play420011050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 420011050
		arg_206_1.duration_ = 3

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
			arg_206_1.auto_ = false
		end

		function arg_206_1.playNext_(arg_208_0)
			arg_206_1.onStoryFinished_()
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = "STwhite"

			if arg_206_1.bgs_[var_209_0] == nil then
				local var_209_1 = Object.Instantiate(arg_206_1.paintGo_)

				var_209_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_209_0)
				var_209_1.name = var_209_0
				var_209_1.transform.parent = arg_206_1.stage_.transform
				var_209_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.bgs_[var_209_0] = var_209_1
			end

			local var_209_2 = 0

			if var_209_2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				local var_209_3 = manager.ui.mainCamera.transform.localPosition
				local var_209_4 = Vector3.New(0, 0, 10) + Vector3.New(var_209_3.x, var_209_3.y, 0)
				local var_209_5 = arg_206_1.bgs_.STwhite

				var_209_5.transform.localPosition = var_209_4
				var_209_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_6 = var_209_5:GetComponent("SpriteRenderer")

				if var_209_6 and var_209_6.sprite then
					local var_209_7 = (var_209_5.transform.localPosition - var_209_3).z
					local var_209_8 = manager.ui.mainCameraCom_
					local var_209_9 = 2 * var_209_7 * Mathf.Tan(var_209_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_209_10 = var_209_9 * var_209_8.aspect
					local var_209_11 = var_209_6.sprite.bounds.size.x
					local var_209_12 = var_209_6.sprite.bounds.size.y
					local var_209_13 = var_209_10 / var_209_11
					local var_209_14 = var_209_9 / var_209_12
					local var_209_15 = var_209_14 < var_209_13 and var_209_13 or var_209_14

					var_209_5.transform.localScale = Vector3.New(var_209_15, var_209_15, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "STwhite" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_16 = 1

			if var_209_16 < arg_206_1.time_ and arg_206_1.time_ <= var_209_16 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			local var_209_17 = 0.166666666666667

			if arg_206_1.time_ >= var_209_16 + var_209_17 and arg_206_1.time_ < var_209_16 + var_209_17 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_18 = 0

			if var_209_18 < arg_206_1.time_ and arg_206_1.time_ <= var_209_18 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_19 = 1

			if var_209_18 <= arg_206_1.time_ and arg_206_1.time_ < var_209_18 + var_209_19 then
				local var_209_20 = (arg_206_1.time_ - var_209_18) / var_209_19
				local var_209_21 = Color.New(0, 0, 0)

				var_209_21.a = Mathf.Lerp(1, 0, var_209_20)
				arg_206_1.mask_.color = var_209_21
			end

			if arg_206_1.time_ >= var_209_18 + var_209_19 and arg_206_1.time_ < var_209_18 + var_209_19 + arg_209_0 then
				local var_209_22 = Color.New(0, 0, 0)
				local var_209_23 = 0

				arg_206_1.mask_.enabled = false
				var_209_22.a = var_209_23
				arg_206_1.mask_.color = var_209_22
			end

			local var_209_24 = 0

			if var_209_24 < arg_206_1.time_ and arg_206_1.time_ <= var_209_24 + arg_209_0 then
				arg_206_1.fswbg_:SetActive(true)
				arg_206_1.dialog_:SetActive(false)

				arg_206_1.fswtw_.percent = 0

				local var_209_25 = arg_206_1:GetWordFromCfg(420011050)
				local var_209_26 = arg_206_1:FormatText(var_209_25.content)

				arg_206_1.fswt_.text = var_209_26

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.fswt_)

				arg_206_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_206_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_206_1.fswtw_:SetDirty()

				arg_206_1.typewritterCharCountI18N = 0

				SetActive(arg_206_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_206_1:ShowNextGo(false)
			end

			local var_209_27 = 1

			if var_209_27 < arg_206_1.time_ and arg_206_1.time_ <= var_209_27 + arg_209_0 then
				arg_206_1.var_.oldValueTypewriter = arg_206_1.fswtw_.percent

				SetActive(arg_206_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_206_1:ShowNextGo(false)
			end

			local var_209_28 = 14
			local var_209_29 = 0.933333333333333
			local var_209_30 = arg_206_1:GetWordFromCfg(420011050)
			local var_209_31 = arg_206_1:FormatText(var_209_30.content)
			local var_209_32, var_209_33 = arg_206_1:GetPercentByPara(var_209_31, 1)

			if var_209_27 < arg_206_1.time_ and arg_206_1.time_ <= var_209_27 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				local var_209_34 = var_209_28 <= 0 and var_209_29 or var_209_29 * ((var_209_33 - arg_206_1.typewritterCharCountI18N) / var_209_28)

				if var_209_34 > 0 and var_209_29 < var_209_34 then
					arg_206_1.talkMaxDuration = var_209_34

					if var_209_34 + var_209_27 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_34 + var_209_27
					end
				end
			end

			local var_209_35 = 0.933333333333333
			local var_209_36 = math.max(var_209_35, arg_206_1.talkMaxDuration)

			if var_209_27 <= arg_206_1.time_ and arg_206_1.time_ < var_209_27 + var_209_36 then
				local var_209_37 = (arg_206_1.time_ - var_209_27) / var_209_36

				arg_206_1.fswtw_.percent = Mathf.Lerp(arg_206_1.var_.oldValueTypewriter, var_209_32, var_209_37)
				arg_206_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_206_1.fswtw_:SetDirty()
			end

			if arg_206_1.time_ >= var_209_27 + var_209_36 and arg_206_1.time_ < var_209_27 + var_209_36 + arg_209_0 then
				arg_206_1.fswtw_.percent = var_209_32

				arg_206_1.fswtw_:SetDirty()
				arg_206_1:ShowNextGo(true)

				arg_206_1.typewritterCharCountI18N = var_209_33
			end

			local var_209_38 = 1

			if var_209_38 < arg_206_1.time_ and arg_206_1.time_ <= var_209_38 + arg_209_0 then
				local var_209_39 = arg_206_1.fswbg_.transform:Find("textbox/adapt/content") or arg_206_1.fswbg_.transform:Find("textbox/content")
				local var_209_40 = arg_206_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_209_41 = var_209_39:GetComponent("Text")
				local var_209_42 = var_209_39:GetComponent("RectTransform")

				var_209_41.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_209_42.offsetMin = Vector2.New(0, -70)
				var_209_42.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_420011.awb"
	}
}
