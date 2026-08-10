return {
	Play120011001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120011001
		arg_1_1.duration_ = 178.38

		local var_1_0 = {
			zh = 166.099999999999,
			ja = 178.375
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
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play120011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "XH0101"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 141.5

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.XH0101

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
					if iter_4_0 ~= "XH0101" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 138

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 3.5

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(0, 1, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)

				var_4_20.a = 1
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_21 = 141.5

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_22 = 4.5

			if var_4_21 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				local var_4_23 = (arg_1_1.time_ - var_4_21) / var_4_22
				local var_4_24 = Color.New(0, 0, 0)

				var_4_24.a = Mathf.Lerp(1, 0, var_4_23)
				arg_1_1.mask_.color = var_4_24
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				local var_4_25 = Color.New(0, 0, 0)
				local var_4_26 = 0

				arg_1_1.mask_.enabled = false
				var_4_25.a = var_4_26
				arg_1_1.mask_.color = var_4_25
			end

			local var_4_27 = arg_1_1.bgs_.XH0101.transform
			local var_4_28 = 141.5

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0101 = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, 0.5, 2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0101, var_4_31, var_4_30)
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, 0.5, 2)
			end

			local var_4_32 = arg_1_1.bgs_.XH0101.transform
			local var_4_33 = 141.534

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0101 = var_4_32.localPosition
			end

			local var_4_34 = 5

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				local var_4_35 = (arg_1_1.time_ - var_4_33) / var_4_34
				local var_4_36 = Vector3.New(-0.5, 0.5, 2)

				var_4_32.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0101, var_4_36, var_4_35)
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				var_4_32.localPosition = Vector3.New(-0.5, 0.5, 2)
			end

			local var_4_37 = 145.409

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_38 = 1.12500000000001

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_39 = 0
			local var_4_40 = 1

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

			local var_4_45 = 143.4
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_4_49 = ""
				local var_4_50 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

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

			local var_4_51 = 0

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/101200101.usm", function(arg_7_0)
					arg_1_1.time_ = var_4_51 + 141.490000000224

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					if arg_8_0 then
						arg_1_1.state_ = "pause"
					else
						arg_1_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_52 = 141.5

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_53 = 141.5

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_54 = 0.199999999999989

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				-- block empty
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_55 = 145.409
			local var_4_56 = 1.125

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_57 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_57:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_1_1.dialogCg_.alpha = arg_9_0
				end))
				var_4_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_58 = arg_1_1:FormatText(StoryNameCfg[319].name)

				arg_1_1.leftNameTxt_.text = var_4_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(120011001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 45
				local var_4_62 = utf8.len(var_4_60)
				local var_4_63 = var_4_61 <= 0 and var_4_56 or var_4_56 * (var_4_62 / var_4_61)

				if var_4_63 > 0 and var_4_56 < var_4_63 then
					arg_1_1.talkMaxDuration = var_4_63
					var_4_55 = var_4_55 + 0.3

					if var_4_63 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_55
					end
				end

				arg_1_1.text_.text = var_4_60
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011001", "story_v_out_120011.awb") ~= 0 then
					local var_4_64 = manager.audio:GetVoiceLength("story_v_out_120011", "120011001", "story_v_out_120011.awb") / 1000

					if var_4_64 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_55
					end

					if var_4_59.prefab_name ~= "" and arg_1_1.actors_[var_4_59.prefab_name] ~= nil then
						local var_4_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_59.prefab_name].transform, "story_v_out_120011", "120011001", "story_v_out_120011.awb")

						arg_1_1:RecordAudio("120011001", var_4_65)
						arg_1_1:RecordAudio("120011001", var_4_65)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120011", "120011001", "story_v_out_120011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120011", "120011001", "story_v_out_120011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_55 + 0.3
			local var_4_67 = math.max(var_4_56, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 141.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 141.534,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120011002 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 120011002
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play120011003(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.5

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(120011002)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 60
				local var_14_5 = utf8.len(var_14_3)
				local var_14_6 = var_14_4 <= 0 and var_14_1 or var_14_1 * (var_14_5 / var_14_4)

				if var_14_6 > 0 and var_14_1 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_7 and arg_11_1.time_ < var_14_0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play120011003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 120011003
		arg_15_1.duration_ = 3.47

		local var_15_0 = {
			zh = 3.466,
			ja = 3.233
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play120011004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.325

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[319].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:GetWordFromCfg(120011003)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 13
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011003", "story_v_out_120011.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011003", "story_v_out_120011.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_120011", "120011003", "story_v_out_120011.awb")

						arg_15_1:RecordAudio("120011003", var_18_9)
						arg_15_1:RecordAudio("120011003", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_120011", "120011003", "story_v_out_120011.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_120011", "120011003", "story_v_out_120011.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_10 and arg_15_1.time_ < var_18_0 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play120011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 120011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play120011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.4

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(120011004)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 16
				local var_22_5 = utf8.len(var_22_3)
				local var_22_6 = var_22_4 <= 0 and var_22_1 or var_22_1 * (var_22_5 / var_22_4)

				if var_22_6 > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_7 and arg_19_1.time_ < var_22_0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play120011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 120011005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play120011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 1.35

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(120011005)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 50
				local var_26_5 = utf8.len(var_26_3)
				local var_26_6 = var_26_4 <= 0 and var_26_1 or var_26_1 * (var_26_5 / var_26_4)

				if var_26_6 > 0 and var_26_1 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_7 and arg_23_1.time_ < var_26_0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play120011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 120011006
		arg_27_1.duration_ = 7.03

		local var_27_0 = {
			zh = 5.266,
			ja = 7.033
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
				arg_27_0:Play120011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.625

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[319].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(120011006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011006", "story_v_out_120011.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011006", "story_v_out_120011.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_120011", "120011006", "story_v_out_120011.awb")

						arg_27_1:RecordAudio("120011006", var_30_9)
						arg_27_1:RecordAudio("120011006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_120011", "120011006", "story_v_out_120011.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_120011", "120011006", "story_v_out_120011.awb")
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
	Play120011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 120011007
		arg_31_1.duration_ = 4.73

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play120011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.5

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

				local var_34_3 = arg_31_1:GetWordFromCfg(120011007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011007", "story_v_out_120011.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011007", "story_v_out_120011.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_120011", "120011007", "story_v_out_120011.awb")

						arg_31_1:RecordAudio("120011007", var_34_9)
						arg_31_1:RecordAudio("120011007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_120011", "120011007", "story_v_out_120011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_120011", "120011007", "story_v_out_120011.awb")
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
	Play120011008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 120011008
		arg_35_1.duration_ = 3.63

		local var_35_0 = {
			zh = 3.2,
			ja = 3.633
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play120011009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.425

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[36].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(120011008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 17
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011008", "story_v_out_120011.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011008", "story_v_out_120011.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_120011", "120011008", "story_v_out_120011.awb")

						arg_35_1:RecordAudio("120011008", var_38_9)
						arg_35_1:RecordAudio("120011008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_120011", "120011008", "story_v_out_120011.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_120011", "120011008", "story_v_out_120011.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play120011009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 120011009
		arg_39_1.duration_ = 12

		local var_39_0 = {
			zh = 12,
			ja = 10.233
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
				arg_39_0:Play120011010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.125

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[319].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(120011009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011009", "story_v_out_120011.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011009", "story_v_out_120011.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_120011", "120011009", "story_v_out_120011.awb")

						arg_39_1:RecordAudio("120011009", var_42_9)
						arg_39_1:RecordAudio("120011009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_120011", "120011009", "story_v_out_120011.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_120011", "120011009", "story_v_out_120011.awb")
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
	Play120011010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 120011010
		arg_43_1.duration_ = 7

		local var_43_0 = {
			zh = 7,
			ja = 6.4
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
				arg_43_0:Play120011011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.5

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[319].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(120011010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011010", "story_v_out_120011.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011010", "story_v_out_120011.awb") / 1000

					if var_46_8 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_0
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_120011", "120011010", "story_v_out_120011.awb")

						arg_43_1:RecordAudio("120011010", var_46_9)
						arg_43_1:RecordAudio("120011010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_120011", "120011010", "story_v_out_120011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_120011", "120011010", "story_v_out_120011.awb")
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
	Play120011011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 120011011
		arg_47_1.duration_ = 12.43

		local var_47_0 = {
			zh = 9.666,
			ja = 12.433
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
				arg_47_0:Play120011012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.225

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[319].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(120011011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011011", "story_v_out_120011.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011011", "story_v_out_120011.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_120011", "120011011", "story_v_out_120011.awb")

						arg_47_1:RecordAudio("120011011", var_50_9)
						arg_47_1:RecordAudio("120011011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_120011", "120011011", "story_v_out_120011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_120011", "120011011", "story_v_out_120011.awb")
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
	Play120011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 120011012
		arg_51_1.duration_ = 9.8

		local var_51_0 = {
			zh = 9.266,
			ja = 9.8
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
				arg_51_0:Play120011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_1 = 2

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_1 then
				local var_54_2 = (arg_51_1.time_ - var_54_0) / var_54_1
				local var_54_3 = Color.New(0, 0, 0)

				var_54_3.a = Mathf.Lerp(0, 1, var_54_2)
				arg_51_1.mask_.color = var_54_3
			end

			if arg_51_1.time_ >= var_54_0 + var_54_1 and arg_51_1.time_ < var_54_0 + var_54_1 + arg_54_0 then
				local var_54_4 = Color.New(0, 0, 0)

				var_54_4.a = 1
				arg_51_1.mask_.color = var_54_4
			end

			local var_54_5 = 2

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_6 = 2

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6
				local var_54_8 = Color.New(0, 0, 0)

				var_54_8.a = Mathf.Lerp(1, 0, var_54_7)
				arg_51_1.mask_.color = var_54_8
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 then
				local var_54_9 = Color.New(0, 0, 0)
				local var_54_10 = 0

				arg_51_1.mask_.enabled = false
				var_54_9.a = var_54_10
				arg_51_1.mask_.color = var_54_9
			end

			local var_54_11 = arg_51_1.bgs_.XH0101.transform
			local var_54_12 = 1.98333333333333

			if var_54_12 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.var_.moveOldPosXH0101 = var_54_11.localPosition
			end

			local var_54_13 = 0.001

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_13 then
				local var_54_14 = (arg_51_1.time_ - var_54_12) / var_54_13
				local var_54_15 = Vector3.New(0, 1, 10)

				var_54_11.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPosXH0101, var_54_15, var_54_14)
			end

			if arg_51_1.time_ >= var_54_12 + var_54_13 and arg_51_1.time_ < var_54_12 + var_54_13 + arg_54_0 then
				var_54_11.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_16 = 4
			local var_54_17 = 0.5

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_18 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_18:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_19 = arg_51_1:FormatText(StoryNameCfg[36].name)

				arg_51_1.leftNameTxt_.text = var_54_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_20 = arg_51_1:GetWordFromCfg(120011012)
				local var_54_21 = arg_51_1:FormatText(var_54_20.content)

				arg_51_1.text_.text = var_54_21

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_22 = 20
				local var_54_23 = utf8.len(var_54_21)
				local var_54_24 = var_54_22 <= 0 and var_54_17 or var_54_17 * (var_54_23 / var_54_22)

				if var_54_24 > 0 and var_54_17 < var_54_24 then
					arg_51_1.talkMaxDuration = var_54_24
					var_54_16 = var_54_16 + 0.3

					if var_54_24 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_24 + var_54_16
					end
				end

				arg_51_1.text_.text = var_54_21
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011012", "story_v_out_120011.awb") ~= 0 then
					local var_54_25 = manager.audio:GetVoiceLength("story_v_out_120011", "120011012", "story_v_out_120011.awb") / 1000

					if var_54_25 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_25 + var_54_16
					end

					if var_54_20.prefab_name ~= "" and arg_51_1.actors_[var_54_20.prefab_name] ~= nil then
						local var_54_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_20.prefab_name].transform, "story_v_out_120011", "120011012", "story_v_out_120011.awb")

						arg_51_1:RecordAudio("120011012", var_54_26)
						arg_51_1:RecordAudio("120011012", var_54_26)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_120011", "120011012", "story_v_out_120011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_120011", "120011012", "story_v_out_120011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_27 = var_54_16 + 0.3
			local var_54_28 = math.max(var_54_17, arg_51_1.talkMaxDuration)

			if var_54_27 <= arg_51_1.time_ and arg_51_1.time_ < var_54_27 + var_54_28 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_27) / var_54_28

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_27 + var_54_28 and arg_51_1.time_ < var_54_27 + var_54_28 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play120011013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120011013
		arg_57_1.duration_ = 7.63

		local var_57_0 = {
			zh = 7.4,
			ja = 7.633
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
				arg_57_0:Play120011014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.95

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[319].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(120011013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011013", "story_v_out_120011.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011013", "story_v_out_120011.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_120011", "120011013", "story_v_out_120011.awb")

						arg_57_1:RecordAudio("120011013", var_60_9)
						arg_57_1:RecordAudio("120011013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120011", "120011013", "story_v_out_120011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120011", "120011013", "story_v_out_120011.awb")
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
	Play120011014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120011014
		arg_61_1.duration_ = 6.37

		local var_61_0 = {
			zh = 4.866,
			ja = 6.366
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
				arg_61_0:Play120011015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.5

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[319].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(120011014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011014", "story_v_out_120011.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011014", "story_v_out_120011.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_120011", "120011014", "story_v_out_120011.awb")

						arg_61_1:RecordAudio("120011014", var_64_9)
						arg_61_1:RecordAudio("120011014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_120011", "120011014", "story_v_out_120011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_120011", "120011014", "story_v_out_120011.awb")
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
	Play120011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120011015
		arg_65_1.duration_ = 4.07

		local var_65_0 = {
			zh = 1.466,
			ja = 4.066
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
				arg_65_0:Play120011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.125

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[36].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(120011015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011015", "story_v_out_120011.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011015", "story_v_out_120011.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_120011", "120011015", "story_v_out_120011.awb")

						arg_65_1:RecordAudio("120011015", var_68_9)
						arg_65_1:RecordAudio("120011015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120011", "120011015", "story_v_out_120011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120011", "120011015", "story_v_out_120011.awb")
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
	Play120011016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120011016
		arg_69_1.duration_ = 12.73

		local var_69_0 = {
			zh = 12.733,
			ja = 9.366
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
				arg_69_0:Play120011017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.225

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[319].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(120011016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011016", "story_v_out_120011.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011016", "story_v_out_120011.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_120011", "120011016", "story_v_out_120011.awb")

						arg_69_1:RecordAudio("120011016", var_72_9)
						arg_69_1:RecordAudio("120011016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120011", "120011016", "story_v_out_120011.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120011", "120011016", "story_v_out_120011.awb")
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
	Play120011017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120011017
		arg_73_1.duration_ = 11.83

		local var_73_0 = {
			zh = 11.666,
			ja = 11.833
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
				arg_73_0:Play120011018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.25

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[319].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(120011017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011017", "story_v_out_120011.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011017", "story_v_out_120011.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_120011", "120011017", "story_v_out_120011.awb")

						arg_73_1:RecordAudio("120011017", var_76_9)
						arg_73_1:RecordAudio("120011017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_120011", "120011017", "story_v_out_120011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_120011", "120011017", "story_v_out_120011.awb")
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
	Play120011018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120011018
		arg_77_1.duration_ = 4.77

		local var_77_0 = {
			zh = 1.566,
			ja = 4.766
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
				arg_77_0:Play120011019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.125

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[36].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(120011018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011018", "story_v_out_120011.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011018", "story_v_out_120011.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_120011", "120011018", "story_v_out_120011.awb")

						arg_77_1:RecordAudio("120011018", var_80_9)
						arg_77_1:RecordAudio("120011018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_120011", "120011018", "story_v_out_120011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_120011", "120011018", "story_v_out_120011.awb")
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
	Play120011019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120011019
		arg_81_1.duration_ = 13.53

		local var_81_0 = {
			zh = 8.466,
			ja = 13.533
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
				arg_81_0:Play120011020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.85

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[319].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(120011019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011019", "story_v_out_120011.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011019", "story_v_out_120011.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_120011", "120011019", "story_v_out_120011.awb")

						arg_81_1:RecordAudio("120011019", var_84_9)
						arg_81_1:RecordAudio("120011019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120011", "120011019", "story_v_out_120011.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120011", "120011019", "story_v_out_120011.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120011020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120011020
		arg_85_1.duration_ = 3.5

		local var_85_0 = {
			zh = 3.3,
			ja = 3.5
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
				arg_85_0:Play120011021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.4

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[319].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(120011020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011020", "story_v_out_120011.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011020", "story_v_out_120011.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_120011", "120011020", "story_v_out_120011.awb")

						arg_85_1:RecordAudio("120011020", var_88_9)
						arg_85_1:RecordAudio("120011020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120011", "120011020", "story_v_out_120011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120011", "120011020", "story_v_out_120011.awb")
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
	Play120011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120011021
		arg_89_1.duration_ = 13.27

		local var_89_0 = {
			zh = 13.266,
			ja = 12.733
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
				arg_89_0:Play120011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.45

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[319].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(120011021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011021", "story_v_out_120011.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011021", "story_v_out_120011.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_120011", "120011021", "story_v_out_120011.awb")

						arg_89_1:RecordAudio("120011021", var_92_9)
						arg_89_1:RecordAudio("120011021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_120011", "120011021", "story_v_out_120011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_120011", "120011021", "story_v_out_120011.awb")
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
	Play120011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120011022
		arg_93_1.duration_ = 9.8

		local var_93_0 = {
			zh = 6.3,
			ja = 9.8
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
				arg_93_0:Play120011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.575

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[319].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(120011022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011022", "story_v_out_120011.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011022", "story_v_out_120011.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_120011", "120011022", "story_v_out_120011.awb")

						arg_93_1:RecordAudio("120011022", var_96_9)
						arg_93_1:RecordAudio("120011022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_120011", "120011022", "story_v_out_120011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_120011", "120011022", "story_v_out_120011.awb")
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
	Play120011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120011023
		arg_97_1.duration_ = 4

		local var_97_0 = {
			zh = 3.966,
			ja = 4
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play120011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.275

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[36].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(120011023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 11
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011023", "story_v_out_120011.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011023", "story_v_out_120011.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_120011", "120011023", "story_v_out_120011.awb")

						arg_97_1:RecordAudio("120011023", var_100_9)
						arg_97_1:RecordAudio("120011023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_120011", "120011023", "story_v_out_120011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_120011", "120011023", "story_v_out_120011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120011024
		arg_101_1.duration_ = 4.7

		local var_101_0 = {
			zh = 3.133,
			ja = 4.7
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
				arg_101_0:Play120011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.35

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[319].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(120011024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011024", "story_v_out_120011.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011024", "story_v_out_120011.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_120011", "120011024", "story_v_out_120011.awb")

						arg_101_1:RecordAudio("120011024", var_104_9)
						arg_101_1:RecordAudio("120011024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_120011", "120011024", "story_v_out_120011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_120011", "120011024", "story_v_out_120011.awb")
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
	Play120011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120011025
		arg_105_1.duration_ = 1.27

		local var_105_0 = {
			zh = 1.266,
			ja = 0.999999999999
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
				arg_105_0:Play120011026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.05

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[36].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(120011025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011025", "story_v_out_120011.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011025", "story_v_out_120011.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_120011", "120011025", "story_v_out_120011.awb")

						arg_105_1:RecordAudio("120011025", var_108_9)
						arg_105_1:RecordAudio("120011025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_120011", "120011025", "story_v_out_120011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_120011", "120011025", "story_v_out_120011.awb")
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
	Play120011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120011026
		arg_109_1.duration_ = 4.73

		local var_109_0 = {
			zh = 4.133,
			ja = 4.733
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
				arg_109_0:Play120011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.575

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[319].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(120011026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011026", "story_v_out_120011.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011026", "story_v_out_120011.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_120011", "120011026", "story_v_out_120011.awb")

						arg_109_1:RecordAudio("120011026", var_112_9)
						arg_109_1:RecordAudio("120011026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_120011", "120011026", "story_v_out_120011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_120011", "120011026", "story_v_out_120011.awb")
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
	Play120011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120011027
		arg_113_1.duration_ = 8.6

		local var_113_0 = {
			zh = 6.1,
			ja = 8.6
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
				arg_113_0:Play120011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.525

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[319].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(120011027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011027", "story_v_out_120011.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011027", "story_v_out_120011.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_120011", "120011027", "story_v_out_120011.awb")

						arg_113_1:RecordAudio("120011027", var_116_9)
						arg_113_1:RecordAudio("120011027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120011", "120011027", "story_v_out_120011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120011", "120011027", "story_v_out_120011.awb")
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
	Play120011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120011028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play120011029(arg_117_1)
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

				local var_120_2 = arg_117_1:GetWordFromCfg(120011028)
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
	Play120011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120011029
		arg_121_1.duration_ = 6.9

		local var_121_0 = {
			zh = 6.9,
			ja = 5.2
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
				arg_121_0:Play120011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.675

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[319].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(120011029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 27
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011029", "story_v_out_120011.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011029", "story_v_out_120011.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_120011", "120011029", "story_v_out_120011.awb")

						arg_121_1:RecordAudio("120011029", var_124_9)
						arg_121_1:RecordAudio("120011029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120011", "120011029", "story_v_out_120011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120011", "120011029", "story_v_out_120011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120011030
		arg_125_1.duration_ = 5.1

		local var_125_0 = {
			zh = 1.666,
			ja = 5.1
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
				arg_125_0:Play120011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.225

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[36].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(120011030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011030", "story_v_out_120011.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011030", "story_v_out_120011.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_120011", "120011030", "story_v_out_120011.awb")

						arg_125_1:RecordAudio("120011030", var_128_9)
						arg_125_1:RecordAudio("120011030", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_120011", "120011030", "story_v_out_120011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_120011", "120011030", "story_v_out_120011.awb")
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
	Play120011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120011031
		arg_129_1.duration_ = 6

		local var_129_0 = {
			zh = 4.033,
			ja = 6
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
				arg_129_0:Play120011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.525

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[319].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(120011031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011031", "story_v_out_120011.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011031", "story_v_out_120011.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_120011", "120011031", "story_v_out_120011.awb")

						arg_129_1:RecordAudio("120011031", var_132_9)
						arg_129_1:RecordAudio("120011031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_120011", "120011031", "story_v_out_120011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_120011", "120011031", "story_v_out_120011.awb")
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
	Play120011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120011032
		arg_133_1.duration_ = 8.47

		local var_133_0 = {
			zh = 6.433,
			ja = 8.466
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
				arg_133_0:Play120011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.7

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[319].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(120011032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011032", "story_v_out_120011.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011032", "story_v_out_120011.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_120011", "120011032", "story_v_out_120011.awb")

						arg_133_1:RecordAudio("120011032", var_136_9)
						arg_133_1:RecordAudio("120011032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_120011", "120011032", "story_v_out_120011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_120011", "120011032", "story_v_out_120011.awb")
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
	Play120011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120011033
		arg_137_1.duration_ = 2.4

		local var_137_0 = {
			zh = 1.033,
			ja = 2.4
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
				arg_137_0:Play120011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.075

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[36].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(120011033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011033", "story_v_out_120011.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011033", "story_v_out_120011.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_120011", "120011033", "story_v_out_120011.awb")

						arg_137_1:RecordAudio("120011033", var_140_9)
						arg_137_1:RecordAudio("120011033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120011", "120011033", "story_v_out_120011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120011", "120011033", "story_v_out_120011.awb")
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
	Play120011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120011034
		arg_141_1.duration_ = 10.83

		local var_141_0 = {
			zh = 7.066,
			ja = 10.833
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
				arg_141_0:Play120011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.325

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[319].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(120011034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 13
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011034", "story_v_out_120011.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011034", "story_v_out_120011.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_120011", "120011034", "story_v_out_120011.awb")

						arg_141_1:RecordAudio("120011034", var_144_9)
						arg_141_1:RecordAudio("120011034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120011", "120011034", "story_v_out_120011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120011", "120011034", "story_v_out_120011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120011035
		arg_145_1.duration_ = 3.6

		local var_145_0 = {
			zh = 2.4,
			ja = 3.6
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
				arg_145_0:Play120011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.3

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[36].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(120011035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011035", "story_v_out_120011.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011035", "story_v_out_120011.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_120011", "120011035", "story_v_out_120011.awb")

						arg_145_1:RecordAudio("120011035", var_148_9)
						arg_145_1:RecordAudio("120011035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_120011", "120011035", "story_v_out_120011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_120011", "120011035", "story_v_out_120011.awb")
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
	Play120011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120011036
		arg_149_1.duration_ = 7.03

		local var_149_0 = {
			zh = 7.033,
			ja = 5.166
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
				arg_149_0:Play120011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.775

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[319].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(120011036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011036", "story_v_out_120011.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011036", "story_v_out_120011.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_120011", "120011036", "story_v_out_120011.awb")

						arg_149_1:RecordAudio("120011036", var_152_9)
						arg_149_1:RecordAudio("120011036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120011", "120011036", "story_v_out_120011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120011", "120011036", "story_v_out_120011.awb")
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
	Play120011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120011037
		arg_153_1.duration_ = 10.3

		local var_153_0 = {
			zh = 6.133,
			ja = 10.3
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
				arg_153_0:Play120011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.75

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[319].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(120011037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011037", "story_v_out_120011.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011037", "story_v_out_120011.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_120011", "120011037", "story_v_out_120011.awb")

						arg_153_1:RecordAudio("120011037", var_156_9)
						arg_153_1:RecordAudio("120011037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120011", "120011037", "story_v_out_120011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120011", "120011037", "story_v_out_120011.awb")
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
	Play120011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120011038
		arg_157_1.duration_ = 11.2

		local var_157_0 = {
			zh = 9.366,
			ja = 11.2
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
				arg_157_0:Play120011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.9

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[319].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(120011038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011038", "story_v_out_120011.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011038", "story_v_out_120011.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_120011", "120011038", "story_v_out_120011.awb")

						arg_157_1:RecordAudio("120011038", var_160_9)
						arg_157_1:RecordAudio("120011038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120011", "120011038", "story_v_out_120011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120011", "120011038", "story_v_out_120011.awb")
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
	Play120011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120011039
		arg_161_1.duration_ = 14.5

		local var_161_0 = {
			zh = 5.466,
			ja = 14.5
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
				arg_161_0:Play120011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.575

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[36].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(120011039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011039", "story_v_out_120011.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011039", "story_v_out_120011.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_120011", "120011039", "story_v_out_120011.awb")

						arg_161_1:RecordAudio("120011039", var_164_9)
						arg_161_1:RecordAudio("120011039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120011", "120011039", "story_v_out_120011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120011", "120011039", "story_v_out_120011.awb")
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
	Play120011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120011040
		arg_165_1.duration_ = 8.47

		local var_165_0 = {
			zh = 8.466,
			ja = 6.6
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
				arg_165_0:Play120011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.9

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[319].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(120011040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 36
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011040", "story_v_out_120011.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011040", "story_v_out_120011.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_120011", "120011040", "story_v_out_120011.awb")

						arg_165_1:RecordAudio("120011040", var_168_9)
						arg_165_1:RecordAudio("120011040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_120011", "120011040", "story_v_out_120011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_120011", "120011040", "story_v_out_120011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play120011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120011041
		arg_169_1.duration_ = 9.6

		local var_169_0 = {
			zh = 9.6,
			ja = 7.9
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
				arg_169_0:Play120011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.075

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[319].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(120011041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 43
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011041", "story_v_out_120011.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011041", "story_v_out_120011.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_120011", "120011041", "story_v_out_120011.awb")

						arg_169_1:RecordAudio("120011041", var_172_9)
						arg_169_1:RecordAudio("120011041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120011", "120011041", "story_v_out_120011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120011", "120011041", "story_v_out_120011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play120011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120011042
		arg_173_1.duration_ = 7.43

		local var_173_0 = {
			zh = 6.3,
			ja = 7.433
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
				arg_173_0:Play120011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.625

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[36].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(120011042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011042", "story_v_out_120011.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011042", "story_v_out_120011.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_120011", "120011042", "story_v_out_120011.awb")

						arg_173_1:RecordAudio("120011042", var_176_9)
						arg_173_1:RecordAudio("120011042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120011", "120011042", "story_v_out_120011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120011", "120011042", "story_v_out_120011.awb")
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
	Play120011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120011043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play120011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.75

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

				local var_180_2 = arg_177_1:GetWordFromCfg(120011043)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 29
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
	Play120011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120011044
		arg_181_1.duration_ = 9

		local var_181_0 = {
			zh = 8.866,
			ja = 9
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
				arg_181_0:Play120011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.275

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[36].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(120011044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011044", "story_v_out_120011.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011044", "story_v_out_120011.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_120011", "120011044", "story_v_out_120011.awb")

						arg_181_1:RecordAudio("120011044", var_184_9)
						arg_181_1:RecordAudio("120011044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_120011", "120011044", "story_v_out_120011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_120011", "120011044", "story_v_out_120011.awb")
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
	Play120011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120011045
		arg_185_1.duration_ = 3.53

		local var_185_0 = {
			zh = 3.3,
			ja = 3.533
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
				arg_185_0:Play120011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.225

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[319].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(120011045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 9
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011045", "story_v_out_120011.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011045", "story_v_out_120011.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_120011", "120011045", "story_v_out_120011.awb")

						arg_185_1:RecordAudio("120011045", var_188_9)
						arg_185_1:RecordAudio("120011045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120011", "120011045", "story_v_out_120011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120011", "120011045", "story_v_out_120011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120011046
		arg_189_1.duration_ = 7.7

		local var_189_0 = {
			zh = 4.9,
			ja = 7.7
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
				arg_189_0:Play120011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.45

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[36].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(120011046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 18
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011046", "story_v_out_120011.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011046", "story_v_out_120011.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_120011", "120011046", "story_v_out_120011.awb")

						arg_189_1:RecordAudio("120011046", var_192_9)
						arg_189_1:RecordAudio("120011046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120011", "120011046", "story_v_out_120011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120011", "120011046", "story_v_out_120011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play120011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120011047
		arg_193_1.duration_ = 12.17

		local var_193_0 = {
			zh = 8.7,
			ja = 12.166
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
				arg_193_0:Play120011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.9

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[36].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(120011047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011047", "story_v_out_120011.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011047", "story_v_out_120011.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_120011", "120011047", "story_v_out_120011.awb")

						arg_193_1:RecordAudio("120011047", var_196_9)
						arg_193_1:RecordAudio("120011047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_120011", "120011047", "story_v_out_120011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_120011", "120011047", "story_v_out_120011.awb")
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
	Play120011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120011048
		arg_197_1.duration_ = 7.87

		local var_197_0 = {
			zh = 5.866,
			ja = 7.866
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
				arg_197_0:Play120011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.55

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[36].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(120011048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 22
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011048", "story_v_out_120011.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011048", "story_v_out_120011.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_120011", "120011048", "story_v_out_120011.awb")

						arg_197_1:RecordAudio("120011048", var_200_9)
						arg_197_1:RecordAudio("120011048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120011", "120011048", "story_v_out_120011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120011", "120011048", "story_v_out_120011.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play120011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120011049
		arg_201_1.duration_ = 6.9

		local var_201_0 = {
			zh = 5.3,
			ja = 6.9
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
				arg_201_0:Play120011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.525

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[319].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(120011049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011049", "story_v_out_120011.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011049", "story_v_out_120011.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_120011", "120011049", "story_v_out_120011.awb")

						arg_201_1:RecordAudio("120011049", var_204_9)
						arg_201_1:RecordAudio("120011049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120011", "120011049", "story_v_out_120011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120011", "120011049", "story_v_out_120011.awb")
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
	Play120011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120011050
		arg_205_1.duration_ = 3.03

		local var_205_0 = {
			zh = 1.6,
			ja = 3.033
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
				arg_205_0:Play120011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.2

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[319].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(120011050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011050", "story_v_out_120011.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011050", "story_v_out_120011.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_120011", "120011050", "story_v_out_120011.awb")

						arg_205_1:RecordAudio("120011050", var_208_9)
						arg_205_1:RecordAudio("120011050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_120011", "120011050", "story_v_out_120011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_120011", "120011050", "story_v_out_120011.awb")
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
	Play120011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120011051
		arg_209_1.duration_ = 1.97

		local var_209_0 = {
			zh = 1.266,
			ja = 1.966
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
				arg_209_0:Play120011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.1

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[36].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(120011051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 4
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011051", "story_v_out_120011.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011051", "story_v_out_120011.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_120011", "120011051", "story_v_out_120011.awb")

						arg_209_1:RecordAudio("120011051", var_212_9)
						arg_209_1:RecordAudio("120011051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_120011", "120011051", "story_v_out_120011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_120011", "120011051", "story_v_out_120011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play120011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 120011052
		arg_213_1.duration_ = 3.67

		local var_213_0 = {
			zh = 3.666,
			ja = 1.8
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
				arg_213_0:Play120011053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.3

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[319].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(120011052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 12
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011052", "story_v_out_120011.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011052", "story_v_out_120011.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_120011", "120011052", "story_v_out_120011.awb")

						arg_213_1:RecordAudio("120011052", var_216_9)
						arg_213_1:RecordAudio("120011052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_120011", "120011052", "story_v_out_120011.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_120011", "120011052", "story_v_out_120011.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play120011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 120011053
		arg_217_1.duration_ = 10.1

		local var_217_0 = {
			zh = 10.1,
			ja = 8.366
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
				arg_217_0:Play120011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.95

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[319].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(120011053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 38
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011053", "story_v_out_120011.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011053", "story_v_out_120011.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_120011", "120011053", "story_v_out_120011.awb")

						arg_217_1:RecordAudio("120011053", var_220_9)
						arg_217_1:RecordAudio("120011053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_120011", "120011053", "story_v_out_120011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_120011", "120011053", "story_v_out_120011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play120011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 120011054
		arg_221_1.duration_ = 5.1

		local var_221_0 = {
			zh = 1.633,
			ja = 5.1
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
				arg_221_0:Play120011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.2

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[36].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(120011054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011054", "story_v_out_120011.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011054", "story_v_out_120011.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_120011", "120011054", "story_v_out_120011.awb")

						arg_221_1:RecordAudio("120011054", var_224_9)
						arg_221_1:RecordAudio("120011054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_120011", "120011054", "story_v_out_120011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_120011", "120011054", "story_v_out_120011.awb")
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
	Play120011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120011055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play120011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.2

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(120011055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 48
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play120011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120011056
		arg_229_1.duration_ = 1.93

		local var_229_0 = {
			zh = 1.6,
			ja = 1.933
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
				arg_229_0:Play120011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.175

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[319].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(120011056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 7
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011056", "story_v_out_120011.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011056", "story_v_out_120011.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_120011", "120011056", "story_v_out_120011.awb")

						arg_229_1:RecordAudio("120011056", var_232_9)
						arg_229_1:RecordAudio("120011056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_120011", "120011056", "story_v_out_120011.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_120011", "120011056", "story_v_out_120011.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play120011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120011057
		arg_233_1.duration_ = 6.97

		local var_233_0 = {
			zh = 3.9,
			ja = 6.966
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play120011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.375

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[36].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:GetWordFromCfg(120011057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 15
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011057", "story_v_out_120011.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011057", "story_v_out_120011.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_120011", "120011057", "story_v_out_120011.awb")

						arg_233_1:RecordAudio("120011057", var_236_9)
						arg_233_1:RecordAudio("120011057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_120011", "120011057", "story_v_out_120011.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_120011", "120011057", "story_v_out_120011.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play120011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 120011058
		arg_237_1.duration_ = 4.97

		local var_237_0 = {
			zh = 4.966,
			ja = 3.733
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
				arg_237_0:Play120011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.4

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[319].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(120011058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011058", "story_v_out_120011.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011058", "story_v_out_120011.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_120011", "120011058", "story_v_out_120011.awb")

						arg_237_1:RecordAudio("120011058", var_240_9)
						arg_237_1:RecordAudio("120011058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_120011", "120011058", "story_v_out_120011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_120011", "120011058", "story_v_out_120011.awb")
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
	Play120011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120011059
		arg_241_1.duration_ = 7.5

		local var_241_0 = {
			zh = 5.966,
			ja = 7.5
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play120011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.525

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[36].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(120011059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011059", "story_v_out_120011.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011059", "story_v_out_120011.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_120011", "120011059", "story_v_out_120011.awb")

						arg_241_1:RecordAudio("120011059", var_244_9)
						arg_241_1:RecordAudio("120011059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_120011", "120011059", "story_v_out_120011.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_120011", "120011059", "story_v_out_120011.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play120011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120011060
		arg_245_1.duration_ = 1.3

		local var_245_0 = {
			zh = 1.3,
			ja = 1.1
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
				arg_245_0:Play120011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.075

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[319].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(120011060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 3
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011060", "story_v_out_120011.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011060", "story_v_out_120011.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_120011", "120011060", "story_v_out_120011.awb")

						arg_245_1:RecordAudio("120011060", var_248_9)
						arg_245_1:RecordAudio("120011060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120011", "120011060", "story_v_out_120011.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120011", "120011060", "story_v_out_120011.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play120011061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120011061
		arg_249_1.duration_ = 4.47

		local var_249_0 = {
			zh = 1.8,
			ja = 4.466
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
				arg_249_0:Play120011062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.15

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[36].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(120011061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 6
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011061", "story_v_out_120011.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011061", "story_v_out_120011.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_120011", "120011061", "story_v_out_120011.awb")

						arg_249_1:RecordAudio("120011061", var_252_9)
						arg_249_1:RecordAudio("120011061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120011", "120011061", "story_v_out_120011.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120011", "120011061", "story_v_out_120011.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play120011062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120011062
		arg_253_1.duration_ = 1.1

		local var_253_0 = {
			zh = 1.066,
			ja = 1.1
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
				arg_253_0:Play120011063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.05

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[319].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:GetWordFromCfg(120011062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 2
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011062", "story_v_out_120011.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011062", "story_v_out_120011.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_120011", "120011062", "story_v_out_120011.awb")

						arg_253_1:RecordAudio("120011062", var_256_9)
						arg_253_1:RecordAudio("120011062", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_120011", "120011062", "story_v_out_120011.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_120011", "120011062", "story_v_out_120011.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play120011063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120011063
		arg_257_1.duration_ = 5.13

		local var_257_0 = {
			zh = 5.133,
			ja = 2.266
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
				arg_257_0:Play120011064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.45

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[319].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(120011063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011063", "story_v_out_120011.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011063", "story_v_out_120011.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_120011", "120011063", "story_v_out_120011.awb")

						arg_257_1:RecordAudio("120011063", var_260_9)
						arg_257_1:RecordAudio("120011063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120011", "120011063", "story_v_out_120011.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120011", "120011063", "story_v_out_120011.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120011064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120011064
		arg_261_1.duration_ = 9

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play120011065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = "ST45"

			if arg_261_1.bgs_[var_264_0] == nil then
				local var_264_1 = Object.Instantiate(arg_261_1.paintGo_)

				var_264_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_264_0)
				var_264_1.name = var_264_0
				var_264_1.transform.parent = arg_261_1.stage_.transform
				var_264_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_[var_264_0] = var_264_1
			end

			local var_264_2 = 2

			if var_264_2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				local var_264_3 = manager.ui.mainCamera.transform.localPosition
				local var_264_4 = Vector3.New(0, 0, 10) + Vector3.New(var_264_3.x, var_264_3.y, 0)
				local var_264_5 = arg_261_1.bgs_.ST45

				var_264_5.transform.localPosition = var_264_4
				var_264_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_6 = var_264_5:GetComponent("SpriteRenderer")

				if var_264_6 and var_264_6.sprite then
					local var_264_7 = (var_264_5.transform.localPosition - var_264_3).z
					local var_264_8 = manager.ui.mainCameraCom_
					local var_264_9 = 2 * var_264_7 * Mathf.Tan(var_264_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_264_10 = var_264_9 * var_264_8.aspect
					local var_264_11 = var_264_6.sprite.bounds.size.x
					local var_264_12 = var_264_6.sprite.bounds.size.y
					local var_264_13 = var_264_10 / var_264_11
					local var_264_14 = var_264_9 / var_264_12
					local var_264_15 = var_264_14 < var_264_13 and var_264_13 or var_264_14

					var_264_5.transform.localScale = Vector3.New(var_264_15, var_264_15, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "ST45" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_17 = 2

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17
				local var_264_19 = Color.New(0, 0, 0)

				var_264_19.a = Mathf.Lerp(0, 1, var_264_18)
				arg_261_1.mask_.color = var_264_19
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 then
				local var_264_20 = Color.New(0, 0, 0)

				var_264_20.a = 1
				arg_261_1.mask_.color = var_264_20
			end

			local var_264_21 = 2

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_22 = 2

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22
				local var_264_24 = Color.New(0, 0, 0)

				var_264_24.a = Mathf.Lerp(1, 0, var_264_23)
				arg_261_1.mask_.color = var_264_24
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 then
				local var_264_25 = Color.New(0, 0, 0)
				local var_264_26 = 0

				arg_261_1.mask_.enabled = false
				var_264_25.a = var_264_26
				arg_261_1.mask_.color = var_264_25
			end

			local var_264_27 = arg_261_1.bgs_.ST45.transform
			local var_264_28 = 2

			if var_264_28 < arg_261_1.time_ and arg_261_1.time_ <= var_264_28 + arg_264_0 then
				arg_261_1.var_.moveOldPosST45 = var_264_27.localPosition
			end

			local var_264_29 = 0.001

			if var_264_28 <= arg_261_1.time_ and arg_261_1.time_ < var_264_28 + var_264_29 then
				local var_264_30 = (arg_261_1.time_ - var_264_28) / var_264_29
				local var_264_31 = Vector3.New(0, 1, 9.5)

				var_264_27.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosST45, var_264_31, var_264_30)
			end

			if arg_261_1.time_ >= var_264_28 + var_264_29 and arg_261_1.time_ < var_264_28 + var_264_29 + arg_264_0 then
				var_264_27.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_264_32 = arg_261_1.bgs_.ST45.transform
			local var_264_33 = 2.01666666666667

			if var_264_33 < arg_261_1.time_ and arg_261_1.time_ <= var_264_33 + arg_264_0 then
				arg_261_1.var_.moveOldPosST45 = var_264_32.localPosition
			end

			local var_264_34 = 3.5

			if var_264_33 <= arg_261_1.time_ and arg_261_1.time_ < var_264_33 + var_264_34 then
				local var_264_35 = (arg_261_1.time_ - var_264_33) / var_264_34
				local var_264_36 = Vector3.New(0, 1, 10)

				var_264_32.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosST45, var_264_36, var_264_35)
			end

			if arg_261_1.time_ >= var_264_33 + var_264_34 and arg_261_1.time_ < var_264_33 + var_264_34 + arg_264_0 then
				var_264_32.localPosition = Vector3.New(0, 1, 10)
			end

			local var_264_37 = 3.9

			if var_264_37 < arg_261_1.time_ and arg_261_1.time_ <= var_264_37 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			local var_264_38 = 1.61666666666667

			if arg_261_1.time_ >= var_264_37 + var_264_38 and arg_261_1.time_ < var_264_37 + var_264_38 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_39 = 3.999999999999
			local var_264_40 = 0.6

			if var_264_39 < arg_261_1.time_ and arg_261_1.time_ <= var_264_39 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_41 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_41:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_42 = arg_261_1:GetWordFromCfg(120011064)
				local var_264_43 = arg_261_1:FormatText(var_264_42.content)

				arg_261_1.text_.text = var_264_43

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_44 = 24
				local var_264_45 = utf8.len(var_264_43)
				local var_264_46 = var_264_44 <= 0 and var_264_40 or var_264_40 * (var_264_45 / var_264_44)

				if var_264_46 > 0 and var_264_40 < var_264_46 then
					arg_261_1.talkMaxDuration = var_264_46
					var_264_39 = var_264_39 + 0.3

					if var_264_46 + var_264_39 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_46 + var_264_39
					end
				end

				arg_261_1.text_.text = var_264_43
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_47 = var_264_39 + 0.3
			local var_264_48 = math.max(var_264_40, arg_261_1.talkMaxDuration)

			if var_264_47 <= arg_261_1.time_ and arg_261_1.time_ < var_264_47 + var_264_48 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_47) / var_264_48

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_47 + var_264_48 and arg_261_1.time_ < var_264_47 + var_264_48 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST45",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST45",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play120011065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 120011065
		arg_267_1.duration_ = 3.97

		local var_267_0 = {
			zh = 3.133,
			ja = 3.966
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play120011066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.275

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[319].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(120011065)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 11
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011065", "story_v_out_120011.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011065", "story_v_out_120011.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_120011", "120011065", "story_v_out_120011.awb")

						arg_267_1:RecordAudio("120011065", var_270_9)
						arg_267_1:RecordAudio("120011065", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_120011", "120011065", "story_v_out_120011.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_120011", "120011065", "story_v_out_120011.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play120011066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 120011066
		arg_271_1.duration_ = 8.48

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play120011067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = "STblack"

			if arg_271_1.bgs_[var_274_0] == nil then
				local var_274_1 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_274_0)
				var_274_1.name = var_274_0
				var_274_1.transform.parent = arg_271_1.stage_.transform
				var_274_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_[var_274_0] = var_274_1
			end

			local var_274_2 = 2

			if var_274_2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				local var_274_3 = manager.ui.mainCamera.transform.localPosition
				local var_274_4 = Vector3.New(0, 0, 10) + Vector3.New(var_274_3.x, var_274_3.y, 0)
				local var_274_5 = arg_271_1.bgs_.STblack

				var_274_5.transform.localPosition = var_274_4
				var_274_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_6 = var_274_5:GetComponent("SpriteRenderer")

				if var_274_6 and var_274_6.sprite then
					local var_274_7 = (var_274_5.transform.localPosition - var_274_3).z
					local var_274_8 = manager.ui.mainCameraCom_
					local var_274_9 = 2 * var_274_7 * Mathf.Tan(var_274_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_10 = var_274_9 * var_274_8.aspect
					local var_274_11 = var_274_6.sprite.bounds.size.x
					local var_274_12 = var_274_6.sprite.bounds.size.y
					local var_274_13 = var_274_10 / var_274_11
					local var_274_14 = var_274_9 / var_274_12
					local var_274_15 = var_274_14 < var_274_13 and var_274_13 or var_274_14

					var_274_5.transform.localScale = Vector3.New(var_274_15, var_274_15, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "STblack" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_17 = 2

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_17 then
				local var_274_18 = (arg_271_1.time_ - var_274_16) / var_274_17
				local var_274_19 = Color.New(0, 0, 0)

				var_274_19.a = Mathf.Lerp(0, 1, var_274_18)
				arg_271_1.mask_.color = var_274_19
			end

			if arg_271_1.time_ >= var_274_16 + var_274_17 and arg_271_1.time_ < var_274_16 + var_274_17 + arg_274_0 then
				local var_274_20 = Color.New(0, 0, 0)

				var_274_20.a = 1
				arg_271_1.mask_.color = var_274_20
			end

			local var_274_21 = 2

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_22 = 2

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				local var_274_23 = (arg_271_1.time_ - var_274_21) / var_274_22
				local var_274_24 = Color.New(0, 0, 0)

				var_274_24.a = Mathf.Lerp(1, 0, var_274_23)
				arg_271_1.mask_.color = var_274_24
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				local var_274_25 = Color.New(0, 0, 0)
				local var_274_26 = 0

				arg_271_1.mask_.enabled = false
				var_274_25.a = var_274_26
				arg_271_1.mask_.color = var_274_25
			end

			local var_274_27 = 0
			local var_274_28 = 0.666666666666667

			if var_274_27 < arg_271_1.time_ and arg_271_1.time_ <= var_274_27 + arg_274_0 then
				local var_274_29 = "play"
				local var_274_30 = "music"

				arg_271_1:AudioAction(var_274_29, var_274_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_274_31 = ""
				local var_274_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_274_32 ~= "" then
					if arg_271_1.bgmTxt_.text ~= var_274_32 and arg_271_1.bgmTxt_.text ~= "" then
						if arg_271_1.bgmTxt2_.text ~= "" then
							arg_271_1.bgmTxt_.text = arg_271_1.bgmTxt2_.text
						end

						arg_271_1.bgmTxt2_.text = var_274_32

						arg_271_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_271_1.bgmTxt_.text = var_274_32
						arg_271_1.bgmTxt2_.text = var_274_32
					end

					if arg_271_1.bgmTimer then
						arg_271_1.bgmTimer:Stop()

						arg_271_1.bgmTimer = nil
					end

					if arg_271_1.settingData.show_music_name == 1 then
						arg_271_1.musicController:SetSelectedState("show")
						arg_271_1.musicAnimator_:Play("open", 0, 0)

						if arg_271_1.settingData.music_time ~= 0 then
							arg_271_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_271_1.settingData.music_time), function()
								if arg_271_1 == nil or isNil(arg_271_1.bgmTxt_) then
									return
								end

								arg_271_1.musicController:SetSelectedState("hide")
								arg_271_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_33 = 3.475
			local var_274_34 = 0.525

			if var_274_33 < arg_271_1.time_ and arg_271_1.time_ <= var_274_33 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_35 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_35:setOnUpdate(LuaHelper.FloatAction(function(arg_276_0)
					arg_271_1.dialogCg_.alpha = arg_276_0
				end))
				var_274_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_36 = arg_271_1:GetWordFromCfg(120011066)
				local var_274_37 = arg_271_1:FormatText(var_274_36.content)

				arg_271_1.text_.text = var_274_37

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_38 = 21
				local var_274_39 = utf8.len(var_274_37)
				local var_274_40 = var_274_38 <= 0 and var_274_34 or var_274_34 * (var_274_39 / var_274_38)

				if var_274_40 > 0 and var_274_34 < var_274_40 then
					arg_271_1.talkMaxDuration = var_274_40
					var_274_33 = var_274_33 + 0.3

					if var_274_40 + var_274_33 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_40 + var_274_33
					end
				end

				arg_271_1.text_.text = var_274_37
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_41 = var_274_33 + 0.3
			local var_274_42 = math.max(var_274_34, arg_271_1.talkMaxDuration)

			if var_274_41 <= arg_271_1.time_ and arg_271_1.time_ < var_274_41 + var_274_42 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_41) / var_274_42

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_41 + var_274_42 and arg_271_1.time_ < var_274_41 + var_274_42 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play120011067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 120011067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play120011068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.375

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(120011067)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 55
				local var_281_5 = utf8.len(var_281_3)
				local var_281_6 = var_281_4 <= 0 and var_281_1 or var_281_1 * (var_281_5 / var_281_4)

				if var_281_6 > 0 and var_281_1 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_7 and arg_278_1.time_ < var_281_0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play120011068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 120011068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play120011069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.475

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(120011068)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 19
				local var_285_5 = utf8.len(var_285_3)
				local var_285_6 = var_285_4 <= 0 and var_285_1 or var_285_1 * (var_285_5 / var_285_4)

				if var_285_6 > 0 and var_285_1 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_7 and arg_282_1.time_ < var_285_0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play120011069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 120011069
		arg_286_1.duration_ = 0.33

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"

			SetActive(arg_286_1.choicesGo_, true)

			for iter_287_0, iter_287_1 in ipairs(arg_286_1.choices_) do
				local var_287_0 = iter_287_0 <= 2

				SetActive(iter_287_1.go, var_287_0)
			end

			arg_286_1.choices_[1].txt.text = arg_286_1:FormatText(StoryChoiceCfg[362].name)
			arg_286_1.choices_[2].txt.text = arg_286_1:FormatText(StoryChoiceCfg[363].name)
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play120011070(arg_286_1)
			end

			if arg_288_0 == 2 then
				arg_286_0:Play120011072(arg_286_1)
			end

			arg_286_1:RecordChoiceLog(120011069, 362, 363)
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			local var_289_1 = 0.333333333333333

			if arg_286_1.time_ >= var_289_0 + var_289_1 and arg_286_1.time_ < var_289_0 + var_289_1 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play120011070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 120011070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play120011071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.675

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(120011070)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 27
				local var_293_5 = utf8.len(var_293_3)
				local var_293_6 = var_293_4 <= 0 and var_293_1 or var_293_1 * (var_293_5 / var_293_4)

				if var_293_6 > 0 and var_293_1 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_7 and arg_290_1.time_ < var_293_0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play120011071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 120011071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play120011074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.5

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(120011071)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 20
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play120011074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 120011074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play120011075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 1.025

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(120011074)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 41
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play120011075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 120011075
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play120011076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 1

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				local var_305_2 = "play"
				local var_305_3 = "effect"

				arg_302_1:AudioAction(var_305_2, var_305_3, "se_story_16", "se_story_16_gun", "")
			end

			local var_305_4 = 0
			local var_305_5 = 0.1

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(120011075)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_8 = 4
				local var_305_9 = utf8.len(var_305_7)
				local var_305_10 = var_305_8 <= 0 and var_305_5 or var_305_5 * (var_305_9 / var_305_8)

				if var_305_10 > 0 and var_305_5 < var_305_10 then
					arg_302_1.talkMaxDuration = var_305_10

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_11 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_11 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_11

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_11 and arg_302_1.time_ < var_305_4 + var_305_11 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play120011076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 120011076
		arg_306_1.duration_ = 1

		local var_306_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play120011077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.075

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[6].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:GetWordFromCfg(120011076)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 3
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011076", "story_v_out_120011.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011076", "story_v_out_120011.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_120011", "120011076", "story_v_out_120011.awb")

						arg_306_1:RecordAudio("120011076", var_309_9)
						arg_306_1:RecordAudio("120011076", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_120011", "120011076", "story_v_out_120011.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_120011", "120011076", "story_v_out_120011.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play120011077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 120011077
		arg_310_1.duration_ = 7

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play120011078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = "ST31"

			if arg_310_1.bgs_[var_313_0] == nil then
				local var_313_1 = Object.Instantiate(arg_310_1.paintGo_)

				var_313_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_313_0)
				var_313_1.name = var_313_0
				var_313_1.transform.parent = arg_310_1.stage_.transform
				var_313_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_[var_313_0] = var_313_1
			end

			local var_313_2 = 0

			if var_313_2 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				local var_313_3 = manager.ui.mainCamera.transform.localPosition
				local var_313_4 = Vector3.New(0, 0, 10) + Vector3.New(var_313_3.x, var_313_3.y, 0)
				local var_313_5 = arg_310_1.bgs_.ST31

				var_313_5.transform.localPosition = var_313_4
				var_313_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_6 = var_313_5:GetComponent("SpriteRenderer")

				if var_313_6 and var_313_6.sprite then
					local var_313_7 = (var_313_5.transform.localPosition - var_313_3).z
					local var_313_8 = manager.ui.mainCameraCom_
					local var_313_9 = 2 * var_313_7 * Mathf.Tan(var_313_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_313_10 = var_313_9 * var_313_8.aspect
					local var_313_11 = var_313_6.sprite.bounds.size.x
					local var_313_12 = var_313_6.sprite.bounds.size.y
					local var_313_13 = var_313_10 / var_313_11
					local var_313_14 = var_313_9 / var_313_12
					local var_313_15 = var_313_14 < var_313_13 and var_313_13 or var_313_14

					var_313_5.transform.localScale = Vector3.New(var_313_15, var_313_15, 0)
				end

				for iter_313_0, iter_313_1 in pairs(arg_310_1.bgs_) do
					if iter_313_0 ~= "ST31" then
						iter_313_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_313_16 = 0

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_17 = 2

			if var_313_16 <= arg_310_1.time_ and arg_310_1.time_ < var_313_16 + var_313_17 then
				local var_313_18 = (arg_310_1.time_ - var_313_16) / var_313_17
				local var_313_19 = Color.New(0, 0, 0)

				var_313_19.a = Mathf.Lerp(1, 0, var_313_18)
				arg_310_1.mask_.color = var_313_19
			end

			if arg_310_1.time_ >= var_313_16 + var_313_17 and arg_310_1.time_ < var_313_16 + var_313_17 + arg_313_0 then
				local var_313_20 = Color.New(0, 0, 0)
				local var_313_21 = 0

				arg_310_1.mask_.enabled = false
				var_313_20.a = var_313_21
				arg_310_1.mask_.color = var_313_20
			end

			local var_313_22 = 0
			local var_313_23 = 1

			if var_313_22 < arg_310_1.time_ and arg_310_1.time_ <= var_313_22 + arg_313_0 then
				local var_313_24 = "play"
				local var_313_25 = "effect"

				arg_310_1:AudioAction(var_313_24, var_313_25, "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_313_26 = "ST31_blur"

			if arg_310_1.bgs_[var_313_26] == nil then
				local var_313_27 = Object.Instantiate(arg_310_1.blurPaintGo_)
				local var_313_28 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_313_26)

				var_313_27:GetComponent("SpriteRenderer").sprite = var_313_28
				var_313_27.name = var_313_26
				var_313_27.transform.parent = arg_310_1.stage_.transform
				var_313_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_[var_313_26] = var_313_27
			end

			local var_313_29 = 0
			local var_313_30 = arg_310_1.bgs_[var_313_26]

			if var_313_29 < arg_310_1.time_ and arg_310_1.time_ <= var_313_29 + arg_313_0 then
				local var_313_31 = manager.ui.mainCamera.transform.localPosition
				local var_313_32 = Vector3.New(0, 0, 10) + Vector3.New(var_313_31.x, var_313_31.y, 0)

				var_313_30.transform.localPosition = var_313_32
				var_313_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_33 = var_313_30:GetComponent("SpriteRenderer")

				if var_313_33 and var_313_33.sprite then
					local var_313_34 = (var_313_30.transform.localPosition - var_313_31).z
					local var_313_35 = manager.ui.mainCameraCom_
					local var_313_36 = 2 * var_313_34 * Mathf.Tan(var_313_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_313_37 = var_313_36 * var_313_35.aspect
					local var_313_38 = var_313_33.sprite.bounds.size.x
					local var_313_39 = var_313_33.sprite.bounds.size.y
					local var_313_40 = var_313_37 / var_313_38
					local var_313_41 = var_313_36 / var_313_39
					local var_313_42 = var_313_41 < var_313_40 and var_313_40 or var_313_41

					var_313_30.transform.localScale = Vector3.New(var_313_42, var_313_42, 0)
				end
			end

			local var_313_43 = 2

			if var_313_29 <= arg_310_1.time_ and arg_310_1.time_ < var_313_29 + var_313_43 then
				local var_313_44 = (arg_310_1.time_ - var_313_29) / var_313_43
				local var_313_45 = Color.New(1, 1, 1)

				var_313_45.a = Mathf.Lerp(0, 1, var_313_44)

				var_313_30:GetComponent("SpriteRenderer").material:SetColor("_Color", var_313_45)
			end

			local var_313_46 = 0
			local var_313_47 = 0.433333333333333

			if var_313_46 < arg_310_1.time_ and arg_310_1.time_ <= var_313_46 + arg_313_0 then
				local var_313_48 = "play"
				local var_313_49 = "music"

				arg_310_1:AudioAction(var_313_48, var_313_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_313_50 = ""
				local var_313_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_313_51 ~= "" then
					if arg_310_1.bgmTxt_.text ~= var_313_51 and arg_310_1.bgmTxt_.text ~= "" then
						if arg_310_1.bgmTxt2_.text ~= "" then
							arg_310_1.bgmTxt_.text = arg_310_1.bgmTxt2_.text
						end

						arg_310_1.bgmTxt2_.text = var_313_51

						arg_310_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_310_1.bgmTxt_.text = var_313_51
						arg_310_1.bgmTxt2_.text = var_313_51
					end

					if arg_310_1.bgmTimer then
						arg_310_1.bgmTimer:Stop()

						arg_310_1.bgmTimer = nil
					end

					if arg_310_1.settingData.show_music_name == 1 then
						arg_310_1.musicController:SetSelectedState("show")
						arg_310_1.musicAnimator_:Play("open", 0, 0)

						if arg_310_1.settingData.music_time ~= 0 then
							arg_310_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_310_1.settingData.music_time), function()
								if arg_310_1 == nil or isNil(arg_310_1.bgmTxt_) then
									return
								end

								arg_310_1.musicController:SetSelectedState("hide")
								arg_310_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_313_52 = 0.517975796759129
			local var_313_53 = 0.8

			if var_313_52 < arg_310_1.time_ and arg_310_1.time_ <= var_313_52 + arg_313_0 then
				local var_313_54 = "play"
				local var_313_55 = "music"

				arg_310_1:AudioAction(var_313_54, var_313_55, "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_313_56 = ""
				local var_313_57 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

				if var_313_57 ~= "" then
					if arg_310_1.bgmTxt_.text ~= var_313_57 and arg_310_1.bgmTxt_.text ~= "" then
						if arg_310_1.bgmTxt2_.text ~= "" then
							arg_310_1.bgmTxt_.text = arg_310_1.bgmTxt2_.text
						end

						arg_310_1.bgmTxt2_.text = var_313_57

						arg_310_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_310_1.bgmTxt_.text = var_313_57
						arg_310_1.bgmTxt2_.text = var_313_57
					end

					if arg_310_1.bgmTimer then
						arg_310_1.bgmTimer:Stop()

						arg_310_1.bgmTimer = nil
					end

					if arg_310_1.settingData.show_music_name == 1 then
						arg_310_1.musicController:SetSelectedState("show")
						arg_310_1.musicAnimator_:Play("open", 0, 0)

						if arg_310_1.settingData.music_time ~= 0 then
							arg_310_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_310_1.settingData.music_time), function()
								if arg_310_1 == nil or isNil(arg_310_1.bgmTxt_) then
									return
								end

								arg_310_1.musicController:SetSelectedState("hide")
								arg_310_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_58 = 2
			local var_313_59 = 1.075

			if var_313_58 < arg_310_1.time_ and arg_310_1.time_ <= var_313_58 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_60 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_60:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_310_1.dialogCg_.alpha = arg_316_0
				end))
				var_313_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_61 = arg_310_1:GetWordFromCfg(120011077)
				local var_313_62 = arg_310_1:FormatText(var_313_61.content)

				arg_310_1.text_.text = var_313_62

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_63 = 43
				local var_313_64 = utf8.len(var_313_62)
				local var_313_65 = var_313_63 <= 0 and var_313_59 or var_313_59 * (var_313_64 / var_313_63)

				if var_313_65 > 0 and var_313_59 < var_313_65 then
					arg_310_1.talkMaxDuration = var_313_65
					var_313_58 = var_313_58 + 0.3

					if var_313_65 + var_313_58 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_65 + var_313_58
					end
				end

				arg_310_1.text_.text = var_313_62
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_66 = var_313_58 + 0.3
			local var_313_67 = math.max(var_313_59, arg_310_1.talkMaxDuration)

			if var_313_66 <= arg_310_1.time_ and arg_310_1.time_ < var_313_66 + var_313_67 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_66) / var_313_67

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_66 + var_313_67 and arg_310_1.time_ < var_313_66 + var_313_67 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play120011078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 120011078
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play120011079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.55

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_2 = arg_318_1:GetWordFromCfg(120011078)
				local var_321_3 = arg_318_1:FormatText(var_321_2.content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 61
				local var_321_5 = utf8.len(var_321_3)
				local var_321_6 = var_321_4 <= 0 and var_321_1 or var_321_1 * (var_321_5 / var_321_4)

				if var_321_6 > 0 and var_321_1 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_7 and arg_318_1.time_ < var_321_0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play120011079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 120011079
		arg_322_1.duration_ = 3.5

		local var_322_0 = {
			zh = 3,
			ja = 3.5
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play120011080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = "1084ui_story"

			if arg_322_1.actors_[var_325_0] == nil then
				local var_325_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_325_1) then
					local var_325_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_322_1.stage_.transform)

					var_325_2.name = var_325_0
					var_325_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_322_1.actors_[var_325_0] = var_325_2

					local var_325_3 = var_325_2:GetComponentInChildren(typeof(CharacterEffect))

					var_325_3.enabled = true

					local var_325_4 = GameObjectTools.GetOrAddComponent(var_325_2, typeof(DynamicBoneHelper))

					if var_325_4 then
						var_325_4:EnableDynamicBone(false)
					end

					arg_322_1:ShowWeapon(var_325_3.transform, false)

					arg_322_1.var_[var_325_0 .. "Animator"] = var_325_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_322_1.var_[var_325_0 .. "Animator"].applyRootMotion = true
					arg_322_1.var_[var_325_0 .. "LipSync"] = var_325_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_325_5 = arg_322_1.actors_["1084ui_story"].transform
			local var_325_6 = 0

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.var_.moveOldPos1084ui_story = var_325_5.localPosition
			end

			local var_325_7 = 0.001

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_7 then
				local var_325_8 = (arg_322_1.time_ - var_325_6) / var_325_7
				local var_325_9 = Vector3.New(0, -0.97, -6)

				var_325_5.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1084ui_story, var_325_9, var_325_8)

				local var_325_10 = manager.ui.mainCamera.transform.position - var_325_5.position

				var_325_5.forward = Vector3.New(var_325_10.x, var_325_10.y, var_325_10.z)

				local var_325_11 = var_325_5.localEulerAngles

				var_325_11.z = 0
				var_325_11.x = 0
				var_325_5.localEulerAngles = var_325_11
			end

			if arg_322_1.time_ >= var_325_6 + var_325_7 and arg_322_1.time_ < var_325_6 + var_325_7 + arg_325_0 then
				var_325_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_325_12 = manager.ui.mainCamera.transform.position - var_325_5.position

				var_325_5.forward = Vector3.New(var_325_12.x, var_325_12.y, var_325_12.z)

				local var_325_13 = var_325_5.localEulerAngles

				var_325_13.z = 0
				var_325_13.x = 0
				var_325_5.localEulerAngles = var_325_13
			end

			local var_325_14 = arg_322_1.actors_["1084ui_story"]
			local var_325_15 = 0

			if var_325_15 < arg_322_1.time_ and arg_322_1.time_ <= var_325_15 + arg_325_0 and not isNil(var_325_14) and arg_322_1.var_.characterEffect1084ui_story == nil then
				arg_322_1.var_.characterEffect1084ui_story = var_325_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_16 = 0.2

			if var_325_15 <= arg_322_1.time_ and arg_322_1.time_ < var_325_15 + var_325_16 and not isNil(var_325_14) then
				local var_325_17 = (arg_322_1.time_ - var_325_15) / var_325_16

				if arg_322_1.var_.characterEffect1084ui_story and not isNil(var_325_14) then
					arg_322_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_15 + var_325_16 and arg_322_1.time_ < var_325_15 + var_325_16 + arg_325_0 and not isNil(var_325_14) and arg_322_1.var_.characterEffect1084ui_story then
				arg_322_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_325_18 = 0

			if var_325_18 < arg_322_1.time_ and arg_322_1.time_ <= var_325_18 + arg_325_0 then
				arg_322_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_325_19 = 0

			if var_325_19 < arg_322_1.time_ and arg_322_1.time_ <= var_325_19 + arg_325_0 then
				arg_322_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_325_20 = "ST31_blur"

			if arg_322_1.bgs_[var_325_20] == nil then
				local var_325_21 = Object.Instantiate(arg_322_1.blurPaintGo_)
				local var_325_22 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_325_20)

				var_325_21:GetComponent("SpriteRenderer").sprite = var_325_22
				var_325_21.name = var_325_20
				var_325_21.transform.parent = arg_322_1.stage_.transform
				var_325_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.bgs_[var_325_20] = var_325_21
			end

			local var_325_23 = 0
			local var_325_24 = arg_322_1.bgs_[var_325_20]

			if var_325_23 < arg_322_1.time_ and arg_322_1.time_ <= var_325_23 + arg_325_0 then
				local var_325_25 = manager.ui.mainCamera.transform.localPosition
				local var_325_26 = Vector3.New(0, 0, 10) + Vector3.New(var_325_25.x, var_325_25.y, 0)

				var_325_24.transform.localPosition = var_325_26
				var_325_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_325_27 = var_325_24:GetComponent("SpriteRenderer")

				if var_325_27 and var_325_27.sprite then
					local var_325_28 = (var_325_24.transform.localPosition - var_325_25).z
					local var_325_29 = manager.ui.mainCameraCom_
					local var_325_30 = 2 * var_325_28 * Mathf.Tan(var_325_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_325_31 = var_325_30 * var_325_29.aspect
					local var_325_32 = var_325_27.sprite.bounds.size.x
					local var_325_33 = var_325_27.sprite.bounds.size.y
					local var_325_34 = var_325_31 / var_325_32
					local var_325_35 = var_325_30 / var_325_33
					local var_325_36 = var_325_35 < var_325_34 and var_325_34 or var_325_35

					var_325_24.transform.localScale = Vector3.New(var_325_36, var_325_36, 0)
				end
			end

			local var_325_37 = 2

			if var_325_23 <= arg_322_1.time_ and arg_322_1.time_ < var_325_23 + var_325_37 then
				local var_325_38 = (arg_322_1.time_ - var_325_23) / var_325_37
				local var_325_39 = Color.New(1, 1, 1)

				var_325_39.a = Mathf.Lerp(1, 0, var_325_38)

				var_325_24:GetComponent("SpriteRenderer").material:SetColor("_Color", var_325_39)
			end

			local var_325_40 = 0
			local var_325_41 = 0.325

			if var_325_40 < arg_322_1.time_ and arg_322_1.time_ <= var_325_40 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_42 = arg_322_1:FormatText(StoryNameCfg[6].name)

				arg_322_1.leftNameTxt_.text = var_325_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_43 = arg_322_1:GetWordFromCfg(120011079)
				local var_325_44 = arg_322_1:FormatText(var_325_43.content)

				arg_322_1.text_.text = var_325_44

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_45 = 13
				local var_325_46 = utf8.len(var_325_44)
				local var_325_47 = var_325_45 <= 0 and var_325_41 or var_325_41 * (var_325_46 / var_325_45)

				if var_325_47 > 0 and var_325_41 < var_325_47 then
					arg_322_1.talkMaxDuration = var_325_47

					if var_325_47 + var_325_40 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_47 + var_325_40
					end
				end

				arg_322_1.text_.text = var_325_44
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011079", "story_v_out_120011.awb") ~= 0 then
					local var_325_48 = manager.audio:GetVoiceLength("story_v_out_120011", "120011079", "story_v_out_120011.awb") / 1000

					if var_325_48 + var_325_40 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_48 + var_325_40
					end

					if var_325_43.prefab_name ~= "" and arg_322_1.actors_[var_325_43.prefab_name] ~= nil then
						local var_325_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_43.prefab_name].transform, "story_v_out_120011", "120011079", "story_v_out_120011.awb")

						arg_322_1:RecordAudio("120011079", var_325_49)
						arg_322_1:RecordAudio("120011079", var_325_49)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_120011", "120011079", "story_v_out_120011.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_120011", "120011079", "story_v_out_120011.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_50 = math.max(var_325_41, arg_322_1.talkMaxDuration)

			if var_325_40 <= arg_322_1.time_ and arg_322_1.time_ < var_325_40 + var_325_50 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_40) / var_325_50

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_40 + var_325_50 and arg_322_1.time_ < var_325_40 + var_325_50 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
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

		arg_322_1:InitPlayNodeList()
	end,
	Play120011080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 120011080
		arg_326_1.duration_ = 8.45

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play120011081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_1 = 2

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_1 then
				local var_329_2 = (arg_326_1.time_ - var_329_0) / var_329_1
				local var_329_3 = Color.New(0, 0, 0)

				var_329_3.a = Mathf.Lerp(0, 1, var_329_2)
				arg_326_1.mask_.color = var_329_3
			end

			if arg_326_1.time_ >= var_329_0 + var_329_1 and arg_326_1.time_ < var_329_0 + var_329_1 + arg_329_0 then
				local var_329_4 = Color.New(0, 0, 0)

				var_329_4.a = 1
				arg_326_1.mask_.color = var_329_4
			end

			local var_329_5 = 2

			if var_329_5 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_6 = 2

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_6 then
				local var_329_7 = (arg_326_1.time_ - var_329_5) / var_329_6
				local var_329_8 = Color.New(0, 0, 0)

				var_329_8.a = Mathf.Lerp(1, 0, var_329_7)
				arg_326_1.mask_.color = var_329_8
			end

			if arg_326_1.time_ >= var_329_5 + var_329_6 and arg_326_1.time_ < var_329_5 + var_329_6 + arg_329_0 then
				local var_329_9 = Color.New(0, 0, 0)
				local var_329_10 = 0

				arg_326_1.mask_.enabled = false
				var_329_9.a = var_329_10
				arg_326_1.mask_.color = var_329_9
			end

			local var_329_11 = arg_326_1.actors_["1084ui_story"].transform
			local var_329_12 = 2

			if var_329_12 < arg_326_1.time_ and arg_326_1.time_ <= var_329_12 + arg_329_0 then
				arg_326_1.var_.moveOldPos1084ui_story = var_329_11.localPosition
			end

			local var_329_13 = 0.001

			if var_329_12 <= arg_326_1.time_ and arg_326_1.time_ < var_329_12 + var_329_13 then
				local var_329_14 = (arg_326_1.time_ - var_329_12) / var_329_13
				local var_329_15 = Vector3.New(0, 100, 0)

				var_329_11.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1084ui_story, var_329_15, var_329_14)

				local var_329_16 = manager.ui.mainCamera.transform.position - var_329_11.position

				var_329_11.forward = Vector3.New(var_329_16.x, var_329_16.y, var_329_16.z)

				local var_329_17 = var_329_11.localEulerAngles

				var_329_17.z = 0
				var_329_17.x = 0
				var_329_11.localEulerAngles = var_329_17
			end

			if arg_326_1.time_ >= var_329_12 + var_329_13 and arg_326_1.time_ < var_329_12 + var_329_13 + arg_329_0 then
				var_329_11.localPosition = Vector3.New(0, 100, 0)

				local var_329_18 = manager.ui.mainCamera.transform.position - var_329_11.position

				var_329_11.forward = Vector3.New(var_329_18.x, var_329_18.y, var_329_18.z)

				local var_329_19 = var_329_11.localEulerAngles

				var_329_19.z = 0
				var_329_19.x = 0
				var_329_11.localEulerAngles = var_329_19
			end

			local var_329_20 = 0

			if var_329_20 < arg_326_1.time_ and arg_326_1.time_ <= var_329_20 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_329_21 = 0

			if var_329_21 < arg_326_1.time_ and arg_326_1.time_ <= var_329_21 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_22 = 3.45
			local var_329_23 = 1.45

			if var_329_22 < arg_326_1.time_ and arg_326_1.time_ <= var_329_22 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_24 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_24:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_25 = arg_326_1:GetWordFromCfg(120011080)
				local var_329_26 = arg_326_1:FormatText(var_329_25.content)

				arg_326_1.text_.text = var_329_26

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_27 = 42
				local var_329_28 = utf8.len(var_329_26)
				local var_329_29 = var_329_27 <= 0 and var_329_23 or var_329_23 * (var_329_28 / var_329_27)

				if var_329_29 > 0 and var_329_23 < var_329_29 then
					arg_326_1.talkMaxDuration = var_329_29
					var_329_22 = var_329_22 + 0.3

					if var_329_29 + var_329_22 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_29 + var_329_22
					end
				end

				arg_326_1.text_.text = var_329_26
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_30 = var_329_22 + 0.3
			local var_329_31 = math.max(var_329_23, arg_326_1.talkMaxDuration)

			if var_329_30 <= arg_326_1.time_ and arg_326_1.time_ < var_329_30 + var_329_31 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_30) / var_329_31

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_30 + var_329_31 and arg_326_1.time_ < var_329_30 + var_329_31 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play120011081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 120011081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play120011082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.375

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(120011081)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 15
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_8 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_8 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_8

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_8 and arg_332_1.time_ < var_335_0 + var_335_8 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play120011082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 120011082
		arg_336_1.duration_ = 3.03

		local var_336_0 = {
			zh = 3.033,
			ja = 2.6
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play120011083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1084ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1084ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0, -0.97, -6)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1084ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = arg_336_1.actors_["1084ui_story"]
			local var_339_10 = 0

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1084ui_story == nil then
				arg_336_1.var_.characterEffect1084ui_story = var_339_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_11 = 0.2

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_11 and not isNil(var_339_9) then
				local var_339_12 = (arg_336_1.time_ - var_339_10) / var_339_11

				if arg_336_1.var_.characterEffect1084ui_story and not isNil(var_339_9) then
					arg_336_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_10 + var_339_11 and arg_336_1.time_ < var_339_10 + var_339_11 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1084ui_story then
				arg_336_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_339_13 = 0

			if var_339_13 < arg_336_1.time_ and arg_336_1.time_ <= var_339_13 + arg_339_0 then
				arg_336_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_339_14 = 0

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_339_15 = 0
			local var_339_16 = 0.275

			if var_339_15 < arg_336_1.time_ and arg_336_1.time_ <= var_339_15 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_17 = arg_336_1:FormatText(StoryNameCfg[6].name)

				arg_336_1.leftNameTxt_.text = var_339_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_18 = arg_336_1:GetWordFromCfg(120011082)
				local var_339_19 = arg_336_1:FormatText(var_339_18.content)

				arg_336_1.text_.text = var_339_19

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_20 = 11
				local var_339_21 = utf8.len(var_339_19)
				local var_339_22 = var_339_20 <= 0 and var_339_16 or var_339_16 * (var_339_21 / var_339_20)

				if var_339_22 > 0 and var_339_16 < var_339_22 then
					arg_336_1.talkMaxDuration = var_339_22

					if var_339_22 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_22 + var_339_15
					end
				end

				arg_336_1.text_.text = var_339_19
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011082", "story_v_out_120011.awb") ~= 0 then
					local var_339_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011082", "story_v_out_120011.awb") / 1000

					if var_339_23 + var_339_15 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_23 + var_339_15
					end

					if var_339_18.prefab_name ~= "" and arg_336_1.actors_[var_339_18.prefab_name] ~= nil then
						local var_339_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_18.prefab_name].transform, "story_v_out_120011", "120011082", "story_v_out_120011.awb")

						arg_336_1:RecordAudio("120011082", var_339_24)
						arg_336_1:RecordAudio("120011082", var_339_24)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_120011", "120011082", "story_v_out_120011.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_120011", "120011082", "story_v_out_120011.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_25 = math.max(var_339_16, arg_336_1.talkMaxDuration)

			if var_339_15 <= arg_336_1.time_ and arg_336_1.time_ < var_339_15 + var_339_25 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_15) / var_339_25

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_15 + var_339_25 and arg_336_1.time_ < var_339_15 + var_339_25 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
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

		arg_336_1:InitPlayNodeList()
	end,
	Play120011083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 120011083
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play120011084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1084ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos1084ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(0, 100, 0)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1084ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0, 100, 0)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = 0
			local var_343_10 = 1.625

			if var_343_9 < arg_340_1.time_ and arg_340_1.time_ <= var_343_9 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_11 = arg_340_1:GetWordFromCfg(120011083)
				local var_343_12 = arg_340_1:FormatText(var_343_11.content)

				arg_340_1.text_.text = var_343_12

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_13 = 65
				local var_343_14 = utf8.len(var_343_12)
				local var_343_15 = var_343_13 <= 0 and var_343_10 or var_343_10 * (var_343_14 / var_343_13)

				if var_343_15 > 0 and var_343_10 < var_343_15 then
					arg_340_1.talkMaxDuration = var_343_15

					if var_343_15 + var_343_9 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_15 + var_343_9
					end
				end

				arg_340_1.text_.text = var_343_12
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_16 = math.max(var_343_10, arg_340_1.talkMaxDuration)

			if var_343_9 <= arg_340_1.time_ and arg_340_1.time_ < var_343_9 + var_343_16 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_9) / var_343_16

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_9 + var_343_16 and arg_340_1.time_ < var_343_9 + var_343_16 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
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

		arg_340_1:InitPlayNodeList()
	end,
	Play120011084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 120011084
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play120011085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.975

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[7].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(120011084)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 39
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_8 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_8 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_8

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_8 and arg_344_1.time_ < var_347_0 + var_347_8 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play120011085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 120011085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play120011086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.325

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_2 = arg_348_1:GetWordFromCfg(120011085)
				local var_351_3 = arg_348_1:FormatText(var_351_2.content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 13
				local var_351_5 = utf8.len(var_351_3)
				local var_351_6 = var_351_4 <= 0 and var_351_1 or var_351_1 * (var_351_5 / var_351_4)

				if var_351_6 > 0 and var_351_1 < var_351_6 then
					arg_348_1.talkMaxDuration = var_351_6

					if var_351_6 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_7 and arg_348_1.time_ < var_351_0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play120011086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 120011086
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play120011087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.225

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(120011086)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 9
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_8 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_8 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_8

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_8 and arg_352_1.time_ < var_355_0 + var_355_8 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play120011087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 120011087
		arg_356_1.duration_ = 7.2

		local var_356_0 = {
			zh = 4,
			ja = 7.2
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play120011088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.425

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[10].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(120011087)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 17
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011087", "story_v_out_120011.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011087", "story_v_out_120011.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_120011", "120011087", "story_v_out_120011.awb")

						arg_356_1:RecordAudio("120011087", var_359_9)
						arg_356_1:RecordAudio("120011087", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_120011", "120011087", "story_v_out_120011.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_120011", "120011087", "story_v_out_120011.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play120011088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 120011088
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play120011089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.475

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

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(120011088)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 19
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
	Play120011089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 120011089
		arg_364_1.duration_ = 4.03

		local var_364_0 = {
			zh = 3.633,
			ja = 4.033
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play120011090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1084ui_story"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1084ui_story = var_367_0.localPosition
			end

			local var_367_2 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2
				local var_367_4 = Vector3.New(0, -0.97, -6)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1084ui_story, var_367_4, var_367_3)

				local var_367_5 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_5.x, var_367_5.y, var_367_5.z)

				local var_367_6 = var_367_0.localEulerAngles

				var_367_6.z = 0
				var_367_6.x = 0
				var_367_0.localEulerAngles = var_367_6
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_367_7 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_7.x, var_367_7.y, var_367_7.z)

				local var_367_8 = var_367_0.localEulerAngles

				var_367_8.z = 0
				var_367_8.x = 0
				var_367_0.localEulerAngles = var_367_8
			end

			local var_367_9 = arg_364_1.actors_["1084ui_story"]
			local var_367_10 = 0

			if var_367_10 < arg_364_1.time_ and arg_364_1.time_ <= var_367_10 + arg_367_0 and not isNil(var_367_9) and arg_364_1.var_.characterEffect1084ui_story == nil then
				arg_364_1.var_.characterEffect1084ui_story = var_367_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_11 = 0.2

			if var_367_10 <= arg_364_1.time_ and arg_364_1.time_ < var_367_10 + var_367_11 and not isNil(var_367_9) then
				local var_367_12 = (arg_364_1.time_ - var_367_10) / var_367_11

				if arg_364_1.var_.characterEffect1084ui_story and not isNil(var_367_9) then
					arg_364_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_10 + var_367_11 and arg_364_1.time_ < var_367_10 + var_367_11 + arg_367_0 and not isNil(var_367_9) and arg_364_1.var_.characterEffect1084ui_story then
				arg_364_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_367_13 = 0

			if var_367_13 < arg_364_1.time_ and arg_364_1.time_ <= var_367_13 + arg_367_0 then
				arg_364_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_367_14 = 0

			if var_367_14 < arg_364_1.time_ and arg_364_1.time_ <= var_367_14 + arg_367_0 then
				arg_364_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_367_15 = 0
			local var_367_16 = 0.45

			if var_367_15 < arg_364_1.time_ and arg_364_1.time_ <= var_367_15 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_17 = arg_364_1:FormatText(StoryNameCfg[6].name)

				arg_364_1.leftNameTxt_.text = var_367_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_18 = arg_364_1:GetWordFromCfg(120011089)
				local var_367_19 = arg_364_1:FormatText(var_367_18.content)

				arg_364_1.text_.text = var_367_19

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_20 = 18
				local var_367_21 = utf8.len(var_367_19)
				local var_367_22 = var_367_20 <= 0 and var_367_16 or var_367_16 * (var_367_21 / var_367_20)

				if var_367_22 > 0 and var_367_16 < var_367_22 then
					arg_364_1.talkMaxDuration = var_367_22

					if var_367_22 + var_367_15 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_22 + var_367_15
					end
				end

				arg_364_1.text_.text = var_367_19
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011089", "story_v_out_120011.awb") ~= 0 then
					local var_367_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011089", "story_v_out_120011.awb") / 1000

					if var_367_23 + var_367_15 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_23 + var_367_15
					end

					if var_367_18.prefab_name ~= "" and arg_364_1.actors_[var_367_18.prefab_name] ~= nil then
						local var_367_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_18.prefab_name].transform, "story_v_out_120011", "120011089", "story_v_out_120011.awb")

						arg_364_1:RecordAudio("120011089", var_367_24)
						arg_364_1:RecordAudio("120011089", var_367_24)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_120011", "120011089", "story_v_out_120011.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_120011", "120011089", "story_v_out_120011.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_25 = math.max(var_367_16, arg_364_1.talkMaxDuration)

			if var_367_15 <= arg_364_1.time_ and arg_364_1.time_ < var_367_15 + var_367_25 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_15) / var_367_25

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_15 + var_367_25 and arg_364_1.time_ < var_367_15 + var_367_25 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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

		arg_364_1:InitPlayNodeList()
	end,
	Play120011090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 120011090
		arg_368_1.duration_ = 7.2

		local var_368_0 = {
			zh = 5.833,
			ja = 7.2
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play120011091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1084ui_story"].transform
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.var_.moveOldPos1084ui_story = var_371_0.localPosition
			end

			local var_371_2 = 0.001

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2
				local var_371_4 = Vector3.New(0, -0.97, -6)

				var_371_0.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1084ui_story, var_371_4, var_371_3)

				local var_371_5 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_5.x, var_371_5.y, var_371_5.z)

				local var_371_6 = var_371_0.localEulerAngles

				var_371_6.z = 0
				var_371_6.x = 0
				var_371_0.localEulerAngles = var_371_6
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 then
				var_371_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_371_7 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_7.x, var_371_7.y, var_371_7.z)

				local var_371_8 = var_371_0.localEulerAngles

				var_371_8.z = 0
				var_371_8.x = 0
				var_371_0.localEulerAngles = var_371_8
			end

			local var_371_9 = 0

			if var_371_9 < arg_368_1.time_ and arg_368_1.time_ <= var_371_9 + arg_371_0 then
				arg_368_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_371_10 = 0
			local var_371_11 = 0.575

			if var_371_10 < arg_368_1.time_ and arg_368_1.time_ <= var_371_10 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_12 = arg_368_1:FormatText(StoryNameCfg[6].name)

				arg_368_1.leftNameTxt_.text = var_371_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_13 = arg_368_1:GetWordFromCfg(120011090)
				local var_371_14 = arg_368_1:FormatText(var_371_13.content)

				arg_368_1.text_.text = var_371_14

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_15 = 23
				local var_371_16 = utf8.len(var_371_14)
				local var_371_17 = var_371_15 <= 0 and var_371_11 or var_371_11 * (var_371_16 / var_371_15)

				if var_371_17 > 0 and var_371_11 < var_371_17 then
					arg_368_1.talkMaxDuration = var_371_17

					if var_371_17 + var_371_10 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_17 + var_371_10
					end
				end

				arg_368_1.text_.text = var_371_14
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011090", "story_v_out_120011.awb") ~= 0 then
					local var_371_18 = manager.audio:GetVoiceLength("story_v_out_120011", "120011090", "story_v_out_120011.awb") / 1000

					if var_371_18 + var_371_10 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_18 + var_371_10
					end

					if var_371_13.prefab_name ~= "" and arg_368_1.actors_[var_371_13.prefab_name] ~= nil then
						local var_371_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_13.prefab_name].transform, "story_v_out_120011", "120011090", "story_v_out_120011.awb")

						arg_368_1:RecordAudio("120011090", var_371_19)
						arg_368_1:RecordAudio("120011090", var_371_19)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_120011", "120011090", "story_v_out_120011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_120011", "120011090", "story_v_out_120011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_20 = math.max(var_371_11, arg_368_1.talkMaxDuration)

			if var_371_10 <= arg_368_1.time_ and arg_368_1.time_ < var_371_10 + var_371_20 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_10) / var_371_20

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_10 + var_371_20 and arg_368_1.time_ < var_371_10 + var_371_20 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
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

		arg_368_1:InitPlayNodeList()
	end,
	Play120011091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 120011091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play120011092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1084ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1084ui_story == nil then
				arg_372_1.var_.characterEffect1084ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.2

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect1084ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1084ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1084ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1084ui_story.fillRatio = var_375_5
			end

			local var_375_6 = 0
			local var_375_7 = 0.775

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[7].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_9 = arg_372_1:GetWordFromCfg(120011091)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 31
				local var_375_12 = utf8.len(var_375_10)
				local var_375_13 = var_375_11 <= 0 and var_375_7 or var_375_7 * (var_375_12 / var_375_11)

				if var_375_13 > 0 and var_375_7 < var_375_13 then
					arg_372_1.talkMaxDuration = var_375_13

					if var_375_13 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_6
					end
				end

				arg_372_1.text_.text = var_375_10
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_14 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_14 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_14

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_14 and arg_372_1.time_ < var_375_6 + var_375_14 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play120011092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 120011092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play120011093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1084ui_story"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1084ui_story = var_379_0.localPosition
			end

			local var_379_2 = 0.001

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2
				local var_379_4 = Vector3.New(0, 100, 0)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1084ui_story, var_379_4, var_379_3)

				local var_379_5 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_5.x, var_379_5.y, var_379_5.z)

				local var_379_6 = var_379_0.localEulerAngles

				var_379_6.z = 0
				var_379_6.x = 0
				var_379_0.localEulerAngles = var_379_6
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(0, 100, 0)

				local var_379_7 = manager.ui.mainCamera.transform.position - var_379_0.position

				var_379_0.forward = Vector3.New(var_379_7.x, var_379_7.y, var_379_7.z)

				local var_379_8 = var_379_0.localEulerAngles

				var_379_8.z = 0
				var_379_8.x = 0
				var_379_0.localEulerAngles = var_379_8
			end

			local var_379_9 = 0
			local var_379_10 = 1.425

			if var_379_9 < arg_376_1.time_ and arg_376_1.time_ <= var_379_9 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_11 = arg_376_1:GetWordFromCfg(120011092)
				local var_379_12 = arg_376_1:FormatText(var_379_11.content)

				arg_376_1.text_.text = var_379_12

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_13 = 57
				local var_379_14 = utf8.len(var_379_12)
				local var_379_15 = var_379_13 <= 0 and var_379_10 or var_379_10 * (var_379_14 / var_379_13)

				if var_379_15 > 0 and var_379_10 < var_379_15 then
					arg_376_1.talkMaxDuration = var_379_15

					if var_379_15 + var_379_9 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_15 + var_379_9
					end
				end

				arg_376_1.text_.text = var_379_12
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_16 = math.max(var_379_10, arg_376_1.talkMaxDuration)

			if var_379_9 <= arg_376_1.time_ and arg_376_1.time_ < var_379_9 + var_379_16 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_9) / var_379_16

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_9 + var_379_16 and arg_376_1.time_ < var_379_9 + var_379_16 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
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

		arg_376_1:InitPlayNodeList()
	end,
	Play120011093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 120011093
		arg_380_1.duration_ = 6.9

		local var_380_0 = {
			zh = 5.366,
			ja = 6.9
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play120011094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1084ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos1084ui_story = var_383_0.localPosition
			end

			local var_383_2 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2
				local var_383_4 = Vector3.New(0, -0.97, -6)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1084ui_story, var_383_4, var_383_3)

				local var_383_5 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_5.x, var_383_5.y, var_383_5.z)

				local var_383_6 = var_383_0.localEulerAngles

				var_383_6.z = 0
				var_383_6.x = 0
				var_383_0.localEulerAngles = var_383_6
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_383_7 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_7.x, var_383_7.y, var_383_7.z)

				local var_383_8 = var_383_0.localEulerAngles

				var_383_8.z = 0
				var_383_8.x = 0
				var_383_0.localEulerAngles = var_383_8
			end

			local var_383_9 = arg_380_1.actors_["1084ui_story"]
			local var_383_10 = 0

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1084ui_story == nil then
				arg_380_1.var_.characterEffect1084ui_story = var_383_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_11 = 0.2

			if var_383_10 <= arg_380_1.time_ and arg_380_1.time_ < var_383_10 + var_383_11 and not isNil(var_383_9) then
				local var_383_12 = (arg_380_1.time_ - var_383_10) / var_383_11

				if arg_380_1.var_.characterEffect1084ui_story and not isNil(var_383_9) then
					arg_380_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_10 + var_383_11 and arg_380_1.time_ < var_383_10 + var_383_11 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect1084ui_story then
				arg_380_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_383_13 = 0

			if var_383_13 < arg_380_1.time_ and arg_380_1.time_ <= var_383_13 + arg_383_0 then
				arg_380_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_383_14 = 0

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				arg_380_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_383_15 = 0
			local var_383_16 = 0.65

			if var_383_15 < arg_380_1.time_ and arg_380_1.time_ <= var_383_15 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_17 = arg_380_1:FormatText(StoryNameCfg[6].name)

				arg_380_1.leftNameTxt_.text = var_383_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_18 = arg_380_1:GetWordFromCfg(120011093)
				local var_383_19 = arg_380_1:FormatText(var_383_18.content)

				arg_380_1.text_.text = var_383_19

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_20 = 26
				local var_383_21 = utf8.len(var_383_19)
				local var_383_22 = var_383_20 <= 0 and var_383_16 or var_383_16 * (var_383_21 / var_383_20)

				if var_383_22 > 0 and var_383_16 < var_383_22 then
					arg_380_1.talkMaxDuration = var_383_22

					if var_383_22 + var_383_15 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_22 + var_383_15
					end
				end

				arg_380_1.text_.text = var_383_19
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011093", "story_v_out_120011.awb") ~= 0 then
					local var_383_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011093", "story_v_out_120011.awb") / 1000

					if var_383_23 + var_383_15 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_23 + var_383_15
					end

					if var_383_18.prefab_name ~= "" and arg_380_1.actors_[var_383_18.prefab_name] ~= nil then
						local var_383_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_18.prefab_name].transform, "story_v_out_120011", "120011093", "story_v_out_120011.awb")

						arg_380_1:RecordAudio("120011093", var_383_24)
						arg_380_1:RecordAudio("120011093", var_383_24)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_120011", "120011093", "story_v_out_120011.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_120011", "120011093", "story_v_out_120011.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_25 = math.max(var_383_16, arg_380_1.talkMaxDuration)

			if var_383_15 <= arg_380_1.time_ and arg_380_1.time_ < var_383_15 + var_383_25 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_15) / var_383_25

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_15 + var_383_25 and arg_380_1.time_ < var_383_15 + var_383_25 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
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

		arg_380_1:InitPlayNodeList()
	end,
	Play120011094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 120011094
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play120011095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1084ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1084ui_story == nil then
				arg_384_1.var_.characterEffect1084ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect1084ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1084ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1084ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1084ui_story.fillRatio = var_387_5
			end

			local var_387_6 = 0
			local var_387_7 = 0.8

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_9 = arg_384_1:GetWordFromCfg(120011094)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 32
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
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_14 and arg_384_1.time_ < var_387_6 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play120011095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 120011095
		arg_388_1.duration_ = 10.23

		local var_388_0 = {
			zh = 10.233,
			ja = 9.7
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play120011096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1084ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1084ui_story == nil then
				arg_388_1.var_.characterEffect1084ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1084ui_story and not isNil(var_391_0) then
					arg_388_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1084ui_story then
				arg_388_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_391_4 = 0

			if var_391_4 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_391_5 = 0
			local var_391_6 = 1.05

			if var_391_5 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_7 = arg_388_1:FormatText(StoryNameCfg[6].name)

				arg_388_1.leftNameTxt_.text = var_391_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_8 = arg_388_1:GetWordFromCfg(120011095)
				local var_391_9 = arg_388_1:FormatText(var_391_8.content)

				arg_388_1.text_.text = var_391_9

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_10 = 42
				local var_391_11 = utf8.len(var_391_9)
				local var_391_12 = var_391_10 <= 0 and var_391_6 or var_391_6 * (var_391_11 / var_391_10)

				if var_391_12 > 0 and var_391_6 < var_391_12 then
					arg_388_1.talkMaxDuration = var_391_12

					if var_391_12 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_12 + var_391_5
					end
				end

				arg_388_1.text_.text = var_391_9
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011095", "story_v_out_120011.awb") ~= 0 then
					local var_391_13 = manager.audio:GetVoiceLength("story_v_out_120011", "120011095", "story_v_out_120011.awb") / 1000

					if var_391_13 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_5
					end

					if var_391_8.prefab_name ~= "" and arg_388_1.actors_[var_391_8.prefab_name] ~= nil then
						local var_391_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_8.prefab_name].transform, "story_v_out_120011", "120011095", "story_v_out_120011.awb")

						arg_388_1:RecordAudio("120011095", var_391_14)
						arg_388_1:RecordAudio("120011095", var_391_14)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_120011", "120011095", "story_v_out_120011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_120011", "120011095", "story_v_out_120011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_15 = math.max(var_391_6, arg_388_1.talkMaxDuration)

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_15 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_5) / var_391_15

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_5 + var_391_15 and arg_388_1.time_ < var_391_5 + var_391_15 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play120011096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 120011096
		arg_392_1.duration_ = 10.57

		local var_392_0 = {
			zh = 7,
			ja = 10.566
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play120011097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1084ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1084ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(0, -0.97, -6)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1084ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = 0

			if var_395_9 < arg_392_1.time_ and arg_392_1.time_ <= var_395_9 + arg_395_0 then
				arg_392_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_395_10 = 0

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 then
				arg_392_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action467")
			end

			local var_395_11 = 0
			local var_395_12 = 0.7

			if var_395_11 < arg_392_1.time_ and arg_392_1.time_ <= var_395_11 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_13 = arg_392_1:FormatText(StoryNameCfg[6].name)

				arg_392_1.leftNameTxt_.text = var_395_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_14 = arg_392_1:GetWordFromCfg(120011096)
				local var_395_15 = arg_392_1:FormatText(var_395_14.content)

				arg_392_1.text_.text = var_395_15

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_16 = 28
				local var_395_17 = utf8.len(var_395_15)
				local var_395_18 = var_395_16 <= 0 and var_395_12 or var_395_12 * (var_395_17 / var_395_16)

				if var_395_18 > 0 and var_395_12 < var_395_18 then
					arg_392_1.talkMaxDuration = var_395_18

					if var_395_18 + var_395_11 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_18 + var_395_11
					end
				end

				arg_392_1.text_.text = var_395_15
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011096", "story_v_out_120011.awb") ~= 0 then
					local var_395_19 = manager.audio:GetVoiceLength("story_v_out_120011", "120011096", "story_v_out_120011.awb") / 1000

					if var_395_19 + var_395_11 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_19 + var_395_11
					end

					if var_395_14.prefab_name ~= "" and arg_392_1.actors_[var_395_14.prefab_name] ~= nil then
						local var_395_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_14.prefab_name].transform, "story_v_out_120011", "120011096", "story_v_out_120011.awb")

						arg_392_1:RecordAudio("120011096", var_395_20)
						arg_392_1:RecordAudio("120011096", var_395_20)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_120011", "120011096", "story_v_out_120011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_120011", "120011096", "story_v_out_120011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_21 = math.max(var_395_12, arg_392_1.talkMaxDuration)

			if var_395_11 <= arg_392_1.time_ and arg_392_1.time_ < var_395_11 + var_395_21 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_11) / var_395_21

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_11 + var_395_21 and arg_392_1.time_ < var_395_11 + var_395_21 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
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

		arg_392_1:InitPlayNodeList()
	end,
	Play120011097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 120011097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play120011098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1084ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1084ui_story == nil then
				arg_396_1.var_.characterEffect1084ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.2

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect1084ui_story and not isNil(var_399_0) then
					local var_399_4 = Mathf.Lerp(0, 0.5, var_399_3)

					arg_396_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1084ui_story.fillRatio = var_399_4
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1084ui_story then
				local var_399_5 = 0.5

				arg_396_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1084ui_story.fillRatio = var_399_5
			end

			local var_399_6 = 0
			local var_399_7 = 0.5

			if var_399_6 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_8 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_9 = arg_396_1:GetWordFromCfg(120011097)
				local var_399_10 = arg_396_1:FormatText(var_399_9.content)

				arg_396_1.text_.text = var_399_10

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 20
				local var_399_12 = utf8.len(var_399_10)
				local var_399_13 = var_399_11 <= 0 and var_399_7 or var_399_7 * (var_399_12 / var_399_11)

				if var_399_13 > 0 and var_399_7 < var_399_13 then
					arg_396_1.talkMaxDuration = var_399_13

					if var_399_13 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_10
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_14 and arg_396_1.time_ < var_399_6 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play120011098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 120011098
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play120011099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.925

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[7].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(120011098)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 37
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_8 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_8 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_8

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_8 and arg_400_1.time_ < var_403_0 + var_403_8 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play120011099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 120011099
		arg_404_1.duration_ = 9.73

		local var_404_0 = {
			zh = 3.7,
			ja = 9.733
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play120011100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1084ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos1084ui_story = var_407_0.localPosition
			end

			local var_407_2 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2
				local var_407_4 = Vector3.New(0, -0.97, -6)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1084ui_story, var_407_4, var_407_3)

				local var_407_5 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_5.x, var_407_5.y, var_407_5.z)

				local var_407_6 = var_407_0.localEulerAngles

				var_407_6.z = 0
				var_407_6.x = 0
				var_407_0.localEulerAngles = var_407_6
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_407_7 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_7.x, var_407_7.y, var_407_7.z)

				local var_407_8 = var_407_0.localEulerAngles

				var_407_8.z = 0
				var_407_8.x = 0
				var_407_0.localEulerAngles = var_407_8
			end

			local var_407_9 = arg_404_1.actors_["1084ui_story"]
			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1084ui_story == nil then
				arg_404_1.var_.characterEffect1084ui_story = var_407_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.2

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_11 and not isNil(var_407_9) then
				local var_407_12 = (arg_404_1.time_ - var_407_10) / var_407_11

				if arg_404_1.var_.characterEffect1084ui_story and not isNil(var_407_9) then
					arg_404_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_10 + var_407_11 and arg_404_1.time_ < var_407_10 + var_407_11 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1084ui_story then
				arg_404_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_407_13 = 0

			if var_407_13 < arg_404_1.time_ and arg_404_1.time_ <= var_407_13 + arg_407_0 then
				arg_404_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_407_14 = 0

			if var_407_14 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 then
				arg_404_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action472")
			end

			local var_407_15 = 0
			local var_407_16 = 0.4

			if var_407_15 < arg_404_1.time_ and arg_404_1.time_ <= var_407_15 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_17 = arg_404_1:FormatText(StoryNameCfg[6].name)

				arg_404_1.leftNameTxt_.text = var_407_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_18 = arg_404_1:GetWordFromCfg(120011099)
				local var_407_19 = arg_404_1:FormatText(var_407_18.content)

				arg_404_1.text_.text = var_407_19

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_20 = 16
				local var_407_21 = utf8.len(var_407_19)
				local var_407_22 = var_407_20 <= 0 and var_407_16 or var_407_16 * (var_407_21 / var_407_20)

				if var_407_22 > 0 and var_407_16 < var_407_22 then
					arg_404_1.talkMaxDuration = var_407_22

					if var_407_22 + var_407_15 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_22 + var_407_15
					end
				end

				arg_404_1.text_.text = var_407_19
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011099", "story_v_out_120011.awb") ~= 0 then
					local var_407_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011099", "story_v_out_120011.awb") / 1000

					if var_407_23 + var_407_15 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_23 + var_407_15
					end

					if var_407_18.prefab_name ~= "" and arg_404_1.actors_[var_407_18.prefab_name] ~= nil then
						local var_407_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_18.prefab_name].transform, "story_v_out_120011", "120011099", "story_v_out_120011.awb")

						arg_404_1:RecordAudio("120011099", var_407_24)
						arg_404_1:RecordAudio("120011099", var_407_24)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_120011", "120011099", "story_v_out_120011.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_120011", "120011099", "story_v_out_120011.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_25 = math.max(var_407_16, arg_404_1.talkMaxDuration)

			if var_407_15 <= arg_404_1.time_ and arg_404_1.time_ < var_407_15 + var_407_25 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_15) / var_407_25

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_15 + var_407_25 and arg_404_1.time_ < var_407_15 + var_407_25 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
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

		arg_404_1:InitPlayNodeList()
	end,
	Play120011100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 120011100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play120011101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1084ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1084ui_story == nil then
				arg_408_1.var_.characterEffect1084ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.2

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect1084ui_story and not isNil(var_411_0) then
					local var_411_4 = Mathf.Lerp(0, 0.5, var_411_3)

					arg_408_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1084ui_story.fillRatio = var_411_4
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect1084ui_story then
				local var_411_5 = 0.5

				arg_408_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1084ui_story.fillRatio = var_411_5
			end

			local var_411_6 = 0

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_411_7 = 0
			local var_411_8 = 0.25

			if var_411_7 < arg_408_1.time_ and arg_408_1.time_ <= var_411_7 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_9 = arg_408_1:FormatText(StoryNameCfg[7].name)

				arg_408_1.leftNameTxt_.text = var_411_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_10 = arg_408_1:GetWordFromCfg(120011100)
				local var_411_11 = arg_408_1:FormatText(var_411_10.content)

				arg_408_1.text_.text = var_411_11

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_12 = 10
				local var_411_13 = utf8.len(var_411_11)
				local var_411_14 = var_411_12 <= 0 and var_411_8 or var_411_8 * (var_411_13 / var_411_12)

				if var_411_14 > 0 and var_411_8 < var_411_14 then
					arg_408_1.talkMaxDuration = var_411_14

					if var_411_14 + var_411_7 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_7
					end
				end

				arg_408_1.text_.text = var_411_11
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_15 = math.max(var_411_8, arg_408_1.talkMaxDuration)

			if var_411_7 <= arg_408_1.time_ and arg_408_1.time_ < var_411_7 + var_411_15 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_7) / var_411_15

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_7 + var_411_15 and arg_408_1.time_ < var_411_7 + var_411_15 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play120011101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 120011101
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play120011102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1084ui_story"].transform
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.var_.moveOldPos1084ui_story = var_415_0.localPosition
			end

			local var_415_2 = 0.001

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2
				local var_415_4 = Vector3.New(0, 100, 0)

				var_415_0.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1084ui_story, var_415_4, var_415_3)

				local var_415_5 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_5.x, var_415_5.y, var_415_5.z)

				local var_415_6 = var_415_0.localEulerAngles

				var_415_6.z = 0
				var_415_6.x = 0
				var_415_0.localEulerAngles = var_415_6
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 then
				var_415_0.localPosition = Vector3.New(0, 100, 0)

				local var_415_7 = manager.ui.mainCamera.transform.position - var_415_0.position

				var_415_0.forward = Vector3.New(var_415_7.x, var_415_7.y, var_415_7.z)

				local var_415_8 = var_415_0.localEulerAngles

				var_415_8.z = 0
				var_415_8.x = 0
				var_415_0.localEulerAngles = var_415_8
			end

			local var_415_9 = 0
			local var_415_10 = 0.875

			if var_415_9 < arg_412_1.time_ and arg_412_1.time_ <= var_415_9 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_11 = arg_412_1:GetWordFromCfg(120011101)
				local var_415_12 = arg_412_1:FormatText(var_415_11.content)

				arg_412_1.text_.text = var_415_12

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_13 = 35
				local var_415_14 = utf8.len(var_415_12)
				local var_415_15 = var_415_13 <= 0 and var_415_10 or var_415_10 * (var_415_14 / var_415_13)

				if var_415_15 > 0 and var_415_10 < var_415_15 then
					arg_412_1.talkMaxDuration = var_415_15

					if var_415_15 + var_415_9 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_15 + var_415_9
					end
				end

				arg_412_1.text_.text = var_415_12
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_16 = math.max(var_415_10, arg_412_1.talkMaxDuration)

			if var_415_9 <= arg_412_1.time_ and arg_412_1.time_ < var_415_9 + var_415_16 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_9) / var_415_16

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_9 + var_415_16 and arg_412_1.time_ < var_415_9 + var_415_16 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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

		arg_412_1:InitPlayNodeList()
	end,
	Play120011102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 120011102
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play120011103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 1.1

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:GetWordFromCfg(120011102)
				local var_419_3 = arg_416_1:FormatText(var_419_2.content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 44
				local var_419_5 = utf8.len(var_419_3)
				local var_419_6 = var_419_4 <= 0 and var_419_1 or var_419_1 * (var_419_5 / var_419_4)

				if var_419_6 > 0 and var_419_1 < var_419_6 then
					arg_416_1.talkMaxDuration = var_419_6

					if var_419_6 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_7 and arg_416_1.time_ < var_419_0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play120011103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 120011103
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play120011104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = "1071ui_story"

			if arg_420_1.actors_[var_423_0] == nil then
				local var_423_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_423_1) then
					local var_423_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_420_1.stage_.transform)

					var_423_2.name = var_423_0
					var_423_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_420_1.actors_[var_423_0] = var_423_2

					local var_423_3 = var_423_2:GetComponentInChildren(typeof(CharacterEffect))

					var_423_3.enabled = true

					local var_423_4 = GameObjectTools.GetOrAddComponent(var_423_2, typeof(DynamicBoneHelper))

					if var_423_4 then
						var_423_4:EnableDynamicBone(false)
					end

					arg_420_1:ShowWeapon(var_423_3.transform, false)

					arg_420_1.var_[var_423_0 .. "Animator"] = var_423_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_420_1.var_[var_423_0 .. "Animator"].applyRootMotion = true
					arg_420_1.var_[var_423_0 .. "LipSync"] = var_423_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_423_5 = 0

			if var_423_5 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_423_6 = 0
			local var_423_7 = 0.75

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_8 = arg_420_1:GetWordFromCfg(120011103)
				local var_423_9 = arg_420_1:FormatText(var_423_8.content)

				arg_420_1.text_.text = var_423_9

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_10 = 30
				local var_423_11 = utf8.len(var_423_9)
				local var_423_12 = var_423_10 <= 0 and var_423_7 or var_423_7 * (var_423_11 / var_423_10)

				if var_423_12 > 0 and var_423_7 < var_423_12 then
					arg_420_1.talkMaxDuration = var_423_12

					if var_423_12 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_12 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_9
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_13 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_13 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_13

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_13 and arg_420_1.time_ < var_423_6 + var_423_13 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play120011104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 120011104
		arg_424_1.duration_ = 2.73

		local var_424_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play120011105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1084ui_story"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos1084ui_story = var_427_0.localPosition
			end

			local var_427_2 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2
				local var_427_4 = Vector3.New(-0.7, -0.97, -6)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1084ui_story, var_427_4, var_427_3)

				local var_427_5 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_5.x, var_427_5.y, var_427_5.z)

				local var_427_6 = var_427_0.localEulerAngles

				var_427_6.z = 0
				var_427_6.x = 0
				var_427_0.localEulerAngles = var_427_6
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_427_7 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_7.x, var_427_7.y, var_427_7.z)

				local var_427_8 = var_427_0.localEulerAngles

				var_427_8.z = 0
				var_427_8.x = 0
				var_427_0.localEulerAngles = var_427_8
			end

			local var_427_9 = arg_424_1.actors_["1071ui_story"].transform
			local var_427_10 = 0

			if var_427_10 < arg_424_1.time_ and arg_424_1.time_ <= var_427_10 + arg_427_0 then
				arg_424_1.var_.moveOldPos1071ui_story = var_427_9.localPosition
			end

			local var_427_11 = 0.001

			if var_427_10 <= arg_424_1.time_ and arg_424_1.time_ < var_427_10 + var_427_11 then
				local var_427_12 = (arg_424_1.time_ - var_427_10) / var_427_11
				local var_427_13 = Vector3.New(0.7, -1.05, -6.2)

				var_427_9.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1071ui_story, var_427_13, var_427_12)

				local var_427_14 = manager.ui.mainCamera.transform.position - var_427_9.position

				var_427_9.forward = Vector3.New(var_427_14.x, var_427_14.y, var_427_14.z)

				local var_427_15 = var_427_9.localEulerAngles

				var_427_15.z = 0
				var_427_15.x = 0
				var_427_9.localEulerAngles = var_427_15
			end

			if arg_424_1.time_ >= var_427_10 + var_427_11 and arg_424_1.time_ < var_427_10 + var_427_11 + arg_427_0 then
				var_427_9.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_427_16 = manager.ui.mainCamera.transform.position - var_427_9.position

				var_427_9.forward = Vector3.New(var_427_16.x, var_427_16.y, var_427_16.z)

				local var_427_17 = var_427_9.localEulerAngles

				var_427_17.z = 0
				var_427_17.x = 0
				var_427_9.localEulerAngles = var_427_17
			end

			local var_427_18 = arg_424_1.actors_["1084ui_story"]
			local var_427_19 = 0

			if var_427_19 < arg_424_1.time_ and arg_424_1.time_ <= var_427_19 + arg_427_0 and not isNil(var_427_18) and arg_424_1.var_.characterEffect1084ui_story == nil then
				arg_424_1.var_.characterEffect1084ui_story = var_427_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_20 = 0.2

			if var_427_19 <= arg_424_1.time_ and arg_424_1.time_ < var_427_19 + var_427_20 and not isNil(var_427_18) then
				local var_427_21 = (arg_424_1.time_ - var_427_19) / var_427_20

				if arg_424_1.var_.characterEffect1084ui_story and not isNil(var_427_18) then
					arg_424_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_19 + var_427_20 and arg_424_1.time_ < var_427_19 + var_427_20 + arg_427_0 and not isNil(var_427_18) and arg_424_1.var_.characterEffect1084ui_story then
				arg_424_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_427_22 = 0

			if var_427_22 < arg_424_1.time_ and arg_424_1.time_ <= var_427_22 + arg_427_0 then
				arg_424_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_427_23 = 0

			if var_427_23 < arg_424_1.time_ and arg_424_1.time_ <= var_427_23 + arg_427_0 then
				arg_424_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_427_24 = arg_424_1.actors_["1071ui_story"]
			local var_427_25 = 0

			if var_427_25 < arg_424_1.time_ and arg_424_1.time_ <= var_427_25 + arg_427_0 and not isNil(var_427_24) and arg_424_1.var_.characterEffect1071ui_story == nil then
				arg_424_1.var_.characterEffect1071ui_story = var_427_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_26 = 0.2

			if var_427_25 <= arg_424_1.time_ and arg_424_1.time_ < var_427_25 + var_427_26 and not isNil(var_427_24) then
				local var_427_27 = (arg_424_1.time_ - var_427_25) / var_427_26

				if arg_424_1.var_.characterEffect1071ui_story and not isNil(var_427_24) then
					local var_427_28 = Mathf.Lerp(0, 0.5, var_427_27)

					arg_424_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1071ui_story.fillRatio = var_427_28
				end
			end

			if arg_424_1.time_ >= var_427_25 + var_427_26 and arg_424_1.time_ < var_427_25 + var_427_26 + arg_427_0 and not isNil(var_427_24) and arg_424_1.var_.characterEffect1071ui_story then
				local var_427_29 = 0.5

				arg_424_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1071ui_story.fillRatio = var_427_29
			end

			local var_427_30 = 0

			if var_427_30 < arg_424_1.time_ and arg_424_1.time_ <= var_427_30 + arg_427_0 then
				arg_424_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_427_31 = 0
			local var_427_32 = 0.225

			if var_427_31 < arg_424_1.time_ and arg_424_1.time_ <= var_427_31 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_33 = arg_424_1:FormatText(StoryNameCfg[6].name)

				arg_424_1.leftNameTxt_.text = var_427_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_34 = arg_424_1:GetWordFromCfg(120011104)
				local var_427_35 = arg_424_1:FormatText(var_427_34.content)

				arg_424_1.text_.text = var_427_35

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_36 = 9
				local var_427_37 = utf8.len(var_427_35)
				local var_427_38 = var_427_36 <= 0 and var_427_32 or var_427_32 * (var_427_37 / var_427_36)

				if var_427_38 > 0 and var_427_32 < var_427_38 then
					arg_424_1.talkMaxDuration = var_427_38

					if var_427_38 + var_427_31 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_38 + var_427_31
					end
				end

				arg_424_1.text_.text = var_427_35
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011104", "story_v_out_120011.awb") ~= 0 then
					local var_427_39 = manager.audio:GetVoiceLength("story_v_out_120011", "120011104", "story_v_out_120011.awb") / 1000

					if var_427_39 + var_427_31 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_39 + var_427_31
					end

					if var_427_34.prefab_name ~= "" and arg_424_1.actors_[var_427_34.prefab_name] ~= nil then
						local var_427_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_34.prefab_name].transform, "story_v_out_120011", "120011104", "story_v_out_120011.awb")

						arg_424_1:RecordAudio("120011104", var_427_40)
						arg_424_1:RecordAudio("120011104", var_427_40)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_120011", "120011104", "story_v_out_120011.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_120011", "120011104", "story_v_out_120011.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_41 = math.max(var_427_32, arg_424_1.talkMaxDuration)

			if var_427_31 <= arg_424_1.time_ and arg_424_1.time_ < var_427_31 + var_427_41 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_31) / var_427_41

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_31 + var_427_41 and arg_424_1.time_ < var_427_31 + var_427_41 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play120011105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 120011105
		arg_428_1.duration_ = 7.1

		local var_428_0 = {
			zh = 4.766,
			ja = 7.1
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play120011106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1084ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1084ui_story == nil then
				arg_428_1.var_.characterEffect1084ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.2

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect1084ui_story and not isNil(var_431_0) then
					local var_431_4 = Mathf.Lerp(0, 0.5, var_431_3)

					arg_428_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1084ui_story.fillRatio = var_431_4
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1084ui_story then
				local var_431_5 = 0.5

				arg_428_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1084ui_story.fillRatio = var_431_5
			end

			local var_431_6 = arg_428_1.actors_["1071ui_story"]
			local var_431_7 = 0

			if var_431_7 < arg_428_1.time_ and arg_428_1.time_ <= var_431_7 + arg_431_0 and not isNil(var_431_6) and arg_428_1.var_.characterEffect1071ui_story == nil then
				arg_428_1.var_.characterEffect1071ui_story = var_431_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_8 = 0.2

			if var_431_7 <= arg_428_1.time_ and arg_428_1.time_ < var_431_7 + var_431_8 and not isNil(var_431_6) then
				local var_431_9 = (arg_428_1.time_ - var_431_7) / var_431_8

				if arg_428_1.var_.characterEffect1071ui_story and not isNil(var_431_6) then
					arg_428_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_7 + var_431_8 and arg_428_1.time_ < var_431_7 + var_431_8 + arg_431_0 and not isNil(var_431_6) and arg_428_1.var_.characterEffect1071ui_story then
				arg_428_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_431_10 = 0

			if var_431_10 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 then
				arg_428_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_431_11 = 0
			local var_431_12 = 0.625

			if var_431_11 < arg_428_1.time_ and arg_428_1.time_ <= var_431_11 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_13 = arg_428_1:FormatText(StoryNameCfg[376].name)

				arg_428_1.leftNameTxt_.text = var_431_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_14 = arg_428_1:GetWordFromCfg(120011105)
				local var_431_15 = arg_428_1:FormatText(var_431_14.content)

				arg_428_1.text_.text = var_431_15

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_16 = 25
				local var_431_17 = utf8.len(var_431_15)
				local var_431_18 = var_431_16 <= 0 and var_431_12 or var_431_12 * (var_431_17 / var_431_16)

				if var_431_18 > 0 and var_431_12 < var_431_18 then
					arg_428_1.talkMaxDuration = var_431_18

					if var_431_18 + var_431_11 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_18 + var_431_11
					end
				end

				arg_428_1.text_.text = var_431_15
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011105", "story_v_out_120011.awb") ~= 0 then
					local var_431_19 = manager.audio:GetVoiceLength("story_v_out_120011", "120011105", "story_v_out_120011.awb") / 1000

					if var_431_19 + var_431_11 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_19 + var_431_11
					end

					if var_431_14.prefab_name ~= "" and arg_428_1.actors_[var_431_14.prefab_name] ~= nil then
						local var_431_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_14.prefab_name].transform, "story_v_out_120011", "120011105", "story_v_out_120011.awb")

						arg_428_1:RecordAudio("120011105", var_431_20)
						arg_428_1:RecordAudio("120011105", var_431_20)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_120011", "120011105", "story_v_out_120011.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_120011", "120011105", "story_v_out_120011.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_21 = math.max(var_431_12, arg_428_1.talkMaxDuration)

			if var_431_11 <= arg_428_1.time_ and arg_428_1.time_ < var_431_11 + var_431_21 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_11) / var_431_21

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_11 + var_431_21 and arg_428_1.time_ < var_431_11 + var_431_21 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play120011106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 120011106
		arg_432_1.duration_ = 3.77

		local var_432_0 = {
			zh = 3.766,
			ja = 3.4
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play120011107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1071ui_story"].transform
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.var_.moveOldPos1071ui_story = var_435_0.localPosition
			end

			local var_435_2 = 0.001

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2
				local var_435_4 = Vector3.New(0.7, -1.05, -6.2)

				var_435_0.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1071ui_story, var_435_4, var_435_3)

				local var_435_5 = manager.ui.mainCamera.transform.position - var_435_0.position

				var_435_0.forward = Vector3.New(var_435_5.x, var_435_5.y, var_435_5.z)

				local var_435_6 = var_435_0.localEulerAngles

				var_435_6.z = 0
				var_435_6.x = 0
				var_435_0.localEulerAngles = var_435_6
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 then
				var_435_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_435_7 = manager.ui.mainCamera.transform.position - var_435_0.position

				var_435_0.forward = Vector3.New(var_435_7.x, var_435_7.y, var_435_7.z)

				local var_435_8 = var_435_0.localEulerAngles

				var_435_8.z = 0
				var_435_8.x = 0
				var_435_0.localEulerAngles = var_435_8
			end

			local var_435_9 = 0

			if var_435_9 < arg_432_1.time_ and arg_432_1.time_ <= var_435_9 + arg_435_0 then
				arg_432_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_435_10 = 0
			local var_435_11 = 0.45

			if var_435_10 < arg_432_1.time_ and arg_432_1.time_ <= var_435_10 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_12 = arg_432_1:FormatText(StoryNameCfg[376].name)

				arg_432_1.leftNameTxt_.text = var_435_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_13 = arg_432_1:GetWordFromCfg(120011106)
				local var_435_14 = arg_432_1:FormatText(var_435_13.content)

				arg_432_1.text_.text = var_435_14

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_15 = 18
				local var_435_16 = utf8.len(var_435_14)
				local var_435_17 = var_435_15 <= 0 and var_435_11 or var_435_11 * (var_435_16 / var_435_15)

				if var_435_17 > 0 and var_435_11 < var_435_17 then
					arg_432_1.talkMaxDuration = var_435_17

					if var_435_17 + var_435_10 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_17 + var_435_10
					end
				end

				arg_432_1.text_.text = var_435_14
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011106", "story_v_out_120011.awb") ~= 0 then
					local var_435_18 = manager.audio:GetVoiceLength("story_v_out_120011", "120011106", "story_v_out_120011.awb") / 1000

					if var_435_18 + var_435_10 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_18 + var_435_10
					end

					if var_435_13.prefab_name ~= "" and arg_432_1.actors_[var_435_13.prefab_name] ~= nil then
						local var_435_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_13.prefab_name].transform, "story_v_out_120011", "120011106", "story_v_out_120011.awb")

						arg_432_1:RecordAudio("120011106", var_435_19)
						arg_432_1:RecordAudio("120011106", var_435_19)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_120011", "120011106", "story_v_out_120011.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_120011", "120011106", "story_v_out_120011.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_20 = math.max(var_435_11, arg_432_1.talkMaxDuration)

			if var_435_10 <= arg_432_1.time_ and arg_432_1.time_ < var_435_10 + var_435_20 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_10) / var_435_20

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_10 + var_435_20 and arg_432_1.time_ < var_435_10 + var_435_20 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play120011107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 120011107
		arg_436_1.duration_ = 4.07

		local var_436_0 = {
			zh = 2.533,
			ja = 4.066
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play120011108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1084ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1084ui_story == nil then
				arg_436_1.var_.characterEffect1084ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect1084ui_story and not isNil(var_439_0) then
					arg_436_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1084ui_story then
				arg_436_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_439_4 = arg_436_1.actors_["1071ui_story"]
			local var_439_5 = 0

			if var_439_5 < arg_436_1.time_ and arg_436_1.time_ <= var_439_5 + arg_439_0 and not isNil(var_439_4) and arg_436_1.var_.characterEffect1071ui_story == nil then
				arg_436_1.var_.characterEffect1071ui_story = var_439_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_6 = 0.2

			if var_439_5 <= arg_436_1.time_ and arg_436_1.time_ < var_439_5 + var_439_6 and not isNil(var_439_4) then
				local var_439_7 = (arg_436_1.time_ - var_439_5) / var_439_6

				if arg_436_1.var_.characterEffect1071ui_story and not isNil(var_439_4) then
					local var_439_8 = Mathf.Lerp(0, 0.5, var_439_7)

					arg_436_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1071ui_story.fillRatio = var_439_8
				end
			end

			if arg_436_1.time_ >= var_439_5 + var_439_6 and arg_436_1.time_ < var_439_5 + var_439_6 + arg_439_0 and not isNil(var_439_4) and arg_436_1.var_.characterEffect1071ui_story then
				local var_439_9 = 0.5

				arg_436_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1071ui_story.fillRatio = var_439_9
			end

			local var_439_10 = 0

			if var_439_10 < arg_436_1.time_ and arg_436_1.time_ <= var_439_10 + arg_439_0 then
				arg_436_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_439_11 = 0

			if var_439_11 < arg_436_1.time_ and arg_436_1.time_ <= var_439_11 + arg_439_0 then
				arg_436_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_439_12 = 0
			local var_439_13 = 0.25

			if var_439_12 < arg_436_1.time_ and arg_436_1.time_ <= var_439_12 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_14 = arg_436_1:FormatText(StoryNameCfg[6].name)

				arg_436_1.leftNameTxt_.text = var_439_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_15 = arg_436_1:GetWordFromCfg(120011107)
				local var_439_16 = arg_436_1:FormatText(var_439_15.content)

				arg_436_1.text_.text = var_439_16

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_17 = 10
				local var_439_18 = utf8.len(var_439_16)
				local var_439_19 = var_439_17 <= 0 and var_439_13 or var_439_13 * (var_439_18 / var_439_17)

				if var_439_19 > 0 and var_439_13 < var_439_19 then
					arg_436_1.talkMaxDuration = var_439_19

					if var_439_19 + var_439_12 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_19 + var_439_12
					end
				end

				arg_436_1.text_.text = var_439_16
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011107", "story_v_out_120011.awb") ~= 0 then
					local var_439_20 = manager.audio:GetVoiceLength("story_v_out_120011", "120011107", "story_v_out_120011.awb") / 1000

					if var_439_20 + var_439_12 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_20 + var_439_12
					end

					if var_439_15.prefab_name ~= "" and arg_436_1.actors_[var_439_15.prefab_name] ~= nil then
						local var_439_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_15.prefab_name].transform, "story_v_out_120011", "120011107", "story_v_out_120011.awb")

						arg_436_1:RecordAudio("120011107", var_439_21)
						arg_436_1:RecordAudio("120011107", var_439_21)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_120011", "120011107", "story_v_out_120011.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_120011", "120011107", "story_v_out_120011.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_22 = math.max(var_439_13, arg_436_1.talkMaxDuration)

			if var_439_12 <= arg_436_1.time_ and arg_436_1.time_ < var_439_12 + var_439_22 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_12) / var_439_22

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_12 + var_439_22 and arg_436_1.time_ < var_439_12 + var_439_22 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play120011108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 120011108
		arg_440_1.duration_ = 1.6

		local var_440_0 = {
			zh = 1.6,
			ja = 1.4
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play120011109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1071ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1071ui_story = var_443_0.localPosition
			end

			local var_443_2 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2
				local var_443_4 = Vector3.New(0.7, -1.05, -6.2)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1071ui_story, var_443_4, var_443_3)

				local var_443_5 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_5.x, var_443_5.y, var_443_5.z)

				local var_443_6 = var_443_0.localEulerAngles

				var_443_6.z = 0
				var_443_6.x = 0
				var_443_0.localEulerAngles = var_443_6
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_443_7 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_7.x, var_443_7.y, var_443_7.z)

				local var_443_8 = var_443_0.localEulerAngles

				var_443_8.z = 0
				var_443_8.x = 0
				var_443_0.localEulerAngles = var_443_8
			end

			local var_443_9 = arg_440_1.actors_["1071ui_story"]
			local var_443_10 = 0

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1071ui_story == nil then
				arg_440_1.var_.characterEffect1071ui_story = var_443_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_11 = 0.2

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_11 and not isNil(var_443_9) then
				local var_443_12 = (arg_440_1.time_ - var_443_10) / var_443_11

				if arg_440_1.var_.characterEffect1071ui_story and not isNil(var_443_9) then
					arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_10 + var_443_11 and arg_440_1.time_ < var_443_10 + var_443_11 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1071ui_story then
				arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_443_13 = arg_440_1.actors_["1084ui_story"]
			local var_443_14 = 0

			if var_443_14 < arg_440_1.time_ and arg_440_1.time_ <= var_443_14 + arg_443_0 and not isNil(var_443_13) and arg_440_1.var_.characterEffect1084ui_story == nil then
				arg_440_1.var_.characterEffect1084ui_story = var_443_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_15 = 0.2

			if var_443_14 <= arg_440_1.time_ and arg_440_1.time_ < var_443_14 + var_443_15 and not isNil(var_443_13) then
				local var_443_16 = (arg_440_1.time_ - var_443_14) / var_443_15

				if arg_440_1.var_.characterEffect1084ui_story and not isNil(var_443_13) then
					local var_443_17 = Mathf.Lerp(0, 0.5, var_443_16)

					arg_440_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1084ui_story.fillRatio = var_443_17
				end
			end

			if arg_440_1.time_ >= var_443_14 + var_443_15 and arg_440_1.time_ < var_443_14 + var_443_15 + arg_443_0 and not isNil(var_443_13) and arg_440_1.var_.characterEffect1084ui_story then
				local var_443_18 = 0.5

				arg_440_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1084ui_story.fillRatio = var_443_18
			end

			local var_443_19 = 0
			local var_443_20 = 0.05

			if var_443_19 < arg_440_1.time_ and arg_440_1.time_ <= var_443_19 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_21 = arg_440_1:FormatText(StoryNameCfg[376].name)

				arg_440_1.leftNameTxt_.text = var_443_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_22 = arg_440_1:GetWordFromCfg(120011108)
				local var_443_23 = arg_440_1:FormatText(var_443_22.content)

				arg_440_1.text_.text = var_443_23

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_24 = 2
				local var_443_25 = utf8.len(var_443_23)
				local var_443_26 = var_443_24 <= 0 and var_443_20 or var_443_20 * (var_443_25 / var_443_24)

				if var_443_26 > 0 and var_443_20 < var_443_26 then
					arg_440_1.talkMaxDuration = var_443_26

					if var_443_26 + var_443_19 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_26 + var_443_19
					end
				end

				arg_440_1.text_.text = var_443_23
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011108", "story_v_out_120011.awb") ~= 0 then
					local var_443_27 = manager.audio:GetVoiceLength("story_v_out_120011", "120011108", "story_v_out_120011.awb") / 1000

					if var_443_27 + var_443_19 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_27 + var_443_19
					end

					if var_443_22.prefab_name ~= "" and arg_440_1.actors_[var_443_22.prefab_name] ~= nil then
						local var_443_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_22.prefab_name].transform, "story_v_out_120011", "120011108", "story_v_out_120011.awb")

						arg_440_1:RecordAudio("120011108", var_443_28)
						arg_440_1:RecordAudio("120011108", var_443_28)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_120011", "120011108", "story_v_out_120011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_120011", "120011108", "story_v_out_120011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_29 = math.max(var_443_20, arg_440_1.talkMaxDuration)

			if var_443_19 <= arg_440_1.time_ and arg_440_1.time_ < var_443_19 + var_443_29 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_19) / var_443_29

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_19 + var_443_29 and arg_440_1.time_ < var_443_19 + var_443_29 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play120011109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 120011109
		arg_444_1.duration_ = 9.9

		local var_444_0 = {
			zh = 7.9,
			ja = 9.9
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play120011110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1071ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos1071ui_story = var_447_0.localPosition
			end

			local var_447_2 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2
				local var_447_4 = Vector3.New(0.7, -1.05, -6.2)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1071ui_story, var_447_4, var_447_3)

				local var_447_5 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_5.x, var_447_5.y, var_447_5.z)

				local var_447_6 = var_447_0.localEulerAngles

				var_447_6.z = 0
				var_447_6.x = 0
				var_447_0.localEulerAngles = var_447_6
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_447_7 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_7.x, var_447_7.y, var_447_7.z)

				local var_447_8 = var_447_0.localEulerAngles

				var_447_8.z = 0
				var_447_8.x = 0
				var_447_0.localEulerAngles = var_447_8
			end

			local var_447_9 = 0

			if var_447_9 < arg_444_1.time_ and arg_444_1.time_ <= var_447_9 + arg_447_0 then
				arg_444_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_447_10 = 0
			local var_447_11 = 0.975

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_12 = arg_444_1:FormatText(StoryNameCfg[376].name)

				arg_444_1.leftNameTxt_.text = var_447_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_13 = arg_444_1:GetWordFromCfg(120011109)
				local var_447_14 = arg_444_1:FormatText(var_447_13.content)

				arg_444_1.text_.text = var_447_14

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_15 = 39
				local var_447_16 = utf8.len(var_447_14)
				local var_447_17 = var_447_15 <= 0 and var_447_11 or var_447_11 * (var_447_16 / var_447_15)

				if var_447_17 > 0 and var_447_11 < var_447_17 then
					arg_444_1.talkMaxDuration = var_447_17

					if var_447_17 + var_447_10 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_17 + var_447_10
					end
				end

				arg_444_1.text_.text = var_447_14
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011109", "story_v_out_120011.awb") ~= 0 then
					local var_447_18 = manager.audio:GetVoiceLength("story_v_out_120011", "120011109", "story_v_out_120011.awb") / 1000

					if var_447_18 + var_447_10 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_18 + var_447_10
					end

					if var_447_13.prefab_name ~= "" and arg_444_1.actors_[var_447_13.prefab_name] ~= nil then
						local var_447_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_13.prefab_name].transform, "story_v_out_120011", "120011109", "story_v_out_120011.awb")

						arg_444_1:RecordAudio("120011109", var_447_19)
						arg_444_1:RecordAudio("120011109", var_447_19)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_120011", "120011109", "story_v_out_120011.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_120011", "120011109", "story_v_out_120011.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_20 = math.max(var_447_11, arg_444_1.talkMaxDuration)

			if var_447_10 <= arg_444_1.time_ and arg_444_1.time_ < var_447_10 + var_447_20 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_10) / var_447_20

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_10 + var_447_20 and arg_444_1.time_ < var_447_10 + var_447_20 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play120011110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 120011110
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play120011111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1071ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1071ui_story == nil then
				arg_448_1.var_.characterEffect1071ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1071ui_story and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1071ui_story.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1071ui_story then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1071ui_story.fillRatio = var_451_5
			end

			local var_451_6 = 0

			if var_451_6 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_451_7 = 0

			if var_451_7 < arg_448_1.time_ and arg_448_1.time_ <= var_451_7 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_451_8 = 0
			local var_451_9 = 0.325

			if var_451_8 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_10 = arg_448_1:FormatText(StoryNameCfg[7].name)

				arg_448_1.leftNameTxt_.text = var_451_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_11 = arg_448_1:GetWordFromCfg(120011110)
				local var_451_12 = arg_448_1:FormatText(var_451_11.content)

				arg_448_1.text_.text = var_451_12

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_13 = 13
				local var_451_14 = utf8.len(var_451_12)
				local var_451_15 = var_451_13 <= 0 and var_451_9 or var_451_9 * (var_451_14 / var_451_13)

				if var_451_15 > 0 and var_451_9 < var_451_15 then
					arg_448_1.talkMaxDuration = var_451_15

					if var_451_15 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_15 + var_451_8
					end
				end

				arg_448_1.text_.text = var_451_12
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_16 = math.max(var_451_9, arg_448_1.talkMaxDuration)

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_16 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_8) / var_451_16

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_8 + var_451_16 and arg_448_1.time_ < var_451_8 + var_451_16 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play120011111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 120011111
		arg_452_1.duration_ = 6.63

		local var_452_0 = {
			zh = 6.633,
			ja = 5.766
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play120011112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1071ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1071ui_story == nil then
				arg_452_1.var_.characterEffect1071ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect1071ui_story and not isNil(var_455_0) then
					arg_452_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect1071ui_story then
				arg_452_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_455_4 = 0

			if var_455_4 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_455_5 = 0
			local var_455_6 = 0.6

			if var_455_5 < arg_452_1.time_ and arg_452_1.time_ <= var_455_5 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_7 = arg_452_1:FormatText(StoryNameCfg[376].name)

				arg_452_1.leftNameTxt_.text = var_455_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_8 = arg_452_1:GetWordFromCfg(120011111)
				local var_455_9 = arg_452_1:FormatText(var_455_8.content)

				arg_452_1.text_.text = var_455_9

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_10 = 24
				local var_455_11 = utf8.len(var_455_9)
				local var_455_12 = var_455_10 <= 0 and var_455_6 or var_455_6 * (var_455_11 / var_455_10)

				if var_455_12 > 0 and var_455_6 < var_455_12 then
					arg_452_1.talkMaxDuration = var_455_12

					if var_455_12 + var_455_5 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_12 + var_455_5
					end
				end

				arg_452_1.text_.text = var_455_9
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011111", "story_v_out_120011.awb") ~= 0 then
					local var_455_13 = manager.audio:GetVoiceLength("story_v_out_120011", "120011111", "story_v_out_120011.awb") / 1000

					if var_455_13 + var_455_5 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_13 + var_455_5
					end

					if var_455_8.prefab_name ~= "" and arg_452_1.actors_[var_455_8.prefab_name] ~= nil then
						local var_455_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_8.prefab_name].transform, "story_v_out_120011", "120011111", "story_v_out_120011.awb")

						arg_452_1:RecordAudio("120011111", var_455_14)
						arg_452_1:RecordAudio("120011111", var_455_14)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_120011", "120011111", "story_v_out_120011.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_120011", "120011111", "story_v_out_120011.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_15 = math.max(var_455_6, arg_452_1.talkMaxDuration)

			if var_455_5 <= arg_452_1.time_ and arg_452_1.time_ < var_455_5 + var_455_15 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_5) / var_455_15

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_5 + var_455_15 and arg_452_1.time_ < var_455_5 + var_455_15 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play120011112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 120011112
		arg_456_1.duration_ = 13

		local var_456_0 = {
			zh = 8.233,
			ja = 13
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play120011113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 1.125

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[376].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:GetWordFromCfg(120011112)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 45
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011112", "story_v_out_120011.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011112", "story_v_out_120011.awb") / 1000

					if var_459_8 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_0
					end

					if var_459_3.prefab_name ~= "" and arg_456_1.actors_[var_459_3.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_3.prefab_name].transform, "story_v_out_120011", "120011112", "story_v_out_120011.awb")

						arg_456_1:RecordAudio("120011112", var_459_9)
						arg_456_1:RecordAudio("120011112", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_120011", "120011112", "story_v_out_120011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_120011", "120011112", "story_v_out_120011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_10 and arg_456_1.time_ < var_459_0 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play120011113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 120011113
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play120011114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1084ui_story"].transform
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.var_.moveOldPos1084ui_story = var_463_0.localPosition
			end

			local var_463_2 = 0.001

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2
				local var_463_4 = Vector3.New(0, 100, 0)

				var_463_0.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1084ui_story, var_463_4, var_463_3)

				local var_463_5 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_5.x, var_463_5.y, var_463_5.z)

				local var_463_6 = var_463_0.localEulerAngles

				var_463_6.z = 0
				var_463_6.x = 0
				var_463_0.localEulerAngles = var_463_6
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 then
				var_463_0.localPosition = Vector3.New(0, 100, 0)

				local var_463_7 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_7.x, var_463_7.y, var_463_7.z)

				local var_463_8 = var_463_0.localEulerAngles

				var_463_8.z = 0
				var_463_8.x = 0
				var_463_0.localEulerAngles = var_463_8
			end

			local var_463_9 = arg_460_1.actors_["1071ui_story"].transform
			local var_463_10 = 0

			if var_463_10 < arg_460_1.time_ and arg_460_1.time_ <= var_463_10 + arg_463_0 then
				arg_460_1.var_.moveOldPos1071ui_story = var_463_9.localPosition
			end

			local var_463_11 = 0.001

			if var_463_10 <= arg_460_1.time_ and arg_460_1.time_ < var_463_10 + var_463_11 then
				local var_463_12 = (arg_460_1.time_ - var_463_10) / var_463_11
				local var_463_13 = Vector3.New(0, 100, 0)

				var_463_9.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1071ui_story, var_463_13, var_463_12)

				local var_463_14 = manager.ui.mainCamera.transform.position - var_463_9.position

				var_463_9.forward = Vector3.New(var_463_14.x, var_463_14.y, var_463_14.z)

				local var_463_15 = var_463_9.localEulerAngles

				var_463_15.z = 0
				var_463_15.x = 0
				var_463_9.localEulerAngles = var_463_15
			end

			if arg_460_1.time_ >= var_463_10 + var_463_11 and arg_460_1.time_ < var_463_10 + var_463_11 + arg_463_0 then
				var_463_9.localPosition = Vector3.New(0, 100, 0)

				local var_463_16 = manager.ui.mainCamera.transform.position - var_463_9.position

				var_463_9.forward = Vector3.New(var_463_16.x, var_463_16.y, var_463_16.z)

				local var_463_17 = var_463_9.localEulerAngles

				var_463_17.z = 0
				var_463_17.x = 0
				var_463_9.localEulerAngles = var_463_17
			end

			local var_463_18 = 0
			local var_463_19 = 0.4

			if var_463_18 < arg_460_1.time_ and arg_460_1.time_ <= var_463_18 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_20 = arg_460_1:GetWordFromCfg(120011113)
				local var_463_21 = arg_460_1:FormatText(var_463_20.content)

				arg_460_1.text_.text = var_463_21

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_22 = 16
				local var_463_23 = utf8.len(var_463_21)
				local var_463_24 = var_463_22 <= 0 and var_463_19 or var_463_19 * (var_463_23 / var_463_22)

				if var_463_24 > 0 and var_463_19 < var_463_24 then
					arg_460_1.talkMaxDuration = var_463_24

					if var_463_24 + var_463_18 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_24 + var_463_18
					end
				end

				arg_460_1.text_.text = var_463_21
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_25 = math.max(var_463_19, arg_460_1.talkMaxDuration)

			if var_463_18 <= arg_460_1.time_ and arg_460_1.time_ < var_463_18 + var_463_25 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_18) / var_463_25

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_18 + var_463_25 and arg_460_1.time_ < var_463_18 + var_463_25 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play120011114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 120011114
		arg_464_1.duration_ = 4.8

		local var_464_0 = {
			zh = 4.133,
			ja = 4.8
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play120011115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1084ui_story"].transform
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.var_.moveOldPos1084ui_story = var_467_0.localPosition
			end

			local var_467_2 = 0.001

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2
				local var_467_4 = Vector3.New(0, -0.97, -6)

				var_467_0.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1084ui_story, var_467_4, var_467_3)

				local var_467_5 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_5.x, var_467_5.y, var_467_5.z)

				local var_467_6 = var_467_0.localEulerAngles

				var_467_6.z = 0
				var_467_6.x = 0
				var_467_0.localEulerAngles = var_467_6
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 then
				var_467_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_467_7 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_7.x, var_467_7.y, var_467_7.z)

				local var_467_8 = var_467_0.localEulerAngles

				var_467_8.z = 0
				var_467_8.x = 0
				var_467_0.localEulerAngles = var_467_8
			end

			local var_467_9 = arg_464_1.actors_["1084ui_story"]
			local var_467_10 = 0

			if var_467_10 < arg_464_1.time_ and arg_464_1.time_ <= var_467_10 + arg_467_0 and not isNil(var_467_9) and arg_464_1.var_.characterEffect1084ui_story == nil then
				arg_464_1.var_.characterEffect1084ui_story = var_467_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_11 = 0.2

			if var_467_10 <= arg_464_1.time_ and arg_464_1.time_ < var_467_10 + var_467_11 and not isNil(var_467_9) then
				local var_467_12 = (arg_464_1.time_ - var_467_10) / var_467_11

				if arg_464_1.var_.characterEffect1084ui_story and not isNil(var_467_9) then
					arg_464_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_10 + var_467_11 and arg_464_1.time_ < var_467_10 + var_467_11 + arg_467_0 and not isNil(var_467_9) and arg_464_1.var_.characterEffect1084ui_story then
				arg_464_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_467_13 = 0

			if var_467_13 < arg_464_1.time_ and arg_464_1.time_ <= var_467_13 + arg_467_0 then
				arg_464_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_467_14 = 0

			if var_467_14 < arg_464_1.time_ and arg_464_1.time_ <= var_467_14 + arg_467_0 then
				arg_464_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_467_15 = 0
			local var_467_16 = 0.45

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_17 = arg_464_1:FormatText(StoryNameCfg[6].name)

				arg_464_1.leftNameTxt_.text = var_467_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_18 = arg_464_1:GetWordFromCfg(120011114)
				local var_467_19 = arg_464_1:FormatText(var_467_18.content)

				arg_464_1.text_.text = var_467_19

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_20 = 18
				local var_467_21 = utf8.len(var_467_19)
				local var_467_22 = var_467_20 <= 0 and var_467_16 or var_467_16 * (var_467_21 / var_467_20)

				if var_467_22 > 0 and var_467_16 < var_467_22 then
					arg_464_1.talkMaxDuration = var_467_22

					if var_467_22 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_22 + var_467_15
					end
				end

				arg_464_1.text_.text = var_467_19
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011114", "story_v_out_120011.awb") ~= 0 then
					local var_467_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011114", "story_v_out_120011.awb") / 1000

					if var_467_23 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_23 + var_467_15
					end

					if var_467_18.prefab_name ~= "" and arg_464_1.actors_[var_467_18.prefab_name] ~= nil then
						local var_467_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_18.prefab_name].transform, "story_v_out_120011", "120011114", "story_v_out_120011.awb")

						arg_464_1:RecordAudio("120011114", var_467_24)
						arg_464_1:RecordAudio("120011114", var_467_24)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_120011", "120011114", "story_v_out_120011.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_120011", "120011114", "story_v_out_120011.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_25 = math.max(var_467_16, arg_464_1.talkMaxDuration)

			if var_467_15 <= arg_464_1.time_ and arg_464_1.time_ < var_467_15 + var_467_25 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_15) / var_467_25

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_15 + var_467_25 and arg_464_1.time_ < var_467_15 + var_467_25 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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

		arg_464_1:InitPlayNodeList()
	end,
	Play120011115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 120011115
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play120011116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1084ui_story"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1084ui_story == nil then
				arg_468_1.var_.characterEffect1084ui_story = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.2

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1084ui_story and not isNil(var_471_0) then
					local var_471_4 = Mathf.Lerp(0, 0.5, var_471_3)

					arg_468_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1084ui_story.fillRatio = var_471_4
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1084ui_story then
				local var_471_5 = 0.5

				arg_468_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1084ui_story.fillRatio = var_471_5
			end

			local var_471_6 = 0
			local var_471_7 = 0.675

			if var_471_6 < arg_468_1.time_ and arg_468_1.time_ <= var_471_6 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_8 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_9 = arg_468_1:GetWordFromCfg(120011115)
				local var_471_10 = arg_468_1:FormatText(var_471_9.content)

				arg_468_1.text_.text = var_471_10

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_11 = 27
				local var_471_12 = utf8.len(var_471_10)
				local var_471_13 = var_471_11 <= 0 and var_471_7 or var_471_7 * (var_471_12 / var_471_11)

				if var_471_13 > 0 and var_471_7 < var_471_13 then
					arg_468_1.talkMaxDuration = var_471_13

					if var_471_13 + var_471_6 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_13 + var_471_6
					end
				end

				arg_468_1.text_.text = var_471_10
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_14 = math.max(var_471_7, arg_468_1.talkMaxDuration)

			if var_471_6 <= arg_468_1.time_ and arg_468_1.time_ < var_471_6 + var_471_14 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_6) / var_471_14

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_6 + var_471_14 and arg_468_1.time_ < var_471_6 + var_471_14 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play120011116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 120011116
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play120011117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1084ui_story"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos1084ui_story = var_475_0.localPosition
			end

			local var_475_2 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2
				local var_475_4 = Vector3.New(0, 100, 0)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1084ui_story, var_475_4, var_475_3)

				local var_475_5 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_5.x, var_475_5.y, var_475_5.z)

				local var_475_6 = var_475_0.localEulerAngles

				var_475_6.z = 0
				var_475_6.x = 0
				var_475_0.localEulerAngles = var_475_6
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(0, 100, 0)

				local var_475_7 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_7.x, var_475_7.y, var_475_7.z)

				local var_475_8 = var_475_0.localEulerAngles

				var_475_8.z = 0
				var_475_8.x = 0
				var_475_0.localEulerAngles = var_475_8
			end

			local var_475_9 = 0
			local var_475_10 = 0.5

			if var_475_9 < arg_472_1.time_ and arg_472_1.time_ <= var_475_9 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_11 = arg_472_1:GetWordFromCfg(120011116)
				local var_475_12 = arg_472_1:FormatText(var_475_11.content)

				arg_472_1.text_.text = var_475_12

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_13 = 20
				local var_475_14 = utf8.len(var_475_12)
				local var_475_15 = var_475_13 <= 0 and var_475_10 or var_475_10 * (var_475_14 / var_475_13)

				if var_475_15 > 0 and var_475_10 < var_475_15 then
					arg_472_1.talkMaxDuration = var_475_15

					if var_475_15 + var_475_9 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_15 + var_475_9
					end
				end

				arg_472_1.text_.text = var_475_12
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_16 = math.max(var_475_10, arg_472_1.talkMaxDuration)

			if var_475_9 <= arg_472_1.time_ and arg_472_1.time_ < var_475_9 + var_475_16 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_9) / var_475_16

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_9 + var_475_16 and arg_472_1.time_ < var_475_9 + var_475_16 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
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

		arg_472_1:InitPlayNodeList()
	end,
	Play120011117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 120011117
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play120011118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.5

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_2 = arg_476_1:GetWordFromCfg(120011117)
				local var_479_3 = arg_476_1:FormatText(var_479_2.content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 20
				local var_479_5 = utf8.len(var_479_3)
				local var_479_6 = var_479_4 <= 0 and var_479_1 or var_479_1 * (var_479_5 / var_479_4)

				if var_479_6 > 0 and var_479_1 < var_479_6 then
					arg_476_1.talkMaxDuration = var_479_6

					if var_479_6 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_6 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_7 and arg_476_1.time_ < var_479_0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play120011118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 120011118
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play120011119(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.1

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[7].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_3 = arg_480_1:GetWordFromCfg(120011118)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 4
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_8 and arg_480_1.time_ < var_483_0 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play120011119 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 120011119
		arg_484_1.duration_ = 7.6

		local var_484_0 = {
			zh = 6.333,
			ja = 7.6
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play120011120(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1084ui_story"].transform
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.var_.moveOldPos1084ui_story = var_487_0.localPosition
			end

			local var_487_2 = 0.001

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2
				local var_487_4 = Vector3.New(0, -0.97, -6)

				var_487_0.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1084ui_story, var_487_4, var_487_3)

				local var_487_5 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_5.x, var_487_5.y, var_487_5.z)

				local var_487_6 = var_487_0.localEulerAngles

				var_487_6.z = 0
				var_487_6.x = 0
				var_487_0.localEulerAngles = var_487_6
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 then
				var_487_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_487_7 = manager.ui.mainCamera.transform.position - var_487_0.position

				var_487_0.forward = Vector3.New(var_487_7.x, var_487_7.y, var_487_7.z)

				local var_487_8 = var_487_0.localEulerAngles

				var_487_8.z = 0
				var_487_8.x = 0
				var_487_0.localEulerAngles = var_487_8
			end

			local var_487_9 = arg_484_1.actors_["1084ui_story"]
			local var_487_10 = 0

			if var_487_10 < arg_484_1.time_ and arg_484_1.time_ <= var_487_10 + arg_487_0 and not isNil(var_487_9) and arg_484_1.var_.characterEffect1084ui_story == nil then
				arg_484_1.var_.characterEffect1084ui_story = var_487_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_11 = 0.2

			if var_487_10 <= arg_484_1.time_ and arg_484_1.time_ < var_487_10 + var_487_11 and not isNil(var_487_9) then
				local var_487_12 = (arg_484_1.time_ - var_487_10) / var_487_11

				if arg_484_1.var_.characterEffect1084ui_story and not isNil(var_487_9) then
					arg_484_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= var_487_10 + var_487_11 and arg_484_1.time_ < var_487_10 + var_487_11 + arg_487_0 and not isNil(var_487_9) and arg_484_1.var_.characterEffect1084ui_story then
				arg_484_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_487_13 = 0

			if var_487_13 < arg_484_1.time_ and arg_484_1.time_ <= var_487_13 + arg_487_0 then
				arg_484_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_487_14 = 0

			if var_487_14 < arg_484_1.time_ and arg_484_1.time_ <= var_487_14 + arg_487_0 then
				arg_484_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_487_15 = 0
			local var_487_16 = 0.65

			if var_487_15 < arg_484_1.time_ and arg_484_1.time_ <= var_487_15 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_17 = arg_484_1:FormatText(StoryNameCfg[6].name)

				arg_484_1.leftNameTxt_.text = var_487_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_18 = arg_484_1:GetWordFromCfg(120011119)
				local var_487_19 = arg_484_1:FormatText(var_487_18.content)

				arg_484_1.text_.text = var_487_19

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_20 = 26
				local var_487_21 = utf8.len(var_487_19)
				local var_487_22 = var_487_20 <= 0 and var_487_16 or var_487_16 * (var_487_21 / var_487_20)

				if var_487_22 > 0 and var_487_16 < var_487_22 then
					arg_484_1.talkMaxDuration = var_487_22

					if var_487_22 + var_487_15 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_22 + var_487_15
					end
				end

				arg_484_1.text_.text = var_487_19
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011119", "story_v_out_120011.awb") ~= 0 then
					local var_487_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011119", "story_v_out_120011.awb") / 1000

					if var_487_23 + var_487_15 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_23 + var_487_15
					end

					if var_487_18.prefab_name ~= "" and arg_484_1.actors_[var_487_18.prefab_name] ~= nil then
						local var_487_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_18.prefab_name].transform, "story_v_out_120011", "120011119", "story_v_out_120011.awb")

						arg_484_1:RecordAudio("120011119", var_487_24)
						arg_484_1:RecordAudio("120011119", var_487_24)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_120011", "120011119", "story_v_out_120011.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_120011", "120011119", "story_v_out_120011.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_25 = math.max(var_487_16, arg_484_1.talkMaxDuration)

			if var_487_15 <= arg_484_1.time_ and arg_484_1.time_ < var_487_15 + var_487_25 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_15) / var_487_25

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_15 + var_487_25 and arg_484_1.time_ < var_487_15 + var_487_25 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
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

		arg_484_1:InitPlayNodeList()
	end,
	Play120011120 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 120011120
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play120011121(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1084ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1084ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, 100, 0)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1084ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, 100, 0)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = 0
			local var_491_10 = 1.15

			if var_491_9 < arg_488_1.time_ and arg_488_1.time_ <= var_491_9 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_11 = arg_488_1:GetWordFromCfg(120011120)
				local var_491_12 = arg_488_1:FormatText(var_491_11.content)

				arg_488_1.text_.text = var_491_12

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_13 = 46
				local var_491_14 = utf8.len(var_491_12)
				local var_491_15 = var_491_13 <= 0 and var_491_10 or var_491_10 * (var_491_14 / var_491_13)

				if var_491_15 > 0 and var_491_10 < var_491_15 then
					arg_488_1.talkMaxDuration = var_491_15

					if var_491_15 + var_491_9 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_15 + var_491_9
					end
				end

				arg_488_1.text_.text = var_491_12
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_16 = math.max(var_491_10, arg_488_1.talkMaxDuration)

			if var_491_9 <= arg_488_1.time_ and arg_488_1.time_ < var_491_9 + var_491_16 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_9) / var_491_16

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_9 + var_491_16 and arg_488_1.time_ < var_491_9 + var_491_16 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
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

		arg_488_1:InitPlayNodeList()
	end,
	Play120011121 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 120011121
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play120011122(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.85

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_2 = arg_492_1:GetWordFromCfg(120011121)
				local var_495_3 = arg_492_1:FormatText(var_495_2.content)

				arg_492_1.text_.text = var_495_3

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_4 = 34
				local var_495_5 = utf8.len(var_495_3)
				local var_495_6 = var_495_4 <= 0 and var_495_1 or var_495_1 * (var_495_5 / var_495_4)

				if var_495_6 > 0 and var_495_1 < var_495_6 then
					arg_492_1.talkMaxDuration = var_495_6

					if var_495_6 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_6 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_3
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_7 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_7 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_7

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_7 and arg_492_1.time_ < var_495_0 + var_495_7 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play120011122 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 120011122
		arg_496_1.duration_ = 9

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play120011123(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = "XH0102a"

			if arg_496_1.bgs_[var_499_0] == nil then
				local var_499_1 = Object.Instantiate(arg_496_1.paintGo_)

				var_499_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_499_0)
				var_499_1.name = var_499_0
				var_499_1.transform.parent = arg_496_1.stage_.transform
				var_499_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.bgs_[var_499_0] = var_499_1
			end

			local var_499_2 = 2

			if var_499_2 < arg_496_1.time_ and arg_496_1.time_ <= var_499_2 + arg_499_0 then
				local var_499_3 = manager.ui.mainCamera.transform.localPosition
				local var_499_4 = Vector3.New(0, 0, 10) + Vector3.New(var_499_3.x, var_499_3.y, 0)
				local var_499_5 = arg_496_1.bgs_.XH0102a

				var_499_5.transform.localPosition = var_499_4
				var_499_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_499_6 = var_499_5:GetComponent("SpriteRenderer")

				if var_499_6 and var_499_6.sprite then
					local var_499_7 = (var_499_5.transform.localPosition - var_499_3).z
					local var_499_8 = manager.ui.mainCameraCom_
					local var_499_9 = 2 * var_499_7 * Mathf.Tan(var_499_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_499_10 = var_499_9 * var_499_8.aspect
					local var_499_11 = var_499_6.sprite.bounds.size.x
					local var_499_12 = var_499_6.sprite.bounds.size.y
					local var_499_13 = var_499_10 / var_499_11
					local var_499_14 = var_499_9 / var_499_12
					local var_499_15 = var_499_14 < var_499_13 and var_499_13 or var_499_14

					var_499_5.transform.localScale = Vector3.New(var_499_15, var_499_15, 0)
				end

				for iter_499_0, iter_499_1 in pairs(arg_496_1.bgs_) do
					if iter_499_0 ~= "XH0102a" then
						iter_499_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_499_16 = 0

			if var_499_16 < arg_496_1.time_ and arg_496_1.time_ <= var_499_16 + arg_499_0 then
				arg_496_1.mask_.enabled = true
				arg_496_1.mask_.raycastTarget = true

				arg_496_1:SetGaussion(false)
			end

			local var_499_17 = 2

			if var_499_16 <= arg_496_1.time_ and arg_496_1.time_ < var_499_16 + var_499_17 then
				local var_499_18 = (arg_496_1.time_ - var_499_16) / var_499_17
				local var_499_19 = Color.New(0, 0, 0)

				var_499_19.a = Mathf.Lerp(0, 1, var_499_18)
				arg_496_1.mask_.color = var_499_19
			end

			if arg_496_1.time_ >= var_499_16 + var_499_17 and arg_496_1.time_ < var_499_16 + var_499_17 + arg_499_0 then
				local var_499_20 = Color.New(0, 0, 0)

				var_499_20.a = 1
				arg_496_1.mask_.color = var_499_20
			end

			local var_499_21 = 2

			if var_499_21 < arg_496_1.time_ and arg_496_1.time_ <= var_499_21 + arg_499_0 then
				arg_496_1.mask_.enabled = true
				arg_496_1.mask_.raycastTarget = true

				arg_496_1:SetGaussion(false)
			end

			local var_499_22 = 2

			if var_499_21 <= arg_496_1.time_ and arg_496_1.time_ < var_499_21 + var_499_22 then
				local var_499_23 = (arg_496_1.time_ - var_499_21) / var_499_22
				local var_499_24 = Color.New(0, 0, 0)

				var_499_24.a = Mathf.Lerp(1, 0, var_499_23)
				arg_496_1.mask_.color = var_499_24
			end

			if arg_496_1.time_ >= var_499_21 + var_499_22 and arg_496_1.time_ < var_499_21 + var_499_22 + arg_499_0 then
				local var_499_25 = Color.New(0, 0, 0)
				local var_499_26 = 0

				arg_496_1.mask_.enabled = false
				var_499_25.a = var_499_26
				arg_496_1.mask_.color = var_499_25
			end

			local var_499_27 = arg_496_1.bgs_.XH0102a.transform
			local var_499_28 = 2

			if var_499_28 < arg_496_1.time_ and arg_496_1.time_ <= var_499_28 + arg_499_0 then
				arg_496_1.var_.moveOldPosXH0102a = var_499_27.localPosition
			end

			local var_499_29 = 0.001

			if var_499_28 <= arg_496_1.time_ and arg_496_1.time_ < var_499_28 + var_499_29 then
				local var_499_30 = (arg_496_1.time_ - var_499_28) / var_499_29
				local var_499_31 = Vector3.New(0, 1, 4)

				var_499_27.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPosXH0102a, var_499_31, var_499_30)
			end

			if arg_496_1.time_ >= var_499_28 + var_499_29 and arg_496_1.time_ < var_499_28 + var_499_29 + arg_499_0 then
				var_499_27.localPosition = Vector3.New(0, 1, 4)
			end

			local var_499_32 = arg_496_1.bgs_.XH0102a.transform
			local var_499_33 = 2.01666666666667

			if var_499_33 < arg_496_1.time_ and arg_496_1.time_ <= var_499_33 + arg_499_0 then
				arg_496_1.var_.moveOldPosXH0102a = var_499_32.localPosition
			end

			local var_499_34 = 2.5

			if var_499_33 <= arg_496_1.time_ and arg_496_1.time_ < var_499_33 + var_499_34 then
				local var_499_35 = (arg_496_1.time_ - var_499_33) / var_499_34
				local var_499_36 = Vector3.New(0, 0.5, 4.5)

				var_499_32.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPosXH0102a, var_499_36, var_499_35)
			end

			if arg_496_1.time_ >= var_499_33 + var_499_34 and arg_496_1.time_ < var_499_33 + var_499_34 + arg_499_0 then
				var_499_32.localPosition = Vector3.New(0, 0.5, 4.5)
			end

			local var_499_37 = 4

			if var_499_37 < arg_496_1.time_ and arg_496_1.time_ <= var_499_37 + arg_499_0 then
				arg_496_1.allBtn_.enabled = false
			end

			local var_499_38 = 1

			if arg_496_1.time_ >= var_499_37 + var_499_38 and arg_496_1.time_ < var_499_37 + var_499_38 + arg_499_0 then
				arg_496_1.allBtn_.enabled = true
			end

			if arg_496_1.frameCnt_ <= 1 then
				arg_496_1.dialog_:SetActive(false)
			end

			local var_499_39 = 4
			local var_499_40 = 1.3

			if var_499_39 < arg_496_1.time_ and arg_496_1.time_ <= var_499_39 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0

				arg_496_1.dialog_:SetActive(true)

				arg_496_1.dialogCg_.alpha = 0

				local var_499_41 = LeanTween.value(arg_496_1.dialog_, 0, 1, 0.3)

				var_499_41:setOnUpdate(LuaHelper.FloatAction(function(arg_500_0)
					arg_496_1.dialogCg_.alpha = arg_500_0
				end))
				var_499_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_496_1.dialog_)
					var_499_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_496_1.duration_ = arg_496_1.duration_ + 0.3

				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_42 = arg_496_1:GetWordFromCfg(120011122)
				local var_499_43 = arg_496_1:FormatText(var_499_42.content)

				arg_496_1.text_.text = var_499_43

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_44 = 52
				local var_499_45 = utf8.len(var_499_43)
				local var_499_46 = var_499_44 <= 0 and var_499_40 or var_499_40 * (var_499_45 / var_499_44)

				if var_499_46 > 0 and var_499_40 < var_499_46 then
					arg_496_1.talkMaxDuration = var_499_46
					var_499_39 = var_499_39 + 0.3

					if var_499_46 + var_499_39 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_46 + var_499_39
					end
				end

				arg_496_1.text_.text = var_499_43
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_47 = var_499_39 + 0.3
			local var_499_48 = math.max(var_499_40, arg_496_1.talkMaxDuration)

			if var_499_47 <= arg_496_1.time_ and arg_496_1.time_ < var_499_47 + var_499_48 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_47) / var_499_48

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_47 + var_499_48 and arg_496_1.time_ < var_499_47 + var_499_48 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0102a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0102a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play120011123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 120011123
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play120011124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 1.175

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_2 = arg_502_1:GetWordFromCfg(120011123)
				local var_505_3 = arg_502_1:FormatText(var_505_2.content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 47
				local var_505_5 = utf8.len(var_505_3)
				local var_505_6 = var_505_4 <= 0 and var_505_1 or var_505_1 * (var_505_5 / var_505_4)

				if var_505_6 > 0 and var_505_1 < var_505_6 then
					arg_502_1.talkMaxDuration = var_505_6

					if var_505_6 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_6 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_7 and arg_502_1.time_ < var_505_0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play120011124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 120011124
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play120011125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.85

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[7].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:GetWordFromCfg(120011124)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 34
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_8 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_8 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_8

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_8 and arg_506_1.time_ < var_509_0 + var_509_8 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play120011125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 120011125
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play120011126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 0.875

			if var_513_0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_2 = arg_510_1:GetWordFromCfg(120011125)
				local var_513_3 = arg_510_1:FormatText(var_513_2.content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 35
				local var_513_5 = utf8.len(var_513_3)
				local var_513_6 = var_513_4 <= 0 and var_513_1 or var_513_1 * (var_513_5 / var_513_4)

				if var_513_6 > 0 and var_513_1 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_0
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_1, arg_510_1.talkMaxDuration)

			if var_513_0 <= arg_510_1.time_ and arg_510_1.time_ < var_513_0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_0 + var_513_7 and arg_510_1.time_ < var_513_0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play120011126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 120011126
		arg_514_1.duration_ = 7.53

		local var_514_0 = {
			zh = 7.533,
			ja = 5.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play120011127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0
			local var_517_1 = 0.875

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_2 = arg_514_1:FormatText(StoryNameCfg[6].name)

				arg_514_1.leftNameTxt_.text = var_517_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_3 = arg_514_1:GetWordFromCfg(120011126)
				local var_517_4 = arg_514_1:FormatText(var_517_3.content)

				arg_514_1.text_.text = var_517_4

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 35
				local var_517_6 = utf8.len(var_517_4)
				local var_517_7 = var_517_5 <= 0 and var_517_1 or var_517_1 * (var_517_6 / var_517_5)

				if var_517_7 > 0 and var_517_1 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_0
					end
				end

				arg_514_1.text_.text = var_517_4
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011126", "story_v_out_120011.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011126", "story_v_out_120011.awb") / 1000

					if var_517_8 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_0
					end

					if var_517_3.prefab_name ~= "" and arg_514_1.actors_[var_517_3.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_3.prefab_name].transform, "story_v_out_120011", "120011126", "story_v_out_120011.awb")

						arg_514_1:RecordAudio("120011126", var_517_9)
						arg_514_1:RecordAudio("120011126", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_120011", "120011126", "story_v_out_120011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_120011", "120011126", "story_v_out_120011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_1, arg_514_1.talkMaxDuration)

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_0) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_0 + var_517_10 and arg_514_1.time_ < var_517_0 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play120011127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 120011127
		arg_518_1.duration_ = 11.37

		local var_518_0 = {
			zh = 10.066,
			ja = 11.366
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play120011128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0
			local var_521_1 = 1.075

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_2 = arg_518_1:FormatText(StoryNameCfg[6].name)

				arg_518_1.leftNameTxt_.text = var_521_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:GetWordFromCfg(120011127)
				local var_521_4 = arg_518_1:FormatText(var_521_3.content)

				arg_518_1.text_.text = var_521_4

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 43
				local var_521_6 = utf8.len(var_521_4)
				local var_521_7 = var_521_5 <= 0 and var_521_1 or var_521_1 * (var_521_6 / var_521_5)

				if var_521_7 > 0 and var_521_1 < var_521_7 then
					arg_518_1.talkMaxDuration = var_521_7

					if var_521_7 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_7 + var_521_0
					end
				end

				arg_518_1.text_.text = var_521_4
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011127", "story_v_out_120011.awb") ~= 0 then
					local var_521_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011127", "story_v_out_120011.awb") / 1000

					if var_521_8 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_8 + var_521_0
					end

					if var_521_3.prefab_name ~= "" and arg_518_1.actors_[var_521_3.prefab_name] ~= nil then
						local var_521_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_3.prefab_name].transform, "story_v_out_120011", "120011127", "story_v_out_120011.awb")

						arg_518_1:RecordAudio("120011127", var_521_9)
						arg_518_1:RecordAudio("120011127", var_521_9)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_120011", "120011127", "story_v_out_120011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_120011", "120011127", "story_v_out_120011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_10 = math.max(var_521_1, arg_518_1.talkMaxDuration)

			if var_521_0 <= arg_518_1.time_ and arg_518_1.time_ < var_521_0 + var_521_10 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_0) / var_521_10

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_0 + var_521_10 and arg_518_1.time_ < var_521_0 + var_521_10 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play120011128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 120011128
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play120011129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 0
			local var_525_1 = 1.175

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_2 = arg_522_1:FormatText(StoryNameCfg[7].name)

				arg_522_1.leftNameTxt_.text = var_525_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:GetWordFromCfg(120011128)
				local var_525_4 = arg_522_1:FormatText(var_525_3.content)

				arg_522_1.text_.text = var_525_4

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 48
				local var_525_6 = utf8.len(var_525_4)
				local var_525_7 = var_525_5 <= 0 and var_525_1 or var_525_1 * (var_525_6 / var_525_5)

				if var_525_7 > 0 and var_525_1 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_0
					end
				end

				arg_522_1.text_.text = var_525_4
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_8 = math.max(var_525_1, arg_522_1.talkMaxDuration)

			if var_525_0 <= arg_522_1.time_ and arg_522_1.time_ < var_525_0 + var_525_8 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_0) / var_525_8

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_0 + var_525_8 and arg_522_1.time_ < var_525_0 + var_525_8 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play120011129 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 120011129
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play120011130(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 0.8

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_2 = arg_526_1:FormatText(StoryNameCfg[7].name)

				arg_526_1.leftNameTxt_.text = var_529_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_3 = arg_526_1:GetWordFromCfg(120011129)
				local var_529_4 = arg_526_1:FormatText(var_529_3.content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 32
				local var_529_6 = utf8.len(var_529_4)
				local var_529_7 = var_529_5 <= 0 and var_529_1 or var_529_1 * (var_529_6 / var_529_5)

				if var_529_7 > 0 and var_529_1 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_8 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_8 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_8

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_8 and arg_526_1.time_ < var_529_0 + var_529_8 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play120011130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 120011130
		arg_530_1.duration_ = 6.83

		local var_530_0 = {
			zh = 4.966,
			ja = 6.833
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play120011131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0
			local var_533_1 = 0.325

			if var_533_0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_2 = arg_530_1:FormatText(StoryNameCfg[6].name)

				arg_530_1.leftNameTxt_.text = var_533_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_3 = arg_530_1:GetWordFromCfg(120011130)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 13
				local var_533_6 = utf8.len(var_533_4)
				local var_533_7 = var_533_5 <= 0 and var_533_1 or var_533_1 * (var_533_6 / var_533_5)

				if var_533_7 > 0 and var_533_1 < var_533_7 then
					arg_530_1.talkMaxDuration = var_533_7

					if var_533_7 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_0
					end
				end

				arg_530_1.text_.text = var_533_4
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011130", "story_v_out_120011.awb") ~= 0 then
					local var_533_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011130", "story_v_out_120011.awb") / 1000

					if var_533_8 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_0
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_out_120011", "120011130", "story_v_out_120011.awb")

						arg_530_1:RecordAudio("120011130", var_533_9)
						arg_530_1:RecordAudio("120011130", var_533_9)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_120011", "120011130", "story_v_out_120011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_120011", "120011130", "story_v_out_120011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_10 = math.max(var_533_1, arg_530_1.talkMaxDuration)

			if var_533_0 <= arg_530_1.time_ and arg_530_1.time_ < var_533_0 + var_533_10 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_0) / var_533_10

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_0 + var_533_10 and arg_530_1.time_ < var_533_0 + var_533_10 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play120011131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 120011131
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play120011132(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0
			local var_537_1 = 0.4

			if var_537_0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_2 = arg_534_1:FormatText(StoryNameCfg[7].name)

				arg_534_1.leftNameTxt_.text = var_537_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_3 = arg_534_1:GetWordFromCfg(120011131)
				local var_537_4 = arg_534_1:FormatText(var_537_3.content)

				arg_534_1.text_.text = var_537_4

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_5 = 16
				local var_537_6 = utf8.len(var_537_4)
				local var_537_7 = var_537_5 <= 0 and var_537_1 or var_537_1 * (var_537_6 / var_537_5)

				if var_537_7 > 0 and var_537_1 < var_537_7 then
					arg_534_1.talkMaxDuration = var_537_7

					if var_537_7 + var_537_0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_7 + var_537_0
					end
				end

				arg_534_1.text_.text = var_537_4
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_8 = math.max(var_537_1, arg_534_1.talkMaxDuration)

			if var_537_0 <= arg_534_1.time_ and arg_534_1.time_ < var_537_0 + var_537_8 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_0) / var_537_8

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_0 + var_537_8 and arg_534_1.time_ < var_537_0 + var_537_8 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play120011132 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 120011132
		arg_538_1.duration_ = 9

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play120011133(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = 2

			if var_541_0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_0 + arg_541_0 then
				local var_541_1 = manager.ui.mainCamera.transform.localPosition
				local var_541_2 = Vector3.New(0, 0, 10) + Vector3.New(var_541_1.x, var_541_1.y, 0)
				local var_541_3 = arg_538_1.bgs_.ST31

				var_541_3.transform.localPosition = var_541_2
				var_541_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_541_4 = var_541_3:GetComponent("SpriteRenderer")

				if var_541_4 and var_541_4.sprite then
					local var_541_5 = (var_541_3.transform.localPosition - var_541_1).z
					local var_541_6 = manager.ui.mainCameraCom_
					local var_541_7 = 2 * var_541_5 * Mathf.Tan(var_541_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_541_8 = var_541_7 * var_541_6.aspect
					local var_541_9 = var_541_4.sprite.bounds.size.x
					local var_541_10 = var_541_4.sprite.bounds.size.y
					local var_541_11 = var_541_8 / var_541_9
					local var_541_12 = var_541_7 / var_541_10
					local var_541_13 = var_541_12 < var_541_11 and var_541_11 or var_541_12

					var_541_3.transform.localScale = Vector3.New(var_541_13, var_541_13, 0)
				end

				for iter_541_0, iter_541_1 in pairs(arg_538_1.bgs_) do
					if iter_541_0 ~= "ST31" then
						iter_541_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_541_14 = 0

			if var_541_14 < arg_538_1.time_ and arg_538_1.time_ <= var_541_14 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_15 = 2

			if var_541_14 <= arg_538_1.time_ and arg_538_1.time_ < var_541_14 + var_541_15 then
				local var_541_16 = (arg_538_1.time_ - var_541_14) / var_541_15
				local var_541_17 = Color.New(0, 0, 0)

				var_541_17.a = Mathf.Lerp(0, 1, var_541_16)
				arg_538_1.mask_.color = var_541_17
			end

			if arg_538_1.time_ >= var_541_14 + var_541_15 and arg_538_1.time_ < var_541_14 + var_541_15 + arg_541_0 then
				local var_541_18 = Color.New(0, 0, 0)

				var_541_18.a = 1
				arg_538_1.mask_.color = var_541_18
			end

			local var_541_19 = 2

			if var_541_19 < arg_538_1.time_ and arg_538_1.time_ <= var_541_19 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_20 = 2

			if var_541_19 <= arg_538_1.time_ and arg_538_1.time_ < var_541_19 + var_541_20 then
				local var_541_21 = (arg_538_1.time_ - var_541_19) / var_541_20
				local var_541_22 = Color.New(0, 0, 0)

				var_541_22.a = Mathf.Lerp(1, 0, var_541_21)
				arg_538_1.mask_.color = var_541_22
			end

			if arg_538_1.time_ >= var_541_19 + var_541_20 and arg_538_1.time_ < var_541_19 + var_541_20 + arg_541_0 then
				local var_541_23 = Color.New(0, 0, 0)
				local var_541_24 = 0

				arg_538_1.mask_.enabled = false
				var_541_23.a = var_541_24
				arg_538_1.mask_.color = var_541_23
			end

			if arg_538_1.frameCnt_ <= 1 then
				arg_538_1.dialog_:SetActive(false)
			end

			local var_541_25 = 4
			local var_541_26 = 0.625

			if var_541_25 < arg_538_1.time_ and arg_538_1.time_ <= var_541_25 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0

				arg_538_1.dialog_:SetActive(true)

				arg_538_1.dialogCg_.alpha = 0

				local var_541_27 = LeanTween.value(arg_538_1.dialog_, 0, 1, 0.3)

				var_541_27:setOnUpdate(LuaHelper.FloatAction(function(arg_542_0)
					arg_538_1.dialogCg_.alpha = arg_542_0
				end))
				var_541_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_538_1.dialog_)
					var_541_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_538_1.duration_ = arg_538_1.duration_ + 0.3

				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_28 = arg_538_1:GetWordFromCfg(120011132)
				local var_541_29 = arg_538_1:FormatText(var_541_28.content)

				arg_538_1.text_.text = var_541_29

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_30 = 25
				local var_541_31 = utf8.len(var_541_29)
				local var_541_32 = var_541_30 <= 0 and var_541_26 or var_541_26 * (var_541_31 / var_541_30)

				if var_541_32 > 0 and var_541_26 < var_541_32 then
					arg_538_1.talkMaxDuration = var_541_32
					var_541_25 = var_541_25 + 0.3

					if var_541_32 + var_541_25 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_32 + var_541_25
					end
				end

				arg_538_1.text_.text = var_541_29
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_33 = var_541_25 + 0.3
			local var_541_34 = math.max(var_541_26, arg_538_1.talkMaxDuration)

			if var_541_33 <= arg_538_1.time_ and arg_538_1.time_ < var_541_33 + var_541_34 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_33) / var_541_34

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_33 + var_541_34 and arg_538_1.time_ < var_541_33 + var_541_34 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play120011133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 120011133
		arg_544_1.duration_ = 8.37

		local var_544_0 = {
			zh = 8.1,
			ja = 8.366
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play120011134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1084ui_story"].transform
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.var_.moveOldPos1084ui_story = var_547_0.localPosition
			end

			local var_547_2 = 0.001

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2
				local var_547_4 = Vector3.New(0, -0.97, -6)

				var_547_0.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1084ui_story, var_547_4, var_547_3)

				local var_547_5 = manager.ui.mainCamera.transform.position - var_547_0.position

				var_547_0.forward = Vector3.New(var_547_5.x, var_547_5.y, var_547_5.z)

				local var_547_6 = var_547_0.localEulerAngles

				var_547_6.z = 0
				var_547_6.x = 0
				var_547_0.localEulerAngles = var_547_6
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 then
				var_547_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_547_7 = manager.ui.mainCamera.transform.position - var_547_0.position

				var_547_0.forward = Vector3.New(var_547_7.x, var_547_7.y, var_547_7.z)

				local var_547_8 = var_547_0.localEulerAngles

				var_547_8.z = 0
				var_547_8.x = 0
				var_547_0.localEulerAngles = var_547_8
			end

			local var_547_9 = arg_544_1.actors_["1084ui_story"]
			local var_547_10 = 0

			if var_547_10 < arg_544_1.time_ and arg_544_1.time_ <= var_547_10 + arg_547_0 and not isNil(var_547_9) and arg_544_1.var_.characterEffect1084ui_story == nil then
				arg_544_1.var_.characterEffect1084ui_story = var_547_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_11 = 0.2

			if var_547_10 <= arg_544_1.time_ and arg_544_1.time_ < var_547_10 + var_547_11 and not isNil(var_547_9) then
				local var_547_12 = (arg_544_1.time_ - var_547_10) / var_547_11

				if arg_544_1.var_.characterEffect1084ui_story and not isNil(var_547_9) then
					arg_544_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= var_547_10 + var_547_11 and arg_544_1.time_ < var_547_10 + var_547_11 + arg_547_0 and not isNil(var_547_9) and arg_544_1.var_.characterEffect1084ui_story then
				arg_544_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_547_13 = 0

			if var_547_13 < arg_544_1.time_ and arg_544_1.time_ <= var_547_13 + arg_547_0 then
				arg_544_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_547_14 = 0

			if var_547_14 < arg_544_1.time_ and arg_544_1.time_ <= var_547_14 + arg_547_0 then
				arg_544_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_547_15 = 0
			local var_547_16 = 0.9

			if var_547_15 < arg_544_1.time_ and arg_544_1.time_ <= var_547_15 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_17 = arg_544_1:FormatText(StoryNameCfg[6].name)

				arg_544_1.leftNameTxt_.text = var_547_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_18 = arg_544_1:GetWordFromCfg(120011133)
				local var_547_19 = arg_544_1:FormatText(var_547_18.content)

				arg_544_1.text_.text = var_547_19

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_20 = 36
				local var_547_21 = utf8.len(var_547_19)
				local var_547_22 = var_547_20 <= 0 and var_547_16 or var_547_16 * (var_547_21 / var_547_20)

				if var_547_22 > 0 and var_547_16 < var_547_22 then
					arg_544_1.talkMaxDuration = var_547_22

					if var_547_22 + var_547_15 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_22 + var_547_15
					end
				end

				arg_544_1.text_.text = var_547_19
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011133", "story_v_out_120011.awb") ~= 0 then
					local var_547_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011133", "story_v_out_120011.awb") / 1000

					if var_547_23 + var_547_15 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_23 + var_547_15
					end

					if var_547_18.prefab_name ~= "" and arg_544_1.actors_[var_547_18.prefab_name] ~= nil then
						local var_547_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_18.prefab_name].transform, "story_v_out_120011", "120011133", "story_v_out_120011.awb")

						arg_544_1:RecordAudio("120011133", var_547_24)
						arg_544_1:RecordAudio("120011133", var_547_24)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_120011", "120011133", "story_v_out_120011.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_120011", "120011133", "story_v_out_120011.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_25 = math.max(var_547_16, arg_544_1.talkMaxDuration)

			if var_547_15 <= arg_544_1.time_ and arg_544_1.time_ < var_547_15 + var_547_25 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_15) / var_547_25

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_15 + var_547_25 and arg_544_1.time_ < var_547_15 + var_547_25 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
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

		arg_544_1:InitPlayNodeList()
	end,
	Play120011134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 120011134
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play120011135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1084ui_story"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.characterEffect1084ui_story == nil then
				arg_548_1.var_.characterEffect1084ui_story = var_551_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_2 = 0.2

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.characterEffect1084ui_story and not isNil(var_551_0) then
					local var_551_4 = Mathf.Lerp(0, 0.5, var_551_3)

					arg_548_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_548_1.var_.characterEffect1084ui_story.fillRatio = var_551_4
				end
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.characterEffect1084ui_story then
				local var_551_5 = 0.5

				arg_548_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_548_1.var_.characterEffect1084ui_story.fillRatio = var_551_5
			end

			local var_551_6 = 0
			local var_551_7 = 0.6

			if var_551_6 < arg_548_1.time_ and arg_548_1.time_ <= var_551_6 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_8 = arg_548_1:FormatText(StoryNameCfg[7].name)

				arg_548_1.leftNameTxt_.text = var_551_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_9 = arg_548_1:GetWordFromCfg(120011134)
				local var_551_10 = arg_548_1:FormatText(var_551_9.content)

				arg_548_1.text_.text = var_551_10

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_11 = 24
				local var_551_12 = utf8.len(var_551_10)
				local var_551_13 = var_551_11 <= 0 and var_551_7 or var_551_7 * (var_551_12 / var_551_11)

				if var_551_13 > 0 and var_551_7 < var_551_13 then
					arg_548_1.talkMaxDuration = var_551_13

					if var_551_13 + var_551_6 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_13 + var_551_6
					end
				end

				arg_548_1.text_.text = var_551_10
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_14 = math.max(var_551_7, arg_548_1.talkMaxDuration)

			if var_551_6 <= arg_548_1.time_ and arg_548_1.time_ < var_551_6 + var_551_14 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_6) / var_551_14

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_6 + var_551_14 and arg_548_1.time_ < var_551_6 + var_551_14 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play120011135 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 120011135
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play120011136(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 0.925

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[7].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(120011135)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 37
				local var_555_6 = utf8.len(var_555_4)
				local var_555_7 = var_555_5 <= 0 and var_555_1 or var_555_1 * (var_555_6 / var_555_5)

				if var_555_7 > 0 and var_555_1 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_4
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_8 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_8 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_8

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_8 and arg_552_1.time_ < var_555_0 + var_555_8 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play120011136 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 120011136
		arg_556_1.duration_ = 5.43

		local var_556_0 = {
			zh = 5.433,
			ja = 4.4
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play120011137(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = arg_556_1.actors_["1084ui_story"].transform
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 then
				arg_556_1.var_.moveOldPos1084ui_story = var_559_0.localPosition
			end

			local var_559_2 = 0.001

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / var_559_2
				local var_559_4 = Vector3.New(0, -0.97, -6)

				var_559_0.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos1084ui_story, var_559_4, var_559_3)

				local var_559_5 = manager.ui.mainCamera.transform.position - var_559_0.position

				var_559_0.forward = Vector3.New(var_559_5.x, var_559_5.y, var_559_5.z)

				local var_559_6 = var_559_0.localEulerAngles

				var_559_6.z = 0
				var_559_6.x = 0
				var_559_0.localEulerAngles = var_559_6
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 then
				var_559_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_559_7 = manager.ui.mainCamera.transform.position - var_559_0.position

				var_559_0.forward = Vector3.New(var_559_7.x, var_559_7.y, var_559_7.z)

				local var_559_8 = var_559_0.localEulerAngles

				var_559_8.z = 0
				var_559_8.x = 0
				var_559_0.localEulerAngles = var_559_8
			end

			local var_559_9 = arg_556_1.actors_["1084ui_story"]
			local var_559_10 = 0

			if var_559_10 < arg_556_1.time_ and arg_556_1.time_ <= var_559_10 + arg_559_0 and not isNil(var_559_9) and arg_556_1.var_.characterEffect1084ui_story == nil then
				arg_556_1.var_.characterEffect1084ui_story = var_559_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_11 = 0.2

			if var_559_10 <= arg_556_1.time_ and arg_556_1.time_ < var_559_10 + var_559_11 and not isNil(var_559_9) then
				local var_559_12 = (arg_556_1.time_ - var_559_10) / var_559_11

				if arg_556_1.var_.characterEffect1084ui_story and not isNil(var_559_9) then
					arg_556_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= var_559_10 + var_559_11 and arg_556_1.time_ < var_559_10 + var_559_11 + arg_559_0 and not isNil(var_559_9) and arg_556_1.var_.characterEffect1084ui_story then
				arg_556_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_559_13 = 0

			if var_559_13 < arg_556_1.time_ and arg_556_1.time_ <= var_559_13 + arg_559_0 then
				arg_556_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action457")
			end

			local var_559_14 = 0

			if var_559_14 < arg_556_1.time_ and arg_556_1.time_ <= var_559_14 + arg_559_0 then
				arg_556_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_559_15 = 0
			local var_559_16 = 0.425

			if var_559_15 < arg_556_1.time_ and arg_556_1.time_ <= var_559_15 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_17 = arg_556_1:FormatText(StoryNameCfg[6].name)

				arg_556_1.leftNameTxt_.text = var_559_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_18 = arg_556_1:GetWordFromCfg(120011136)
				local var_559_19 = arg_556_1:FormatText(var_559_18.content)

				arg_556_1.text_.text = var_559_19

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_20 = 17
				local var_559_21 = utf8.len(var_559_19)
				local var_559_22 = var_559_20 <= 0 and var_559_16 or var_559_16 * (var_559_21 / var_559_20)

				if var_559_22 > 0 and var_559_16 < var_559_22 then
					arg_556_1.talkMaxDuration = var_559_22

					if var_559_22 + var_559_15 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_22 + var_559_15
					end
				end

				arg_556_1.text_.text = var_559_19
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011136", "story_v_out_120011.awb") ~= 0 then
					local var_559_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011136", "story_v_out_120011.awb") / 1000

					if var_559_23 + var_559_15 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_23 + var_559_15
					end

					if var_559_18.prefab_name ~= "" and arg_556_1.actors_[var_559_18.prefab_name] ~= nil then
						local var_559_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_18.prefab_name].transform, "story_v_out_120011", "120011136", "story_v_out_120011.awb")

						arg_556_1:RecordAudio("120011136", var_559_24)
						arg_556_1:RecordAudio("120011136", var_559_24)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_120011", "120011136", "story_v_out_120011.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_120011", "120011136", "story_v_out_120011.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_25 = math.max(var_559_16, arg_556_1.talkMaxDuration)

			if var_559_15 <= arg_556_1.time_ and arg_556_1.time_ < var_559_15 + var_559_25 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_15) / var_559_25

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_15 + var_559_25 and arg_556_1.time_ < var_559_15 + var_559_25 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
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

		arg_556_1:InitPlayNodeList()
	end,
	Play120011137 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 120011137
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play120011138(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["1084ui_story"]
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.characterEffect1084ui_story == nil then
				arg_560_1.var_.characterEffect1084ui_story = var_563_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_2 = 0.2

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 and not isNil(var_563_0) then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2

				if arg_560_1.var_.characterEffect1084ui_story and not isNil(var_563_0) then
					local var_563_4 = Mathf.Lerp(0, 0.5, var_563_3)

					arg_560_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_560_1.var_.characterEffect1084ui_story.fillRatio = var_563_4
				end
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.characterEffect1084ui_story then
				local var_563_5 = 0.5

				arg_560_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_560_1.var_.characterEffect1084ui_story.fillRatio = var_563_5
			end

			local var_563_6 = 0
			local var_563_7 = 0.175

			if var_563_6 < arg_560_1.time_ and arg_560_1.time_ <= var_563_6 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_8 = arg_560_1:FormatText(StoryNameCfg[7].name)

				arg_560_1.leftNameTxt_.text = var_563_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_9 = arg_560_1:GetWordFromCfg(120011137)
				local var_563_10 = arg_560_1:FormatText(var_563_9.content)

				arg_560_1.text_.text = var_563_10

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_11 = 7
				local var_563_12 = utf8.len(var_563_10)
				local var_563_13 = var_563_11 <= 0 and var_563_7 or var_563_7 * (var_563_12 / var_563_11)

				if var_563_13 > 0 and var_563_7 < var_563_13 then
					arg_560_1.talkMaxDuration = var_563_13

					if var_563_13 + var_563_6 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_13 + var_563_6
					end
				end

				arg_560_1.text_.text = var_563_10
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_14 = math.max(var_563_7, arg_560_1.talkMaxDuration)

			if var_563_6 <= arg_560_1.time_ and arg_560_1.time_ < var_563_6 + var_563_14 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_6) / var_563_14

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_6 + var_563_14 and arg_560_1.time_ < var_563_6 + var_563_14 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play120011138 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 120011138
		arg_564_1.duration_ = 2.63

		local var_564_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play120011139(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["1084ui_story"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect1084ui_story == nil then
				arg_564_1.var_.characterEffect1084ui_story = var_567_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_2 = 0.2

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.characterEffect1084ui_story and not isNil(var_567_0) then
					arg_564_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect1084ui_story then
				arg_564_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_567_4 = 0

			if var_567_4 < arg_564_1.time_ and arg_564_1.time_ <= var_567_4 + arg_567_0 then
				arg_564_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			local var_567_5 = 0

			if var_567_5 < arg_564_1.time_ and arg_564_1.time_ <= var_567_5 + arg_567_0 then
				arg_564_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_567_6 = 0
			local var_567_7 = 0.2

			if var_567_6 < arg_564_1.time_ and arg_564_1.time_ <= var_567_6 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_8 = arg_564_1:FormatText(StoryNameCfg[6].name)

				arg_564_1.leftNameTxt_.text = var_567_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_9 = arg_564_1:GetWordFromCfg(120011138)
				local var_567_10 = arg_564_1:FormatText(var_567_9.content)

				arg_564_1.text_.text = var_567_10

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_11 = 8
				local var_567_12 = utf8.len(var_567_10)
				local var_567_13 = var_567_11 <= 0 and var_567_7 or var_567_7 * (var_567_12 / var_567_11)

				if var_567_13 > 0 and var_567_7 < var_567_13 then
					arg_564_1.talkMaxDuration = var_567_13

					if var_567_13 + var_567_6 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_13 + var_567_6
					end
				end

				arg_564_1.text_.text = var_567_10
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011138", "story_v_out_120011.awb") ~= 0 then
					local var_567_14 = manager.audio:GetVoiceLength("story_v_out_120011", "120011138", "story_v_out_120011.awb") / 1000

					if var_567_14 + var_567_6 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_14 + var_567_6
					end

					if var_567_9.prefab_name ~= "" and arg_564_1.actors_[var_567_9.prefab_name] ~= nil then
						local var_567_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_9.prefab_name].transform, "story_v_out_120011", "120011138", "story_v_out_120011.awb")

						arg_564_1:RecordAudio("120011138", var_567_15)
						arg_564_1:RecordAudio("120011138", var_567_15)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_120011", "120011138", "story_v_out_120011.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_120011", "120011138", "story_v_out_120011.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_16 = math.max(var_567_7, arg_564_1.talkMaxDuration)

			if var_567_6 <= arg_564_1.time_ and arg_564_1.time_ < var_567_6 + var_567_16 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_6) / var_567_16

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_6 + var_567_16 and arg_564_1.time_ < var_567_6 + var_567_16 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play120011139 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 120011139
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play120011140(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = arg_568_1.actors_["1084ui_story"].transform
			local var_571_1 = 0

			if var_571_1 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.var_.moveOldPos1084ui_story = var_571_0.localPosition
			end

			local var_571_2 = 0.001

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_2 then
				local var_571_3 = (arg_568_1.time_ - var_571_1) / var_571_2
				local var_571_4 = Vector3.New(0, 100, 0)

				var_571_0.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1084ui_story, var_571_4, var_571_3)

				local var_571_5 = manager.ui.mainCamera.transform.position - var_571_0.position

				var_571_0.forward = Vector3.New(var_571_5.x, var_571_5.y, var_571_5.z)

				local var_571_6 = var_571_0.localEulerAngles

				var_571_6.z = 0
				var_571_6.x = 0
				var_571_0.localEulerAngles = var_571_6
			end

			if arg_568_1.time_ >= var_571_1 + var_571_2 and arg_568_1.time_ < var_571_1 + var_571_2 + arg_571_0 then
				var_571_0.localPosition = Vector3.New(0, 100, 0)

				local var_571_7 = manager.ui.mainCamera.transform.position - var_571_0.position

				var_571_0.forward = Vector3.New(var_571_7.x, var_571_7.y, var_571_7.z)

				local var_571_8 = var_571_0.localEulerAngles

				var_571_8.z = 0
				var_571_8.x = 0
				var_571_0.localEulerAngles = var_571_8
			end

			local var_571_9 = 0
			local var_571_10 = 0.725

			if var_571_9 < arg_568_1.time_ and arg_568_1.time_ <= var_571_9 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_11 = arg_568_1:GetWordFromCfg(120011139)
				local var_571_12 = arg_568_1:FormatText(var_571_11.content)

				arg_568_1.text_.text = var_571_12

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_13 = 29
				local var_571_14 = utf8.len(var_571_12)
				local var_571_15 = var_571_13 <= 0 and var_571_10 or var_571_10 * (var_571_14 / var_571_13)

				if var_571_15 > 0 and var_571_10 < var_571_15 then
					arg_568_1.talkMaxDuration = var_571_15

					if var_571_15 + var_571_9 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_15 + var_571_9
					end
				end

				arg_568_1.text_.text = var_571_12
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_16 = math.max(var_571_10, arg_568_1.talkMaxDuration)

			if var_571_9 <= arg_568_1.time_ and arg_568_1.time_ < var_571_9 + var_571_16 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_9) / var_571_16

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_9 + var_571_16 and arg_568_1.time_ < var_571_9 + var_571_16 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
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

		arg_568_1:InitPlayNodeList()
	end,
	Play120011140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 120011140
		arg_572_1.duration_ = 3.9

		local var_572_0 = {
			zh = 3.9,
			ja = 2.633
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play120011141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["1084ui_story"].transform
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 then
				arg_572_1.var_.moveOldPos1084ui_story = var_575_0.localPosition
			end

			local var_575_2 = 0.001

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2
				local var_575_4 = Vector3.New(0, -0.97, -6)

				var_575_0.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1084ui_story, var_575_4, var_575_3)

				local var_575_5 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_5.x, var_575_5.y, var_575_5.z)

				local var_575_6 = var_575_0.localEulerAngles

				var_575_6.z = 0
				var_575_6.x = 0
				var_575_0.localEulerAngles = var_575_6
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 then
				var_575_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_575_7 = manager.ui.mainCamera.transform.position - var_575_0.position

				var_575_0.forward = Vector3.New(var_575_7.x, var_575_7.y, var_575_7.z)

				local var_575_8 = var_575_0.localEulerAngles

				var_575_8.z = 0
				var_575_8.x = 0
				var_575_0.localEulerAngles = var_575_8
			end

			local var_575_9 = arg_572_1.actors_["1084ui_story"]
			local var_575_10 = 0

			if var_575_10 < arg_572_1.time_ and arg_572_1.time_ <= var_575_10 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1084ui_story == nil then
				arg_572_1.var_.characterEffect1084ui_story = var_575_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_11 = 0.2

			if var_575_10 <= arg_572_1.time_ and arg_572_1.time_ < var_575_10 + var_575_11 and not isNil(var_575_9) then
				local var_575_12 = (arg_572_1.time_ - var_575_10) / var_575_11

				if arg_572_1.var_.characterEffect1084ui_story and not isNil(var_575_9) then
					arg_572_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= var_575_10 + var_575_11 and arg_572_1.time_ < var_575_10 + var_575_11 + arg_575_0 and not isNil(var_575_9) and arg_572_1.var_.characterEffect1084ui_story then
				arg_572_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_575_13 = 0

			if var_575_13 < arg_572_1.time_ and arg_572_1.time_ <= var_575_13 + arg_575_0 then
				arg_572_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_575_14 = 0

			if var_575_14 < arg_572_1.time_ and arg_572_1.time_ <= var_575_14 + arg_575_0 then
				arg_572_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_575_15 = 0
			local var_575_16 = 0.375

			if var_575_15 < arg_572_1.time_ and arg_572_1.time_ <= var_575_15 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_17 = arg_572_1:FormatText(StoryNameCfg[6].name)

				arg_572_1.leftNameTxt_.text = var_575_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_18 = arg_572_1:GetWordFromCfg(120011140)
				local var_575_19 = arg_572_1:FormatText(var_575_18.content)

				arg_572_1.text_.text = var_575_19

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_20 = 15
				local var_575_21 = utf8.len(var_575_19)
				local var_575_22 = var_575_20 <= 0 and var_575_16 or var_575_16 * (var_575_21 / var_575_20)

				if var_575_22 > 0 and var_575_16 < var_575_22 then
					arg_572_1.talkMaxDuration = var_575_22

					if var_575_22 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_22 + var_575_15
					end
				end

				arg_572_1.text_.text = var_575_19
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011140", "story_v_out_120011.awb") ~= 0 then
					local var_575_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011140", "story_v_out_120011.awb") / 1000

					if var_575_23 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_23 + var_575_15
					end

					if var_575_18.prefab_name ~= "" and arg_572_1.actors_[var_575_18.prefab_name] ~= nil then
						local var_575_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_18.prefab_name].transform, "story_v_out_120011", "120011140", "story_v_out_120011.awb")

						arg_572_1:RecordAudio("120011140", var_575_24)
						arg_572_1:RecordAudio("120011140", var_575_24)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_120011", "120011140", "story_v_out_120011.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_120011", "120011140", "story_v_out_120011.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_25 = math.max(var_575_16, arg_572_1.talkMaxDuration)

			if var_575_15 <= arg_572_1.time_ and arg_572_1.time_ < var_575_15 + var_575_25 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_15) / var_575_25

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_15 + var_575_25 and arg_572_1.time_ < var_575_15 + var_575_25 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
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

		arg_572_1:InitPlayNodeList()
	end,
	Play120011141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 120011141
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play120011142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["1084ui_story"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect1084ui_story == nil then
				arg_576_1.var_.characterEffect1084ui_story = var_579_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_2 = 0.2

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.characterEffect1084ui_story and not isNil(var_579_0) then
					local var_579_4 = Mathf.Lerp(0, 0.5, var_579_3)

					arg_576_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_576_1.var_.characterEffect1084ui_story.fillRatio = var_579_4
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect1084ui_story then
				local var_579_5 = 0.5

				arg_576_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_576_1.var_.characterEffect1084ui_story.fillRatio = var_579_5
			end

			local var_579_6 = 0
			local var_579_7 = 1.075

			if var_579_6 < arg_576_1.time_ and arg_576_1.time_ <= var_579_6 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_8 = arg_576_1:FormatText(StoryNameCfg[7].name)

				arg_576_1.leftNameTxt_.text = var_579_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_9 = arg_576_1:GetWordFromCfg(120011141)
				local var_579_10 = arg_576_1:FormatText(var_579_9.content)

				arg_576_1.text_.text = var_579_10

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_11 = 43
				local var_579_12 = utf8.len(var_579_10)
				local var_579_13 = var_579_11 <= 0 and var_579_7 or var_579_7 * (var_579_12 / var_579_11)

				if var_579_13 > 0 and var_579_7 < var_579_13 then
					arg_576_1.talkMaxDuration = var_579_13

					if var_579_13 + var_579_6 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_13 + var_579_6
					end
				end

				arg_576_1.text_.text = var_579_10
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_14 = math.max(var_579_7, arg_576_1.talkMaxDuration)

			if var_579_6 <= arg_576_1.time_ and arg_576_1.time_ < var_579_6 + var_579_14 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_6) / var_579_14

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_6 + var_579_14 and arg_576_1.time_ < var_579_6 + var_579_14 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play120011142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 120011142
		arg_580_1.duration_ = 3.97

		local var_580_0 = {
			zh = 1.233,
			ja = 3.966
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play120011143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["1084ui_story"].transform
			local var_583_1 = 0

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.var_.moveOldPos1084ui_story = var_583_0.localPosition
			end

			local var_583_2 = 0.001

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_2 then
				local var_583_3 = (arg_580_1.time_ - var_583_1) / var_583_2
				local var_583_4 = Vector3.New(0, 100, 0)

				var_583_0.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1084ui_story, var_583_4, var_583_3)

				local var_583_5 = manager.ui.mainCamera.transform.position - var_583_0.position

				var_583_0.forward = Vector3.New(var_583_5.x, var_583_5.y, var_583_5.z)

				local var_583_6 = var_583_0.localEulerAngles

				var_583_6.z = 0
				var_583_6.x = 0
				var_583_0.localEulerAngles = var_583_6
			end

			if arg_580_1.time_ >= var_583_1 + var_583_2 and arg_580_1.time_ < var_583_1 + var_583_2 + arg_583_0 then
				var_583_0.localPosition = Vector3.New(0, 100, 0)

				local var_583_7 = manager.ui.mainCamera.transform.position - var_583_0.position

				var_583_0.forward = Vector3.New(var_583_7.x, var_583_7.y, var_583_7.z)

				local var_583_8 = var_583_0.localEulerAngles

				var_583_8.z = 0
				var_583_8.x = 0
				var_583_0.localEulerAngles = var_583_8
			end

			local var_583_9 = 0
			local var_583_10 = 0.125

			if var_583_9 < arg_580_1.time_ and arg_580_1.time_ <= var_583_9 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_11 = arg_580_1:FormatText(StoryNameCfg[377].name)

				arg_580_1.leftNameTxt_.text = var_583_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_12 = arg_580_1:GetWordFromCfg(120011142)
				local var_583_13 = arg_580_1:FormatText(var_583_12.content)

				arg_580_1.text_.text = var_583_13

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_14 = 5
				local var_583_15 = utf8.len(var_583_13)
				local var_583_16 = var_583_14 <= 0 and var_583_10 or var_583_10 * (var_583_15 / var_583_14)

				if var_583_16 > 0 and var_583_10 < var_583_16 then
					arg_580_1.talkMaxDuration = var_583_16

					if var_583_16 + var_583_9 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_16 + var_583_9
					end
				end

				arg_580_1.text_.text = var_583_13
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011142", "story_v_out_120011.awb") ~= 0 then
					local var_583_17 = manager.audio:GetVoiceLength("story_v_out_120011", "120011142", "story_v_out_120011.awb") / 1000

					if var_583_17 + var_583_9 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_17 + var_583_9
					end

					if var_583_12.prefab_name ~= "" and arg_580_1.actors_[var_583_12.prefab_name] ~= nil then
						local var_583_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_12.prefab_name].transform, "story_v_out_120011", "120011142", "story_v_out_120011.awb")

						arg_580_1:RecordAudio("120011142", var_583_18)
						arg_580_1:RecordAudio("120011142", var_583_18)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_120011", "120011142", "story_v_out_120011.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_120011", "120011142", "story_v_out_120011.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_19 = math.max(var_583_10, arg_580_1.talkMaxDuration)

			if var_583_9 <= arg_580_1.time_ and arg_580_1.time_ < var_583_9 + var_583_19 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_9) / var_583_19

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_9 + var_583_19 and arg_580_1.time_ < var_583_9 + var_583_19 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
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

		arg_580_1:InitPlayNodeList()
	end,
	Play120011143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 120011143
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play120011144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0
			local var_587_1 = 0.95

			if var_587_0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_2 = arg_584_1:GetWordFromCfg(120011143)
				local var_587_3 = arg_584_1:FormatText(var_587_2.content)

				arg_584_1.text_.text = var_587_3

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 38
				local var_587_5 = utf8.len(var_587_3)
				local var_587_6 = var_587_4 <= 0 and var_587_1 or var_587_1 * (var_587_5 / var_587_4)

				if var_587_6 > 0 and var_587_1 < var_587_6 then
					arg_584_1.talkMaxDuration = var_587_6

					if var_587_6 + var_587_0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_6 + var_587_0
					end
				end

				arg_584_1.text_.text = var_587_3
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_1, arg_584_1.talkMaxDuration)

			if var_587_0 <= arg_584_1.time_ and arg_584_1.time_ < var_587_0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_0 + var_587_7 and arg_584_1.time_ < var_587_0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play120011144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 120011144
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play120011145(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0
			local var_591_1 = 0.525

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_2 = arg_588_1:GetWordFromCfg(120011144)
				local var_591_3 = arg_588_1:FormatText(var_591_2.content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_4 = 21
				local var_591_5 = utf8.len(var_591_3)
				local var_591_6 = var_591_4 <= 0 and var_591_1 or var_591_1 * (var_591_5 / var_591_4)

				if var_591_6 > 0 and var_591_1 < var_591_6 then
					arg_588_1.talkMaxDuration = var_591_6

					if var_591_6 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_6 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_7 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_7 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_7

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_7 and arg_588_1.time_ < var_591_0 + var_591_7 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play120011145 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 120011145
		arg_592_1.duration_ = 3.33

		local var_592_0 = {
			zh = 1.999999999999,
			ja = 3.333
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play120011146(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = "1069ui_story"

			if arg_592_1.actors_[var_595_0] == nil then
				local var_595_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_595_1) then
					local var_595_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_592_1.stage_.transform)

					var_595_2.name = var_595_0
					var_595_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_592_1.actors_[var_595_0] = var_595_2

					local var_595_3 = var_595_2:GetComponentInChildren(typeof(CharacterEffect))

					var_595_3.enabled = true

					local var_595_4 = GameObjectTools.GetOrAddComponent(var_595_2, typeof(DynamicBoneHelper))

					if var_595_4 then
						var_595_4:EnableDynamicBone(false)
					end

					arg_592_1:ShowWeapon(var_595_3.transform, false)

					arg_592_1.var_[var_595_0 .. "Animator"] = var_595_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_592_1.var_[var_595_0 .. "Animator"].applyRootMotion = true
					arg_592_1.var_[var_595_0 .. "LipSync"] = var_595_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_595_5 = arg_592_1.actors_["1069ui_story"].transform
			local var_595_6 = 0

			if var_595_6 < arg_592_1.time_ and arg_592_1.time_ <= var_595_6 + arg_595_0 then
				arg_592_1.var_.moveOldPos1069ui_story = var_595_5.localPosition
			end

			local var_595_7 = 0.001

			if var_595_6 <= arg_592_1.time_ and arg_592_1.time_ < var_595_6 + var_595_7 then
				local var_595_8 = (arg_592_1.time_ - var_595_6) / var_595_7
				local var_595_9 = Vector3.New(0, -1, -6)

				var_595_5.localPosition = Vector3.Lerp(arg_592_1.var_.moveOldPos1069ui_story, var_595_9, var_595_8)

				local var_595_10 = manager.ui.mainCamera.transform.position - var_595_5.position

				var_595_5.forward = Vector3.New(var_595_10.x, var_595_10.y, var_595_10.z)

				local var_595_11 = var_595_5.localEulerAngles

				var_595_11.z = 0
				var_595_11.x = 0
				var_595_5.localEulerAngles = var_595_11
			end

			if arg_592_1.time_ >= var_595_6 + var_595_7 and arg_592_1.time_ < var_595_6 + var_595_7 + arg_595_0 then
				var_595_5.localPosition = Vector3.New(0, -1, -6)

				local var_595_12 = manager.ui.mainCamera.transform.position - var_595_5.position

				var_595_5.forward = Vector3.New(var_595_12.x, var_595_12.y, var_595_12.z)

				local var_595_13 = var_595_5.localEulerAngles

				var_595_13.z = 0
				var_595_13.x = 0
				var_595_5.localEulerAngles = var_595_13
			end

			local var_595_14 = arg_592_1.actors_["1069ui_story"]
			local var_595_15 = 0

			if var_595_15 < arg_592_1.time_ and arg_592_1.time_ <= var_595_15 + arg_595_0 and not isNil(var_595_14) and arg_592_1.var_.characterEffect1069ui_story == nil then
				arg_592_1.var_.characterEffect1069ui_story = var_595_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_16 = 0.2

			if var_595_15 <= arg_592_1.time_ and arg_592_1.time_ < var_595_15 + var_595_16 and not isNil(var_595_14) then
				local var_595_17 = (arg_592_1.time_ - var_595_15) / var_595_16

				if arg_592_1.var_.characterEffect1069ui_story and not isNil(var_595_14) then
					arg_592_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= var_595_15 + var_595_16 and arg_592_1.time_ < var_595_15 + var_595_16 + arg_595_0 and not isNil(var_595_14) and arg_592_1.var_.characterEffect1069ui_story then
				arg_592_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_595_18 = 0

			if var_595_18 < arg_592_1.time_ and arg_592_1.time_ <= var_595_18 + arg_595_0 then
				arg_592_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_595_19 = 0

			if var_595_19 < arg_592_1.time_ and arg_592_1.time_ <= var_595_19 + arg_595_0 then
				arg_592_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_595_20 = 0
			local var_595_21 = 0.25

			if var_595_20 < arg_592_1.time_ and arg_592_1.time_ <= var_595_20 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_22 = arg_592_1:FormatText(StoryNameCfg[377].name)

				arg_592_1.leftNameTxt_.text = var_595_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_23 = arg_592_1:GetWordFromCfg(120011145)
				local var_595_24 = arg_592_1:FormatText(var_595_23.content)

				arg_592_1.text_.text = var_595_24

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_25 = 10
				local var_595_26 = utf8.len(var_595_24)
				local var_595_27 = var_595_25 <= 0 and var_595_21 or var_595_21 * (var_595_26 / var_595_25)

				if var_595_27 > 0 and var_595_21 < var_595_27 then
					arg_592_1.talkMaxDuration = var_595_27

					if var_595_27 + var_595_20 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_27 + var_595_20
					end
				end

				arg_592_1.text_.text = var_595_24
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011145", "story_v_out_120011.awb") ~= 0 then
					local var_595_28 = manager.audio:GetVoiceLength("story_v_out_120011", "120011145", "story_v_out_120011.awb") / 1000

					if var_595_28 + var_595_20 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_28 + var_595_20
					end

					if var_595_23.prefab_name ~= "" and arg_592_1.actors_[var_595_23.prefab_name] ~= nil then
						local var_595_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_23.prefab_name].transform, "story_v_out_120011", "120011145", "story_v_out_120011.awb")

						arg_592_1:RecordAudio("120011145", var_595_29)
						arg_592_1:RecordAudio("120011145", var_595_29)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_120011", "120011145", "story_v_out_120011.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_120011", "120011145", "story_v_out_120011.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_30 = math.max(var_595_21, arg_592_1.talkMaxDuration)

			if var_595_20 <= arg_592_1.time_ and arg_592_1.time_ < var_595_20 + var_595_30 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_20) / var_595_30

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_20 + var_595_30 and arg_592_1.time_ < var_595_20 + var_595_30 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_592_1:InitPlayNodeList()
	end,
	Play120011146 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 120011146
		arg_596_1.duration_ = 2.03

		local var_596_0 = {
			zh = 1.333,
			ja = 2.033
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play120011147(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0
			local var_599_1 = 0.125

			if var_599_0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_2 = arg_596_1:FormatText(StoryNameCfg[377].name)

				arg_596_1.leftNameTxt_.text = var_599_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_3 = arg_596_1:GetWordFromCfg(120011146)
				local var_599_4 = arg_596_1:FormatText(var_599_3.content)

				arg_596_1.text_.text = var_599_4

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_5 = 5
				local var_599_6 = utf8.len(var_599_4)
				local var_599_7 = var_599_5 <= 0 and var_599_1 or var_599_1 * (var_599_6 / var_599_5)

				if var_599_7 > 0 and var_599_1 < var_599_7 then
					arg_596_1.talkMaxDuration = var_599_7

					if var_599_7 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_7 + var_599_0
					end
				end

				arg_596_1.text_.text = var_599_4
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011146", "story_v_out_120011.awb") ~= 0 then
					local var_599_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011146", "story_v_out_120011.awb") / 1000

					if var_599_8 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_8 + var_599_0
					end

					if var_599_3.prefab_name ~= "" and arg_596_1.actors_[var_599_3.prefab_name] ~= nil then
						local var_599_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_3.prefab_name].transform, "story_v_out_120011", "120011146", "story_v_out_120011.awb")

						arg_596_1:RecordAudio("120011146", var_599_9)
						arg_596_1:RecordAudio("120011146", var_599_9)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_120011", "120011146", "story_v_out_120011.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_120011", "120011146", "story_v_out_120011.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_10 = math.max(var_599_1, arg_596_1.talkMaxDuration)

			if var_599_0 <= arg_596_1.time_ and arg_596_1.time_ < var_599_0 + var_599_10 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_0) / var_599_10

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_0 + var_599_10 and arg_596_1.time_ < var_599_0 + var_599_10 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play120011147 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 120011147
		arg_600_1.duration_ = 0.2

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"

			SetActive(arg_600_1.choicesGo_, true)

			for iter_601_0, iter_601_1 in ipairs(arg_600_1.choices_) do
				local var_601_0 = iter_601_0 <= 2

				SetActive(iter_601_1.go, var_601_0)
			end

			arg_600_1.choices_[1].txt.text = arg_600_1:FormatText(StoryChoiceCfg[364].name)
			arg_600_1.choices_[2].txt.text = arg_600_1:FormatText(StoryChoiceCfg[365].name)
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play120011148(arg_600_1)
			end

			if arg_602_0 == 2 then
				arg_600_0:Play120011148(arg_600_1)
			end

			arg_600_1:RecordChoiceLog(120011147, 364, 365)
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["1069ui_story"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1069ui_story == nil then
				arg_600_1.var_.characterEffect1069ui_story = var_603_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_2 = 0.2

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.characterEffect1069ui_story and not isNil(var_603_0) then
					local var_603_4 = Mathf.Lerp(0, 0.5, var_603_3)

					arg_600_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1069ui_story.fillRatio = var_603_4
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.characterEffect1069ui_story then
				local var_603_5 = 0.5

				arg_600_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1069ui_story.fillRatio = var_603_5
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play120011148 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 120011148
		arg_604_1.duration_ = 4.43

		local var_604_0 = {
			zh = 3.766,
			ja = 4.433
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play120011149(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1069ui_story"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1069ui_story == nil then
				arg_604_1.var_.characterEffect1069ui_story = var_607_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_2 = 0.2

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.characterEffect1069ui_story and not isNil(var_607_0) then
					arg_604_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1069ui_story then
				arg_604_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_607_4 = "1069ui_story"

			if arg_604_1.actors_[var_607_4] == nil then
				local var_607_5 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_607_5) then
					local var_607_6 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_604_1.stage_.transform)

					var_607_6.name = var_607_4
					var_607_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_604_1.actors_[var_607_4] = var_607_6

					local var_607_7 = var_607_6:GetComponentInChildren(typeof(CharacterEffect))

					var_607_7.enabled = true

					local var_607_8 = GameObjectTools.GetOrAddComponent(var_607_6, typeof(DynamicBoneHelper))

					if var_607_8 then
						var_607_8:EnableDynamicBone(false)
					end

					arg_604_1:ShowWeapon(var_607_7.transform, false)

					arg_604_1.var_[var_607_4 .. "Animator"] = var_607_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_604_1.var_[var_607_4 .. "Animator"].applyRootMotion = true
					arg_604_1.var_[var_607_4 .. "LipSync"] = var_607_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_607_9 = 0

			if var_607_9 < arg_604_1.time_ and arg_604_1.time_ <= var_607_9 + arg_607_0 then
				arg_604_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_607_10 = 0
			local var_607_11 = 0.4

			if var_607_10 < arg_604_1.time_ and arg_604_1.time_ <= var_607_10 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_12 = arg_604_1:FormatText(StoryNameCfg[378].name)

				arg_604_1.leftNameTxt_.text = var_607_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_13 = arg_604_1:GetWordFromCfg(120011148)
				local var_607_14 = arg_604_1:FormatText(var_607_13.content)

				arg_604_1.text_.text = var_607_14

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_15 = 16
				local var_607_16 = utf8.len(var_607_14)
				local var_607_17 = var_607_15 <= 0 and var_607_11 or var_607_11 * (var_607_16 / var_607_15)

				if var_607_17 > 0 and var_607_11 < var_607_17 then
					arg_604_1.talkMaxDuration = var_607_17

					if var_607_17 + var_607_10 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_17 + var_607_10
					end
				end

				arg_604_1.text_.text = var_607_14
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011148", "story_v_out_120011.awb") ~= 0 then
					local var_607_18 = manager.audio:GetVoiceLength("story_v_out_120011", "120011148", "story_v_out_120011.awb") / 1000

					if var_607_18 + var_607_10 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_18 + var_607_10
					end

					if var_607_13.prefab_name ~= "" and arg_604_1.actors_[var_607_13.prefab_name] ~= nil then
						local var_607_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_13.prefab_name].transform, "story_v_out_120011", "120011148", "story_v_out_120011.awb")

						arg_604_1:RecordAudio("120011148", var_607_19)
						arg_604_1:RecordAudio("120011148", var_607_19)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_120011", "120011148", "story_v_out_120011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_120011", "120011148", "story_v_out_120011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_20 = math.max(var_607_11, arg_604_1.talkMaxDuration)

			if var_607_10 <= arg_604_1.time_ and arg_604_1.time_ < var_607_10 + var_607_20 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_10) / var_607_20

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_10 + var_607_20 and arg_604_1.time_ < var_607_10 + var_607_20 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play120011149 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 120011149
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play120011150(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1069ui_story"].transform
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				arg_608_1.var_.moveOldPos1069ui_story = var_611_0.localPosition
			end

			local var_611_2 = 0.001

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2
				local var_611_4 = Vector3.New(0, 100, 0)

				var_611_0.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1069ui_story, var_611_4, var_611_3)

				local var_611_5 = manager.ui.mainCamera.transform.position - var_611_0.position

				var_611_0.forward = Vector3.New(var_611_5.x, var_611_5.y, var_611_5.z)

				local var_611_6 = var_611_0.localEulerAngles

				var_611_6.z = 0
				var_611_6.x = 0
				var_611_0.localEulerAngles = var_611_6
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 then
				var_611_0.localPosition = Vector3.New(0, 100, 0)

				local var_611_7 = manager.ui.mainCamera.transform.position - var_611_0.position

				var_611_0.forward = Vector3.New(var_611_7.x, var_611_7.y, var_611_7.z)

				local var_611_8 = var_611_0.localEulerAngles

				var_611_8.z = 0
				var_611_8.x = 0
				var_611_0.localEulerAngles = var_611_8
			end

			local var_611_9 = 0
			local var_611_10 = 1.05

			if var_611_9 < arg_608_1.time_ and arg_608_1.time_ <= var_611_9 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_11 = arg_608_1:GetWordFromCfg(120011149)
				local var_611_12 = arg_608_1:FormatText(var_611_11.content)

				arg_608_1.text_.text = var_611_12

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_13 = 42
				local var_611_14 = utf8.len(var_611_12)
				local var_611_15 = var_611_13 <= 0 and var_611_10 or var_611_10 * (var_611_14 / var_611_13)

				if var_611_15 > 0 and var_611_10 < var_611_15 then
					arg_608_1.talkMaxDuration = var_611_15

					if var_611_15 + var_611_9 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_15 + var_611_9
					end
				end

				arg_608_1.text_.text = var_611_12
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_16 = math.max(var_611_10, arg_608_1.talkMaxDuration)

			if var_611_9 <= arg_608_1.time_ and arg_608_1.time_ < var_611_9 + var_611_16 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_9) / var_611_16

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_9 + var_611_16 and arg_608_1.time_ < var_611_9 + var_611_16 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play120011150 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 120011150
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play120011151(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.725

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, false)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_2 = arg_612_1:GetWordFromCfg(120011150)
				local var_615_3 = arg_612_1:FormatText(var_615_2.content)

				arg_612_1.text_.text = var_615_3

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_4 = 29
				local var_615_5 = utf8.len(var_615_3)
				local var_615_6 = var_615_4 <= 0 and var_615_1 or var_615_1 * (var_615_5 / var_615_4)

				if var_615_6 > 0 and var_615_1 < var_615_6 then
					arg_612_1.talkMaxDuration = var_615_6

					if var_615_6 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_6 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_3
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_7 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_7 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_7

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_7 and arg_612_1.time_ < var_615_0 + var_615_7 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play120011151 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 120011151
		arg_616_1.duration_ = 10.4

		local var_616_0 = {
			zh = 6.1,
			ja = 10.4
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play120011152(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = arg_616_1.actors_["1084ui_story"].transform
			local var_619_1 = 0

			if var_619_1 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 then
				arg_616_1.var_.moveOldPos1084ui_story = var_619_0.localPosition
			end

			local var_619_2 = 0.001

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_2 then
				local var_619_3 = (arg_616_1.time_ - var_619_1) / var_619_2
				local var_619_4 = Vector3.New(-0.7, -0.97, -6)

				var_619_0.localPosition = Vector3.Lerp(arg_616_1.var_.moveOldPos1084ui_story, var_619_4, var_619_3)

				local var_619_5 = manager.ui.mainCamera.transform.position - var_619_0.position

				var_619_0.forward = Vector3.New(var_619_5.x, var_619_5.y, var_619_5.z)

				local var_619_6 = var_619_0.localEulerAngles

				var_619_6.z = 0
				var_619_6.x = 0
				var_619_0.localEulerAngles = var_619_6
			end

			if arg_616_1.time_ >= var_619_1 + var_619_2 and arg_616_1.time_ < var_619_1 + var_619_2 + arg_619_0 then
				var_619_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_619_7 = manager.ui.mainCamera.transform.position - var_619_0.position

				var_619_0.forward = Vector3.New(var_619_7.x, var_619_7.y, var_619_7.z)

				local var_619_8 = var_619_0.localEulerAngles

				var_619_8.z = 0
				var_619_8.x = 0
				var_619_0.localEulerAngles = var_619_8
			end

			local var_619_9 = arg_616_1.actors_["1069ui_story"].transform
			local var_619_10 = 0

			if var_619_10 < arg_616_1.time_ and arg_616_1.time_ <= var_619_10 + arg_619_0 then
				arg_616_1.var_.moveOldPos1069ui_story = var_619_9.localPosition
			end

			local var_619_11 = 0.001

			if var_619_10 <= arg_616_1.time_ and arg_616_1.time_ < var_619_10 + var_619_11 then
				local var_619_12 = (arg_616_1.time_ - var_619_10) / var_619_11
				local var_619_13 = Vector3.New(0.7, -1, -6)

				var_619_9.localPosition = Vector3.Lerp(arg_616_1.var_.moveOldPos1069ui_story, var_619_13, var_619_12)

				local var_619_14 = manager.ui.mainCamera.transform.position - var_619_9.position

				var_619_9.forward = Vector3.New(var_619_14.x, var_619_14.y, var_619_14.z)

				local var_619_15 = var_619_9.localEulerAngles

				var_619_15.z = 0
				var_619_15.x = 0
				var_619_9.localEulerAngles = var_619_15
			end

			if arg_616_1.time_ >= var_619_10 + var_619_11 and arg_616_1.time_ < var_619_10 + var_619_11 + arg_619_0 then
				var_619_9.localPosition = Vector3.New(0.7, -1, -6)

				local var_619_16 = manager.ui.mainCamera.transform.position - var_619_9.position

				var_619_9.forward = Vector3.New(var_619_16.x, var_619_16.y, var_619_16.z)

				local var_619_17 = var_619_9.localEulerAngles

				var_619_17.z = 0
				var_619_17.x = 0
				var_619_9.localEulerAngles = var_619_17
			end

			local var_619_18 = arg_616_1.actors_["1084ui_story"]
			local var_619_19 = 0

			if var_619_19 < arg_616_1.time_ and arg_616_1.time_ <= var_619_19 + arg_619_0 and not isNil(var_619_18) and arg_616_1.var_.characterEffect1084ui_story == nil then
				arg_616_1.var_.characterEffect1084ui_story = var_619_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_20 = 0.2

			if var_619_19 <= arg_616_1.time_ and arg_616_1.time_ < var_619_19 + var_619_20 and not isNil(var_619_18) then
				local var_619_21 = (arg_616_1.time_ - var_619_19) / var_619_20

				if arg_616_1.var_.characterEffect1084ui_story and not isNil(var_619_18) then
					arg_616_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_616_1.time_ >= var_619_19 + var_619_20 and arg_616_1.time_ < var_619_19 + var_619_20 + arg_619_0 and not isNil(var_619_18) and arg_616_1.var_.characterEffect1084ui_story then
				arg_616_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_619_22 = arg_616_1.actors_["1069ui_story"]
			local var_619_23 = 0

			if var_619_23 < arg_616_1.time_ and arg_616_1.time_ <= var_619_23 + arg_619_0 and not isNil(var_619_22) and arg_616_1.var_.characterEffect1069ui_story == nil then
				arg_616_1.var_.characterEffect1069ui_story = var_619_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_24 = 0.034

			if var_619_23 <= arg_616_1.time_ and arg_616_1.time_ < var_619_23 + var_619_24 and not isNil(var_619_22) then
				local var_619_25 = (arg_616_1.time_ - var_619_23) / var_619_24

				if arg_616_1.var_.characterEffect1069ui_story and not isNil(var_619_22) then
					local var_619_26 = Mathf.Lerp(0, 0.5, var_619_25)

					arg_616_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1069ui_story.fillRatio = var_619_26
				end
			end

			if arg_616_1.time_ >= var_619_23 + var_619_24 and arg_616_1.time_ < var_619_23 + var_619_24 + arg_619_0 and not isNil(var_619_22) and arg_616_1.var_.characterEffect1069ui_story then
				local var_619_27 = 0.5

				arg_616_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1069ui_story.fillRatio = var_619_27
			end

			local var_619_28 = 0

			if var_619_28 < arg_616_1.time_ and arg_616_1.time_ <= var_619_28 + arg_619_0 then
				arg_616_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_619_29 = 0

			if var_619_29 < arg_616_1.time_ and arg_616_1.time_ <= var_619_29 + arg_619_0 then
				arg_616_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_619_30 = 0

			if var_619_30 < arg_616_1.time_ and arg_616_1.time_ <= var_619_30 + arg_619_0 then
				arg_616_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_619_31 = 0
			local var_619_32 = 0.55

			if var_619_31 < arg_616_1.time_ and arg_616_1.time_ <= var_619_31 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_33 = arg_616_1:FormatText(StoryNameCfg[6].name)

				arg_616_1.leftNameTxt_.text = var_619_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_34 = arg_616_1:GetWordFromCfg(120011151)
				local var_619_35 = arg_616_1:FormatText(var_619_34.content)

				arg_616_1.text_.text = var_619_35

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_36 = 22
				local var_619_37 = utf8.len(var_619_35)
				local var_619_38 = var_619_36 <= 0 and var_619_32 or var_619_32 * (var_619_37 / var_619_36)

				if var_619_38 > 0 and var_619_32 < var_619_38 then
					arg_616_1.talkMaxDuration = var_619_38

					if var_619_38 + var_619_31 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_38 + var_619_31
					end
				end

				arg_616_1.text_.text = var_619_35
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011151", "story_v_out_120011.awb") ~= 0 then
					local var_619_39 = manager.audio:GetVoiceLength("story_v_out_120011", "120011151", "story_v_out_120011.awb") / 1000

					if var_619_39 + var_619_31 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_39 + var_619_31
					end

					if var_619_34.prefab_name ~= "" and arg_616_1.actors_[var_619_34.prefab_name] ~= nil then
						local var_619_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_34.prefab_name].transform, "story_v_out_120011", "120011151", "story_v_out_120011.awb")

						arg_616_1:RecordAudio("120011151", var_619_40)
						arg_616_1:RecordAudio("120011151", var_619_40)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_120011", "120011151", "story_v_out_120011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_120011", "120011151", "story_v_out_120011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_41 = math.max(var_619_32, arg_616_1.talkMaxDuration)

			if var_619_31 <= arg_616_1.time_ and arg_616_1.time_ < var_619_31 + var_619_41 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_31) / var_619_41

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_31 + var_619_41 and arg_616_1.time_ < var_619_31 + var_619_41 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_616_1:InitPlayNodeList()
	end,
	Play120011152 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 120011152
		arg_620_1.duration_ = 3.8

		local var_620_0 = {
			zh = 2,
			ja = 3.8
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play120011153(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = arg_620_1.actors_["1084ui_story"]
			local var_623_1 = 0

			if var_623_1 < arg_620_1.time_ and arg_620_1.time_ <= var_623_1 + arg_623_0 and not isNil(var_623_0) and arg_620_1.var_.characterEffect1084ui_story == nil then
				arg_620_1.var_.characterEffect1084ui_story = var_623_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_2 = 0.2

			if var_623_1 <= arg_620_1.time_ and arg_620_1.time_ < var_623_1 + var_623_2 and not isNil(var_623_0) then
				local var_623_3 = (arg_620_1.time_ - var_623_1) / var_623_2

				if arg_620_1.var_.characterEffect1084ui_story and not isNil(var_623_0) then
					local var_623_4 = Mathf.Lerp(0, 0.5, var_623_3)

					arg_620_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_620_1.var_.characterEffect1084ui_story.fillRatio = var_623_4
				end
			end

			if arg_620_1.time_ >= var_623_1 + var_623_2 and arg_620_1.time_ < var_623_1 + var_623_2 + arg_623_0 and not isNil(var_623_0) and arg_620_1.var_.characterEffect1084ui_story then
				local var_623_5 = 0.5

				arg_620_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_620_1.var_.characterEffect1084ui_story.fillRatio = var_623_5
			end

			local var_623_6 = arg_620_1.actors_["1069ui_story"]
			local var_623_7 = 0

			if var_623_7 < arg_620_1.time_ and arg_620_1.time_ <= var_623_7 + arg_623_0 and not isNil(var_623_6) and arg_620_1.var_.characterEffect1069ui_story == nil then
				arg_620_1.var_.characterEffect1069ui_story = var_623_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_8 = 0.2

			if var_623_7 <= arg_620_1.time_ and arg_620_1.time_ < var_623_7 + var_623_8 and not isNil(var_623_6) then
				local var_623_9 = (arg_620_1.time_ - var_623_7) / var_623_8

				if arg_620_1.var_.characterEffect1069ui_story and not isNil(var_623_6) then
					arg_620_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_620_1.time_ >= var_623_7 + var_623_8 and arg_620_1.time_ < var_623_7 + var_623_8 + arg_623_0 and not isNil(var_623_6) and arg_620_1.var_.characterEffect1069ui_story then
				arg_620_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_623_10 = 0

			if var_623_10 < arg_620_1.time_ and arg_620_1.time_ <= var_623_10 + arg_623_0 then
				arg_620_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_623_11 = 0
			local var_623_12 = 0.275

			if var_623_11 < arg_620_1.time_ and arg_620_1.time_ <= var_623_11 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_13 = arg_620_1:FormatText(StoryNameCfg[378].name)

				arg_620_1.leftNameTxt_.text = var_623_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_14 = arg_620_1:GetWordFromCfg(120011152)
				local var_623_15 = arg_620_1:FormatText(var_623_14.content)

				arg_620_1.text_.text = var_623_15

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_16 = 11
				local var_623_17 = utf8.len(var_623_15)
				local var_623_18 = var_623_16 <= 0 and var_623_12 or var_623_12 * (var_623_17 / var_623_16)

				if var_623_18 > 0 and var_623_12 < var_623_18 then
					arg_620_1.talkMaxDuration = var_623_18

					if var_623_18 + var_623_11 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_18 + var_623_11
					end
				end

				arg_620_1.text_.text = var_623_15
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011152", "story_v_out_120011.awb") ~= 0 then
					local var_623_19 = manager.audio:GetVoiceLength("story_v_out_120011", "120011152", "story_v_out_120011.awb") / 1000

					if var_623_19 + var_623_11 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_19 + var_623_11
					end

					if var_623_14.prefab_name ~= "" and arg_620_1.actors_[var_623_14.prefab_name] ~= nil then
						local var_623_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_14.prefab_name].transform, "story_v_out_120011", "120011152", "story_v_out_120011.awb")

						arg_620_1:RecordAudio("120011152", var_623_20)
						arg_620_1:RecordAudio("120011152", var_623_20)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_120011", "120011152", "story_v_out_120011.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_120011", "120011152", "story_v_out_120011.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_21 = math.max(var_623_12, arg_620_1.talkMaxDuration)

			if var_623_11 <= arg_620_1.time_ and arg_620_1.time_ < var_623_11 + var_623_21 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_11) / var_623_21

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_11 + var_623_21 and arg_620_1.time_ < var_623_11 + var_623_21 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play120011153 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 120011153
		arg_624_1.duration_ = 7.4

		local var_624_0 = {
			zh = 7.4,
			ja = 4
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play120011154(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_627_1 = 0

			if var_627_1 < arg_624_1.time_ and arg_624_1.time_ <= var_627_1 + arg_627_0 then
				arg_624_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			local var_627_2 = 0

			if var_627_2 < arg_624_1.time_ and arg_624_1.time_ <= var_627_2 + arg_627_0 then
				arg_624_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_627_3 = 0
			local var_627_4 = 0.95

			if var_627_3 < arg_624_1.time_ and arg_624_1.time_ <= var_627_3 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_5 = arg_624_1:FormatText(StoryNameCfg[378].name)

				arg_624_1.leftNameTxt_.text = var_627_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_6 = arg_624_1:GetWordFromCfg(120011153)
				local var_627_7 = arg_624_1:FormatText(var_627_6.content)

				arg_624_1.text_.text = var_627_7

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_8 = 38
				local var_627_9 = utf8.len(var_627_7)
				local var_627_10 = var_627_8 <= 0 and var_627_4 or var_627_4 * (var_627_9 / var_627_8)

				if var_627_10 > 0 and var_627_4 < var_627_10 then
					arg_624_1.talkMaxDuration = var_627_10

					if var_627_10 + var_627_3 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_10 + var_627_3
					end
				end

				arg_624_1.text_.text = var_627_7
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011153", "story_v_out_120011.awb") ~= 0 then
					local var_627_11 = manager.audio:GetVoiceLength("story_v_out_120011", "120011153", "story_v_out_120011.awb") / 1000

					if var_627_11 + var_627_3 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_11 + var_627_3
					end

					if var_627_6.prefab_name ~= "" and arg_624_1.actors_[var_627_6.prefab_name] ~= nil then
						local var_627_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_6.prefab_name].transform, "story_v_out_120011", "120011153", "story_v_out_120011.awb")

						arg_624_1:RecordAudio("120011153", var_627_12)
						arg_624_1:RecordAudio("120011153", var_627_12)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_120011", "120011153", "story_v_out_120011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_120011", "120011153", "story_v_out_120011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_13 = math.max(var_627_4, arg_624_1.talkMaxDuration)

			if var_627_3 <= arg_624_1.time_ and arg_624_1.time_ < var_627_3 + var_627_13 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_3) / var_627_13

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_3 + var_627_13 and arg_624_1.time_ < var_627_3 + var_627_13 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play120011154 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 120011154
		arg_628_1.duration_ = 5.03

		local var_628_0 = {
			zh = 4.333,
			ja = 5.033
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play120011155(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0
			local var_631_1 = 0.4

			if var_631_0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_0 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_2 = arg_628_1:FormatText(StoryNameCfg[378].name)

				arg_628_1.leftNameTxt_.text = var_631_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_3 = arg_628_1:GetWordFromCfg(120011154)
				local var_631_4 = arg_628_1:FormatText(var_631_3.content)

				arg_628_1.text_.text = var_631_4

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_5 = 16
				local var_631_6 = utf8.len(var_631_4)
				local var_631_7 = var_631_5 <= 0 and var_631_1 or var_631_1 * (var_631_6 / var_631_5)

				if var_631_7 > 0 and var_631_1 < var_631_7 then
					arg_628_1.talkMaxDuration = var_631_7

					if var_631_7 + var_631_0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_7 + var_631_0
					end
				end

				arg_628_1.text_.text = var_631_4
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011154", "story_v_out_120011.awb") ~= 0 then
					local var_631_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011154", "story_v_out_120011.awb") / 1000

					if var_631_8 + var_631_0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_8 + var_631_0
					end

					if var_631_3.prefab_name ~= "" and arg_628_1.actors_[var_631_3.prefab_name] ~= nil then
						local var_631_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_3.prefab_name].transform, "story_v_out_120011", "120011154", "story_v_out_120011.awb")

						arg_628_1:RecordAudio("120011154", var_631_9)
						arg_628_1:RecordAudio("120011154", var_631_9)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_out_120011", "120011154", "story_v_out_120011.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_out_120011", "120011154", "story_v_out_120011.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_10 = math.max(var_631_1, arg_628_1.talkMaxDuration)

			if var_631_0 <= arg_628_1.time_ and arg_628_1.time_ < var_631_0 + var_631_10 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_0) / var_631_10

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_0 + var_631_10 and arg_628_1.time_ < var_631_0 + var_631_10 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play120011155 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 120011155
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play120011156(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = arg_632_1.actors_["1069ui_story"]
			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 and not isNil(var_635_0) and arg_632_1.var_.characterEffect1069ui_story == nil then
				arg_632_1.var_.characterEffect1069ui_story = var_635_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_2 = 0.2

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_2 and not isNil(var_635_0) then
				local var_635_3 = (arg_632_1.time_ - var_635_1) / var_635_2

				if arg_632_1.var_.characterEffect1069ui_story and not isNil(var_635_0) then
					local var_635_4 = Mathf.Lerp(0, 0.5, var_635_3)

					arg_632_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1069ui_story.fillRatio = var_635_4
				end
			end

			if arg_632_1.time_ >= var_635_1 + var_635_2 and arg_632_1.time_ < var_635_1 + var_635_2 + arg_635_0 and not isNil(var_635_0) and arg_632_1.var_.characterEffect1069ui_story then
				local var_635_5 = 0.5

				arg_632_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1069ui_story.fillRatio = var_635_5
			end

			local var_635_6 = 0
			local var_635_7 = 0.925

			if var_635_6 < arg_632_1.time_ and arg_632_1.time_ <= var_635_6 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_8 = arg_632_1:FormatText(StoryNameCfg[7].name)

				arg_632_1.leftNameTxt_.text = var_635_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_9 = arg_632_1:GetWordFromCfg(120011155)
				local var_635_10 = arg_632_1:FormatText(var_635_9.content)

				arg_632_1.text_.text = var_635_10

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_11 = 37
				local var_635_12 = utf8.len(var_635_10)
				local var_635_13 = var_635_11 <= 0 and var_635_7 or var_635_7 * (var_635_12 / var_635_11)

				if var_635_13 > 0 and var_635_7 < var_635_13 then
					arg_632_1.talkMaxDuration = var_635_13

					if var_635_13 + var_635_6 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_13 + var_635_6
					end
				end

				arg_632_1.text_.text = var_635_10
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_14 = math.max(var_635_7, arg_632_1.talkMaxDuration)

			if var_635_6 <= arg_632_1.time_ and arg_632_1.time_ < var_635_6 + var_635_14 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_6) / var_635_14

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_6 + var_635_14 and arg_632_1.time_ < var_635_6 + var_635_14 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play120011156 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 120011156
		arg_636_1.duration_ = 1.47

		local var_636_0 = {
			zh = 1.466,
			ja = 0.999999999999
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play120011157(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = arg_636_1.actors_["1069ui_story"]
			local var_639_1 = 0

			if var_639_1 < arg_636_1.time_ and arg_636_1.time_ <= var_639_1 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect1069ui_story == nil then
				arg_636_1.var_.characterEffect1069ui_story = var_639_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_2 = 0.2

			if var_639_1 <= arg_636_1.time_ and arg_636_1.time_ < var_639_1 + var_639_2 and not isNil(var_639_0) then
				local var_639_3 = (arg_636_1.time_ - var_639_1) / var_639_2

				if arg_636_1.var_.characterEffect1069ui_story and not isNil(var_639_0) then
					arg_636_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= var_639_1 + var_639_2 and arg_636_1.time_ < var_639_1 + var_639_2 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect1069ui_story then
				arg_636_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_639_4 = 0
			local var_639_5 = 0.125

			if var_639_4 < arg_636_1.time_ and arg_636_1.time_ <= var_639_4 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_6 = arg_636_1:FormatText(StoryNameCfg[378].name)

				arg_636_1.leftNameTxt_.text = var_639_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_7 = arg_636_1:GetWordFromCfg(120011156)
				local var_639_8 = arg_636_1:FormatText(var_639_7.content)

				arg_636_1.text_.text = var_639_8

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_9 = 5
				local var_639_10 = utf8.len(var_639_8)
				local var_639_11 = var_639_9 <= 0 and var_639_5 or var_639_5 * (var_639_10 / var_639_9)

				if var_639_11 > 0 and var_639_5 < var_639_11 then
					arg_636_1.talkMaxDuration = var_639_11

					if var_639_11 + var_639_4 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_11 + var_639_4
					end
				end

				arg_636_1.text_.text = var_639_8
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011156", "story_v_out_120011.awb") ~= 0 then
					local var_639_12 = manager.audio:GetVoiceLength("story_v_out_120011", "120011156", "story_v_out_120011.awb") / 1000

					if var_639_12 + var_639_4 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_12 + var_639_4
					end

					if var_639_7.prefab_name ~= "" and arg_636_1.actors_[var_639_7.prefab_name] ~= nil then
						local var_639_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_7.prefab_name].transform, "story_v_out_120011", "120011156", "story_v_out_120011.awb")

						arg_636_1:RecordAudio("120011156", var_639_13)
						arg_636_1:RecordAudio("120011156", var_639_13)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_out_120011", "120011156", "story_v_out_120011.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_out_120011", "120011156", "story_v_out_120011.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_14 = math.max(var_639_5, arg_636_1.talkMaxDuration)

			if var_639_4 <= arg_636_1.time_ and arg_636_1.time_ < var_639_4 + var_639_14 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_4) / var_639_14

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_4 + var_639_14 and arg_636_1.time_ < var_639_4 + var_639_14 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play120011157 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 120011157
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play120011158(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = arg_640_1.actors_["1084ui_story"].transform
			local var_643_1 = 0

			if var_643_1 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 then
				arg_640_1.var_.moveOldPos1084ui_story = var_643_0.localPosition
			end

			local var_643_2 = 0.001

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_2 then
				local var_643_3 = (arg_640_1.time_ - var_643_1) / var_643_2
				local var_643_4 = Vector3.New(0, 100, 0)

				var_643_0.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1084ui_story, var_643_4, var_643_3)

				local var_643_5 = manager.ui.mainCamera.transform.position - var_643_0.position

				var_643_0.forward = Vector3.New(var_643_5.x, var_643_5.y, var_643_5.z)

				local var_643_6 = var_643_0.localEulerAngles

				var_643_6.z = 0
				var_643_6.x = 0
				var_643_0.localEulerAngles = var_643_6
			end

			if arg_640_1.time_ >= var_643_1 + var_643_2 and arg_640_1.time_ < var_643_1 + var_643_2 + arg_643_0 then
				var_643_0.localPosition = Vector3.New(0, 100, 0)

				local var_643_7 = manager.ui.mainCamera.transform.position - var_643_0.position

				var_643_0.forward = Vector3.New(var_643_7.x, var_643_7.y, var_643_7.z)

				local var_643_8 = var_643_0.localEulerAngles

				var_643_8.z = 0
				var_643_8.x = 0
				var_643_0.localEulerAngles = var_643_8
			end

			local var_643_9 = arg_640_1.actors_["1069ui_story"].transform
			local var_643_10 = 0

			if var_643_10 < arg_640_1.time_ and arg_640_1.time_ <= var_643_10 + arg_643_0 then
				arg_640_1.var_.moveOldPos1069ui_story = var_643_9.localPosition
			end

			local var_643_11 = 0.001

			if var_643_10 <= arg_640_1.time_ and arg_640_1.time_ < var_643_10 + var_643_11 then
				local var_643_12 = (arg_640_1.time_ - var_643_10) / var_643_11
				local var_643_13 = Vector3.New(0, 100, 0)

				var_643_9.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1069ui_story, var_643_13, var_643_12)

				local var_643_14 = manager.ui.mainCamera.transform.position - var_643_9.position

				var_643_9.forward = Vector3.New(var_643_14.x, var_643_14.y, var_643_14.z)

				local var_643_15 = var_643_9.localEulerAngles

				var_643_15.z = 0
				var_643_15.x = 0
				var_643_9.localEulerAngles = var_643_15
			end

			if arg_640_1.time_ >= var_643_10 + var_643_11 and arg_640_1.time_ < var_643_10 + var_643_11 + arg_643_0 then
				var_643_9.localPosition = Vector3.New(0, 100, 0)

				local var_643_16 = manager.ui.mainCamera.transform.position - var_643_9.position

				var_643_9.forward = Vector3.New(var_643_16.x, var_643_16.y, var_643_16.z)

				local var_643_17 = var_643_9.localEulerAngles

				var_643_17.z = 0
				var_643_17.x = 0
				var_643_9.localEulerAngles = var_643_17
			end

			local var_643_18 = 0
			local var_643_19 = 0.9

			if var_643_18 < arg_640_1.time_ and arg_640_1.time_ <= var_643_18 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, false)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_20 = arg_640_1:GetWordFromCfg(120011157)
				local var_643_21 = arg_640_1:FormatText(var_643_20.content)

				arg_640_1.text_.text = var_643_21

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_22 = 36
				local var_643_23 = utf8.len(var_643_21)
				local var_643_24 = var_643_22 <= 0 and var_643_19 or var_643_19 * (var_643_23 / var_643_22)

				if var_643_24 > 0 and var_643_19 < var_643_24 then
					arg_640_1.talkMaxDuration = var_643_24

					if var_643_24 + var_643_18 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_24 + var_643_18
					end
				end

				arg_640_1.text_.text = var_643_21
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_25 = math.max(var_643_19, arg_640_1.talkMaxDuration)

			if var_643_18 <= arg_640_1.time_ and arg_640_1.time_ < var_643_18 + var_643_25 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_18) / var_643_25

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_18 + var_643_25 and arg_640_1.time_ < var_643_18 + var_643_25 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play120011158 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 120011158
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play120011159(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0
			local var_647_1 = 0.15

			if var_647_0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_2 = arg_644_1:FormatText(StoryNameCfg[7].name)

				arg_644_1.leftNameTxt_.text = var_647_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, true)
				arg_644_1.iconController_:SetSelectedState("hero")

				arg_644_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_644_1.callingController_:SetSelectedState("normal")

				arg_644_1.keyicon_.color = Color.New(1, 1, 1)
				arg_644_1.icon_.color = Color.New(1, 1, 1)

				local var_647_3 = arg_644_1:GetWordFromCfg(120011158)
				local var_647_4 = arg_644_1:FormatText(var_647_3.content)

				arg_644_1.text_.text = var_647_4

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_5 = 6
				local var_647_6 = utf8.len(var_647_4)
				local var_647_7 = var_647_5 <= 0 and var_647_1 or var_647_1 * (var_647_6 / var_647_5)

				if var_647_7 > 0 and var_647_1 < var_647_7 then
					arg_644_1.talkMaxDuration = var_647_7

					if var_647_7 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_7 + var_647_0
					end
				end

				arg_644_1.text_.text = var_647_4
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_8 = math.max(var_647_1, arg_644_1.talkMaxDuration)

			if var_647_0 <= arg_644_1.time_ and arg_644_1.time_ < var_647_0 + var_647_8 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_0) / var_647_8

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_0 + var_647_8 and arg_644_1.time_ < var_647_0 + var_647_8 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play120011159 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 120011159
		arg_648_1.duration_ = 2.87

		local var_648_0 = {
			zh = 2.8,
			ja = 2.866
		}
		local var_648_1 = manager.audio:GetLocalizationFlag()

		if var_648_0[var_648_1] ~= nil then
			arg_648_1.duration_ = var_648_0[var_648_1]
		end

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play120011160(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = arg_648_1.actors_["1069ui_story"].transform
			local var_651_1 = 0

			if var_651_1 < arg_648_1.time_ and arg_648_1.time_ <= var_651_1 + arg_651_0 then
				arg_648_1.var_.moveOldPos1069ui_story = var_651_0.localPosition
			end

			local var_651_2 = 0.001

			if var_651_1 <= arg_648_1.time_ and arg_648_1.time_ < var_651_1 + var_651_2 then
				local var_651_3 = (arg_648_1.time_ - var_651_1) / var_651_2
				local var_651_4 = Vector3.New(0, -1, -6)

				var_651_0.localPosition = Vector3.Lerp(arg_648_1.var_.moveOldPos1069ui_story, var_651_4, var_651_3)

				local var_651_5 = manager.ui.mainCamera.transform.position - var_651_0.position

				var_651_0.forward = Vector3.New(var_651_5.x, var_651_5.y, var_651_5.z)

				local var_651_6 = var_651_0.localEulerAngles

				var_651_6.z = 0
				var_651_6.x = 0
				var_651_0.localEulerAngles = var_651_6
			end

			if arg_648_1.time_ >= var_651_1 + var_651_2 and arg_648_1.time_ < var_651_1 + var_651_2 + arg_651_0 then
				var_651_0.localPosition = Vector3.New(0, -1, -6)

				local var_651_7 = manager.ui.mainCamera.transform.position - var_651_0.position

				var_651_0.forward = Vector3.New(var_651_7.x, var_651_7.y, var_651_7.z)

				local var_651_8 = var_651_0.localEulerAngles

				var_651_8.z = 0
				var_651_8.x = 0
				var_651_0.localEulerAngles = var_651_8
			end

			local var_651_9 = arg_648_1.actors_["1069ui_story"]
			local var_651_10 = 0

			if var_651_10 < arg_648_1.time_ and arg_648_1.time_ <= var_651_10 + arg_651_0 and not isNil(var_651_9) and arg_648_1.var_.characterEffect1069ui_story == nil then
				arg_648_1.var_.characterEffect1069ui_story = var_651_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_651_11 = 0.2

			if var_651_10 <= arg_648_1.time_ and arg_648_1.time_ < var_651_10 + var_651_11 and not isNil(var_651_9) then
				local var_651_12 = (arg_648_1.time_ - var_651_10) / var_651_11

				if arg_648_1.var_.characterEffect1069ui_story and not isNil(var_651_9) then
					arg_648_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_648_1.time_ >= var_651_10 + var_651_11 and arg_648_1.time_ < var_651_10 + var_651_11 + arg_651_0 and not isNil(var_651_9) and arg_648_1.var_.characterEffect1069ui_story then
				arg_648_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_651_13 = 0

			if var_651_13 < arg_648_1.time_ and arg_648_1.time_ <= var_651_13 + arg_651_0 then
				arg_648_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_651_14 = 0

			if var_651_14 < arg_648_1.time_ and arg_648_1.time_ <= var_651_14 + arg_651_0 then
				arg_648_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_651_15 = 0
			local var_651_16 = 0.225

			if var_651_15 < arg_648_1.time_ and arg_648_1.time_ <= var_651_15 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_17 = arg_648_1:FormatText(StoryNameCfg[378].name)

				arg_648_1.leftNameTxt_.text = var_651_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_18 = arg_648_1:GetWordFromCfg(120011159)
				local var_651_19 = arg_648_1:FormatText(var_651_18.content)

				arg_648_1.text_.text = var_651_19

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_20 = 9
				local var_651_21 = utf8.len(var_651_19)
				local var_651_22 = var_651_20 <= 0 and var_651_16 or var_651_16 * (var_651_21 / var_651_20)

				if var_651_22 > 0 and var_651_16 < var_651_22 then
					arg_648_1.talkMaxDuration = var_651_22

					if var_651_22 + var_651_15 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_22 + var_651_15
					end
				end

				arg_648_1.text_.text = var_651_19
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011159", "story_v_out_120011.awb") ~= 0 then
					local var_651_23 = manager.audio:GetVoiceLength("story_v_out_120011", "120011159", "story_v_out_120011.awb") / 1000

					if var_651_23 + var_651_15 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_23 + var_651_15
					end

					if var_651_18.prefab_name ~= "" and arg_648_1.actors_[var_651_18.prefab_name] ~= nil then
						local var_651_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_18.prefab_name].transform, "story_v_out_120011", "120011159", "story_v_out_120011.awb")

						arg_648_1:RecordAudio("120011159", var_651_24)
						arg_648_1:RecordAudio("120011159", var_651_24)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_out_120011", "120011159", "story_v_out_120011.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_out_120011", "120011159", "story_v_out_120011.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_25 = math.max(var_651_16, arg_648_1.talkMaxDuration)

			if var_651_15 <= arg_648_1.time_ and arg_648_1.time_ < var_651_15 + var_651_25 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_15) / var_651_25

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_15 + var_651_25 and arg_648_1.time_ < var_651_15 + var_651_25 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_648_1:InitPlayNodeList()
	end,
	Play120011160 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 120011160
		arg_652_1.duration_ = 5.23

		local var_652_0 = {
			zh = 1.999999999999,
			ja = 5.233
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play120011161(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = "1072ui_story"

			if arg_652_1.actors_[var_655_0] == nil then
				local var_655_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_655_1) then
					local var_655_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_652_1.stage_.transform)

					var_655_2.name = var_655_0
					var_655_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_652_1.actors_[var_655_0] = var_655_2

					local var_655_3 = var_655_2:GetComponentInChildren(typeof(CharacterEffect))

					var_655_3.enabled = true

					local var_655_4 = GameObjectTools.GetOrAddComponent(var_655_2, typeof(DynamicBoneHelper))

					if var_655_4 then
						var_655_4:EnableDynamicBone(false)
					end

					arg_652_1:ShowWeapon(var_655_3.transform, false)

					arg_652_1.var_[var_655_0 .. "Animator"] = var_655_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_652_1.var_[var_655_0 .. "Animator"].applyRootMotion = true
					arg_652_1.var_[var_655_0 .. "LipSync"] = var_655_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_655_5 = arg_652_1.actors_["1072ui_story"].transform
			local var_655_6 = 0

			if var_655_6 < arg_652_1.time_ and arg_652_1.time_ <= var_655_6 + arg_655_0 then
				arg_652_1.var_.moveOldPos1072ui_story = var_655_5.localPosition

				local var_655_7 = "1072ui_story"

				arg_652_1:ShowWeapon(arg_652_1.var_[var_655_7 .. "Animator"].transform, false)
			end

			local var_655_8 = 0.001

			if var_655_6 <= arg_652_1.time_ and arg_652_1.time_ < var_655_6 + var_655_8 then
				local var_655_9 = (arg_652_1.time_ - var_655_6) / var_655_8
				local var_655_10 = Vector3.New(0, -0.71, -6)

				var_655_5.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPos1072ui_story, var_655_10, var_655_9)

				local var_655_11 = manager.ui.mainCamera.transform.position - var_655_5.position

				var_655_5.forward = Vector3.New(var_655_11.x, var_655_11.y, var_655_11.z)

				local var_655_12 = var_655_5.localEulerAngles

				var_655_12.z = 0
				var_655_12.x = 0
				var_655_5.localEulerAngles = var_655_12
			end

			if arg_652_1.time_ >= var_655_6 + var_655_8 and arg_652_1.time_ < var_655_6 + var_655_8 + arg_655_0 then
				var_655_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_655_13 = manager.ui.mainCamera.transform.position - var_655_5.position

				var_655_5.forward = Vector3.New(var_655_13.x, var_655_13.y, var_655_13.z)

				local var_655_14 = var_655_5.localEulerAngles

				var_655_14.z = 0
				var_655_14.x = 0
				var_655_5.localEulerAngles = var_655_14
			end

			local var_655_15 = arg_652_1.actors_["1072ui_story"]
			local var_655_16 = 0

			if var_655_16 < arg_652_1.time_ and arg_652_1.time_ <= var_655_16 + arg_655_0 and not isNil(var_655_15) and arg_652_1.var_.characterEffect1072ui_story == nil then
				arg_652_1.var_.characterEffect1072ui_story = var_655_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_17 = 0.2

			if var_655_16 <= arg_652_1.time_ and arg_652_1.time_ < var_655_16 + var_655_17 and not isNil(var_655_15) then
				local var_655_18 = (arg_652_1.time_ - var_655_16) / var_655_17

				if arg_652_1.var_.characterEffect1072ui_story and not isNil(var_655_15) then
					arg_652_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_652_1.time_ >= var_655_16 + var_655_17 and arg_652_1.time_ < var_655_16 + var_655_17 + arg_655_0 and not isNil(var_655_15) and arg_652_1.var_.characterEffect1072ui_story then
				arg_652_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_655_19 = arg_652_1.actors_["1069ui_story"].transform
			local var_655_20 = 0

			if var_655_20 < arg_652_1.time_ and arg_652_1.time_ <= var_655_20 + arg_655_0 then
				arg_652_1.var_.moveOldPos1069ui_story = var_655_19.localPosition
			end

			local var_655_21 = 0.001

			if var_655_20 <= arg_652_1.time_ and arg_652_1.time_ < var_655_20 + var_655_21 then
				local var_655_22 = (arg_652_1.time_ - var_655_20) / var_655_21
				local var_655_23 = Vector3.New(0, 100, 0)

				var_655_19.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPos1069ui_story, var_655_23, var_655_22)

				local var_655_24 = manager.ui.mainCamera.transform.position - var_655_19.position

				var_655_19.forward = Vector3.New(var_655_24.x, var_655_24.y, var_655_24.z)

				local var_655_25 = var_655_19.localEulerAngles

				var_655_25.z = 0
				var_655_25.x = 0
				var_655_19.localEulerAngles = var_655_25
			end

			if arg_652_1.time_ >= var_655_20 + var_655_21 and arg_652_1.time_ < var_655_20 + var_655_21 + arg_655_0 then
				var_655_19.localPosition = Vector3.New(0, 100, 0)

				local var_655_26 = manager.ui.mainCamera.transform.position - var_655_19.position

				var_655_19.forward = Vector3.New(var_655_26.x, var_655_26.y, var_655_26.z)

				local var_655_27 = var_655_19.localEulerAngles

				var_655_27.z = 0
				var_655_27.x = 0
				var_655_19.localEulerAngles = var_655_27
			end

			local var_655_28 = 0

			if var_655_28 < arg_652_1.time_ and arg_652_1.time_ <= var_655_28 + arg_655_0 then
				arg_652_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_655_29 = 0

			if var_655_29 < arg_652_1.time_ and arg_652_1.time_ <= var_655_29 + arg_655_0 then
				arg_652_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_655_30 = 0
			local var_655_31 = 0.15

			if var_655_30 < arg_652_1.time_ and arg_652_1.time_ <= var_655_30 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				local var_655_32 = arg_652_1:FormatText(StoryNameCfg[36].name)

				arg_652_1.leftNameTxt_.text = var_655_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_33 = arg_652_1:GetWordFromCfg(120011160)
				local var_655_34 = arg_652_1:FormatText(var_655_33.content)

				arg_652_1.text_.text = var_655_34

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_35 = 6
				local var_655_36 = utf8.len(var_655_34)
				local var_655_37 = var_655_35 <= 0 and var_655_31 or var_655_31 * (var_655_36 / var_655_35)

				if var_655_37 > 0 and var_655_31 < var_655_37 then
					arg_652_1.talkMaxDuration = var_655_37

					if var_655_37 + var_655_30 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_37 + var_655_30
					end
				end

				arg_652_1.text_.text = var_655_34
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011160", "story_v_out_120011.awb") ~= 0 then
					local var_655_38 = manager.audio:GetVoiceLength("story_v_out_120011", "120011160", "story_v_out_120011.awb") / 1000

					if var_655_38 + var_655_30 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_38 + var_655_30
					end

					if var_655_33.prefab_name ~= "" and arg_652_1.actors_[var_655_33.prefab_name] ~= nil then
						local var_655_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_33.prefab_name].transform, "story_v_out_120011", "120011160", "story_v_out_120011.awb")

						arg_652_1:RecordAudio("120011160", var_655_39)
						arg_652_1:RecordAudio("120011160", var_655_39)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_out_120011", "120011160", "story_v_out_120011.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_out_120011", "120011160", "story_v_out_120011.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_40 = math.max(var_655_31, arg_652_1.talkMaxDuration)

			if var_655_30 <= arg_652_1.time_ and arg_652_1.time_ < var_655_30 + var_655_40 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_30) / var_655_40

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_30 + var_655_40 and arg_652_1.time_ < var_655_30 + var_655_40 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {
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
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_652_1:InitPlayNodeList()
	end,
	Play120011161 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 120011161
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play120011162(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = arg_656_1.actors_["1072ui_story"]
			local var_659_1 = 0

			if var_659_1 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 and not isNil(var_659_0) and arg_656_1.var_.characterEffect1072ui_story == nil then
				arg_656_1.var_.characterEffect1072ui_story = var_659_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_2 = 0.2

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_2 and not isNil(var_659_0) then
				local var_659_3 = (arg_656_1.time_ - var_659_1) / var_659_2

				if arg_656_1.var_.characterEffect1072ui_story and not isNil(var_659_0) then
					local var_659_4 = Mathf.Lerp(0, 0.5, var_659_3)

					arg_656_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_656_1.var_.characterEffect1072ui_story.fillRatio = var_659_4
				end
			end

			if arg_656_1.time_ >= var_659_1 + var_659_2 and arg_656_1.time_ < var_659_1 + var_659_2 + arg_659_0 and not isNil(var_659_0) and arg_656_1.var_.characterEffect1072ui_story then
				local var_659_5 = 0.5

				arg_656_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_656_1.var_.characterEffect1072ui_story.fillRatio = var_659_5
			end

			local var_659_6 = 0
			local var_659_7 = 0.475

			if var_659_6 < arg_656_1.time_ and arg_656_1.time_ <= var_659_6 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, false)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_8 = arg_656_1:GetWordFromCfg(120011161)
				local var_659_9 = arg_656_1:FormatText(var_659_8.content)

				arg_656_1.text_.text = var_659_9

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_10 = 19
				local var_659_11 = utf8.len(var_659_9)
				local var_659_12 = var_659_10 <= 0 and var_659_7 or var_659_7 * (var_659_11 / var_659_10)

				if var_659_12 > 0 and var_659_7 < var_659_12 then
					arg_656_1.talkMaxDuration = var_659_12

					if var_659_12 + var_659_6 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_12 + var_659_6
					end
				end

				arg_656_1.text_.text = var_659_9
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_13 = math.max(var_659_7, arg_656_1.talkMaxDuration)

			if var_659_6 <= arg_656_1.time_ and arg_656_1.time_ < var_659_6 + var_659_13 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_6) / var_659_13

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_6 + var_659_13 and arg_656_1.time_ < var_659_6 + var_659_13 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play120011162 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 120011162
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play120011163(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = arg_660_1.actors_["1072ui_story"].transform
			local var_663_1 = 0

			if var_663_1 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 then
				arg_660_1.var_.moveOldPos1072ui_story = var_663_0.localPosition

				local var_663_2 = "1072ui_story"

				arg_660_1:ShowWeapon(arg_660_1.var_[var_663_2 .. "Animator"].transform, false)
			end

			local var_663_3 = 0.001

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_3 then
				local var_663_4 = (arg_660_1.time_ - var_663_1) / var_663_3
				local var_663_5 = Vector3.New(0, 100, 0)

				var_663_0.localPosition = Vector3.Lerp(arg_660_1.var_.moveOldPos1072ui_story, var_663_5, var_663_4)

				local var_663_6 = manager.ui.mainCamera.transform.position - var_663_0.position

				var_663_0.forward = Vector3.New(var_663_6.x, var_663_6.y, var_663_6.z)

				local var_663_7 = var_663_0.localEulerAngles

				var_663_7.z = 0
				var_663_7.x = 0
				var_663_0.localEulerAngles = var_663_7
			end

			if arg_660_1.time_ >= var_663_1 + var_663_3 and arg_660_1.time_ < var_663_1 + var_663_3 + arg_663_0 then
				var_663_0.localPosition = Vector3.New(0, 100, 0)

				local var_663_8 = manager.ui.mainCamera.transform.position - var_663_0.position

				var_663_0.forward = Vector3.New(var_663_8.x, var_663_8.y, var_663_8.z)

				local var_663_9 = var_663_0.localEulerAngles

				var_663_9.z = 0
				var_663_9.x = 0
				var_663_0.localEulerAngles = var_663_9
			end

			local var_663_10 = 0
			local var_663_11 = 1.2

			if var_663_10 < arg_660_1.time_ and arg_660_1.time_ <= var_663_10 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_12 = arg_660_1:GetWordFromCfg(120011162)
				local var_663_13 = arg_660_1:FormatText(var_663_12.content)

				arg_660_1.text_.text = var_663_13

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_14 = 48
				local var_663_15 = utf8.len(var_663_13)
				local var_663_16 = var_663_14 <= 0 and var_663_11 or var_663_11 * (var_663_15 / var_663_14)

				if var_663_16 > 0 and var_663_11 < var_663_16 then
					arg_660_1.talkMaxDuration = var_663_16

					if var_663_16 + var_663_10 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_16 + var_663_10
					end
				end

				arg_660_1.text_.text = var_663_13
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_17 = math.max(var_663_11, arg_660_1.talkMaxDuration)

			if var_663_10 <= arg_660_1.time_ and arg_660_1.time_ < var_663_10 + var_663_17 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_10) / var_663_17

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_10 + var_663_17 and arg_660_1.time_ < var_663_10 + var_663_17 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {
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

		arg_660_1:InitPlayNodeList()
	end,
	Play120011163 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 120011163
		arg_664_1.duration_ = 9.6

		local var_664_0 = {
			zh = 2.8,
			ja = 9.6
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play120011164(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = arg_664_1.actors_["1072ui_story"]
			local var_667_1 = 0

			if var_667_1 < arg_664_1.time_ and arg_664_1.time_ <= var_667_1 + arg_667_0 and not isNil(var_667_0) and arg_664_1.var_.characterEffect1072ui_story == nil then
				arg_664_1.var_.characterEffect1072ui_story = var_667_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_667_2 = 0.2

			if var_667_1 <= arg_664_1.time_ and arg_664_1.time_ < var_667_1 + var_667_2 and not isNil(var_667_0) then
				local var_667_3 = (arg_664_1.time_ - var_667_1) / var_667_2

				if arg_664_1.var_.characterEffect1072ui_story and not isNil(var_667_0) then
					arg_664_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_664_1.time_ >= var_667_1 + var_667_2 and arg_664_1.time_ < var_667_1 + var_667_2 + arg_667_0 and not isNil(var_667_0) and arg_664_1.var_.characterEffect1072ui_story then
				arg_664_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_667_4 = arg_664_1.actors_["1072ui_story"].transform
			local var_667_5 = 0

			if var_667_5 < arg_664_1.time_ and arg_664_1.time_ <= var_667_5 + arg_667_0 then
				arg_664_1.var_.moveOldPos1072ui_story = var_667_4.localPosition

				local var_667_6 = "1072ui_story"

				arg_664_1:ShowWeapon(arg_664_1.var_[var_667_6 .. "Animator"].transform, false)
			end

			local var_667_7 = 0.001

			if var_667_5 <= arg_664_1.time_ and arg_664_1.time_ < var_667_5 + var_667_7 then
				local var_667_8 = (arg_664_1.time_ - var_667_5) / var_667_7
				local var_667_9 = Vector3.New(0, -0.71, -6)

				var_667_4.localPosition = Vector3.Lerp(arg_664_1.var_.moveOldPos1072ui_story, var_667_9, var_667_8)

				local var_667_10 = manager.ui.mainCamera.transform.position - var_667_4.position

				var_667_4.forward = Vector3.New(var_667_10.x, var_667_10.y, var_667_10.z)

				local var_667_11 = var_667_4.localEulerAngles

				var_667_11.z = 0
				var_667_11.x = 0
				var_667_4.localEulerAngles = var_667_11
			end

			if arg_664_1.time_ >= var_667_5 + var_667_7 and arg_664_1.time_ < var_667_5 + var_667_7 + arg_667_0 then
				var_667_4.localPosition = Vector3.New(0, -0.71, -6)

				local var_667_12 = manager.ui.mainCamera.transform.position - var_667_4.position

				var_667_4.forward = Vector3.New(var_667_12.x, var_667_12.y, var_667_12.z)

				local var_667_13 = var_667_4.localEulerAngles

				var_667_13.z = 0
				var_667_13.x = 0
				var_667_4.localEulerAngles = var_667_13
			end

			local var_667_14 = 0

			if var_667_14 < arg_664_1.time_ and arg_664_1.time_ <= var_667_14 + arg_667_0 then
				arg_664_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_667_15 = 0

			if var_667_15 < arg_664_1.time_ and arg_664_1.time_ <= var_667_15 + arg_667_0 then
				arg_664_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_667_16 = 0
			local var_667_17 = 0.25

			if var_667_16 < arg_664_1.time_ and arg_664_1.time_ <= var_667_16 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_18 = arg_664_1:FormatText(StoryNameCfg[379].name)

				arg_664_1.leftNameTxt_.text = var_667_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_19 = arg_664_1:GetWordFromCfg(120011163)
				local var_667_20 = arg_664_1:FormatText(var_667_19.content)

				arg_664_1.text_.text = var_667_20

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_21 = 10
				local var_667_22 = utf8.len(var_667_20)
				local var_667_23 = var_667_21 <= 0 and var_667_17 or var_667_17 * (var_667_22 / var_667_21)

				if var_667_23 > 0 and var_667_17 < var_667_23 then
					arg_664_1.talkMaxDuration = var_667_23

					if var_667_23 + var_667_16 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_23 + var_667_16
					end
				end

				arg_664_1.text_.text = var_667_20
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011163", "story_v_out_120011.awb") ~= 0 then
					local var_667_24 = manager.audio:GetVoiceLength("story_v_out_120011", "120011163", "story_v_out_120011.awb") / 1000

					if var_667_24 + var_667_16 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_24 + var_667_16
					end

					if var_667_19.prefab_name ~= "" and arg_664_1.actors_[var_667_19.prefab_name] ~= nil then
						local var_667_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_19.prefab_name].transform, "story_v_out_120011", "120011163", "story_v_out_120011.awb")

						arg_664_1:RecordAudio("120011163", var_667_25)
						arg_664_1:RecordAudio("120011163", var_667_25)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_out_120011", "120011163", "story_v_out_120011.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_out_120011", "120011163", "story_v_out_120011.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_26 = math.max(var_667_17, arg_664_1.talkMaxDuration)

			if var_667_16 <= arg_664_1.time_ and arg_664_1.time_ < var_667_16 + var_667_26 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_16) / var_667_26

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_16 + var_667_26 and arg_664_1.time_ < var_667_16 + var_667_26 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {
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

		arg_664_1:InitPlayNodeList()
	end,
	Play120011164 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 120011164
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play120011165(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = arg_668_1.actors_["1072ui_story"]
			local var_671_1 = 0

			if var_671_1 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1072ui_story == nil then
				arg_668_1.var_.characterEffect1072ui_story = var_671_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_2 = 0.2

			if var_671_1 <= arg_668_1.time_ and arg_668_1.time_ < var_671_1 + var_671_2 and not isNil(var_671_0) then
				local var_671_3 = (arg_668_1.time_ - var_671_1) / var_671_2

				if arg_668_1.var_.characterEffect1072ui_story and not isNil(var_671_0) then
					local var_671_4 = Mathf.Lerp(0, 0.5, var_671_3)

					arg_668_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_668_1.var_.characterEffect1072ui_story.fillRatio = var_671_4
				end
			end

			if arg_668_1.time_ >= var_671_1 + var_671_2 and arg_668_1.time_ < var_671_1 + var_671_2 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1072ui_story then
				local var_671_5 = 0.5

				arg_668_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_668_1.var_.characterEffect1072ui_story.fillRatio = var_671_5
			end

			local var_671_6 = 0
			local var_671_7 = 0.875

			if var_671_6 < arg_668_1.time_ and arg_668_1.time_ <= var_671_6 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_8 = arg_668_1:FormatText(StoryNameCfg[7].name)

				arg_668_1.leftNameTxt_.text = var_671_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_9 = arg_668_1:GetWordFromCfg(120011164)
				local var_671_10 = arg_668_1:FormatText(var_671_9.content)

				arg_668_1.text_.text = var_671_10

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_11 = 37
				local var_671_12 = utf8.len(var_671_10)
				local var_671_13 = var_671_11 <= 0 and var_671_7 or var_671_7 * (var_671_12 / var_671_11)

				if var_671_13 > 0 and var_671_7 < var_671_13 then
					arg_668_1.talkMaxDuration = var_671_13

					if var_671_13 + var_671_6 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_13 + var_671_6
					end
				end

				arg_668_1.text_.text = var_671_10
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_14 = math.max(var_671_7, arg_668_1.talkMaxDuration)

			if var_671_6 <= arg_668_1.time_ and arg_668_1.time_ < var_671_6 + var_671_14 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_6) / var_671_14

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_6 + var_671_14 and arg_668_1.time_ < var_671_6 + var_671_14 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play120011165 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 120011165
		arg_672_1.duration_ = 4.4

		local var_672_0 = {
			zh = 3.533,
			ja = 4.4
		}
		local var_672_1 = manager.audio:GetLocalizationFlag()

		if var_672_0[var_672_1] ~= nil then
			arg_672_1.duration_ = var_672_0[var_672_1]
		end

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play120011166(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = arg_672_1.actors_["1072ui_story"]
			local var_675_1 = 0

			if var_675_1 < arg_672_1.time_ and arg_672_1.time_ <= var_675_1 + arg_675_0 and not isNil(var_675_0) and arg_672_1.var_.characterEffect1072ui_story == nil then
				arg_672_1.var_.characterEffect1072ui_story = var_675_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_675_2 = 0.2

			if var_675_1 <= arg_672_1.time_ and arg_672_1.time_ < var_675_1 + var_675_2 and not isNil(var_675_0) then
				local var_675_3 = (arg_672_1.time_ - var_675_1) / var_675_2

				if arg_672_1.var_.characterEffect1072ui_story and not isNil(var_675_0) then
					arg_672_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_672_1.time_ >= var_675_1 + var_675_2 and arg_672_1.time_ < var_675_1 + var_675_2 + arg_675_0 and not isNil(var_675_0) and arg_672_1.var_.characterEffect1072ui_story then
				arg_672_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_675_4 = 0
			local var_675_5 = 0.4

			if var_675_4 < arg_672_1.time_ and arg_672_1.time_ <= var_675_4 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				local var_675_6 = arg_672_1:FormatText(StoryNameCfg[379].name)

				arg_672_1.leftNameTxt_.text = var_675_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_7 = arg_672_1:GetWordFromCfg(120011165)
				local var_675_8 = arg_672_1:FormatText(var_675_7.content)

				arg_672_1.text_.text = var_675_8

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_9 = 16
				local var_675_10 = utf8.len(var_675_8)
				local var_675_11 = var_675_9 <= 0 and var_675_5 or var_675_5 * (var_675_10 / var_675_9)

				if var_675_11 > 0 and var_675_5 < var_675_11 then
					arg_672_1.talkMaxDuration = var_675_11

					if var_675_11 + var_675_4 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_11 + var_675_4
					end
				end

				arg_672_1.text_.text = var_675_8
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011165", "story_v_out_120011.awb") ~= 0 then
					local var_675_12 = manager.audio:GetVoiceLength("story_v_out_120011", "120011165", "story_v_out_120011.awb") / 1000

					if var_675_12 + var_675_4 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_12 + var_675_4
					end

					if var_675_7.prefab_name ~= "" and arg_672_1.actors_[var_675_7.prefab_name] ~= nil then
						local var_675_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_7.prefab_name].transform, "story_v_out_120011", "120011165", "story_v_out_120011.awb")

						arg_672_1:RecordAudio("120011165", var_675_13)
						arg_672_1:RecordAudio("120011165", var_675_13)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_out_120011", "120011165", "story_v_out_120011.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_out_120011", "120011165", "story_v_out_120011.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_14 = math.max(var_675_5, arg_672_1.talkMaxDuration)

			if var_675_4 <= arg_672_1.time_ and arg_672_1.time_ < var_675_4 + var_675_14 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_4) / var_675_14

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_4 + var_675_14 and arg_672_1.time_ < var_675_4 + var_675_14 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play120011166 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 120011166
		arg_676_1.duration_ = 0.2

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"

			SetActive(arg_676_1.choicesGo_, true)

			for iter_677_0, iter_677_1 in ipairs(arg_676_1.choices_) do
				local var_677_0 = iter_677_0 <= 2

				SetActive(iter_677_1.go, var_677_0)
			end

			arg_676_1.choices_[1].txt.text = arg_676_1:FormatText(StoryChoiceCfg[366].name)
			arg_676_1.choices_[2].txt.text = arg_676_1:FormatText(StoryChoiceCfg[367].name)
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play120011167(arg_676_1)
			end

			if arg_678_0 == 2 then
				arg_676_0:Play120011167(arg_676_1)
			end

			arg_676_1:RecordChoiceLog(120011166, 366, 367)
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = arg_676_1.actors_["1072ui_story"]
			local var_679_1 = 0

			if var_679_1 < arg_676_1.time_ and arg_676_1.time_ <= var_679_1 + arg_679_0 and not isNil(var_679_0) and arg_676_1.var_.characterEffect1072ui_story == nil then
				arg_676_1.var_.characterEffect1072ui_story = var_679_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_679_2 = 0.2

			if var_679_1 <= arg_676_1.time_ and arg_676_1.time_ < var_679_1 + var_679_2 and not isNil(var_679_0) then
				local var_679_3 = (arg_676_1.time_ - var_679_1) / var_679_2

				if arg_676_1.var_.characterEffect1072ui_story and not isNil(var_679_0) then
					local var_679_4 = Mathf.Lerp(0, 0.5, var_679_3)

					arg_676_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_676_1.var_.characterEffect1072ui_story.fillRatio = var_679_4
				end
			end

			if arg_676_1.time_ >= var_679_1 + var_679_2 and arg_676_1.time_ < var_679_1 + var_679_2 + arg_679_0 and not isNil(var_679_0) and arg_676_1.var_.characterEffect1072ui_story then
				local var_679_5 = 0.5

				arg_676_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_676_1.var_.characterEffect1072ui_story.fillRatio = var_679_5
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play120011167 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 120011167
		arg_680_1.duration_ = 9.7

		local var_680_0 = {
			zh = 9.266,
			ja = 9.7
		}
		local var_680_1 = manager.audio:GetLocalizationFlag()

		if var_680_0[var_680_1] ~= nil then
			arg_680_1.duration_ = var_680_0[var_680_1]
		end

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play120011168(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = "1072ui_story"

			if arg_680_1.actors_[var_683_0] == nil then
				local var_683_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_683_1) then
					local var_683_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_680_1.stage_.transform)

					var_683_2.name = var_683_0
					var_683_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_680_1.actors_[var_683_0] = var_683_2

					local var_683_3 = var_683_2:GetComponentInChildren(typeof(CharacterEffect))

					var_683_3.enabled = true

					local var_683_4 = GameObjectTools.GetOrAddComponent(var_683_2, typeof(DynamicBoneHelper))

					if var_683_4 then
						var_683_4:EnableDynamicBone(false)
					end

					arg_680_1:ShowWeapon(var_683_3.transform, false)

					arg_680_1.var_[var_683_0 .. "Animator"] = var_683_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_680_1.var_[var_683_0 .. "Animator"].applyRootMotion = true
					arg_680_1.var_[var_683_0 .. "LipSync"] = var_683_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_683_5 = 0

			if var_683_5 < arg_680_1.time_ and arg_680_1.time_ <= var_683_5 + arg_683_0 then
				arg_680_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action462")
			end

			local var_683_6 = arg_680_1.actors_["1072ui_story"]
			local var_683_7 = 0

			if var_683_7 < arg_680_1.time_ and arg_680_1.time_ <= var_683_7 + arg_683_0 and not isNil(var_683_6) and arg_680_1.var_.characterEffect1072ui_story == nil then
				arg_680_1.var_.characterEffect1072ui_story = var_683_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_8 = 0.2

			if var_683_7 <= arg_680_1.time_ and arg_680_1.time_ < var_683_7 + var_683_8 and not isNil(var_683_6) then
				local var_683_9 = (arg_680_1.time_ - var_683_7) / var_683_8

				if arg_680_1.var_.characterEffect1072ui_story and not isNil(var_683_6) then
					arg_680_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= var_683_7 + var_683_8 and arg_680_1.time_ < var_683_7 + var_683_8 + arg_683_0 and not isNil(var_683_6) and arg_680_1.var_.characterEffect1072ui_story then
				arg_680_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_683_10 = 0
			local var_683_11 = 1.05

			if var_683_10 < arg_680_1.time_ and arg_680_1.time_ <= var_683_10 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				local var_683_12 = arg_680_1:FormatText(StoryNameCfg[379].name)

				arg_680_1.leftNameTxt_.text = var_683_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_13 = arg_680_1:GetWordFromCfg(120011167)
				local var_683_14 = arg_680_1:FormatText(var_683_13.content)

				arg_680_1.text_.text = var_683_14

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_15 = 42
				local var_683_16 = utf8.len(var_683_14)
				local var_683_17 = var_683_15 <= 0 and var_683_11 or var_683_11 * (var_683_16 / var_683_15)

				if var_683_17 > 0 and var_683_11 < var_683_17 then
					arg_680_1.talkMaxDuration = var_683_17

					if var_683_17 + var_683_10 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_17 + var_683_10
					end
				end

				arg_680_1.text_.text = var_683_14
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011167", "story_v_out_120011.awb") ~= 0 then
					local var_683_18 = manager.audio:GetVoiceLength("story_v_out_120011", "120011167", "story_v_out_120011.awb") / 1000

					if var_683_18 + var_683_10 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_18 + var_683_10
					end

					if var_683_13.prefab_name ~= "" and arg_680_1.actors_[var_683_13.prefab_name] ~= nil then
						local var_683_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_13.prefab_name].transform, "story_v_out_120011", "120011167", "story_v_out_120011.awb")

						arg_680_1:RecordAudio("120011167", var_683_19)
						arg_680_1:RecordAudio("120011167", var_683_19)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_out_120011", "120011167", "story_v_out_120011.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_out_120011", "120011167", "story_v_out_120011.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_20 = math.max(var_683_11, arg_680_1.talkMaxDuration)

			if var_683_10 <= arg_680_1.time_ and arg_680_1.time_ < var_683_10 + var_683_20 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_10) / var_683_20

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_10 + var_683_20 and arg_680_1.time_ < var_683_10 + var_683_20 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play120011168 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 120011168
		arg_684_1.duration_ = 9

		local var_684_0 = {
			zh = 6.066,
			ja = 9
		}
		local var_684_1 = manager.audio:GetLocalizationFlag()

		if var_684_0[var_684_1] ~= nil then
			arg_684_1.duration_ = var_684_0[var_684_1]
		end

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play120011169(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = 0
			local var_687_1 = 0.775

			if var_687_0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, true)

				local var_687_2 = arg_684_1:FormatText(StoryNameCfg[379].name)

				arg_684_1.leftNameTxt_.text = var_687_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_3 = arg_684_1:GetWordFromCfg(120011168)
				local var_687_4 = arg_684_1:FormatText(var_687_3.content)

				arg_684_1.text_.text = var_687_4

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_5 = 31
				local var_687_6 = utf8.len(var_687_4)
				local var_687_7 = var_687_5 <= 0 and var_687_1 or var_687_1 * (var_687_6 / var_687_5)

				if var_687_7 > 0 and var_687_1 < var_687_7 then
					arg_684_1.talkMaxDuration = var_687_7

					if var_687_7 + var_687_0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_7 + var_687_0
					end
				end

				arg_684_1.text_.text = var_687_4
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011168", "story_v_out_120011.awb") ~= 0 then
					local var_687_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011168", "story_v_out_120011.awb") / 1000

					if var_687_8 + var_687_0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_8 + var_687_0
					end

					if var_687_3.prefab_name ~= "" and arg_684_1.actors_[var_687_3.prefab_name] ~= nil then
						local var_687_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_3.prefab_name].transform, "story_v_out_120011", "120011168", "story_v_out_120011.awb")

						arg_684_1:RecordAudio("120011168", var_687_9)
						arg_684_1:RecordAudio("120011168", var_687_9)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_out_120011", "120011168", "story_v_out_120011.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_out_120011", "120011168", "story_v_out_120011.awb")
				end

				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_10 = math.max(var_687_1, arg_684_1.talkMaxDuration)

			if var_687_0 <= arg_684_1.time_ and arg_684_1.time_ < var_687_0 + var_687_10 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - var_687_0) / var_687_10

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= var_687_0 + var_687_10 and arg_684_1.time_ < var_687_0 + var_687_10 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play120011169 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 120011169
		arg_688_1.duration_ = 4.5

		local var_688_0 = {
			zh = 3.866,
			ja = 4.5
		}
		local var_688_1 = manager.audio:GetLocalizationFlag()

		if var_688_0[var_688_1] ~= nil then
			arg_688_1.duration_ = var_688_0[var_688_1]
		end

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
			arg_688_1.auto_ = false
		end

		function arg_688_1.playNext_(arg_690_0)
			arg_688_1.onStoryFinished_()
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = 0
			local var_691_1 = 0.45

			if var_691_0 < arg_688_1.time_ and arg_688_1.time_ <= var_691_0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				local var_691_2 = arg_688_1:FormatText(StoryNameCfg[379].name)

				arg_688_1.leftNameTxt_.text = var_691_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_3 = arg_688_1:GetWordFromCfg(120011169)
				local var_691_4 = arg_688_1:FormatText(var_691_3.content)

				arg_688_1.text_.text = var_691_4

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_5 = 18
				local var_691_6 = utf8.len(var_691_4)
				local var_691_7 = var_691_5 <= 0 and var_691_1 or var_691_1 * (var_691_6 / var_691_5)

				if var_691_7 > 0 and var_691_1 < var_691_7 then
					arg_688_1.talkMaxDuration = var_691_7

					if var_691_7 + var_691_0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_7 + var_691_0
					end
				end

				arg_688_1.text_.text = var_691_4
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011169", "story_v_out_120011.awb") ~= 0 then
					local var_691_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011169", "story_v_out_120011.awb") / 1000

					if var_691_8 + var_691_0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_8 + var_691_0
					end

					if var_691_3.prefab_name ~= "" and arg_688_1.actors_[var_691_3.prefab_name] ~= nil then
						local var_691_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_688_1.actors_[var_691_3.prefab_name].transform, "story_v_out_120011", "120011169", "story_v_out_120011.awb")

						arg_688_1:RecordAudio("120011169", var_691_9)
						arg_688_1:RecordAudio("120011169", var_691_9)
					else
						arg_688_1:AudioAction("play", "voice", "story_v_out_120011", "120011169", "story_v_out_120011.awb")
					end

					arg_688_1:RecordHistoryTalkVoice("story_v_out_120011", "120011169", "story_v_out_120011.awb")
				end

				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_10 = math.max(var_691_1, arg_688_1.talkMaxDuration)

			if var_691_0 <= arg_688_1.time_ and arg_688_1.time_ < var_691_0 + var_691_10 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_0) / var_691_10

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_0 + var_691_10 and arg_688_1.time_ < var_691_0 + var_691_10 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play120011072 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 120011072
		arg_692_1.duration_ = 5

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play120011073(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = 0
			local var_695_1 = 0.7

			if var_695_0 < arg_692_1.time_ and arg_692_1.time_ <= var_695_0 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, false)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_2 = arg_692_1:GetWordFromCfg(120011072)
				local var_695_3 = arg_692_1:FormatText(var_695_2.content)

				arg_692_1.text_.text = var_695_3

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_4 = 28
				local var_695_5 = utf8.len(var_695_3)
				local var_695_6 = var_695_4 <= 0 and var_695_1 or var_695_1 * (var_695_5 / var_695_4)

				if var_695_6 > 0 and var_695_1 < var_695_6 then
					arg_692_1.talkMaxDuration = var_695_6

					if var_695_6 + var_695_0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_6 + var_695_0
					end
				end

				arg_692_1.text_.text = var_695_3
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)
				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_7 = math.max(var_695_1, arg_692_1.talkMaxDuration)

			if var_695_0 <= arg_692_1.time_ and arg_692_1.time_ < var_695_0 + var_695_7 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_0) / var_695_7

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_0 + var_695_7 and arg_692_1.time_ < var_695_0 + var_695_7 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play120011073 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 120011073
		arg_696_1.duration_ = 5

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play120011074(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0
			local var_699_1 = 0.05

			if var_699_0 < arg_696_1.time_ and arg_696_1.time_ <= var_699_0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, false)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_2 = arg_696_1:GetWordFromCfg(120011073)
				local var_699_3 = arg_696_1:FormatText(var_699_2.content)

				arg_696_1.text_.text = var_699_3

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_4 = 2
				local var_699_5 = utf8.len(var_699_3)
				local var_699_6 = var_699_4 <= 0 and var_699_1 or var_699_1 * (var_699_5 / var_699_4)

				if var_699_6 > 0 and var_699_1 < var_699_6 then
					arg_696_1.talkMaxDuration = var_699_6

					if var_699_6 + var_699_0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_6 + var_699_0
					end
				end

				arg_696_1.text_.text = var_699_3
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)
				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_7 = math.max(var_699_1, arg_696_1.talkMaxDuration)

			if var_699_0 <= arg_696_1.time_ and arg_696_1.time_ < var_699_0 + var_699_7 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_0) / var_699_7

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_0 + var_699_7 and arg_696_1.time_ < var_699_0 + var_699_7 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0101",
		"SofdecAsset/story/101200101.usm",
		"TextureConfig/Background/ST45",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/XH0102a"
	},
	voices = {
		"story_v_out_120011.awb"
	},
	skipMarkers = {
		120011001
	}
}
