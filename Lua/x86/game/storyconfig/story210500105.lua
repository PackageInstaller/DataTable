return {
	Play1105005001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1105005001
		arg_1_1.duration_ = 11.23

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1105005002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST12"

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
				local var_4_5 = arg_1_1.bgs_.ST12

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
					if iter_4_0 ~= "ST12" then
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

			local var_4_24 = 0
			local var_4_25 = 0.200000002980232

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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

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
			local var_4_37 = 0.675

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

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[1094].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(1105005001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005001", "story_v_side_new_1105005.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005001", "story_v_side_new_1105005.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_side_new_1105005", "1105005001", "story_v_side_new_1105005.awb")

						arg_1_1:RecordAudio("1105005001", var_4_46)
						arg_1_1:RecordAudio("1105005001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005001", "story_v_side_new_1105005.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005001", "story_v_side_new_1105005.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1105005002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1105005002
		arg_9_1.duration_ = 4.9

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1105005003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.55

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1094].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1105005002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005002", "story_v_side_new_1105005.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005002", "story_v_side_new_1105005.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_side_new_1105005", "1105005002", "story_v_side_new_1105005.awb")

						arg_9_1:RecordAudio("1105005002", var_12_9)
						arg_9_1:RecordAudio("1105005002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005002", "story_v_side_new_1105005.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005002", "story_v_side_new_1105005.awb")
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
	Play1105005003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1105005003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1105005004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.375

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

				local var_16_2 = arg_13_1:GetWordFromCfg(1105005003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 55
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
	Play1105005004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1105005004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1105005005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.3

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1105005004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 12
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1105005005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1105005005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1105005006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.9

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

				local var_24_2 = arg_21_1:GetWordFromCfg(1105005005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 36
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
	Play1105005006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1105005006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1105005007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.25

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

				local var_28_3 = arg_25_1:GetWordFromCfg(1105005006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 10
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
	Play1105005007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1105005007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1105005008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.425

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(1105005007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 57
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1105005008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1105005008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1105005009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.25

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(1105005008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 10
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
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1105005009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1105005009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1105005010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "1150ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "1150ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["1150ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos1150ui_story = var_40_5.localPosition

				local var_40_7 = "1150ui_story"

				arg_37_1:ShowWeapon(arg_37_1.var_[var_40_7 .. "Animator"].transform, false)
			end

			local var_40_8 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_8 then
				local var_40_9 = (arg_37_1.time_ - var_40_6) / var_40_8
				local var_40_10 = Vector3.New(0, -1.01, -6.2)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1150ui_story, var_40_10, var_40_9)

				local var_40_11 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_11.x, var_40_11.y, var_40_11.z)

				local var_40_12 = var_40_5.localEulerAngles

				var_40_12.z = 0
				var_40_12.x = 0
				var_40_5.localEulerAngles = var_40_12
			end

			if arg_37_1.time_ >= var_40_6 + var_40_8 and arg_37_1.time_ < var_40_6 + var_40_8 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_40_13 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_13.x, var_40_13.y, var_40_13.z)

				local var_40_14 = var_40_5.localEulerAngles

				var_40_14.z = 0
				var_40_14.x = 0
				var_40_5.localEulerAngles = var_40_14
			end

			local var_40_15 = arg_37_1.actors_["1150ui_story"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect1150ui_story == nil then
				arg_37_1.var_.characterEffect1150ui_story = var_40_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_17 = 0.200000002980232

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.characterEffect1150ui_story and not isNil(var_40_15) then
					arg_37_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect1150ui_story then
				arg_37_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_21 = 0
			local var_40_22 = 0.275

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_23 = arg_37_1:FormatText(StoryNameCfg[74].name)

				arg_37_1.leftNameTxt_.text = var_40_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(1105005009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 11
				local var_40_27 = utf8.len(var_40_25)
				local var_40_28 = var_40_26 <= 0 and var_40_22 or var_40_22 * (var_40_27 / var_40_26)

				if var_40_28 > 0 and var_40_22 < var_40_28 then
					arg_37_1.talkMaxDuration = var_40_28

					if var_40_28 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_25
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005009", "story_v_side_new_1105005.awb") ~= 0 then
					local var_40_29 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005009", "story_v_side_new_1105005.awb") / 1000

					if var_40_29 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_21
					end

					if var_40_24.prefab_name ~= "" and arg_37_1.actors_[var_40_24.prefab_name] ~= nil then
						local var_40_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_24.prefab_name].transform, "story_v_side_new_1105005", "1105005009", "story_v_side_new_1105005.awb")

						arg_37_1:RecordAudio("1105005009", var_40_30)
						arg_37_1:RecordAudio("1105005009", var_40_30)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005009", "story_v_side_new_1105005.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005009", "story_v_side_new_1105005.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_31 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_31 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_21) / var_40_31

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_21 + var_40_31 and arg_37_1.time_ < var_40_21 + var_40_31 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1105005010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1105005010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1105005011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_1 = 0.866666666666667

			if arg_41_1.time_ >= var_44_0 + var_44_1 and arg_41_1.time_ < var_44_0 + var_44_1 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_2 = arg_41_1.actors_["1150ui_story"]
			local var_44_3 = 0

			if var_44_3 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1150ui_story == nil then
				arg_41_1.var_.characterEffect1150ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.2

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_4 and not isNil(var_44_2) then
				local var_44_5 = (arg_41_1.time_ - var_44_3) / var_44_4

				if arg_41_1.var_.characterEffect1150ui_story and not isNil(var_44_2) then
					local var_44_6 = Mathf.Lerp(0, 0.5, var_44_5)

					arg_41_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1150ui_story.fillRatio = var_44_6
				end
			end

			if arg_41_1.time_ >= var_44_3 + var_44_4 and arg_41_1.time_ < var_44_3 + var_44_4 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1150ui_story then
				local var_44_7 = 0.5

				arg_41_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1150ui_story.fillRatio = var_44_7
			end

			local var_44_8 = arg_41_1.actors_["1150ui_story"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos1150ui_story = var_44_8.localPosition

				local var_44_10 = "1150ui_story"

				arg_41_1:ShowWeapon(arg_41_1.var_[var_44_10 .. "Animator"].transform, true)
			end

			local var_44_11 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_9) / var_44_11
				local var_44_13 = Vector3.New(0, 100, 0)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1150ui_story, var_44_13, var_44_12)

				local var_44_14 = manager.ui.mainCamera.transform.position - var_44_8.position

				var_44_8.forward = Vector3.New(var_44_14.x, var_44_14.y, var_44_14.z)

				local var_44_15 = var_44_8.localEulerAngles

				var_44_15.z = 0
				var_44_15.x = 0
				var_44_8.localEulerAngles = var_44_15
			end

			if arg_41_1.time_ >= var_44_9 + var_44_11 and arg_41_1.time_ < var_44_9 + var_44_11 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, 100, 0)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_8.position

				var_44_8.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_8.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_8.localEulerAngles = var_44_17
			end

			local var_44_18 = 0
			local var_44_19 = 1.35

			if var_44_18 < arg_41_1.time_ and arg_41_1.time_ <= var_44_18 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_20 = arg_41_1:GetWordFromCfg(1105005010)
				local var_44_21 = arg_41_1:FormatText(var_44_20.content)

				arg_41_1.text_.text = var_44_21

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_22 = 54
				local var_44_23 = utf8.len(var_44_21)
				local var_44_24 = var_44_22 <= 0 and var_44_19 or var_44_19 * (var_44_23 / var_44_22)

				if var_44_24 > 0 and var_44_19 < var_44_24 then
					arg_41_1.talkMaxDuration = var_44_24

					if var_44_24 + var_44_18 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_18
					end
				end

				arg_41_1.text_.text = var_44_21
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_19, arg_41_1.talkMaxDuration)

			if var_44_18 <= arg_41_1.time_ and arg_41_1.time_ < var_44_18 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_18) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_18 + var_44_25 and arg_41_1.time_ < var_44_18 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play1105005011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1105005011
		arg_45_1.duration_ = 3.07

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1105005012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1150ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1150ui_story == nil then
				arg_45_1.var_.characterEffect1150ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1150ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1150ui_story then
				arg_45_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_48_5 = arg_45_1.actors_["1150ui_story"].transform
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.var_.moveOldPos1150ui_story = var_48_5.localPosition

				local var_48_7 = "1150ui_story"

				arg_45_1:ShowWeapon(arg_45_1.var_[var_48_7 .. "Animator"].transform, false)
			end

			local var_48_8 = 0.001

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_8 then
				local var_48_9 = (arg_45_1.time_ - var_48_6) / var_48_8
				local var_48_10 = Vector3.New(0, -1.01, -6.2)

				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1150ui_story, var_48_10, var_48_9)

				local var_48_11 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_11.x, var_48_11.y, var_48_11.z)

				local var_48_12 = var_48_5.localEulerAngles

				var_48_12.z = 0
				var_48_12.x = 0
				var_48_5.localEulerAngles = var_48_12
			end

			if arg_45_1.time_ >= var_48_6 + var_48_8 and arg_45_1.time_ < var_48_6 + var_48_8 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_48_13 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_13.x, var_48_13.y, var_48_13.z)

				local var_48_14 = var_48_5.localEulerAngles

				var_48_14.z = 0
				var_48_14.x = 0
				var_48_5.localEulerAngles = var_48_14
			end

			local var_48_15 = 0
			local var_48_16 = 0.35

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[74].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(1105005011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 14
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005011", "story_v_side_new_1105005.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005011", "story_v_side_new_1105005.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_side_new_1105005", "1105005011", "story_v_side_new_1105005.awb")

						arg_45_1:RecordAudio("1105005011", var_48_24)
						arg_45_1:RecordAudio("1105005011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005011", "story_v_side_new_1105005.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005011", "story_v_side_new_1105005.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1105005012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1105005012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1105005013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1150ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1150ui_story == nil then
				arg_49_1.var_.characterEffect1150ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1150ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1150ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1150ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1150ui_story.fillRatio = var_52_5
			end

			local var_52_6 = arg_49_1.actors_["1150ui_story"].transform
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.var_.moveOldPos1150ui_story = var_52_6.localPosition

				local var_52_8 = "1150ui_story"

				arg_49_1:ShowWeapon(arg_49_1.var_[var_52_8 .. "Animator"].transform, true)
			end

			local var_52_9 = 0.001

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_9 then
				local var_52_10 = (arg_49_1.time_ - var_52_7) / var_52_9
				local var_52_11 = Vector3.New(0, 100, 0)

				var_52_6.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1150ui_story, var_52_11, var_52_10)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_6.position

				var_52_6.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_6.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_6.localEulerAngles = var_52_13
			end

			if arg_49_1.time_ >= var_52_7 + var_52_9 and arg_49_1.time_ < var_52_7 + var_52_9 + arg_52_0 then
				var_52_6.localPosition = Vector3.New(0, 100, 0)

				local var_52_14 = manager.ui.mainCamera.transform.position - var_52_6.position

				var_52_6.forward = Vector3.New(var_52_14.x, var_52_14.y, var_52_14.z)

				local var_52_15 = var_52_6.localEulerAngles

				var_52_15.z = 0
				var_52_15.x = 0
				var_52_6.localEulerAngles = var_52_15
			end

			local var_52_16 = 0
			local var_52_17 = 1.2

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(1105005012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 48
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_17 or var_52_17 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_17 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_23 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_23 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_16) / var_52_23

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_16 + var_52_23 and arg_49_1.time_ < var_52_16 + var_52_23 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1105005013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1105005013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1105005014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.725

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(1105005013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 29
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1105005014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1105005014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1105005015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.45

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(1105005014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 18
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
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1105005015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1105005015
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, true)

		arg_61_1.tipsText_.text = StoryTipsCfg[105001].name

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"

			SetActive(arg_61_1.choicesGo_, true)

			for iter_62_0, iter_62_1 in ipairs(arg_61_1.choices_) do
				local var_62_0 = iter_62_0 <= 2

				SetActive(iter_62_1.go, var_62_0)
			end

			arg_61_1.choices_[1].txt.text = arg_61_1:FormatText(StoryChoiceCfg[1099].name)
			arg_61_1.choices_[2].txt.text = arg_61_1:FormatText(StoryChoiceCfg[1061].name)
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1105005016(arg_61_1)
			end

			if arg_63_0 == 2 then
				PlayerAction.UseStoryTrigger(1050011, 210500105, 1105005015, 2)
				arg_61_0:Play1105005018(arg_61_1)
			end

			arg_61_1:RecordChoiceLog(1105005015, 1099, 1061)
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			return
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1105005016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1105005016
		arg_65_1.duration_ = 3.23

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1105005017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1150ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1150ui_story == nil then
				arg_65_1.var_.characterEffect1150ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1150ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1150ui_story then
				arg_65_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_5 = arg_65_1.actors_["1150ui_story"].transform
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.var_.moveOldPos1150ui_story = var_68_5.localPosition

				local var_68_7 = "1150ui_story"

				arg_65_1:ShowWeapon(arg_65_1.var_[var_68_7 .. "Animator"].transform, false)
			end

			local var_68_8 = 0.001

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_8 then
				local var_68_9 = (arg_65_1.time_ - var_68_6) / var_68_8
				local var_68_10 = Vector3.New(0, -1.01, -6.2)

				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1150ui_story, var_68_10, var_68_9)

				local var_68_11 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_11.x, var_68_11.y, var_68_11.z)

				local var_68_12 = var_68_5.localEulerAngles

				var_68_12.z = 0
				var_68_12.x = 0
				var_68_5.localEulerAngles = var_68_12
			end

			if arg_65_1.time_ >= var_68_6 + var_68_8 and arg_65_1.time_ < var_68_6 + var_68_8 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_68_13 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_13.x, var_68_13.y, var_68_13.z)

				local var_68_14 = var_68_5.localEulerAngles

				var_68_14.z = 0
				var_68_14.x = 0
				var_68_5.localEulerAngles = var_68_14
			end

			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_68_16 = 0
			local var_68_17 = 0.25

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[74].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(1105005016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 10
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005016", "story_v_side_new_1105005.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005016", "story_v_side_new_1105005.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_side_new_1105005", "1105005016", "story_v_side_new_1105005.awb")

						arg_65_1:RecordAudio("1105005016", var_68_25)
						arg_65_1:RecordAudio("1105005016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005016", "story_v_side_new_1105005.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005016", "story_v_side_new_1105005.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_26 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_26 and arg_65_1.time_ < var_68_16 + var_68_26 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play1105005017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1105005017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1105005021(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1150ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1150ui_story == nil then
				arg_69_1.var_.characterEffect1150ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1150ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1150ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1150ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1150ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.125

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(1105005017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 5
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1105005021 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1105005021
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1105005022(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1150ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1150ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1150ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = 0
			local var_76_10 = 0.925

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_11 = arg_73_1:GetWordFromCfg(1105005021)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 37
				local var_76_14 = utf8.len(var_76_12)
				local var_76_15 = var_76_13 <= 0 and var_76_10 or var_76_10 * (var_76_14 / var_76_13)

				if var_76_15 > 0 and var_76_10 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_9 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_9
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_10, arg_73_1.talkMaxDuration)

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_9) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_9 + var_76_16 and arg_73_1.time_ < var_76_9 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play1105005022 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1105005022
		arg_77_1.duration_ = 3.37

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1105005023(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1150ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1150ui_story == nil then
				arg_77_1.var_.characterEffect1150ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1150ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1150ui_story then
				arg_77_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["1150ui_story"].transform
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.var_.moveOldPos1150ui_story = var_80_4.localPosition
			end

			local var_80_6 = 0.001

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6
				local var_80_8 = Vector3.New(0, -1.01, -6.2)

				var_80_4.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1150ui_story, var_80_8, var_80_7)

				local var_80_9 = manager.ui.mainCamera.transform.position - var_80_4.position

				var_80_4.forward = Vector3.New(var_80_9.x, var_80_9.y, var_80_9.z)

				local var_80_10 = var_80_4.localEulerAngles

				var_80_10.z = 0
				var_80_10.x = 0
				var_80_4.localEulerAngles = var_80_10
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				var_80_4.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_80_11 = manager.ui.mainCamera.transform.position - var_80_4.position

				var_80_4.forward = Vector3.New(var_80_11.x, var_80_11.y, var_80_11.z)

				local var_80_12 = var_80_4.localEulerAngles

				var_80_12.z = 0
				var_80_12.x = 0
				var_80_4.localEulerAngles = var_80_12
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_80_14 = 0
			local var_80_15 = 0.35

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_16 = arg_77_1:FormatText(StoryNameCfg[74].name)

				arg_77_1.leftNameTxt_.text = var_80_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_17 = arg_77_1:GetWordFromCfg(1105005022)
				local var_80_18 = arg_77_1:FormatText(var_80_17.content)

				arg_77_1.text_.text = var_80_18

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_19 = 14
				local var_80_20 = utf8.len(var_80_18)
				local var_80_21 = var_80_19 <= 0 and var_80_15 or var_80_15 * (var_80_20 / var_80_19)

				if var_80_21 > 0 and var_80_15 < var_80_21 then
					arg_77_1.talkMaxDuration = var_80_21

					if var_80_21 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_21 + var_80_14
					end
				end

				arg_77_1.text_.text = var_80_18
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005022", "story_v_side_new_1105005.awb") ~= 0 then
					local var_80_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005022", "story_v_side_new_1105005.awb") / 1000

					if var_80_22 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_14
					end

					if var_80_17.prefab_name ~= "" and arg_77_1.actors_[var_80_17.prefab_name] ~= nil then
						local var_80_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_17.prefab_name].transform, "story_v_side_new_1105005", "1105005022", "story_v_side_new_1105005.awb")

						arg_77_1:RecordAudio("1105005022", var_80_23)
						arg_77_1:RecordAudio("1105005022", var_80_23)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005022", "story_v_side_new_1105005.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005022", "story_v_side_new_1105005.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_24 = math.max(var_80_15, arg_77_1.talkMaxDuration)

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_24 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_14) / var_80_24

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_14 + var_80_24 and arg_77_1.time_ < var_80_14 + var_80_24 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1105005023 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1105005023
		arg_81_1.duration_ = 9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1105005024(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = "R5001a"

			if arg_81_1.bgs_[var_84_0] == nil then
				local var_84_1 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_0)
				var_84_1.name = var_84_0
				var_84_1.transform.parent = arg_81_1.stage_.transform
				var_84_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_0] = var_84_1
			end

			local var_84_2 = 2

			if var_84_2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				local var_84_3 = manager.ui.mainCamera.transform.localPosition
				local var_84_4 = Vector3.New(0, 0, 10) + Vector3.New(var_84_3.x, var_84_3.y, 0)
				local var_84_5 = arg_81_1.bgs_.R5001a

				var_84_5.transform.localPosition = var_84_4
				var_84_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_6 = var_84_5:GetComponent("SpriteRenderer")

				if var_84_6 and var_84_6.sprite then
					local var_84_7 = (var_84_5.transform.localPosition - var_84_3).z
					local var_84_8 = manager.ui.mainCameraCom_
					local var_84_9 = 2 * var_84_7 * Mathf.Tan(var_84_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_10 = var_84_9 * var_84_8.aspect
					local var_84_11 = var_84_6.sprite.bounds.size.x
					local var_84_12 = var_84_6.sprite.bounds.size.y
					local var_84_13 = var_84_10 / var_84_11
					local var_84_14 = var_84_9 / var_84_12
					local var_84_15 = var_84_14 < var_84_13 and var_84_13 or var_84_14

					var_84_5.transform.localScale = Vector3.New(var_84_15, var_84_15, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "R5001a" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_16 = 4

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_17 = 0.1

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_18 = 0

			if var_84_18 < arg_81_1.time_ and arg_81_1.time_ <= var_84_18 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_19 = 2

			if var_84_18 <= arg_81_1.time_ and arg_81_1.time_ < var_84_18 + var_84_19 then
				local var_84_20 = (arg_81_1.time_ - var_84_18) / var_84_19
				local var_84_21 = Color.New(0, 0, 0)

				var_84_21.a = Mathf.Lerp(0, 1, var_84_20)
				arg_81_1.mask_.color = var_84_21
			end

			if arg_81_1.time_ >= var_84_18 + var_84_19 and arg_81_1.time_ < var_84_18 + var_84_19 + arg_84_0 then
				local var_84_22 = Color.New(0, 0, 0)

				var_84_22.a = 1
				arg_81_1.mask_.color = var_84_22
			end

			local var_84_23 = 2

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_24 = 2

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24
				local var_84_26 = Color.New(0, 0, 0)

				var_84_26.a = Mathf.Lerp(1, 0, var_84_25)
				arg_81_1.mask_.color = var_84_26
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 then
				local var_84_27 = Color.New(0, 0, 0)
				local var_84_28 = 0

				arg_81_1.mask_.enabled = false
				var_84_27.a = var_84_28
				arg_81_1.mask_.color = var_84_27
			end

			local var_84_29 = arg_81_1.actors_["1150ui_story"].transform
			local var_84_30 = 1.96599999815226

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.var_.moveOldPos1150ui_story = var_84_29.localPosition
			end

			local var_84_31 = 0.001

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_31 then
				local var_84_32 = (arg_81_1.time_ - var_84_30) / var_84_31
				local var_84_33 = Vector3.New(0, 100, 0)

				var_84_29.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1150ui_story, var_84_33, var_84_32)

				local var_84_34 = manager.ui.mainCamera.transform.position - var_84_29.position

				var_84_29.forward = Vector3.New(var_84_34.x, var_84_34.y, var_84_34.z)

				local var_84_35 = var_84_29.localEulerAngles

				var_84_35.z = 0
				var_84_35.x = 0
				var_84_29.localEulerAngles = var_84_35
			end

			if arg_81_1.time_ >= var_84_30 + var_84_31 and arg_81_1.time_ < var_84_30 + var_84_31 + arg_84_0 then
				var_84_29.localPosition = Vector3.New(0, 100, 0)

				local var_84_36 = manager.ui.mainCamera.transform.position - var_84_29.position

				var_84_29.forward = Vector3.New(var_84_36.x, var_84_36.y, var_84_36.z)

				local var_84_37 = var_84_29.localEulerAngles

				var_84_37.z = 0
				var_84_37.x = 0
				var_84_29.localEulerAngles = var_84_37
			end

			local var_84_38 = 2

			arg_81_1.isInRecall_ = false

			if var_84_38 < arg_81_1.time_ and arg_81_1.time_ <= var_84_38 + arg_84_0 then
				arg_81_1.screenFilterGo_:SetActive(true)

				arg_81_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_84_2, iter_84_3 in pairs(arg_81_1.actors_) do
					local var_84_39 = iter_84_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_84_4, iter_84_5 in ipairs(var_84_39) do
						if iter_84_5.color.r > 0.51 then
							iter_84_5.color = Color.New(1, 1, 1)
						else
							iter_84_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_84_40 = 0.0333333333333332

			if var_84_38 <= arg_81_1.time_ and arg_81_1.time_ < var_84_38 + var_84_40 then
				local var_84_41 = (arg_81_1.time_ - var_84_38) / var_84_40

				arg_81_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_84_41)
			end

			if arg_81_1.time_ >= var_84_38 + var_84_40 and arg_81_1.time_ < var_84_38 + var_84_40 + arg_84_0 then
				arg_81_1.screenFilterEffect_.weight = 1
			end

			local var_84_42 = arg_81_1.bgs_.R5001a.transform
			local var_84_43 = 2.03333333333333

			if var_84_43 < arg_81_1.time_ and arg_81_1.time_ <= var_84_43 + arg_84_0 then
				arg_81_1.var_.moveOldPosR5001a = var_84_42.localPosition
			end

			local var_84_44 = 0.001

			if var_84_43 <= arg_81_1.time_ and arg_81_1.time_ < var_84_43 + var_84_44 then
				local var_84_45 = (arg_81_1.time_ - var_84_43) / var_84_44
				local var_84_46 = Vector3.New(0, 1, 10)

				var_84_42.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPosR5001a, var_84_46, var_84_45)
			end

			if arg_81_1.time_ >= var_84_43 + var_84_44 and arg_81_1.time_ < var_84_43 + var_84_44 + arg_84_0 then
				var_84_42.localPosition = Vector3.New(0, 1, 10)
			end

			local var_84_47 = arg_81_1.bgs_.R5001a.transform
			local var_84_48 = 2.06733333333333

			if var_84_48 < arg_81_1.time_ and arg_81_1.time_ <= var_84_48 + arg_84_0 then
				arg_81_1.var_.moveOldPosR5001a = var_84_47.localPosition
			end

			local var_84_49 = 1.93266666666667

			if var_84_48 <= arg_81_1.time_ and arg_81_1.time_ < var_84_48 + var_84_49 then
				local var_84_50 = (arg_81_1.time_ - var_84_48) / var_84_49
				local var_84_51 = Vector3.New(0, 1, 9)

				var_84_47.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPosR5001a, var_84_51, var_84_50)
			end

			if arg_81_1.time_ >= var_84_48 + var_84_49 and arg_81_1.time_ < var_84_48 + var_84_49 + arg_84_0 then
				var_84_47.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_52 = 4
			local var_84_53 = 0.375

			if var_84_52 < arg_81_1.time_ and arg_81_1.time_ <= var_84_52 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_54 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_54:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_55 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_55

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

				local var_84_56 = arg_81_1:GetWordFromCfg(1105005023)
				local var_84_57 = arg_81_1:FormatText(var_84_56.content)

				arg_81_1.text_.text = var_84_57

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_58 = 15
				local var_84_59 = utf8.len(var_84_57)
				local var_84_60 = var_84_58 <= 0 and var_84_53 or var_84_53 * (var_84_59 / var_84_58)

				if var_84_60 > 0 and var_84_53 < var_84_60 then
					arg_81_1.talkMaxDuration = var_84_60
					var_84_52 = var_84_52 + 0.3

					if var_84_60 + var_84_52 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_60 + var_84_52
					end
				end

				arg_81_1.text_.text = var_84_57
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_61 = var_84_52 + 0.3
			local var_84_62 = math.max(var_84_53, arg_81_1.talkMaxDuration)

			if var_84_61 <= arg_81_1.time_ and arg_81_1.time_ < var_84_61 + var_84_62 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_61) / var_84_62

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_61 + var_84_62 and arg_81_1.time_ < var_84_61 + var_84_62 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "R5001a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R5001a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93266666666667,
				className = "StoryMoveNode",
				startTime = 2.06733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1105005024 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1105005024
		arg_87_1.duration_ = 1

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1105005025(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.075

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[74].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(1105005024)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 3
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005024", "story_v_side_new_1105005.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005024", "story_v_side_new_1105005.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_side_new_1105005", "1105005024", "story_v_side_new_1105005.awb")

						arg_87_1:RecordAudio("1105005024", var_90_9)
						arg_87_1:RecordAudio("1105005024", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005024", "story_v_side_new_1105005.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005024", "story_v_side_new_1105005.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1105005025 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1105005025
		arg_91_1.duration_ = 2.03

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1105005026(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.25

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[74].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(1105005025)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 10
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005025", "story_v_side_new_1105005.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005025", "story_v_side_new_1105005.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_side_new_1105005", "1105005025", "story_v_side_new_1105005.awb")

						arg_91_1:RecordAudio("1105005025", var_94_9)
						arg_91_1:RecordAudio("1105005025", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005025", "story_v_side_new_1105005.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005025", "story_v_side_new_1105005.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1105005026 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1105005026
		arg_95_1.duration_ = 9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1105005027(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 2

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				local var_98_1 = manager.ui.mainCamera.transform.localPosition
				local var_98_2 = Vector3.New(0, 0, 10) + Vector3.New(var_98_1.x, var_98_1.y, 0)
				local var_98_3 = arg_95_1.bgs_.ST12

				var_98_3.transform.localPosition = var_98_2
				var_98_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_4 = var_98_3:GetComponent("SpriteRenderer")

				if var_98_4 and var_98_4.sprite then
					local var_98_5 = (var_98_3.transform.localPosition - var_98_1).z
					local var_98_6 = manager.ui.mainCameraCom_
					local var_98_7 = 2 * var_98_5 * Mathf.Tan(var_98_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_8 = var_98_7 * var_98_6.aspect
					local var_98_9 = var_98_4.sprite.bounds.size.x
					local var_98_10 = var_98_4.sprite.bounds.size.y
					local var_98_11 = var_98_8 / var_98_9
					local var_98_12 = var_98_7 / var_98_10
					local var_98_13 = var_98_12 < var_98_11 and var_98_11 or var_98_12

					var_98_3.transform.localScale = Vector3.New(var_98_13, var_98_13, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST12" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_14 = 4

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			local var_98_15 = 0.3

			if arg_95_1.time_ >= var_98_14 + var_98_15 and arg_95_1.time_ < var_98_14 + var_98_15 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_17 = 2

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17
				local var_98_19 = Color.New(0, 0, 0)

				var_98_19.a = Mathf.Lerp(0, 1, var_98_18)
				arg_95_1.mask_.color = var_98_19
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				local var_98_20 = Color.New(0, 0, 0)

				var_98_20.a = 1
				arg_95_1.mask_.color = var_98_20
			end

			local var_98_21 = 2

			if var_98_21 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_22 = 2

			if var_98_21 <= arg_95_1.time_ and arg_95_1.time_ < var_98_21 + var_98_22 then
				local var_98_23 = (arg_95_1.time_ - var_98_21) / var_98_22
				local var_98_24 = Color.New(0, 0, 0)

				var_98_24.a = Mathf.Lerp(1, 0, var_98_23)
				arg_95_1.mask_.color = var_98_24
			end

			if arg_95_1.time_ >= var_98_21 + var_98_22 and arg_95_1.time_ < var_98_21 + var_98_22 + arg_98_0 then
				local var_98_25 = Color.New(0, 0, 0)
				local var_98_26 = 0

				arg_95_1.mask_.enabled = false
				var_98_25.a = var_98_26
				arg_95_1.mask_.color = var_98_25
			end

			local var_98_27 = 2

			arg_95_1.isInRecall_ = false

			if var_98_27 < arg_95_1.time_ and arg_95_1.time_ <= var_98_27 + arg_98_0 then
				arg_95_1.screenFilterGo_:SetActive(false)

				for iter_98_2, iter_98_3 in pairs(arg_95_1.actors_) do
					local var_98_28 = iter_98_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_98_4, iter_98_5 in ipairs(var_98_28) do
						if iter_98_5.color.r > 0.51 then
							iter_98_5.color = Color.New(1, 1, 1)
						else
							iter_98_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_98_29 = 0.1

			if var_98_27 <= arg_95_1.time_ and arg_95_1.time_ < var_98_27 + var_98_29 then
				local var_98_30 = (arg_95_1.time_ - var_98_27) / var_98_29

				arg_95_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_98_30)
			end

			if arg_95_1.time_ >= var_98_27 + var_98_29 and arg_95_1.time_ < var_98_27 + var_98_29 + arg_98_0 then
				arg_95_1.screenFilterEffect_.weight = 0
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_31 = 4
			local var_98_32 = 0.375

			if var_98_31 < arg_95_1.time_ and arg_95_1.time_ <= var_98_31 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_33 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_33:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_34 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_35 = arg_95_1:GetWordFromCfg(1105005026)
				local var_98_36 = arg_95_1:FormatText(var_98_35.content)

				arg_95_1.text_.text = var_98_36

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_37 = 15
				local var_98_38 = utf8.len(var_98_36)
				local var_98_39 = var_98_37 <= 0 and var_98_32 or var_98_32 * (var_98_38 / var_98_37)

				if var_98_39 > 0 and var_98_32 < var_98_39 then
					arg_95_1.talkMaxDuration = var_98_39
					var_98_31 = var_98_31 + 0.3

					if var_98_39 + var_98_31 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_39 + var_98_31
					end
				end

				arg_95_1.text_.text = var_98_36
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_40 = var_98_31 + 0.3
			local var_98_41 = math.max(var_98_32, arg_95_1.talkMaxDuration)

			if var_98_40 <= arg_95_1.time_ and arg_95_1.time_ < var_98_40 + var_98_41 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_40) / var_98_41

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_40 + var_98_41 and arg_95_1.time_ < var_98_40 + var_98_41 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1105005027 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1105005027
		arg_101_1.duration_ = 2.13

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1105005028(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1150ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1150ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -1.01, -6.2)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1150ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1150ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1150ui_story == nil then
				arg_101_1.var_.characterEffect1150ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1150ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1150ui_story then
				arg_101_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = 0
			local var_104_16 = 0.2

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[74].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(1105005027)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 8
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005027", "story_v_side_new_1105005.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005027", "story_v_side_new_1105005.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_side_new_1105005", "1105005027", "story_v_side_new_1105005.awb")

						arg_101_1:RecordAudio("1105005027", var_104_24)
						arg_101_1:RecordAudio("1105005027", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005027", "story_v_side_new_1105005.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005027", "story_v_side_new_1105005.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1105005028 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1105005028
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1105005029(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1150ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1150ui_story == nil then
				arg_105_1.var_.characterEffect1150ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1150ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1150ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1150ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1150ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.475

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(1105005028)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 19
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1105005029 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1105005029
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1105005030(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.025

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

				local var_112_2 = arg_109_1:GetWordFromCfg(1105005029)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 41
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
	Play1105005030 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1105005030
		arg_113_1.duration_ = 5.03

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1105005031(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1150ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1150ui_story == nil then
				arg_113_1.var_.characterEffect1150ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1150ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1150ui_story then
				arg_113_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_6 = 0
			local var_116_7 = 0.55

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[74].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_9 = arg_113_1:GetWordFromCfg(1105005030)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 22
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005030", "story_v_side_new_1105005.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005030", "story_v_side_new_1105005.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_side_new_1105005", "1105005030", "story_v_side_new_1105005.awb")

						arg_113_1:RecordAudio("1105005030", var_116_15)
						arg_113_1:RecordAudio("1105005030", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005030", "story_v_side_new_1105005.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005030", "story_v_side_new_1105005.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1105005031 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1105005031
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1105005032(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1150ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1150ui_story == nil then
				arg_117_1.var_.characterEffect1150ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1150ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1150ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1150ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1150ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.125

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(1105005031)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 5
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1105005032 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1105005032
		arg_121_1.duration_ = 3.6

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1105005033(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1150ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1150ui_story == nil then
				arg_121_1.var_.characterEffect1150ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1150ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1150ui_story then
				arg_121_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_124_4 = 0
			local var_124_5 = 0.3

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_6 = arg_121_1:FormatText(StoryNameCfg[74].name)

				arg_121_1.leftNameTxt_.text = var_124_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(1105005032)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 12
				local var_124_10 = utf8.len(var_124_8)
				local var_124_11 = var_124_9 <= 0 and var_124_5 or var_124_5 * (var_124_10 / var_124_9)

				if var_124_11 > 0 and var_124_5 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005032", "story_v_side_new_1105005.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005032", "story_v_side_new_1105005.awb") / 1000

					if var_124_12 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_4
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_side_new_1105005", "1105005032", "story_v_side_new_1105005.awb")

						arg_121_1:RecordAudio("1105005032", var_124_13)
						arg_121_1:RecordAudio("1105005032", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005032", "story_v_side_new_1105005.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005032", "story_v_side_new_1105005.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_14 and arg_121_1.time_ < var_124_4 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1105005033 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1105005033
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1105005034(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1150ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1150ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1150ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = 0
			local var_128_10 = 1.35

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_11 = arg_125_1:GetWordFromCfg(1105005033)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 54
				local var_128_14 = utf8.len(var_128_12)
				local var_128_15 = var_128_13 <= 0 and var_128_10 or var_128_10 * (var_128_14 / var_128_13)

				if var_128_15 > 0 and var_128_10 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_9) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_9 + var_128_16 and arg_125_1.time_ < var_128_9 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1105005034 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1105005034
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1105005035(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.725

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(1105005034)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 29
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
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1105005035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1105005035
		arg_133_1.duration_ = 1

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1105005036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1150ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1150ui_story == nil then
				arg_133_1.var_.characterEffect1150ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1150ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1150ui_story then
				arg_133_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["1150ui_story"].transform
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.var_.moveOldPos1150ui_story = var_136_4.localPosition
			end

			local var_136_6 = 0.001

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6
				local var_136_8 = Vector3.New(0, -1.01, -6.2)

				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1150ui_story, var_136_8, var_136_7)

				local var_136_9 = manager.ui.mainCamera.transform.position - var_136_4.position

				var_136_4.forward = Vector3.New(var_136_9.x, var_136_9.y, var_136_9.z)

				local var_136_10 = var_136_4.localEulerAngles

				var_136_10.z = 0
				var_136_10.x = 0
				var_136_4.localEulerAngles = var_136_10
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_136_11 = manager.ui.mainCamera.transform.position - var_136_4.position

				var_136_4.forward = Vector3.New(var_136_11.x, var_136_11.y, var_136_11.z)

				local var_136_12 = var_136_4.localEulerAngles

				var_136_12.z = 0
				var_136_12.x = 0
				var_136_4.localEulerAngles = var_136_12
			end

			local var_136_13 = 0
			local var_136_14 = 0.125

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_15 = arg_133_1:FormatText(StoryNameCfg[74].name)

				arg_133_1.leftNameTxt_.text = var_136_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_16 = arg_133_1:GetWordFromCfg(1105005035)
				local var_136_17 = arg_133_1:FormatText(var_136_16.content)

				arg_133_1.text_.text = var_136_17

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_18 = 5
				local var_136_19 = utf8.len(var_136_17)
				local var_136_20 = var_136_18 <= 0 and var_136_14 or var_136_14 * (var_136_19 / var_136_18)

				if var_136_20 > 0 and var_136_14 < var_136_20 then
					arg_133_1.talkMaxDuration = var_136_20

					if var_136_20 + var_136_13 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_13
					end
				end

				arg_133_1.text_.text = var_136_17
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005035", "story_v_side_new_1105005.awb") ~= 0 then
					local var_136_21 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005035", "story_v_side_new_1105005.awb") / 1000

					if var_136_21 + var_136_13 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_21 + var_136_13
					end

					if var_136_16.prefab_name ~= "" and arg_133_1.actors_[var_136_16.prefab_name] ~= nil then
						local var_136_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_16.prefab_name].transform, "story_v_side_new_1105005", "1105005035", "story_v_side_new_1105005.awb")

						arg_133_1:RecordAudio("1105005035", var_136_22)
						arg_133_1:RecordAudio("1105005035", var_136_22)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005035", "story_v_side_new_1105005.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005035", "story_v_side_new_1105005.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_23 = math.max(var_136_14, arg_133_1.talkMaxDuration)

			if var_136_13 <= arg_133_1.time_ and arg_133_1.time_ < var_136_13 + var_136_23 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_13) / var_136_23

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_13 + var_136_23 and arg_133_1.time_ < var_136_13 + var_136_23 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1105005036 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1105005036
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1105005037(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1150ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1150ui_story == nil then
				arg_137_1.var_.characterEffect1150ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1150ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1150ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1150ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1150ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.95

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(1105005036)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 38
				local var_140_11 = utf8.len(var_140_9)
				local var_140_12 = var_140_10 <= 0 and var_140_7 or var_140_7 * (var_140_11 / var_140_10)

				if var_140_12 > 0 and var_140_7 < var_140_12 then
					arg_137_1.talkMaxDuration = var_140_12

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_13 and arg_137_1.time_ < var_140_6 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1105005037 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1105005037
		arg_141_1.duration_ = 2.83

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1105005038(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1150ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1150ui_story == nil then
				arg_141_1.var_.characterEffect1150ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1150ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1150ui_story then
				arg_141_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_144_4 = 0
			local var_144_5 = 0.35

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_6 = arg_141_1:FormatText(StoryNameCfg[74].name)

				arg_141_1.leftNameTxt_.text = var_144_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(1105005037)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 14
				local var_144_10 = utf8.len(var_144_8)
				local var_144_11 = var_144_9 <= 0 and var_144_5 or var_144_5 * (var_144_10 / var_144_9)

				if var_144_11 > 0 and var_144_5 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005037", "story_v_side_new_1105005.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005037", "story_v_side_new_1105005.awb") / 1000

					if var_144_12 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_4
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_side_new_1105005", "1105005037", "story_v_side_new_1105005.awb")

						arg_141_1:RecordAudio("1105005037", var_144_13)
						arg_141_1:RecordAudio("1105005037", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005037", "story_v_side_new_1105005.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005037", "story_v_side_new_1105005.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_14 and arg_141_1.time_ < var_144_4 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1105005038 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1105005038
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1105005039(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1150ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1150ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1150ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = 0
			local var_148_10 = 0.825

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_11 = arg_145_1:GetWordFromCfg(1105005038)
				local var_148_12 = arg_145_1:FormatText(var_148_11.content)

				arg_145_1.text_.text = var_148_12

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 33
				local var_148_14 = utf8.len(var_148_12)
				local var_148_15 = var_148_13 <= 0 and var_148_10 or var_148_10 * (var_148_14 / var_148_13)

				if var_148_15 > 0 and var_148_10 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_9 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_9
					end
				end

				arg_145_1.text_.text = var_148_12
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_10, arg_145_1.talkMaxDuration)

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_9) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_9 + var_148_16 and arg_145_1.time_ < var_148_9 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play1105005039 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1105005039
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1105005040(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.25

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(1105005039)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 10
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
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1105005040 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1105005040
		arg_153_1.duration_ = 7

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1105005041(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = "ST01"

			if arg_153_1.bgs_[var_156_0] == nil then
				local var_156_1 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_156_0)
				var_156_1.name = var_156_0
				var_156_1.transform.parent = arg_153_1.stage_.transform
				var_156_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_[var_156_0] = var_156_1
			end

			local var_156_2 = 1

			if var_156_2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				local var_156_3 = manager.ui.mainCamera.transform.localPosition
				local var_156_4 = Vector3.New(0, 0, 10) + Vector3.New(var_156_3.x, var_156_3.y, 0)
				local var_156_5 = arg_153_1.bgs_.ST01

				var_156_5.transform.localPosition = var_156_4
				var_156_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_6 = var_156_5:GetComponent("SpriteRenderer")

				if var_156_6 and var_156_6.sprite then
					local var_156_7 = (var_156_5.transform.localPosition - var_156_3).z
					local var_156_8 = manager.ui.mainCameraCom_
					local var_156_9 = 2 * var_156_7 * Mathf.Tan(var_156_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_156_10 = var_156_9 * var_156_8.aspect
					local var_156_11 = var_156_6.sprite.bounds.size.x
					local var_156_12 = var_156_6.sprite.bounds.size.y
					local var_156_13 = var_156_10 / var_156_11
					local var_156_14 = var_156_9 / var_156_12
					local var_156_15 = var_156_14 < var_156_13 and var_156_13 or var_156_14

					var_156_5.transform.localScale = Vector3.New(var_156_15, var_156_15, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "ST01" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_16 = 2

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_17 = 0.466666666666667

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			local var_156_18 = 0

			if var_156_18 < arg_153_1.time_ and arg_153_1.time_ <= var_156_18 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_19 = 1

			if var_156_18 <= arg_153_1.time_ and arg_153_1.time_ < var_156_18 + var_156_19 then
				local var_156_20 = (arg_153_1.time_ - var_156_18) / var_156_19
				local var_156_21 = Color.New(0, 0, 0)

				var_156_21.a = Mathf.Lerp(0, 1, var_156_20)
				arg_153_1.mask_.color = var_156_21
			end

			if arg_153_1.time_ >= var_156_18 + var_156_19 and arg_153_1.time_ < var_156_18 + var_156_19 + arg_156_0 then
				local var_156_22 = Color.New(0, 0, 0)

				var_156_22.a = 1
				arg_153_1.mask_.color = var_156_22
			end

			local var_156_23 = 1

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_24 = 1

			if var_156_23 <= arg_153_1.time_ and arg_153_1.time_ < var_156_23 + var_156_24 then
				local var_156_25 = (arg_153_1.time_ - var_156_23) / var_156_24
				local var_156_26 = Color.New(0, 0, 0)

				var_156_26.a = Mathf.Lerp(1, 0, var_156_25)
				arg_153_1.mask_.color = var_156_26
			end

			if arg_153_1.time_ >= var_156_23 + var_156_24 and arg_153_1.time_ < var_156_23 + var_156_24 + arg_156_0 then
				local var_156_27 = Color.New(0, 0, 0)
				local var_156_28 = 0

				arg_153_1.mask_.enabled = false
				var_156_27.a = var_156_28
				arg_153_1.mask_.color = var_156_27
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_29 = 2
			local var_156_30 = 1.225

			if var_156_29 < arg_153_1.time_ and arg_153_1.time_ <= var_156_29 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_31 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_31:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_32 = arg_153_1:GetWordFromCfg(1105005040)
				local var_156_33 = arg_153_1:FormatText(var_156_32.content)

				arg_153_1.text_.text = var_156_33

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_34 = 49
				local var_156_35 = utf8.len(var_156_33)
				local var_156_36 = var_156_34 <= 0 and var_156_30 or var_156_30 * (var_156_35 / var_156_34)

				if var_156_36 > 0 and var_156_30 < var_156_36 then
					arg_153_1.talkMaxDuration = var_156_36
					var_156_29 = var_156_29 + 0.3

					if var_156_36 + var_156_29 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_36 + var_156_29
					end
				end

				arg_153_1.text_.text = var_156_33
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_37 = var_156_29 + 0.3
			local var_156_38 = math.max(var_156_30, arg_153_1.talkMaxDuration)

			if var_156_37 <= arg_153_1.time_ and arg_153_1.time_ < var_156_37 + var_156_38 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_37) / var_156_38

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_37 + var_156_38 and arg_153_1.time_ < var_156_37 + var_156_38 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1105005041 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1105005041
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1105005042(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.55

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(1105005041)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 22
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1105005042 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1105005042
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1105005043(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.7

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(1105005042)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 28
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
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1105005043 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1105005043
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1105005044(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.6

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(1105005043)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 64
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1105005044 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1105005044
		arg_171_1.duration_ = 2

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1105005045(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1150ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1150ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -1.01, -6.2)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1150ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1150ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1150ui_story == nil then
				arg_171_1.var_.characterEffect1150ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect1150ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1150ui_story then
				arg_171_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_174_15 = 0
			local var_174_16 = 0.2

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[74].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(1105005044)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 8
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005044", "story_v_side_new_1105005.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005044", "story_v_side_new_1105005.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_side_new_1105005", "1105005044", "story_v_side_new_1105005.awb")

						arg_171_1:RecordAudio("1105005044", var_174_24)
						arg_171_1:RecordAudio("1105005044", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005044", "story_v_side_new_1105005.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005044", "story_v_side_new_1105005.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play1105005045 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1105005045
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1105005046(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1150ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1150ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1150ui_story, var_178_4, var_178_3)

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
			local var_178_10 = 1.3

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

				local var_178_11 = arg_175_1:GetWordFromCfg(1105005045)
				local var_178_12 = arg_175_1:FormatText(var_178_11.content)

				arg_175_1.text_.text = var_178_12

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 52
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
				actorName = "1150ui_story",
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
	Play1105005046 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1105005046
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1105005047(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.15

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(1105005046)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 6
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
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1105005047 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1105005047
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1105005048(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 3.26666666666667
			local var_186_1 = 1

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				local var_186_2 = "play"
				local var_186_3 = "effect"

				arg_183_1:AudioAction(var_186_2, var_186_3, "se_story_side_1050", "se_story_side_1050_whip", "")
			end

			local var_186_4 = 0
			local var_186_5 = 1.3

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(1105005047)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 52
				local var_186_9 = utf8.len(var_186_7)
				local var_186_10 = var_186_8 <= 0 and var_186_5 or var_186_5 * (var_186_9 / var_186_8)

				if var_186_10 > 0 and var_186_5 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_11 and arg_183_1.time_ < var_186_4 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1105005048 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1105005048
		arg_187_1.duration_ = 6

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1105005049(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = manager.ui.mainCamera.transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.shakeOldPos = var_190_0.localPosition
			end

			local var_190_2 = 0.833333333333333

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / 0.066
				local var_190_4, var_190_5 = math.modf(var_190_3)

				var_190_0.localPosition = Vector3.New(var_190_5 * 0.13, var_190_5 * 0.13, var_190_5 * 0.13) + arg_187_1.var_.shakeOldPos
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = arg_187_1.var_.shakeOldPos
			end

			local var_190_6 = 0

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_7 = 1

			if arg_187_1.time_ >= var_190_6 + var_190_7 and arg_187_1.time_ < var_190_6 + var_190_7 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_8 = 1
			local var_190_9 = 1.55

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_10 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_10:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_11 = arg_187_1:GetWordFromCfg(1105005048)
				local var_190_12 = arg_187_1:FormatText(var_190_11.content)

				arg_187_1.text_.text = var_190_12

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 62
				local var_190_14 = utf8.len(var_190_12)
				local var_190_15 = var_190_13 <= 0 and var_190_9 or var_190_9 * (var_190_14 / var_190_13)

				if var_190_15 > 0 and var_190_9 < var_190_15 then
					arg_187_1.talkMaxDuration = var_190_15
					var_190_8 = var_190_8 + 0.3

					if var_190_15 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_15 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_12
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = var_190_8 + 0.3
			local var_190_17 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_16) / var_190_17

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1105005049 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1105005049
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1105005050(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1150ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1150ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -1.01, -6.2)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1150ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1150ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1150ui_story == nil then
				arg_193_1.var_.characterEffect1150ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1150ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1150ui_story then
				arg_193_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			local var_196_15 = 0
			local var_196_16 = 0.125

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[74].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(1105005049)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005049", "story_v_side_new_1105005.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005049", "story_v_side_new_1105005.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_side_new_1105005", "1105005049", "story_v_side_new_1105005.awb")

						arg_193_1:RecordAudio("1105005049", var_196_24)
						arg_193_1:RecordAudio("1105005049", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005049", "story_v_side_new_1105005.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005049", "story_v_side_new_1105005.awb")
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
				actorName = "1150ui_story",
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
	Play1105005050 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1105005050
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1105005051(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1150ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1150ui_story == nil then
				arg_197_1.var_.characterEffect1150ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1150ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1150ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1150ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1150ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.275

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_9 = arg_197_1:GetWordFromCfg(1105005050)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 11
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1105005051 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1105005051
		arg_201_1.duration_ = 3.1

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1105005052(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1150ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1150ui_story == nil then
				arg_201_1.var_.characterEffect1150ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1150ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1150ui_story then
				arg_201_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_204_4 = 0

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_2")
			end

			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_204_6 = 0
			local var_204_7 = 0.175

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[74].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_9 = arg_201_1:GetWordFromCfg(1105005051)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 7
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005051", "story_v_side_new_1105005.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005051", "story_v_side_new_1105005.awb") / 1000

					if var_204_14 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_6
					end

					if var_204_9.prefab_name ~= "" and arg_201_1.actors_[var_204_9.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_9.prefab_name].transform, "story_v_side_new_1105005", "1105005051", "story_v_side_new_1105005.awb")

						arg_201_1:RecordAudio("1105005051", var_204_15)
						arg_201_1:RecordAudio("1105005051", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005051", "story_v_side_new_1105005.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005051", "story_v_side_new_1105005.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_16 and arg_201_1.time_ < var_204_6 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1105005052 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1105005052
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1105005053(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1150ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1150ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 100, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1150ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 100, 0)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = 0
			local var_208_10 = 1.25

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_11 = arg_205_1:GetWordFromCfg(1105005052)
				local var_208_12 = arg_205_1:FormatText(var_208_11.content)

				arg_205_1.text_.text = var_208_12

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 50
				local var_208_14 = utf8.len(var_208_12)
				local var_208_15 = var_208_13 <= 0 and var_208_10 or var_208_10 * (var_208_14 / var_208_13)

				if var_208_15 > 0 and var_208_10 < var_208_15 then
					arg_205_1.talkMaxDuration = var_208_15

					if var_208_15 + var_208_9 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_15 + var_208_9
					end
				end

				arg_205_1.text_.text = var_208_12
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_10, arg_205_1.talkMaxDuration)

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_9) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_9 + var_208_16 and arg_205_1.time_ < var_208_9 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play1105005053 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1105005053
		arg_209_1.duration_ = 2.7

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1105005054(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1150ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1150ui_story == nil then
				arg_209_1.var_.characterEffect1150ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1150ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1150ui_story then
				arg_209_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_212_4 = 0

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_212_6 = arg_209_1.actors_["1150ui_story"].transform
			local var_212_7 = 0

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.var_.moveOldPos1150ui_story = var_212_6.localPosition
			end

			local var_212_8 = 0.001

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_8 then
				local var_212_9 = (arg_209_1.time_ - var_212_7) / var_212_8
				local var_212_10 = Vector3.New(0, -1.01, -6.2)

				var_212_6.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1150ui_story, var_212_10, var_212_9)

				local var_212_11 = manager.ui.mainCamera.transform.position - var_212_6.position

				var_212_6.forward = Vector3.New(var_212_11.x, var_212_11.y, var_212_11.z)

				local var_212_12 = var_212_6.localEulerAngles

				var_212_12.z = 0
				var_212_12.x = 0
				var_212_6.localEulerAngles = var_212_12
			end

			if arg_209_1.time_ >= var_212_7 + var_212_8 and arg_209_1.time_ < var_212_7 + var_212_8 + arg_212_0 then
				var_212_6.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_212_13 = manager.ui.mainCamera.transform.position - var_212_6.position

				var_212_6.forward = Vector3.New(var_212_13.x, var_212_13.y, var_212_13.z)

				local var_212_14 = var_212_6.localEulerAngles

				var_212_14.z = 0
				var_212_14.x = 0
				var_212_6.localEulerAngles = var_212_14
			end

			local var_212_15 = 0
			local var_212_16 = 0.225

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_17 = arg_209_1:FormatText(StoryNameCfg[74].name)

				arg_209_1.leftNameTxt_.text = var_212_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(1105005053)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 9
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_16 or var_212_16 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_16 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005053", "story_v_side_new_1105005.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005053", "story_v_side_new_1105005.awb") / 1000

					if var_212_23 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_15
					end

					if var_212_18.prefab_name ~= "" and arg_209_1.actors_[var_212_18.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_18.prefab_name].transform, "story_v_side_new_1105005", "1105005053", "story_v_side_new_1105005.awb")

						arg_209_1:RecordAudio("1105005053", var_212_24)
						arg_209_1:RecordAudio("1105005053", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005053", "story_v_side_new_1105005.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005053", "story_v_side_new_1105005.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_25 and arg_209_1.time_ < var_212_15 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play1105005054 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1105005054
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1105005055(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1150ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1150ui_story == nil then
				arg_213_1.var_.characterEffect1150ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1150ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1150ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1150ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1150ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.35

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(1105005054)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 14
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1105005055 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1105005055
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1105005056(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1150ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1150ui_story == nil then
				arg_217_1.var_.characterEffect1150ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1150ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1150ui_story then
				arg_217_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_220_4 = 0

			if var_220_4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_220_5 = 0

			if var_220_5 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_220_6 = arg_217_1.actors_["1150ui_story"].transform
			local var_220_7 = 0

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 then
				arg_217_1.var_.moveOldPos1150ui_story = var_220_6.localPosition
			end

			local var_220_8 = 0.001

			if var_220_7 <= arg_217_1.time_ and arg_217_1.time_ < var_220_7 + var_220_8 then
				local var_220_9 = (arg_217_1.time_ - var_220_7) / var_220_8
				local var_220_10 = Vector3.New(0, -1.01, -6.2)

				var_220_6.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1150ui_story, var_220_10, var_220_9)

				local var_220_11 = manager.ui.mainCamera.transform.position - var_220_6.position

				var_220_6.forward = Vector3.New(var_220_11.x, var_220_11.y, var_220_11.z)

				local var_220_12 = var_220_6.localEulerAngles

				var_220_12.z = 0
				var_220_12.x = 0
				var_220_6.localEulerAngles = var_220_12
			end

			if arg_217_1.time_ >= var_220_7 + var_220_8 and arg_217_1.time_ < var_220_7 + var_220_8 + arg_220_0 then
				var_220_6.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_220_13 = manager.ui.mainCamera.transform.position - var_220_6.position

				var_220_6.forward = Vector3.New(var_220_13.x, var_220_13.y, var_220_13.z)

				local var_220_14 = var_220_6.localEulerAngles

				var_220_14.z = 0
				var_220_14.x = 0
				var_220_6.localEulerAngles = var_220_14
			end

			local var_220_15 = 0
			local var_220_16 = 0.2

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[74].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(1105005055)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 8
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005055", "story_v_side_new_1105005.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005055", "story_v_side_new_1105005.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_side_new_1105005", "1105005055", "story_v_side_new_1105005.awb")

						arg_217_1:RecordAudio("1105005055", var_220_24)
						arg_217_1:RecordAudio("1105005055", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005055", "story_v_side_new_1105005.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005055", "story_v_side_new_1105005.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play1105005056 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1105005056
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1105005057(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1150ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1150ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1150ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = 0
			local var_224_10 = 1.825

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_11 = arg_221_1:GetWordFromCfg(1105005056)
				local var_224_12 = arg_221_1:FormatText(var_224_11.content)

				arg_221_1.text_.text = var_224_12

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 73
				local var_224_14 = utf8.len(var_224_12)
				local var_224_15 = var_224_13 <= 0 and var_224_10 or var_224_10 * (var_224_14 / var_224_13)

				if var_224_15 > 0 and var_224_10 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_9 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_9
					end
				end

				arg_221_1.text_.text = var_224_12
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_10, arg_221_1.talkMaxDuration)

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_9) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_9 + var_224_16 and arg_221_1.time_ < var_224_9 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1105005057 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1105005057
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1105005058(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.75

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

				local var_228_2 = arg_225_1:GetWordFromCfg(1105005057)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 70
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
	Play1105005058 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1105005058
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1105005059(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.15

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(1105005058)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 6
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
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1105005059 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1105005059
		arg_233_1.duration_ = 3.93

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1105005060(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1150ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1150ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, -1.01, -6.2)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1150ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1150ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1150ui_story == nil then
				arg_233_1.var_.characterEffect1150ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect1150ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1150ui_story then
				arg_233_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_236_15 = 0
			local var_236_16 = 0.275

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_17 = arg_233_1:FormatText(StoryNameCfg[74].name)

				arg_233_1.leftNameTxt_.text = var_236_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_18 = arg_233_1:GetWordFromCfg(1105005059)
				local var_236_19 = arg_233_1:FormatText(var_236_18.content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_20 = 11
				local var_236_21 = utf8.len(var_236_19)
				local var_236_22 = var_236_20 <= 0 and var_236_16 or var_236_16 * (var_236_21 / var_236_20)

				if var_236_22 > 0 and var_236_16 < var_236_22 then
					arg_233_1.talkMaxDuration = var_236_22

					if var_236_22 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_15
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005059", "story_v_side_new_1105005.awb") ~= 0 then
					local var_236_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005059", "story_v_side_new_1105005.awb") / 1000

					if var_236_23 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_15
					end

					if var_236_18.prefab_name ~= "" and arg_233_1.actors_[var_236_18.prefab_name] ~= nil then
						local var_236_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_18.prefab_name].transform, "story_v_side_new_1105005", "1105005059", "story_v_side_new_1105005.awb")

						arg_233_1:RecordAudio("1105005059", var_236_24)
						arg_233_1:RecordAudio("1105005059", var_236_24)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005059", "story_v_side_new_1105005.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005059", "story_v_side_new_1105005.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_25 = math.max(var_236_16, arg_233_1.talkMaxDuration)

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_25 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_15) / var_236_25

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_15 + var_236_25 and arg_233_1.time_ < var_236_15 + var_236_25 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play1105005060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1105005060
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1105005061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1150ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1150ui_story == nil then
				arg_237_1.var_.characterEffect1150ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1150ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1150ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1150ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1150ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.725

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(1105005060)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 29
				local var_240_11 = utf8.len(var_240_9)
				local var_240_12 = var_240_10 <= 0 and var_240_7 or var_240_7 * (var_240_11 / var_240_10)

				if var_240_12 > 0 and var_240_7 < var_240_12 then
					arg_237_1.talkMaxDuration = var_240_12

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_13 and arg_237_1.time_ < var_240_6 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1105005061 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1105005061
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1105005062(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.2

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

				local var_244_3 = arg_241_1:GetWordFromCfg(1105005061)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 8
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
	Play1105005062 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1105005062
		arg_245_1.duration_ = 3.43

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1105005063(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1150ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1150ui_story == nil then
				arg_245_1.var_.characterEffect1150ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1150ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1150ui_story then
				arg_245_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_248_4 = 0
			local var_248_5 = 0.3

			if var_248_4 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_6 = arg_245_1:FormatText(StoryNameCfg[74].name)

				arg_245_1.leftNameTxt_.text = var_248_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_7 = arg_245_1:GetWordFromCfg(1105005062)
				local var_248_8 = arg_245_1:FormatText(var_248_7.content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 12
				local var_248_10 = utf8.len(var_248_8)
				local var_248_11 = var_248_9 <= 0 and var_248_5 or var_248_5 * (var_248_10 / var_248_9)

				if var_248_11 > 0 and var_248_5 < var_248_11 then
					arg_245_1.talkMaxDuration = var_248_11

					if var_248_11 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005062", "story_v_side_new_1105005.awb") ~= 0 then
					local var_248_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005062", "story_v_side_new_1105005.awb") / 1000

					if var_248_12 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_4
					end

					if var_248_7.prefab_name ~= "" and arg_245_1.actors_[var_248_7.prefab_name] ~= nil then
						local var_248_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_7.prefab_name].transform, "story_v_side_new_1105005", "1105005062", "story_v_side_new_1105005.awb")

						arg_245_1:RecordAudio("1105005062", var_248_13)
						arg_245_1:RecordAudio("1105005062", var_248_13)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005062", "story_v_side_new_1105005.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005062", "story_v_side_new_1105005.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_14 and arg_245_1.time_ < var_248_4 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1105005063 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1105005063
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1105005064(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1150ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1150ui_story == nil then
				arg_249_1.var_.characterEffect1150ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1150ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1150ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1150ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1150ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 0.475

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_9 = arg_249_1:GetWordFromCfg(1105005063)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 19
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1105005064 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1105005064
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1105005065(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1150ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1150ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, 100, 0)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1150ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, 100, 0)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = 0
			local var_256_10 = 1.325

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_11 = arg_253_1:GetWordFromCfg(1105005064)
				local var_256_12 = arg_253_1:FormatText(var_256_11.content)

				arg_253_1.text_.text = var_256_12

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 53
				local var_256_14 = utf8.len(var_256_12)
				local var_256_15 = var_256_13 <= 0 and var_256_10 or var_256_10 * (var_256_14 / var_256_13)

				if var_256_15 > 0 and var_256_10 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15

					if var_256_15 + var_256_9 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_9
					end
				end

				arg_253_1.text_.text = var_256_12
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_10, arg_253_1.talkMaxDuration)

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_9) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_9 + var_256_16 and arg_253_1.time_ < var_256_9 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play1105005065 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1105005065
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1105005066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.925

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

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(1105005065)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 37
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
	Play1105005066 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1105005066
		arg_261_1.duration_ = 2.93

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1105005067(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1150ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1150ui_story == nil then
				arg_261_1.var_.characterEffect1150ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1150ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1150ui_story then
				arg_261_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_264_5 = arg_261_1.actors_["1150ui_story"].transform
			local var_264_6 = 0

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.var_.moveOldPos1150ui_story = var_264_5.localPosition
			end

			local var_264_7 = 0.001

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_7 then
				local var_264_8 = (arg_261_1.time_ - var_264_6) / var_264_7
				local var_264_9 = Vector3.New(0, -1.01, -6.2)

				var_264_5.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1150ui_story, var_264_9, var_264_8)

				local var_264_10 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_10.x, var_264_10.y, var_264_10.z)

				local var_264_11 = var_264_5.localEulerAngles

				var_264_11.z = 0
				var_264_11.x = 0
				var_264_5.localEulerAngles = var_264_11
			end

			if arg_261_1.time_ >= var_264_6 + var_264_7 and arg_261_1.time_ < var_264_6 + var_264_7 + arg_264_0 then
				var_264_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_264_12 = manager.ui.mainCamera.transform.position - var_264_5.position

				var_264_5.forward = Vector3.New(var_264_12.x, var_264_12.y, var_264_12.z)

				local var_264_13 = var_264_5.localEulerAngles

				var_264_13.z = 0
				var_264_13.x = 0
				var_264_5.localEulerAngles = var_264_13
			end

			local var_264_14 = 0
			local var_264_15 = 0.175

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_16 = arg_261_1:FormatText(StoryNameCfg[74].name)

				arg_261_1.leftNameTxt_.text = var_264_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_17 = arg_261_1:GetWordFromCfg(1105005066)
				local var_264_18 = arg_261_1:FormatText(var_264_17.content)

				arg_261_1.text_.text = var_264_18

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_19 = 7
				local var_264_20 = utf8.len(var_264_18)
				local var_264_21 = var_264_19 <= 0 and var_264_15 or var_264_15 * (var_264_20 / var_264_19)

				if var_264_21 > 0 and var_264_15 < var_264_21 then
					arg_261_1.talkMaxDuration = var_264_21

					if var_264_21 + var_264_14 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_21 + var_264_14
					end
				end

				arg_261_1.text_.text = var_264_18
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005066", "story_v_side_new_1105005.awb") ~= 0 then
					local var_264_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005066", "story_v_side_new_1105005.awb") / 1000

					if var_264_22 + var_264_14 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_14
					end

					if var_264_17.prefab_name ~= "" and arg_261_1.actors_[var_264_17.prefab_name] ~= nil then
						local var_264_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_17.prefab_name].transform, "story_v_side_new_1105005", "1105005066", "story_v_side_new_1105005.awb")

						arg_261_1:RecordAudio("1105005066", var_264_23)
						arg_261_1:RecordAudio("1105005066", var_264_23)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005066", "story_v_side_new_1105005.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005066", "story_v_side_new_1105005.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_24 = math.max(var_264_15, arg_261_1.talkMaxDuration)

			if var_264_14 <= arg_261_1.time_ and arg_261_1.time_ < var_264_14 + var_264_24 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_14) / var_264_24

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_14 + var_264_24 and arg_261_1.time_ < var_264_14 + var_264_24 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1105005067 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1105005067
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1105005068(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1150ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1150ui_story == nil then
				arg_265_1.var_.characterEffect1150ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1150ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1150ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1150ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1150ui_story.fillRatio = var_268_5
			end

			local var_268_6 = arg_265_1.actors_["1150ui_story"].transform
			local var_268_7 = 0

			if var_268_7 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.var_.moveOldPos1150ui_story = var_268_6.localPosition
			end

			local var_268_8 = 0.001

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_8 then
				local var_268_9 = (arg_265_1.time_ - var_268_7) / var_268_8
				local var_268_10 = Vector3.New(0, 100, 0)

				var_268_6.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1150ui_story, var_268_10, var_268_9)

				local var_268_11 = manager.ui.mainCamera.transform.position - var_268_6.position

				var_268_6.forward = Vector3.New(var_268_11.x, var_268_11.y, var_268_11.z)

				local var_268_12 = var_268_6.localEulerAngles

				var_268_12.z = 0
				var_268_12.x = 0
				var_268_6.localEulerAngles = var_268_12
			end

			if arg_265_1.time_ >= var_268_7 + var_268_8 and arg_265_1.time_ < var_268_7 + var_268_8 + arg_268_0 then
				var_268_6.localPosition = Vector3.New(0, 100, 0)

				local var_268_13 = manager.ui.mainCamera.transform.position - var_268_6.position

				var_268_6.forward = Vector3.New(var_268_13.x, var_268_13.y, var_268_13.z)

				local var_268_14 = var_268_6.localEulerAngles

				var_268_14.z = 0
				var_268_14.x = 0
				var_268_6.localEulerAngles = var_268_14
			end

			local var_268_15 = 0
			local var_268_16 = 1.35

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_17 = arg_265_1:GetWordFromCfg(1105005067)
				local var_268_18 = arg_265_1:FormatText(var_268_17.content)

				arg_265_1.text_.text = var_268_18

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_19 = 54
				local var_268_20 = utf8.len(var_268_18)
				local var_268_21 = var_268_19 <= 0 and var_268_16 or var_268_16 * (var_268_20 / var_268_19)

				if var_268_21 > 0 and var_268_16 < var_268_21 then
					arg_265_1.talkMaxDuration = var_268_21

					if var_268_21 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_21 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_18
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_22 and arg_265_1.time_ < var_268_15 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1105005068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1105005068
		arg_269_1.duration_ = 9.63

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1105005069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1150ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1150ui_story == nil then
				arg_269_1.var_.characterEffect1150ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1150ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1150ui_story then
				arg_269_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_272_5 = arg_269_1.actors_["1150ui_story"].transform
			local var_272_6 = 0

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.var_.moveOldPos1150ui_story = var_272_5.localPosition

				local var_272_7 = "1150ui_story"

				arg_269_1:ShowWeapon(arg_269_1.var_[var_272_7 .. "Animator"].transform, false)
			end

			local var_272_8 = 0.001

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_8 then
				local var_272_9 = (arg_269_1.time_ - var_272_6) / var_272_8
				local var_272_10 = Vector3.New(0, -1.01, -6.2)

				var_272_5.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1150ui_story, var_272_10, var_272_9)

				local var_272_11 = manager.ui.mainCamera.transform.position - var_272_5.position

				var_272_5.forward = Vector3.New(var_272_11.x, var_272_11.y, var_272_11.z)

				local var_272_12 = var_272_5.localEulerAngles

				var_272_12.z = 0
				var_272_12.x = 0
				var_272_5.localEulerAngles = var_272_12
			end

			if arg_269_1.time_ >= var_272_6 + var_272_8 and arg_269_1.time_ < var_272_6 + var_272_8 + arg_272_0 then
				var_272_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_272_13 = manager.ui.mainCamera.transform.position - var_272_5.position

				var_272_5.forward = Vector3.New(var_272_13.x, var_272_13.y, var_272_13.z)

				local var_272_14 = var_272_5.localEulerAngles

				var_272_14.z = 0
				var_272_14.x = 0
				var_272_5.localEulerAngles = var_272_14
			end

			local var_272_15 = 0
			local var_272_16 = 1.125

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[74].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(1105005068)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 45
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005068", "story_v_side_new_1105005.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005068", "story_v_side_new_1105005.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_side_new_1105005", "1105005068", "story_v_side_new_1105005.awb")

						arg_269_1:RecordAudio("1105005068", var_272_24)
						arg_269_1:RecordAudio("1105005068", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005068", "story_v_side_new_1105005.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005068", "story_v_side_new_1105005.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1105005069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1105005069
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1105005070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1150ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1150ui_story == nil then
				arg_273_1.var_.characterEffect1150ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1150ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1150ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1150ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1150ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.2

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(1105005069)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 8
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1105005070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1105005070
		arg_277_1.duration_ = 9.8

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1105005071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1150ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1150ui_story == nil then
				arg_277_1.var_.characterEffect1150ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1150ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1150ui_story then
				arg_277_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_280_4 = 0
			local var_280_5 = 0.95

			if var_280_4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_6 = arg_277_1:FormatText(StoryNameCfg[74].name)

				arg_277_1.leftNameTxt_.text = var_280_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(1105005070)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 34
				local var_280_10 = utf8.len(var_280_8)
				local var_280_11 = var_280_9 <= 0 and var_280_5 or var_280_5 * (var_280_10 / var_280_9)

				if var_280_11 > 0 and var_280_5 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005070", "story_v_side_new_1105005.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005070", "story_v_side_new_1105005.awb") / 1000

					if var_280_12 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_4
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_side_new_1105005", "1105005070", "story_v_side_new_1105005.awb")

						arg_277_1:RecordAudio("1105005070", var_280_13)
						arg_277_1:RecordAudio("1105005070", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005070", "story_v_side_new_1105005.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005070", "story_v_side_new_1105005.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_14 and arg_277_1.time_ < var_280_4 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1105005071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1105005071
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1105005072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1150ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1150ui_story == nil then
				arg_281_1.var_.characterEffect1150ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1150ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1150ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1150ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1150ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 1

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

				local var_284_9 = arg_281_1:GetWordFromCfg(1105005071)
				local var_284_10 = arg_281_1:FormatText(var_284_9.content)

				arg_281_1.text_.text = var_284_10

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 40
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
	Play1105005072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1105005072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1105005073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.725

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(1105005072)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 29
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1105005073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1105005073
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1105005074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.825

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(1105005073)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 33
				local var_292_5 = utf8.len(var_292_3)
				local var_292_6 = var_292_4 <= 0 and var_292_1 or var_292_1 * (var_292_5 / var_292_4)

				if var_292_6 > 0 and var_292_1 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_7 and arg_289_1.time_ < var_292_0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1105005074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1105005074
		arg_293_1.duration_ = 2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1105005075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_296_2 = arg_293_1.actors_["1150ui_story"]
			local var_296_3 = 0

			if var_296_3 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect1150ui_story == nil then
				arg_293_1.var_.characterEffect1150ui_story = var_296_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_4 = 0.200000002980232

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_4 and not isNil(var_296_2) then
				local var_296_5 = (arg_293_1.time_ - var_296_3) / var_296_4

				if arg_293_1.var_.characterEffect1150ui_story and not isNil(var_296_2) then
					arg_293_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_3 + var_296_4 and arg_293_1.time_ < var_296_3 + var_296_4 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect1150ui_story then
				arg_293_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_296_6 = 0
			local var_296_7 = 0.275

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[74].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_9 = arg_293_1:GetWordFromCfg(1105005074)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005074", "story_v_side_new_1105005.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005074", "story_v_side_new_1105005.awb") / 1000

					if var_296_14 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_6
					end

					if var_296_9.prefab_name ~= "" and arg_293_1.actors_[var_296_9.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_9.prefab_name].transform, "story_v_side_new_1105005", "1105005074", "story_v_side_new_1105005.awb")

						arg_293_1:RecordAudio("1105005074", var_296_15)
						arg_293_1:RecordAudio("1105005074", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005074", "story_v_side_new_1105005.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005074", "story_v_side_new_1105005.awb")
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
	Play1105005075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1105005075
		arg_297_1.duration_ = 9

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1105005076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 2

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				local var_300_1 = manager.ui.mainCamera.transform.localPosition
				local var_300_2 = Vector3.New(0, 0, 10) + Vector3.New(var_300_1.x, var_300_1.y, 0)
				local var_300_3 = arg_297_1.bgs_.ST01

				var_300_3.transform.localPosition = var_300_2
				var_300_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_4 = var_300_3:GetComponent("SpriteRenderer")

				if var_300_4 and var_300_4.sprite then
					local var_300_5 = (var_300_3.transform.localPosition - var_300_1).z
					local var_300_6 = manager.ui.mainCameraCom_
					local var_300_7 = 2 * var_300_5 * Mathf.Tan(var_300_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_300_8 = var_300_7 * var_300_6.aspect
					local var_300_9 = var_300_4.sprite.bounds.size.x
					local var_300_10 = var_300_4.sprite.bounds.size.y
					local var_300_11 = var_300_8 / var_300_9
					local var_300_12 = var_300_7 / var_300_10
					local var_300_13 = var_300_12 < var_300_11 and var_300_11 or var_300_12

					var_300_3.transform.localScale = Vector3.New(var_300_13, var_300_13, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "ST01" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_14 = 4

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			local var_300_15 = 0.3

			if arg_297_1.time_ >= var_300_14 + var_300_15 and arg_297_1.time_ < var_300_14 + var_300_15 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_17 = 2

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17
				local var_300_19 = Color.New(0, 0, 0)

				var_300_19.a = Mathf.Lerp(0, 1, var_300_18)
				arg_297_1.mask_.color = var_300_19
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 then
				local var_300_20 = Color.New(0, 0, 0)

				var_300_20.a = 1
				arg_297_1.mask_.color = var_300_20
			end

			local var_300_21 = 2

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_22 = 2

			if var_300_21 <= arg_297_1.time_ and arg_297_1.time_ < var_300_21 + var_300_22 then
				local var_300_23 = (arg_297_1.time_ - var_300_21) / var_300_22
				local var_300_24 = Color.New(0, 0, 0)

				var_300_24.a = Mathf.Lerp(1, 0, var_300_23)
				arg_297_1.mask_.color = var_300_24
			end

			if arg_297_1.time_ >= var_300_21 + var_300_22 and arg_297_1.time_ < var_300_21 + var_300_22 + arg_300_0 then
				local var_300_25 = Color.New(0, 0, 0)
				local var_300_26 = 0

				arg_297_1.mask_.enabled = false
				var_300_25.a = var_300_26
				arg_297_1.mask_.color = var_300_25
			end

			local var_300_27 = arg_297_1.actors_["1150ui_story"].transform
			local var_300_28 = 1.96599999815226

			if var_300_28 < arg_297_1.time_ and arg_297_1.time_ <= var_300_28 + arg_300_0 then
				arg_297_1.var_.moveOldPos1150ui_story = var_300_27.localPosition
			end

			local var_300_29 = 0.001

			if var_300_28 <= arg_297_1.time_ and arg_297_1.time_ < var_300_28 + var_300_29 then
				local var_300_30 = (arg_297_1.time_ - var_300_28) / var_300_29
				local var_300_31 = Vector3.New(0, 100, 0)

				var_300_27.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1150ui_story, var_300_31, var_300_30)

				local var_300_32 = manager.ui.mainCamera.transform.position - var_300_27.position

				var_300_27.forward = Vector3.New(var_300_32.x, var_300_32.y, var_300_32.z)

				local var_300_33 = var_300_27.localEulerAngles

				var_300_33.z = 0
				var_300_33.x = 0
				var_300_27.localEulerAngles = var_300_33
			end

			if arg_297_1.time_ >= var_300_28 + var_300_29 and arg_297_1.time_ < var_300_28 + var_300_29 + arg_300_0 then
				var_300_27.localPosition = Vector3.New(0, 100, 0)

				local var_300_34 = manager.ui.mainCamera.transform.position - var_300_27.position

				var_300_27.forward = Vector3.New(var_300_34.x, var_300_34.y, var_300_34.z)

				local var_300_35 = var_300_27.localEulerAngles

				var_300_35.z = 0
				var_300_35.x = 0
				var_300_27.localEulerAngles = var_300_35
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_36 = 4
			local var_300_37 = 1.9

			if var_300_36 < arg_297_1.time_ and arg_297_1.time_ <= var_300_36 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_38 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_38:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_39 = arg_297_1:GetWordFromCfg(1105005075)
				local var_300_40 = arg_297_1:FormatText(var_300_39.content)

				arg_297_1.text_.text = var_300_40

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_41 = 76
				local var_300_42 = utf8.len(var_300_40)
				local var_300_43 = var_300_41 <= 0 and var_300_37 or var_300_37 * (var_300_42 / var_300_41)

				if var_300_43 > 0 and var_300_37 < var_300_43 then
					arg_297_1.talkMaxDuration = var_300_43
					var_300_36 = var_300_36 + 0.3

					if var_300_43 + var_300_36 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_43 + var_300_36
					end
				end

				arg_297_1.text_.text = var_300_40
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_44 = var_300_36 + 0.3
			local var_300_45 = math.max(var_300_37, arg_297_1.talkMaxDuration)

			if var_300_44 <= arg_297_1.time_ and arg_297_1.time_ < var_300_44 + var_300_45 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_44) / var_300_45

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_44 + var_300_45 and arg_297_1.time_ < var_300_44 + var_300_45 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play1105005076 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1105005076
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1105005077(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.95

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_2 = arg_303_1:GetWordFromCfg(1105005076)
				local var_306_3 = arg_303_1:FormatText(var_306_2.content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 38
				local var_306_5 = utf8.len(var_306_3)
				local var_306_6 = var_306_4 <= 0 and var_306_1 or var_306_1 * (var_306_5 / var_306_4)

				if var_306_6 > 0 and var_306_1 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_7 and arg_303_1.time_ < var_306_0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1105005077 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1105005077
		arg_307_1.duration_ = 2

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1105005078(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1150ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos1150ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(0, -1.01, -6.2)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1150ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["1150ui_story"]
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1150ui_story == nil then
				arg_307_1.var_.characterEffect1150ui_story = var_310_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_11 = 0.200000002980232

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 and not isNil(var_310_9) then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11

				if arg_307_1.var_.characterEffect1150ui_story and not isNil(var_310_9) then
					arg_307_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 and not isNil(var_310_9) and arg_307_1.var_.characterEffect1150ui_story then
				arg_307_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_310_13 = 0

			if var_310_13 < arg_307_1.time_ and arg_307_1.time_ <= var_310_13 + arg_310_0 then
				arg_307_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_310_14 = 0
			local var_310_15 = 0.2

			if var_310_14 < arg_307_1.time_ and arg_307_1.time_ <= var_310_14 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_16 = arg_307_1:FormatText(StoryNameCfg[74].name)

				arg_307_1.leftNameTxt_.text = var_310_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_17 = arg_307_1:GetWordFromCfg(1105005077)
				local var_310_18 = arg_307_1:FormatText(var_310_17.content)

				arg_307_1.text_.text = var_310_18

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_19 = 8
				local var_310_20 = utf8.len(var_310_18)
				local var_310_21 = var_310_19 <= 0 and var_310_15 or var_310_15 * (var_310_20 / var_310_19)

				if var_310_21 > 0 and var_310_15 < var_310_21 then
					arg_307_1.talkMaxDuration = var_310_21

					if var_310_21 + var_310_14 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_21 + var_310_14
					end
				end

				arg_307_1.text_.text = var_310_18
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005077", "story_v_side_new_1105005.awb") ~= 0 then
					local var_310_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005077", "story_v_side_new_1105005.awb") / 1000

					if var_310_22 + var_310_14 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_22 + var_310_14
					end

					if var_310_17.prefab_name ~= "" and arg_307_1.actors_[var_310_17.prefab_name] ~= nil then
						local var_310_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_17.prefab_name].transform, "story_v_side_new_1105005", "1105005077", "story_v_side_new_1105005.awb")

						arg_307_1:RecordAudio("1105005077", var_310_23)
						arg_307_1:RecordAudio("1105005077", var_310_23)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005077", "story_v_side_new_1105005.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005077", "story_v_side_new_1105005.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_24 = math.max(var_310_15, arg_307_1.talkMaxDuration)

			if var_310_14 <= arg_307_1.time_ and arg_307_1.time_ < var_310_14 + var_310_24 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_14) / var_310_24

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_14 + var_310_24 and arg_307_1.time_ < var_310_14 + var_310_24 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play1105005078 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1105005078
		arg_311_1.duration_ = 6.77

		local var_311_0 = {
			zh = 5.733,
			CriLanguages = 6.766
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
				arg_311_0:Play1105005079(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1150ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1150ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0, 100, 0)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1150ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, 100, 0)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = 0
			local var_314_10 = 0.35

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_11 = arg_311_1:FormatText(StoryNameCfg[29].name)

				arg_311_1.leftNameTxt_.text = var_314_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_12 = arg_311_1:GetWordFromCfg(1105005078)
				local var_314_13 = arg_311_1:FormatText(var_314_12.content)

				arg_311_1.text_.text = var_314_13

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_14 = 14
				local var_314_15 = utf8.len(var_314_13)
				local var_314_16 = var_314_14 <= 0 and var_314_10 or var_314_10 * (var_314_15 / var_314_14)

				if var_314_16 > 0 and var_314_10 < var_314_16 then
					arg_311_1.talkMaxDuration = var_314_16

					if var_314_16 + var_314_9 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_16 + var_314_9
					end
				end

				arg_311_1.text_.text = var_314_13
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005078", "story_v_side_new_1105005.awb") ~= 0 then
					local var_314_17 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005078", "story_v_side_new_1105005.awb") / 1000

					if var_314_17 + var_314_9 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_17 + var_314_9
					end

					if var_314_12.prefab_name ~= "" and arg_311_1.actors_[var_314_12.prefab_name] ~= nil then
						local var_314_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_12.prefab_name].transform, "story_v_side_new_1105005", "1105005078", "story_v_side_new_1105005.awb")

						arg_311_1:RecordAudio("1105005078", var_314_18)
						arg_311_1:RecordAudio("1105005078", var_314_18)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005078", "story_v_side_new_1105005.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005078", "story_v_side_new_1105005.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_19 = math.max(var_314_10, arg_311_1.talkMaxDuration)

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_19 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_9) / var_314_19

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_9 + var_314_19 and arg_311_1.time_ < var_314_9 + var_314_19 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play1105005079 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1105005079
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1105005080(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1150ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1150ui_story == nil then
				arg_315_1.var_.characterEffect1150ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1150ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1150ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1150ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1150ui_story.fillRatio = var_318_5
			end

			local var_318_6 = 2.6
			local var_318_7 = 1

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				local var_318_8 = "play"
				local var_318_9 = "effect"

				arg_315_1:AudioAction(var_318_8, var_318_9, "se_story_side_1050", "se_story_side_1050_handtouch1", "")
			end

			local var_318_10 = 0
			local var_318_11 = 1.625

			if var_318_10 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_12 = arg_315_1:GetWordFromCfg(1105005079)
				local var_318_13 = arg_315_1:FormatText(var_318_12.content)

				arg_315_1.text_.text = var_318_13

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_14 = 65
				local var_318_15 = utf8.len(var_318_13)
				local var_318_16 = var_318_14 <= 0 and var_318_11 or var_318_11 * (var_318_15 / var_318_14)

				if var_318_16 > 0 and var_318_11 < var_318_16 then
					arg_315_1.talkMaxDuration = var_318_16

					if var_318_16 + var_318_10 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_16 + var_318_10
					end
				end

				arg_315_1.text_.text = var_318_13
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_17 = math.max(var_318_11, arg_315_1.talkMaxDuration)

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_17 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_10) / var_318_17

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_10 + var_318_17 and arg_315_1.time_ < var_318_10 + var_318_17 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1105005080 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1105005080
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1105005081(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.375

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_2 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:GetWordFromCfg(1105005080)
				local var_322_4 = arg_319_1:FormatText(var_322_3.content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 15
				local var_322_6 = utf8.len(var_322_4)
				local var_322_7 = var_322_5 <= 0 and var_322_1 or var_322_1 * (var_322_6 / var_322_5)

				if var_322_7 > 0 and var_322_1 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_8 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_8 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_8

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_8 and arg_319_1.time_ < var_322_0 + var_322_8 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1105005081 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1105005081
		arg_323_1.duration_ = 2

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1105005082(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1150ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1150ui_story == nil then
				arg_323_1.var_.characterEffect1150ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1150ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1150ui_story then
				arg_323_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_326_4 = 0

			if var_326_4 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_326_5 = arg_323_1.actors_["1150ui_story"].transform
			local var_326_6 = 0

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.var_.moveOldPos1150ui_story = var_326_5.localPosition
			end

			local var_326_7 = 0.001

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_7 then
				local var_326_8 = (arg_323_1.time_ - var_326_6) / var_326_7
				local var_326_9 = Vector3.New(0, -1.01, -6.2)

				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1150ui_story, var_326_9, var_326_8)

				local var_326_10 = manager.ui.mainCamera.transform.position - var_326_5.position

				var_326_5.forward = Vector3.New(var_326_10.x, var_326_10.y, var_326_10.z)

				local var_326_11 = var_326_5.localEulerAngles

				var_326_11.z = 0
				var_326_11.x = 0
				var_326_5.localEulerAngles = var_326_11
			end

			if arg_323_1.time_ >= var_326_6 + var_326_7 and arg_323_1.time_ < var_326_6 + var_326_7 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_326_12 = manager.ui.mainCamera.transform.position - var_326_5.position

				var_326_5.forward = Vector3.New(var_326_12.x, var_326_12.y, var_326_12.z)

				local var_326_13 = var_326_5.localEulerAngles

				var_326_13.z = 0
				var_326_13.x = 0
				var_326_5.localEulerAngles = var_326_13
			end

			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_326_15 = 0
			local var_326_16 = 0.15

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[74].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(1105005081)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 6
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005081", "story_v_side_new_1105005.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005081", "story_v_side_new_1105005.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_side_new_1105005", "1105005081", "story_v_side_new_1105005.awb")

						arg_323_1:RecordAudio("1105005081", var_326_24)
						arg_323_1:RecordAudio("1105005081", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005081", "story_v_side_new_1105005.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005081", "story_v_side_new_1105005.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_25 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_25 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_25

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_25 and arg_323_1.time_ < var_326_15 + var_326_25 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1105005082 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1105005082
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1105005083(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1150ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1150ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, 100, 0)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1150ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, 100, 0)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = 0
			local var_330_10 = 0.175

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_11 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_12 = arg_327_1:GetWordFromCfg(1105005082)
				local var_330_13 = arg_327_1:FormatText(var_330_12.content)

				arg_327_1.text_.text = var_330_13

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_14 = 7
				local var_330_15 = utf8.len(var_330_13)
				local var_330_16 = var_330_14 <= 0 and var_330_10 or var_330_10 * (var_330_15 / var_330_14)

				if var_330_16 > 0 and var_330_10 < var_330_16 then
					arg_327_1.talkMaxDuration = var_330_16

					if var_330_16 + var_330_9 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_16 + var_330_9
					end
				end

				arg_327_1.text_.text = var_330_13
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_17 = math.max(var_330_10, arg_327_1.talkMaxDuration)

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_17 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_9) / var_330_17

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_9 + var_330_17 and arg_327_1.time_ < var_330_9 + var_330_17 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play1105005083 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1105005083
		arg_331_1.duration_ = 7.1

		local var_331_0 = {
			zh = 6.166,
			CriLanguages = 7.1
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
				arg_331_0:Play1105005084(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.35

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[29].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2069")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(1105005083)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 14
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005083", "story_v_side_new_1105005.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005083", "story_v_side_new_1105005.awb") / 1000

					if var_334_8 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_0
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_side_new_1105005", "1105005083", "story_v_side_new_1105005.awb")

						arg_331_1:RecordAudio("1105005083", var_334_9)
						arg_331_1:RecordAudio("1105005083", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005083", "story_v_side_new_1105005.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005083", "story_v_side_new_1105005.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_10 and arg_331_1.time_ < var_334_0 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1105005084 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1105005084
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1105005085(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1.575
			local var_338_1 = 1

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				local var_338_2 = "play"
				local var_338_3 = "effect"

				arg_335_1:AudioAction(var_338_2, var_338_3, "se_story_side_1050", "se_story_side_1050_handtouch2", "")
			end

			local var_338_4 = manager.ui.mainCamera.transform
			local var_338_5 = 1.575

			if var_338_5 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.var_.shakeOldPos = var_338_4.localPosition
			end

			local var_338_6 = 0.6

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_6 then
				local var_338_7 = (arg_335_1.time_ - var_338_5) / 0.066
				local var_338_8, var_338_9 = math.modf(var_338_7)

				var_338_4.localPosition = Vector3.New(var_338_9 * 0.13, var_338_9 * 0.13, var_338_9 * 0.13) + arg_335_1.var_.shakeOldPos
			end

			if arg_335_1.time_ >= var_338_5 + var_338_6 and arg_335_1.time_ < var_338_5 + var_338_6 + arg_338_0 then
				var_338_4.localPosition = arg_335_1.var_.shakeOldPos
			end

			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			local var_338_11 = 1.575

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end

			local var_338_12 = 0
			local var_338_13 = 1.575

			if var_338_12 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_14 = arg_335_1:GetWordFromCfg(1105005084)
				local var_338_15 = arg_335_1:FormatText(var_338_14.content)

				arg_335_1.text_.text = var_338_15

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_16 = 63
				local var_338_17 = utf8.len(var_338_15)
				local var_338_18 = var_338_16 <= 0 and var_338_13 or var_338_13 * (var_338_17 / var_338_16)

				if var_338_18 > 0 and var_338_13 < var_338_18 then
					arg_335_1.talkMaxDuration = var_338_18

					if var_338_18 + var_338_12 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_18 + var_338_12
					end
				end

				arg_335_1.text_.text = var_338_15
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_19 = math.max(var_338_13, arg_335_1.talkMaxDuration)

			if var_338_12 <= arg_335_1.time_ and arg_335_1.time_ < var_338_12 + var_338_19 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_12) / var_338_19

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_12 + var_338_19 and arg_335_1.time_ < var_338_12 + var_338_19 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1105005085 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1105005085
		arg_339_1.duration_ = 5.9

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1105005086(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1150ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1150ui_story == nil then
				arg_339_1.var_.characterEffect1150ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1150ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1150ui_story then
				arg_339_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_342_4 = arg_339_1.actors_["1150ui_story"].transform
			local var_342_5 = 0

			if var_342_5 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.var_.moveOldPos1150ui_story = var_342_4.localPosition
			end

			local var_342_6 = 0.001

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_6 then
				local var_342_7 = (arg_339_1.time_ - var_342_5) / var_342_6
				local var_342_8 = Vector3.New(0, -1.01, -6.2)

				var_342_4.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1150ui_story, var_342_8, var_342_7)

				local var_342_9 = manager.ui.mainCamera.transform.position - var_342_4.position

				var_342_4.forward = Vector3.New(var_342_9.x, var_342_9.y, var_342_9.z)

				local var_342_10 = var_342_4.localEulerAngles

				var_342_10.z = 0
				var_342_10.x = 0
				var_342_4.localEulerAngles = var_342_10
			end

			if arg_339_1.time_ >= var_342_5 + var_342_6 and arg_339_1.time_ < var_342_5 + var_342_6 + arg_342_0 then
				var_342_4.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_342_11 = manager.ui.mainCamera.transform.position - var_342_4.position

				var_342_4.forward = Vector3.New(var_342_11.x, var_342_11.y, var_342_11.z)

				local var_342_12 = var_342_4.localEulerAngles

				var_342_12.z = 0
				var_342_12.x = 0
				var_342_4.localEulerAngles = var_342_12
			end

			local var_342_13 = 0
			local var_342_14 = 0.05

			if var_342_13 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_15 = arg_339_1:FormatText(StoryNameCfg[74].name)

				arg_339_1.leftNameTxt_.text = var_342_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_16 = arg_339_1:GetWordFromCfg(1105005085)
				local var_342_17 = arg_339_1:FormatText(var_342_16.content)

				arg_339_1.text_.text = var_342_17

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_18 = 2
				local var_342_19 = utf8.len(var_342_17)
				local var_342_20 = var_342_18 <= 0 and var_342_14 or var_342_14 * (var_342_19 / var_342_18)

				if var_342_20 > 0 and var_342_14 < var_342_20 then
					arg_339_1.talkMaxDuration = var_342_20

					if var_342_20 + var_342_13 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_20 + var_342_13
					end
				end

				arg_339_1.text_.text = var_342_17
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005085", "story_v_side_new_1105005.awb") ~= 0 then
					local var_342_21 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005085", "story_v_side_new_1105005.awb") / 1000

					if var_342_21 + var_342_13 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_21 + var_342_13
					end

					if var_342_16.prefab_name ~= "" and arg_339_1.actors_[var_342_16.prefab_name] ~= nil then
						local var_342_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_16.prefab_name].transform, "story_v_side_new_1105005", "1105005085", "story_v_side_new_1105005.awb")

						arg_339_1:RecordAudio("1105005085", var_342_22)
						arg_339_1:RecordAudio("1105005085", var_342_22)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005085", "story_v_side_new_1105005.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005085", "story_v_side_new_1105005.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_23 = math.max(var_342_14, arg_339_1.talkMaxDuration)

			if var_342_13 <= arg_339_1.time_ and arg_339_1.time_ < var_342_13 + var_342_23 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_13) / var_342_23

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_13 + var_342_23 and arg_339_1.time_ < var_342_13 + var_342_23 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play1105005086 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1105005086
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1105005087(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1150ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1150ui_story = var_346_0.localPosition
			end

			local var_346_2 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2
				local var_346_4 = Vector3.New(0, 100, 0)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1150ui_story, var_346_4, var_346_3)

				local var_346_5 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_5.x, var_346_5.y, var_346_5.z)

				local var_346_6 = var_346_0.localEulerAngles

				var_346_6.z = 0
				var_346_6.x = 0
				var_346_0.localEulerAngles = var_346_6
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, 100, 0)

				local var_346_7 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_7.x, var_346_7.y, var_346_7.z)

				local var_346_8 = var_346_0.localEulerAngles

				var_346_8.z = 0
				var_346_8.x = 0
				var_346_0.localEulerAngles = var_346_8
			end

			local var_346_9 = 0
			local var_346_10 = 1.6

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_11 = arg_343_1:GetWordFromCfg(1105005086)
				local var_346_12 = arg_343_1:FormatText(var_346_11.content)

				arg_343_1.text_.text = var_346_12

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 64
				local var_346_14 = utf8.len(var_346_12)
				local var_346_15 = var_346_13 <= 0 and var_346_10 or var_346_10 * (var_346_14 / var_346_13)

				if var_346_15 > 0 and var_346_10 < var_346_15 then
					arg_343_1.talkMaxDuration = var_346_15

					if var_346_15 + var_346_9 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_15 + var_346_9
					end
				end

				arg_343_1.text_.text = var_346_12
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_10, arg_343_1.talkMaxDuration)

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_9) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_9 + var_346_16 and arg_343_1.time_ < var_346_9 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play1105005087 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1105005087
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1105005088(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 1.725

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_2 = arg_347_1:GetWordFromCfg(1105005087)
				local var_350_3 = arg_347_1:FormatText(var_350_2.content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 69
				local var_350_5 = utf8.len(var_350_3)
				local var_350_6 = var_350_4 <= 0 and var_350_1 or var_350_1 * (var_350_5 / var_350_4)

				if var_350_6 > 0 and var_350_1 < var_350_6 then
					arg_347_1.talkMaxDuration = var_350_6

					if var_350_6 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_6 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_7 and arg_347_1.time_ < var_350_0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1105005088 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1105005088
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1105005089(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.325

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(1105005088)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 13
				local var_354_5 = utf8.len(var_354_3)
				local var_354_6 = var_354_4 <= 0 and var_354_1 or var_354_1 * (var_354_5 / var_354_4)

				if var_354_6 > 0 and var_354_1 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_7 and arg_351_1.time_ < var_354_0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1105005089 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1105005089
		arg_355_1.duration_ = 3.67

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1105005090(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1150ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1150ui_story == nil then
				arg_355_1.var_.characterEffect1150ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1150ui_story and not isNil(var_358_0) then
					arg_355_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1150ui_story then
				arg_355_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_358_4 = 0

			if var_358_4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_358_5 = 0

			if var_358_5 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_358_6 = arg_355_1.actors_["1150ui_story"].transform
			local var_358_7 = 0

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 then
				arg_355_1.var_.moveOldPos1150ui_story = var_358_6.localPosition
			end

			local var_358_8 = 0.001

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_8 then
				local var_358_9 = (arg_355_1.time_ - var_358_7) / var_358_8
				local var_358_10 = Vector3.New(0, -1.01, -6.2)

				var_358_6.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1150ui_story, var_358_10, var_358_9)

				local var_358_11 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_11.x, var_358_11.y, var_358_11.z)

				local var_358_12 = var_358_6.localEulerAngles

				var_358_12.z = 0
				var_358_12.x = 0
				var_358_6.localEulerAngles = var_358_12
			end

			if arg_355_1.time_ >= var_358_7 + var_358_8 and arg_355_1.time_ < var_358_7 + var_358_8 + arg_358_0 then
				var_358_6.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_358_13 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_13.x, var_358_13.y, var_358_13.z)

				local var_358_14 = var_358_6.localEulerAngles

				var_358_14.z = 0
				var_358_14.x = 0
				var_358_6.localEulerAngles = var_358_14
			end

			local var_358_15 = 0
			local var_358_16 = 0.275

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_17 = arg_355_1:FormatText(StoryNameCfg[74].name)

				arg_355_1.leftNameTxt_.text = var_358_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_18 = arg_355_1:GetWordFromCfg(1105005089)
				local var_358_19 = arg_355_1:FormatText(var_358_18.content)

				arg_355_1.text_.text = var_358_19

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_20 = 11
				local var_358_21 = utf8.len(var_358_19)
				local var_358_22 = var_358_20 <= 0 and var_358_16 or var_358_16 * (var_358_21 / var_358_20)

				if var_358_22 > 0 and var_358_16 < var_358_22 then
					arg_355_1.talkMaxDuration = var_358_22

					if var_358_22 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_15
					end
				end

				arg_355_1.text_.text = var_358_19
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005089", "story_v_side_new_1105005.awb") ~= 0 then
					local var_358_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005089", "story_v_side_new_1105005.awb") / 1000

					if var_358_23 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_15
					end

					if var_358_18.prefab_name ~= "" and arg_355_1.actors_[var_358_18.prefab_name] ~= nil then
						local var_358_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_18.prefab_name].transform, "story_v_side_new_1105005", "1105005089", "story_v_side_new_1105005.awb")

						arg_355_1:RecordAudio("1105005089", var_358_24)
						arg_355_1:RecordAudio("1105005089", var_358_24)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005089", "story_v_side_new_1105005.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005089", "story_v_side_new_1105005.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_25 = math.max(var_358_16, arg_355_1.talkMaxDuration)

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_25 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_15) / var_358_25

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_15 + var_358_25 and arg_355_1.time_ < var_358_15 + var_358_25 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play1105005090 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1105005090
		arg_359_1.duration_ = 4.4

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1105005091(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.5

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[74].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(1105005090)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005090", "story_v_side_new_1105005.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005090", "story_v_side_new_1105005.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_side_new_1105005", "1105005090", "story_v_side_new_1105005.awb")

						arg_359_1:RecordAudio("1105005090", var_362_9)
						arg_359_1:RecordAudio("1105005090", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005090", "story_v_side_new_1105005.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005090", "story_v_side_new_1105005.awb")
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
	Play1105005091 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1105005091
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1105005092(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1150ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1150ui_story == nil then
				arg_363_1.var_.characterEffect1150ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1150ui_story and not isNil(var_366_0) then
					local var_366_4 = Mathf.Lerp(0, 0.5, var_366_3)

					arg_363_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1150ui_story.fillRatio = var_366_4
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1150ui_story then
				local var_366_5 = 0.5

				arg_363_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1150ui_story.fillRatio = var_366_5
			end

			local var_366_6 = 0
			local var_366_7 = 1.25

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_8 = arg_363_1:GetWordFromCfg(1105005091)
				local var_366_9 = arg_363_1:FormatText(var_366_8.content)

				arg_363_1.text_.text = var_366_9

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_10 = 50
				local var_366_11 = utf8.len(var_366_9)
				local var_366_12 = var_366_10 <= 0 and var_366_7 or var_366_7 * (var_366_11 / var_366_10)

				if var_366_12 > 0 and var_366_7 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_9
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_13 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_13

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_13 and arg_363_1.time_ < var_366_6 + var_366_13 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1105005092 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1105005092
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1105005093(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.55

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(1105005092)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 22
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
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1105005093 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1105005093
		arg_371_1.duration_ = 3.93

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1105005094(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1150ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1150ui_story == nil then
				arg_371_1.var_.characterEffect1150ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1150ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1150ui_story then
				arg_371_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_374_4 = 0

			if var_374_4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_374_5 = 0
			local var_374_6 = 0.475

			if var_374_5 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_7 = arg_371_1:FormatText(StoryNameCfg[74].name)

				arg_371_1.leftNameTxt_.text = var_374_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_8 = arg_371_1:GetWordFromCfg(1105005093)
				local var_374_9 = arg_371_1:FormatText(var_374_8.content)

				arg_371_1.text_.text = var_374_9

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_10 = 19
				local var_374_11 = utf8.len(var_374_9)
				local var_374_12 = var_374_10 <= 0 and var_374_6 or var_374_6 * (var_374_11 / var_374_10)

				if var_374_12 > 0 and var_374_6 < var_374_12 then
					arg_371_1.talkMaxDuration = var_374_12

					if var_374_12 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_12 + var_374_5
					end
				end

				arg_371_1.text_.text = var_374_9
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005093", "story_v_side_new_1105005.awb") ~= 0 then
					local var_374_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005093", "story_v_side_new_1105005.awb") / 1000

					if var_374_13 + var_374_5 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_5
					end

					if var_374_8.prefab_name ~= "" and arg_371_1.actors_[var_374_8.prefab_name] ~= nil then
						local var_374_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_8.prefab_name].transform, "story_v_side_new_1105005", "1105005093", "story_v_side_new_1105005.awb")

						arg_371_1:RecordAudio("1105005093", var_374_14)
						arg_371_1:RecordAudio("1105005093", var_374_14)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005093", "story_v_side_new_1105005.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005093", "story_v_side_new_1105005.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_15 = math.max(var_374_6, arg_371_1.talkMaxDuration)

			if var_374_5 <= arg_371_1.time_ and arg_371_1.time_ < var_374_5 + var_374_15 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_5) / var_374_15

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_5 + var_374_15 and arg_371_1.time_ < var_374_5 + var_374_15 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1105005094 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1105005094
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1105005095(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1150ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1150ui_story == nil then
				arg_375_1.var_.characterEffect1150ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1150ui_story and not isNil(var_378_0) then
					local var_378_4 = Mathf.Lerp(0, 0.5, var_378_3)

					arg_375_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1150ui_story.fillRatio = var_378_4
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1150ui_story then
				local var_378_5 = 0.5

				arg_375_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1150ui_story.fillRatio = var_378_5
			end

			local var_378_6 = 0
			local var_378_7 = 0.9

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

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_9 = arg_375_1:GetWordFromCfg(1105005094)
				local var_378_10 = arg_375_1:FormatText(var_378_9.content)

				arg_375_1.text_.text = var_378_10

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 36
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
	Play1105005095 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1105005095
		arg_379_1.duration_ = 2

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1105005096(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1150ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1150ui_story == nil then
				arg_379_1.var_.characterEffect1150ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1150ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1150ui_story then
				arg_379_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_382_4 = 0

			if var_382_4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_382_5 = 0
			local var_382_6 = 0.125

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_7 = arg_379_1:FormatText(StoryNameCfg[74].name)

				arg_379_1.leftNameTxt_.text = var_382_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(1105005095)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 5
				local var_382_11 = utf8.len(var_382_9)
				local var_382_12 = var_382_10 <= 0 and var_382_6 or var_382_6 * (var_382_11 / var_382_10)

				if var_382_12 > 0 and var_382_6 < var_382_12 then
					arg_379_1.talkMaxDuration = var_382_12

					if var_382_12 + var_382_5 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_5
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005095", "story_v_side_new_1105005.awb") ~= 0 then
					local var_382_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005095", "story_v_side_new_1105005.awb") / 1000

					if var_382_13 + var_382_5 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_5
					end

					if var_382_8.prefab_name ~= "" and arg_379_1.actors_[var_382_8.prefab_name] ~= nil then
						local var_382_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_8.prefab_name].transform, "story_v_side_new_1105005", "1105005095", "story_v_side_new_1105005.awb")

						arg_379_1:RecordAudio("1105005095", var_382_14)
						arg_379_1:RecordAudio("1105005095", var_382_14)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005095", "story_v_side_new_1105005.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005095", "story_v_side_new_1105005.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_15 = math.max(var_382_6, arg_379_1.talkMaxDuration)

			if var_382_5 <= arg_379_1.time_ and arg_379_1.time_ < var_382_5 + var_382_15 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_5) / var_382_15

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_5 + var_382_15 and arg_379_1.time_ < var_382_5 + var_382_15 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1105005096 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1105005096
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1105005097(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1150ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1150ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, 100, 0)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1150ui_story, var_386_4, var_386_3)

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

			local var_386_9 = 0
			local var_386_10 = 0.675

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_11 = arg_383_1:GetWordFromCfg(1105005096)
				local var_386_12 = arg_383_1:FormatText(var_386_11.content)

				arg_383_1.text_.text = var_386_12

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_13 = 27
				local var_386_14 = utf8.len(var_386_12)
				local var_386_15 = var_386_13 <= 0 and var_386_10 or var_386_10 * (var_386_14 / var_386_13)

				if var_386_15 > 0 and var_386_10 < var_386_15 then
					arg_383_1.talkMaxDuration = var_386_15

					if var_386_15 + var_386_9 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_15 + var_386_9
					end
				end

				arg_383_1.text_.text = var_386_12
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_10, arg_383_1.talkMaxDuration)

			if var_386_9 <= arg_383_1.time_ and arg_383_1.time_ < var_386_9 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_9) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_9 + var_386_16 and arg_383_1.time_ < var_386_9 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play1105005097 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1105005097
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1105005098(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.875

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(1105005097)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 35
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
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1105005098 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1105005098
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1105005099(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.5

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[7].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:GetWordFromCfg(1105005098)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 20
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
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_8 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_8 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_8

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_8 and arg_391_1.time_ < var_394_0 + var_394_8 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1105005099 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1105005099
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1105005100(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 1.625

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_2 = arg_395_1:GetWordFromCfg(1105005099)
				local var_398_3 = arg_395_1:FormatText(var_398_2.content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 65
				local var_398_5 = utf8.len(var_398_3)
				local var_398_6 = var_398_4 <= 0 and var_398_1 or var_398_1 * (var_398_5 / var_398_4)

				if var_398_6 > 0 and var_398_1 < var_398_6 then
					arg_395_1.talkMaxDuration = var_398_6

					if var_398_6 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_6 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_7 and arg_395_1.time_ < var_398_0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1105005100 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1105005100
		arg_399_1.duration_ = 2.07

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1105005101(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1150ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1150ui_story == nil then
				arg_399_1.var_.characterEffect1150ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1150ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1150ui_story then
				arg_399_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_402_4 = 0

			if var_402_4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_5 = arg_399_1.actors_["1150ui_story"].transform
			local var_402_6 = 0

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.var_.moveOldPos1150ui_story = var_402_5.localPosition
			end

			local var_402_7 = 0.001

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_7 then
				local var_402_8 = (arg_399_1.time_ - var_402_6) / var_402_7
				local var_402_9 = Vector3.New(0, -1.01, -6.2)

				var_402_5.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1150ui_story, var_402_9, var_402_8)

				local var_402_10 = manager.ui.mainCamera.transform.position - var_402_5.position

				var_402_5.forward = Vector3.New(var_402_10.x, var_402_10.y, var_402_10.z)

				local var_402_11 = var_402_5.localEulerAngles

				var_402_11.z = 0
				var_402_11.x = 0
				var_402_5.localEulerAngles = var_402_11
			end

			if arg_399_1.time_ >= var_402_6 + var_402_7 and arg_399_1.time_ < var_402_6 + var_402_7 + arg_402_0 then
				var_402_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_402_12 = manager.ui.mainCamera.transform.position - var_402_5.position

				var_402_5.forward = Vector3.New(var_402_12.x, var_402_12.y, var_402_12.z)

				local var_402_13 = var_402_5.localEulerAngles

				var_402_13.z = 0
				var_402_13.x = 0
				var_402_5.localEulerAngles = var_402_13
			end

			local var_402_14 = 0
			local var_402_15 = 0.225

			if var_402_14 < arg_399_1.time_ and arg_399_1.time_ <= var_402_14 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_16 = arg_399_1:FormatText(StoryNameCfg[74].name)

				arg_399_1.leftNameTxt_.text = var_402_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_17 = arg_399_1:GetWordFromCfg(1105005100)
				local var_402_18 = arg_399_1:FormatText(var_402_17.content)

				arg_399_1.text_.text = var_402_18

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_19 = 9
				local var_402_20 = utf8.len(var_402_18)
				local var_402_21 = var_402_19 <= 0 and var_402_15 or var_402_15 * (var_402_20 / var_402_19)

				if var_402_21 > 0 and var_402_15 < var_402_21 then
					arg_399_1.talkMaxDuration = var_402_21

					if var_402_21 + var_402_14 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_21 + var_402_14
					end
				end

				arg_399_1.text_.text = var_402_18
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005100", "story_v_side_new_1105005.awb") ~= 0 then
					local var_402_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005100", "story_v_side_new_1105005.awb") / 1000

					if var_402_22 + var_402_14 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_22 + var_402_14
					end

					if var_402_17.prefab_name ~= "" and arg_399_1.actors_[var_402_17.prefab_name] ~= nil then
						local var_402_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_17.prefab_name].transform, "story_v_side_new_1105005", "1105005100", "story_v_side_new_1105005.awb")

						arg_399_1:RecordAudio("1105005100", var_402_23)
						arg_399_1:RecordAudio("1105005100", var_402_23)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005100", "story_v_side_new_1105005.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005100", "story_v_side_new_1105005.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_24 = math.max(var_402_15, arg_399_1.talkMaxDuration)

			if var_402_14 <= arg_399_1.time_ and arg_399_1.time_ < var_402_14 + var_402_24 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_14) / var_402_24

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_14 + var_402_24 and arg_399_1.time_ < var_402_14 + var_402_24 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play1105005101 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1105005101
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1105005102(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1150ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1150ui_story == nil then
				arg_403_1.var_.characterEffect1150ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1150ui_story and not isNil(var_406_0) then
					local var_406_4 = Mathf.Lerp(0, 0.5, var_406_3)

					arg_403_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1150ui_story.fillRatio = var_406_4
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1150ui_story then
				local var_406_5 = 0.5

				arg_403_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1150ui_story.fillRatio = var_406_5
			end

			local var_406_6 = 0
			local var_406_7 = 0.4

			if var_406_6 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_8 = arg_403_1:FormatText(StoryNameCfg[7].name)

				arg_403_1.leftNameTxt_.text = var_406_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_9 = arg_403_1:GetWordFromCfg(1105005101)
				local var_406_10 = arg_403_1:FormatText(var_406_9.content)

				arg_403_1.text_.text = var_406_10

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_11 = 16
				local var_406_12 = utf8.len(var_406_10)
				local var_406_13 = var_406_11 <= 0 and var_406_7 or var_406_7 * (var_406_12 / var_406_11)

				if var_406_13 > 0 and var_406_7 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_6
					end
				end

				arg_403_1.text_.text = var_406_10
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_14 = math.max(var_406_7, arg_403_1.talkMaxDuration)

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_14 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_6) / var_406_14

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_6 + var_406_14 and arg_403_1.time_ < var_406_6 + var_406_14 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1105005102 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1105005102
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1105005103(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 0.85

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_2 = arg_407_1:FormatText(StoryNameCfg[7].name)

				arg_407_1.leftNameTxt_.text = var_410_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:GetWordFromCfg(1105005102)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 34
				local var_410_6 = utf8.len(var_410_4)
				local var_410_7 = var_410_5 <= 0 and var_410_1 or var_410_1 * (var_410_6 / var_410_5)

				if var_410_7 > 0 and var_410_1 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_8 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_8 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_8

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_8 and arg_407_1.time_ < var_410_0 + var_410_8 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1105005103 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1105005103
		arg_411_1.duration_ = 2

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1105005104(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1150ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1150ui_story == nil then
				arg_411_1.var_.characterEffect1150ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1150ui_story and not isNil(var_414_0) then
					arg_411_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1150ui_story then
				arg_411_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_414_4 = 0

			if var_414_4 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_414_5 = 0
			local var_414_6 = 0.15

			if var_414_5 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_7 = arg_411_1:FormatText(StoryNameCfg[74].name)

				arg_411_1.leftNameTxt_.text = var_414_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_8 = arg_411_1:GetWordFromCfg(1105005103)
				local var_414_9 = arg_411_1:FormatText(var_414_8.content)

				arg_411_1.text_.text = var_414_9

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_10 = 6
				local var_414_11 = utf8.len(var_414_9)
				local var_414_12 = var_414_10 <= 0 and var_414_6 or var_414_6 * (var_414_11 / var_414_10)

				if var_414_12 > 0 and var_414_6 < var_414_12 then
					arg_411_1.talkMaxDuration = var_414_12

					if var_414_12 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_12 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_9
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005103", "story_v_side_new_1105005.awb") ~= 0 then
					local var_414_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005103", "story_v_side_new_1105005.awb") / 1000

					if var_414_13 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_5
					end

					if var_414_8.prefab_name ~= "" and arg_411_1.actors_[var_414_8.prefab_name] ~= nil then
						local var_414_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_8.prefab_name].transform, "story_v_side_new_1105005", "1105005103", "story_v_side_new_1105005.awb")

						arg_411_1:RecordAudio("1105005103", var_414_14)
						arg_411_1:RecordAudio("1105005103", var_414_14)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005103", "story_v_side_new_1105005.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005103", "story_v_side_new_1105005.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_15 = math.max(var_414_6, arg_411_1.talkMaxDuration)

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_15 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_5) / var_414_15

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_5 + var_414_15 and arg_411_1.time_ < var_414_5 + var_414_15 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1105005104 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1105005104
		arg_415_1.duration_ = 5.73

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1105005105(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_418_1 = 0
			local var_418_2 = 0.55

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_3 = arg_415_1:FormatText(StoryNameCfg[74].name)

				arg_415_1.leftNameTxt_.text = var_418_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:GetWordFromCfg(1105005104)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_6 = 22
				local var_418_7 = utf8.len(var_418_5)
				local var_418_8 = var_418_6 <= 0 and var_418_2 or var_418_2 * (var_418_7 / var_418_6)

				if var_418_8 > 0 and var_418_2 < var_418_8 then
					arg_415_1.talkMaxDuration = var_418_8

					if var_418_8 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005104", "story_v_side_new_1105005.awb") ~= 0 then
					local var_418_9 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005104", "story_v_side_new_1105005.awb") / 1000

					if var_418_9 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_1
					end

					if var_418_4.prefab_name ~= "" and arg_415_1.actors_[var_418_4.prefab_name] ~= nil then
						local var_418_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_4.prefab_name].transform, "story_v_side_new_1105005", "1105005104", "story_v_side_new_1105005.awb")

						arg_415_1:RecordAudio("1105005104", var_418_10)
						arg_415_1:RecordAudio("1105005104", var_418_10)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005104", "story_v_side_new_1105005.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005104", "story_v_side_new_1105005.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_11 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_11 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_11

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_11 and arg_415_1.time_ < var_418_1 + var_418_11 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1105005105 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1105005105
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1105005106(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1150ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1150ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, 100, 0)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1150ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, 100, 0)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = 0
			local var_422_10 = 1.55

			if var_422_9 < arg_419_1.time_ and arg_419_1.time_ <= var_422_9 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_11 = arg_419_1:GetWordFromCfg(1105005105)
				local var_422_12 = arg_419_1:FormatText(var_422_11.content)

				arg_419_1.text_.text = var_422_12

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_13 = 62
				local var_422_14 = utf8.len(var_422_12)
				local var_422_15 = var_422_13 <= 0 and var_422_10 or var_422_10 * (var_422_14 / var_422_13)

				if var_422_15 > 0 and var_422_10 < var_422_15 then
					arg_419_1.talkMaxDuration = var_422_15

					if var_422_15 + var_422_9 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_15 + var_422_9
					end
				end

				arg_419_1.text_.text = var_422_12
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_16 = math.max(var_422_10, arg_419_1.talkMaxDuration)

			if var_422_9 <= arg_419_1.time_ and arg_419_1.time_ < var_422_9 + var_422_16 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_9) / var_422_16

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_9 + var_422_16 and arg_419_1.time_ < var_422_9 + var_422_16 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1105005106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1105005106
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1105005107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.275

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(1105005106)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 11
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
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_8 and arg_423_1.time_ < var_426_0 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1105005107 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1105005107
		arg_427_1.duration_ = 2

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1105005108(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1150ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1150ui_story == nil then
				arg_427_1.var_.characterEffect1150ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1150ui_story and not isNil(var_430_0) then
					arg_427_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1150ui_story then
				arg_427_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_430_4 = arg_427_1.actors_["1150ui_story"].transform
			local var_430_5 = 0

			if var_430_5 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1.var_.moveOldPos1150ui_story = var_430_4.localPosition
			end

			local var_430_6 = 0.001

			if var_430_5 <= arg_427_1.time_ and arg_427_1.time_ < var_430_5 + var_430_6 then
				local var_430_7 = (arg_427_1.time_ - var_430_5) / var_430_6
				local var_430_8 = Vector3.New(0, -1.01, -6.2)

				var_430_4.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1150ui_story, var_430_8, var_430_7)

				local var_430_9 = manager.ui.mainCamera.transform.position - var_430_4.position

				var_430_4.forward = Vector3.New(var_430_9.x, var_430_9.y, var_430_9.z)

				local var_430_10 = var_430_4.localEulerAngles

				var_430_10.z = 0
				var_430_10.x = 0
				var_430_4.localEulerAngles = var_430_10
			end

			if arg_427_1.time_ >= var_430_5 + var_430_6 and arg_427_1.time_ < var_430_5 + var_430_6 + arg_430_0 then
				var_430_4.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_430_11 = manager.ui.mainCamera.transform.position - var_430_4.position

				var_430_4.forward = Vector3.New(var_430_11.x, var_430_11.y, var_430_11.z)

				local var_430_12 = var_430_4.localEulerAngles

				var_430_12.z = 0
				var_430_12.x = 0
				var_430_4.localEulerAngles = var_430_12
			end

			local var_430_13 = 0

			if var_430_13 < arg_427_1.time_ and arg_427_1.time_ <= var_430_13 + arg_430_0 then
				arg_427_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_430_14 = 0

			if var_430_14 < arg_427_1.time_ and arg_427_1.time_ <= var_430_14 + arg_430_0 then
				arg_427_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_430_15 = 0
			local var_430_16 = 0.125

			if var_430_15 < arg_427_1.time_ and arg_427_1.time_ <= var_430_15 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_17 = arg_427_1:FormatText(StoryNameCfg[74].name)

				arg_427_1.leftNameTxt_.text = var_430_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_18 = arg_427_1:GetWordFromCfg(1105005107)
				local var_430_19 = arg_427_1:FormatText(var_430_18.content)

				arg_427_1.text_.text = var_430_19

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_20 = 5
				local var_430_21 = utf8.len(var_430_19)
				local var_430_22 = var_430_20 <= 0 and var_430_16 or var_430_16 * (var_430_21 / var_430_20)

				if var_430_22 > 0 and var_430_16 < var_430_22 then
					arg_427_1.talkMaxDuration = var_430_22

					if var_430_22 + var_430_15 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_22 + var_430_15
					end
				end

				arg_427_1.text_.text = var_430_19
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005107", "story_v_side_new_1105005.awb") ~= 0 then
					local var_430_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005107", "story_v_side_new_1105005.awb") / 1000

					if var_430_23 + var_430_15 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_23 + var_430_15
					end

					if var_430_18.prefab_name ~= "" and arg_427_1.actors_[var_430_18.prefab_name] ~= nil then
						local var_430_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_18.prefab_name].transform, "story_v_side_new_1105005", "1105005107", "story_v_side_new_1105005.awb")

						arg_427_1:RecordAudio("1105005107", var_430_24)
						arg_427_1:RecordAudio("1105005107", var_430_24)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005107", "story_v_side_new_1105005.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005107", "story_v_side_new_1105005.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_25 = math.max(var_430_16, arg_427_1.talkMaxDuration)

			if var_430_15 <= arg_427_1.time_ and arg_427_1.time_ < var_430_15 + var_430_25 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_15) / var_430_25

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_15 + var_430_25 and arg_427_1.time_ < var_430_15 + var_430_25 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play1105005108 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1105005108
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1105005109(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1150ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1150ui_story == nil then
				arg_431_1.var_.characterEffect1150ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1150ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1150ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1150ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1150ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 0.45

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_9 = arg_431_1:GetWordFromCfg(1105005108)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 18
				local var_434_12 = utf8.len(var_434_10)
				local var_434_13 = var_434_11 <= 0 and var_434_7 or var_434_7 * (var_434_12 / var_434_11)

				if var_434_13 > 0 and var_434_7 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_10
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1105005109 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1105005109
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1105005110(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1150ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1150ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(0, 100, 0)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1150ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, 100, 0)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = 0
			local var_438_10 = 0.65

			if var_438_9 < arg_435_1.time_ and arg_435_1.time_ <= var_438_9 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_11 = arg_435_1:GetWordFromCfg(1105005109)
				local var_438_12 = arg_435_1:FormatText(var_438_11.content)

				arg_435_1.text_.text = var_438_12

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_13 = 26
				local var_438_14 = utf8.len(var_438_12)
				local var_438_15 = var_438_13 <= 0 and var_438_10 or var_438_10 * (var_438_14 / var_438_13)

				if var_438_15 > 0 and var_438_10 < var_438_15 then
					arg_435_1.talkMaxDuration = var_438_15

					if var_438_15 + var_438_9 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_15 + var_438_9
					end
				end

				arg_435_1.text_.text = var_438_12
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_16 = math.max(var_438_10, arg_435_1.talkMaxDuration)

			if var_438_9 <= arg_435_1.time_ and arg_435_1.time_ < var_438_9 + var_438_16 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_9) / var_438_16

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_9 + var_438_16 and arg_435_1.time_ < var_438_9 + var_438_16 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play1105005110 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1105005110
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1105005111(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.3

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[7].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(1105005110)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 12
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_8 and arg_439_1.time_ < var_442_0 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1105005111 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1105005111
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1105005112(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_446_1 = 0
			local var_446_2 = 1.525

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:GetWordFromCfg(1105005111)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 61
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_2 or var_446_2 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_2 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_8 and arg_443_1.time_ < var_446_1 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1105005112 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1105005112
		arg_447_1.duration_ = 2.5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1105005113(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1150ui_story"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1150ui_story = var_450_0.localPosition
			end

			local var_450_2 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2
				local var_450_4 = Vector3.New(0, -1.01, -6.2)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1150ui_story, var_450_4, var_450_3)

				local var_450_5 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_5.x, var_450_5.y, var_450_5.z)

				local var_450_6 = var_450_0.localEulerAngles

				var_450_6.z = 0
				var_450_6.x = 0
				var_450_0.localEulerAngles = var_450_6
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_450_7 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_7.x, var_450_7.y, var_450_7.z)

				local var_450_8 = var_450_0.localEulerAngles

				var_450_8.z = 0
				var_450_8.x = 0
				var_450_0.localEulerAngles = var_450_8
			end

			local var_450_9 = arg_447_1.actors_["1150ui_story"]
			local var_450_10 = 0

			if var_450_10 < arg_447_1.time_ and arg_447_1.time_ <= var_450_10 + arg_450_0 and not isNil(var_450_9) and arg_447_1.var_.characterEffect1150ui_story == nil then
				arg_447_1.var_.characterEffect1150ui_story = var_450_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_11 = 0.200000002980232

			if var_450_10 <= arg_447_1.time_ and arg_447_1.time_ < var_450_10 + var_450_11 and not isNil(var_450_9) then
				local var_450_12 = (arg_447_1.time_ - var_450_10) / var_450_11

				if arg_447_1.var_.characterEffect1150ui_story and not isNil(var_450_9) then
					arg_447_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_10 + var_450_11 and arg_447_1.time_ < var_450_10 + var_450_11 + arg_450_0 and not isNil(var_450_9) and arg_447_1.var_.characterEffect1150ui_story then
				arg_447_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_450_13 = 0

			if var_450_13 < arg_447_1.time_ and arg_447_1.time_ <= var_450_13 + arg_450_0 then
				arg_447_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_450_14 = 0
			local var_450_15 = 0.225

			if var_450_14 < arg_447_1.time_ and arg_447_1.time_ <= var_450_14 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_16 = arg_447_1:FormatText(StoryNameCfg[74].name)

				arg_447_1.leftNameTxt_.text = var_450_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_17 = arg_447_1:GetWordFromCfg(1105005112)
				local var_450_18 = arg_447_1:FormatText(var_450_17.content)

				arg_447_1.text_.text = var_450_18

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_19 = 9
				local var_450_20 = utf8.len(var_450_18)
				local var_450_21 = var_450_19 <= 0 and var_450_15 or var_450_15 * (var_450_20 / var_450_19)

				if var_450_21 > 0 and var_450_15 < var_450_21 then
					arg_447_1.talkMaxDuration = var_450_21

					if var_450_21 + var_450_14 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_21 + var_450_14
					end
				end

				arg_447_1.text_.text = var_450_18
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005112", "story_v_side_new_1105005.awb") ~= 0 then
					local var_450_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005112", "story_v_side_new_1105005.awb") / 1000

					if var_450_22 + var_450_14 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_22 + var_450_14
					end

					if var_450_17.prefab_name ~= "" and arg_447_1.actors_[var_450_17.prefab_name] ~= nil then
						local var_450_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_17.prefab_name].transform, "story_v_side_new_1105005", "1105005112", "story_v_side_new_1105005.awb")

						arg_447_1:RecordAudio("1105005112", var_450_23)
						arg_447_1:RecordAudio("1105005112", var_450_23)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005112", "story_v_side_new_1105005.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005112", "story_v_side_new_1105005.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_24 = math.max(var_450_15, arg_447_1.talkMaxDuration)

			if var_450_14 <= arg_447_1.time_ and arg_447_1.time_ < var_450_14 + var_450_24 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_14) / var_450_24

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_14 + var_450_24 and arg_447_1.time_ < var_450_14 + var_450_24 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1105005113 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1105005113
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1105005114(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1150ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1150ui_story == nil then
				arg_451_1.var_.characterEffect1150ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1150ui_story and not isNil(var_454_0) then
					local var_454_4 = Mathf.Lerp(0, 0.5, var_454_3)

					arg_451_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_451_1.var_.characterEffect1150ui_story.fillRatio = var_454_4
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1150ui_story then
				local var_454_5 = 0.5

				arg_451_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_451_1.var_.characterEffect1150ui_story.fillRatio = var_454_5
			end

			local var_454_6 = 0
			local var_454_7 = 0.95

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_8 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_9 = arg_451_1:GetWordFromCfg(1105005113)
				local var_454_10 = arg_451_1:FormatText(var_454_9.content)

				arg_451_1.text_.text = var_454_10

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 38
				local var_454_12 = utf8.len(var_454_10)
				local var_454_13 = var_454_11 <= 0 and var_454_7 or var_454_7 * (var_454_12 / var_454_11)

				if var_454_13 > 0 and var_454_7 < var_454_13 then
					arg_451_1.talkMaxDuration = var_454_13

					if var_454_13 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_10
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_14 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_14 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_14

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_14 and arg_451_1.time_ < var_454_6 + var_454_14 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1105005114 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1105005114
		arg_455_1.duration_ = 3.03

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1105005115(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1150ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1150ui_story == nil then
				arg_455_1.var_.characterEffect1150ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.2

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1150ui_story and not isNil(var_458_0) then
					arg_455_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1150ui_story then
				arg_455_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_458_4 = 0

			if var_458_4 < arg_455_1.time_ and arg_455_1.time_ <= var_458_4 + arg_458_0 then
				arg_455_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_1")
			end

			local var_458_5 = 0
			local var_458_6 = 0.45

			if var_458_5 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_7 = arg_455_1:FormatText(StoryNameCfg[74].name)

				arg_455_1.leftNameTxt_.text = var_458_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_8 = arg_455_1:GetWordFromCfg(1105005114)
				local var_458_9 = arg_455_1:FormatText(var_458_8.content)

				arg_455_1.text_.text = var_458_9

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_10 = 17
				local var_458_11 = utf8.len(var_458_9)
				local var_458_12 = var_458_10 <= 0 and var_458_6 or var_458_6 * (var_458_11 / var_458_10)

				if var_458_12 > 0 and var_458_6 < var_458_12 then
					arg_455_1.talkMaxDuration = var_458_12

					if var_458_12 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_12 + var_458_5
					end
				end

				arg_455_1.text_.text = var_458_9
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005114", "story_v_side_new_1105005.awb") ~= 0 then
					local var_458_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005114", "story_v_side_new_1105005.awb") / 1000

					if var_458_13 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_13 + var_458_5
					end

					if var_458_8.prefab_name ~= "" and arg_455_1.actors_[var_458_8.prefab_name] ~= nil then
						local var_458_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_8.prefab_name].transform, "story_v_side_new_1105005", "1105005114", "story_v_side_new_1105005.awb")

						arg_455_1:RecordAudio("1105005114", var_458_14)
						arg_455_1:RecordAudio("1105005114", var_458_14)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005114", "story_v_side_new_1105005.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005114", "story_v_side_new_1105005.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_15 = math.max(var_458_6, arg_455_1.talkMaxDuration)

			if var_458_5 <= arg_455_1.time_ and arg_455_1.time_ < var_458_5 + var_458_15 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_5) / var_458_15

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_5 + var_458_15 and arg_455_1.time_ < var_458_5 + var_458_15 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1105005115 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1105005115
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1105005116(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1150ui_story"].transform
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.var_.moveOldPos1150ui_story = var_462_0.localPosition
			end

			local var_462_2 = 0.001

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2
				local var_462_4 = Vector3.New(0, 100, 0)

				var_462_0.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1150ui_story, var_462_4, var_462_3)

				local var_462_5 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_5.x, var_462_5.y, var_462_5.z)

				local var_462_6 = var_462_0.localEulerAngles

				var_462_6.z = 0
				var_462_6.x = 0
				var_462_0.localEulerAngles = var_462_6
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 then
				var_462_0.localPosition = Vector3.New(0, 100, 0)

				local var_462_7 = manager.ui.mainCamera.transform.position - var_462_0.position

				var_462_0.forward = Vector3.New(var_462_7.x, var_462_7.y, var_462_7.z)

				local var_462_8 = var_462_0.localEulerAngles

				var_462_8.z = 0
				var_462_8.x = 0
				var_462_0.localEulerAngles = var_462_8
			end

			local var_462_9 = 0
			local var_462_10 = 1.075

			if var_462_9 < arg_459_1.time_ and arg_459_1.time_ <= var_462_9 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_11 = arg_459_1:GetWordFromCfg(1105005115)
				local var_462_12 = arg_459_1:FormatText(var_462_11.content)

				arg_459_1.text_.text = var_462_12

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_13 = 43
				local var_462_14 = utf8.len(var_462_12)
				local var_462_15 = var_462_13 <= 0 and var_462_10 or var_462_10 * (var_462_14 / var_462_13)

				if var_462_15 > 0 and var_462_10 < var_462_15 then
					arg_459_1.talkMaxDuration = var_462_15

					if var_462_15 + var_462_9 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_15 + var_462_9
					end
				end

				arg_459_1.text_.text = var_462_12
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_16 = math.max(var_462_10, arg_459_1.talkMaxDuration)

			if var_462_9 <= arg_459_1.time_ and arg_459_1.time_ < var_462_9 + var_462_16 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_9) / var_462_16

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_9 + var_462_16 and arg_459_1.time_ < var_462_9 + var_462_16 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play1105005116 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1105005116
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1105005117(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 1.35

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_2 = arg_463_1:GetWordFromCfg(1105005116)
				local var_466_3 = arg_463_1:FormatText(var_466_2.content)

				arg_463_1.text_.text = var_466_3

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 54
				local var_466_5 = utf8.len(var_466_3)
				local var_466_6 = var_466_4 <= 0 and var_466_1 or var_466_1 * (var_466_5 / var_466_4)

				if var_466_6 > 0 and var_466_1 < var_466_6 then
					arg_463_1.talkMaxDuration = var_466_6

					if var_466_6 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_6 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_3
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_7 and arg_463_1.time_ < var_466_0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1105005117 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1105005117
		arg_467_1.duration_ = 2.77

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1105005118(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1150ui_story"]
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect1150ui_story == nil then
				arg_467_1.var_.characterEffect1150ui_story = var_470_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 and not isNil(var_470_0) then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2

				if arg_467_1.var_.characterEffect1150ui_story and not isNil(var_470_0) then
					arg_467_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 and not isNil(var_470_0) and arg_467_1.var_.characterEffect1150ui_story then
				arg_467_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_470_4 = 0

			if var_470_4 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_470_5 = arg_467_1.actors_["1150ui_story"].transform
			local var_470_6 = 0

			if var_470_6 < arg_467_1.time_ and arg_467_1.time_ <= var_470_6 + arg_470_0 then
				arg_467_1.var_.moveOldPos1150ui_story = var_470_5.localPosition
			end

			local var_470_7 = 0.001

			if var_470_6 <= arg_467_1.time_ and arg_467_1.time_ < var_470_6 + var_470_7 then
				local var_470_8 = (arg_467_1.time_ - var_470_6) / var_470_7
				local var_470_9 = Vector3.New(0, -1.01, -6.2)

				var_470_5.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1150ui_story, var_470_9, var_470_8)

				local var_470_10 = manager.ui.mainCamera.transform.position - var_470_5.position

				var_470_5.forward = Vector3.New(var_470_10.x, var_470_10.y, var_470_10.z)

				local var_470_11 = var_470_5.localEulerAngles

				var_470_11.z = 0
				var_470_11.x = 0
				var_470_5.localEulerAngles = var_470_11
			end

			if arg_467_1.time_ >= var_470_6 + var_470_7 and arg_467_1.time_ < var_470_6 + var_470_7 + arg_470_0 then
				var_470_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_470_12 = manager.ui.mainCamera.transform.position - var_470_5.position

				var_470_5.forward = Vector3.New(var_470_12.x, var_470_12.y, var_470_12.z)

				local var_470_13 = var_470_5.localEulerAngles

				var_470_13.z = 0
				var_470_13.x = 0
				var_470_5.localEulerAngles = var_470_13
			end

			local var_470_14 = 0

			if var_470_14 < arg_467_1.time_ and arg_467_1.time_ <= var_470_14 + arg_470_0 then
				arg_467_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_470_15 = 0
			local var_470_16 = 0.25

			if var_470_15 < arg_467_1.time_ and arg_467_1.time_ <= var_470_15 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_17 = arg_467_1:FormatText(StoryNameCfg[74].name)

				arg_467_1.leftNameTxt_.text = var_470_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_18 = arg_467_1:GetWordFromCfg(1105005117)
				local var_470_19 = arg_467_1:FormatText(var_470_18.content)

				arg_467_1.text_.text = var_470_19

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_20 = 10
				local var_470_21 = utf8.len(var_470_19)
				local var_470_22 = var_470_20 <= 0 and var_470_16 or var_470_16 * (var_470_21 / var_470_20)

				if var_470_22 > 0 and var_470_16 < var_470_22 then
					arg_467_1.talkMaxDuration = var_470_22

					if var_470_22 + var_470_15 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_22 + var_470_15
					end
				end

				arg_467_1.text_.text = var_470_19
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005117", "story_v_side_new_1105005.awb") ~= 0 then
					local var_470_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005117", "story_v_side_new_1105005.awb") / 1000

					if var_470_23 + var_470_15 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_23 + var_470_15
					end

					if var_470_18.prefab_name ~= "" and arg_467_1.actors_[var_470_18.prefab_name] ~= nil then
						local var_470_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_18.prefab_name].transform, "story_v_side_new_1105005", "1105005117", "story_v_side_new_1105005.awb")

						arg_467_1:RecordAudio("1105005117", var_470_24)
						arg_467_1:RecordAudio("1105005117", var_470_24)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005117", "story_v_side_new_1105005.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005117", "story_v_side_new_1105005.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_25 = math.max(var_470_16, arg_467_1.talkMaxDuration)

			if var_470_15 <= arg_467_1.time_ and arg_467_1.time_ < var_470_15 + var_470_25 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_15) / var_470_25

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_15 + var_470_25 and arg_467_1.time_ < var_470_15 + var_470_25 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play1105005118 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1105005118
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1105005119(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1150ui_story"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1150ui_story == nil then
				arg_471_1.var_.characterEffect1150ui_story = var_474_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 and not isNil(var_474_0) then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.characterEffect1150ui_story and not isNil(var_474_0) then
					local var_474_4 = Mathf.Lerp(0, 0.5, var_474_3)

					arg_471_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1150ui_story.fillRatio = var_474_4
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and not isNil(var_474_0) and arg_471_1.var_.characterEffect1150ui_story then
				local var_474_5 = 0.5

				arg_471_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1150ui_story.fillRatio = var_474_5
			end

			local var_474_6 = 0
			local var_474_7 = 0.275

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_8 = arg_471_1:FormatText(StoryNameCfg[7].name)

				arg_471_1.leftNameTxt_.text = var_474_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_9 = arg_471_1:GetWordFromCfg(1105005118)
				local var_474_10 = arg_471_1:FormatText(var_474_9.content)

				arg_471_1.text_.text = var_474_10

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_11 = 11
				local var_474_12 = utf8.len(var_474_10)
				local var_474_13 = var_474_11 <= 0 and var_474_7 or var_474_7 * (var_474_12 / var_474_11)

				if var_474_13 > 0 and var_474_7 < var_474_13 then
					arg_471_1.talkMaxDuration = var_474_13

					if var_474_13 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_6
					end
				end

				arg_471_1.text_.text = var_474_10
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_14 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_14 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_14

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_14 and arg_471_1.time_ < var_474_6 + var_474_14 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play1105005119 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1105005119
		arg_475_1.duration_ = 5.87

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1105005120(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1150ui_story"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1150ui_story == nil then
				arg_475_1.var_.characterEffect1150ui_story = var_478_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.characterEffect1150ui_story and not isNil(var_478_0) then
					arg_475_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.characterEffect1150ui_story then
				arg_475_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_478_4 = 0

			if var_478_4 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_478_5 = 0
			local var_478_6 = 0.5

			if var_478_5 < arg_475_1.time_ and arg_475_1.time_ <= var_478_5 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_7 = arg_475_1:FormatText(StoryNameCfg[74].name)

				arg_475_1.leftNameTxt_.text = var_478_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_8 = arg_475_1:GetWordFromCfg(1105005119)
				local var_478_9 = arg_475_1:FormatText(var_478_8.content)

				arg_475_1.text_.text = var_478_9

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_10 = 20
				local var_478_11 = utf8.len(var_478_9)
				local var_478_12 = var_478_10 <= 0 and var_478_6 or var_478_6 * (var_478_11 / var_478_10)

				if var_478_12 > 0 and var_478_6 < var_478_12 then
					arg_475_1.talkMaxDuration = var_478_12

					if var_478_12 + var_478_5 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_12 + var_478_5
					end
				end

				arg_475_1.text_.text = var_478_9
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005119", "story_v_side_new_1105005.awb") ~= 0 then
					local var_478_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005119", "story_v_side_new_1105005.awb") / 1000

					if var_478_13 + var_478_5 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_13 + var_478_5
					end

					if var_478_8.prefab_name ~= "" and arg_475_1.actors_[var_478_8.prefab_name] ~= nil then
						local var_478_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_8.prefab_name].transform, "story_v_side_new_1105005", "1105005119", "story_v_side_new_1105005.awb")

						arg_475_1:RecordAudio("1105005119", var_478_14)
						arg_475_1:RecordAudio("1105005119", var_478_14)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005119", "story_v_side_new_1105005.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005119", "story_v_side_new_1105005.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_15 = math.max(var_478_6, arg_475_1.talkMaxDuration)

			if var_478_5 <= arg_475_1.time_ and arg_475_1.time_ < var_478_5 + var_478_15 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_5) / var_478_15

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_5 + var_478_15 and arg_475_1.time_ < var_478_5 + var_478_15 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play1105005120 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1105005120
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1105005121(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1150ui_story"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1150ui_story == nil then
				arg_479_1.var_.characterEffect1150ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.2

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.characterEffect1150ui_story and not isNil(var_482_0) then
					local var_482_4 = Mathf.Lerp(0, 0.5, var_482_3)

					arg_479_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1150ui_story.fillRatio = var_482_4
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1150ui_story then
				local var_482_5 = 0.5

				arg_479_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1150ui_story.fillRatio = var_482_5
			end

			local var_482_6 = 0

			if var_482_6 < arg_479_1.time_ and arg_479_1.time_ <= var_482_6 + arg_482_0 then
				arg_479_1.allBtn_.enabled = false
			end

			local var_482_7 = 0.666666666666667

			if arg_479_1.time_ >= var_482_6 + var_482_7 and arg_479_1.time_ < var_482_6 + var_482_7 + arg_482_0 then
				arg_479_1.allBtn_.enabled = true
			end

			local var_482_8 = 0
			local var_482_9 = 1.45

			if var_482_8 < arg_479_1.time_ and arg_479_1.time_ <= var_482_8 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_10 = arg_479_1:GetWordFromCfg(1105005120)
				local var_482_11 = arg_479_1:FormatText(var_482_10.content)

				arg_479_1.text_.text = var_482_11

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_12 = 58
				local var_482_13 = utf8.len(var_482_11)
				local var_482_14 = var_482_12 <= 0 and var_482_9 or var_482_9 * (var_482_13 / var_482_12)

				if var_482_14 > 0 and var_482_9 < var_482_14 then
					arg_479_1.talkMaxDuration = var_482_14

					if var_482_14 + var_482_8 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_14 + var_482_8
					end
				end

				arg_479_1.text_.text = var_482_11
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_15 = math.max(var_482_9, arg_479_1.talkMaxDuration)

			if var_482_8 <= arg_479_1.time_ and arg_479_1.time_ < var_482_8 + var_482_15 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_8) / var_482_15

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_8 + var_482_15 and arg_479_1.time_ < var_482_8 + var_482_15 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1105005121 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1105005121
		arg_483_1.duration_ = 2

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1105005122(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1150ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1150ui_story == nil then
				arg_483_1.var_.characterEffect1150ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect1150ui_story and not isNil(var_486_0) then
					arg_483_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1150ui_story then
				arg_483_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_486_4 = 0

			if var_486_4 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_486_5 = 0
			local var_486_6 = 0.15

			if var_486_5 < arg_483_1.time_ and arg_483_1.time_ <= var_486_5 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_7 = arg_483_1:FormatText(StoryNameCfg[74].name)

				arg_483_1.leftNameTxt_.text = var_486_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_8 = arg_483_1:GetWordFromCfg(1105005121)
				local var_486_9 = arg_483_1:FormatText(var_486_8.content)

				arg_483_1.text_.text = var_486_9

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_10 = 6
				local var_486_11 = utf8.len(var_486_9)
				local var_486_12 = var_486_10 <= 0 and var_486_6 or var_486_6 * (var_486_11 / var_486_10)

				if var_486_12 > 0 and var_486_6 < var_486_12 then
					arg_483_1.talkMaxDuration = var_486_12

					if var_486_12 + var_486_5 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_12 + var_486_5
					end
				end

				arg_483_1.text_.text = var_486_9
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005121", "story_v_side_new_1105005.awb") ~= 0 then
					local var_486_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005121", "story_v_side_new_1105005.awb") / 1000

					if var_486_13 + var_486_5 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_13 + var_486_5
					end

					if var_486_8.prefab_name ~= "" and arg_483_1.actors_[var_486_8.prefab_name] ~= nil then
						local var_486_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_8.prefab_name].transform, "story_v_side_new_1105005", "1105005121", "story_v_side_new_1105005.awb")

						arg_483_1:RecordAudio("1105005121", var_486_14)
						arg_483_1:RecordAudio("1105005121", var_486_14)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005121", "story_v_side_new_1105005.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005121", "story_v_side_new_1105005.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_15 = math.max(var_486_6, arg_483_1.talkMaxDuration)

			if var_486_5 <= arg_483_1.time_ and arg_483_1.time_ < var_486_5 + var_486_15 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_5) / var_486_15

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_5 + var_486_15 and arg_483_1.time_ < var_486_5 + var_486_15 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1105005122 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1105005122
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1105005123(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["1150ui_story"].transform
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos1150ui_story = var_490_0.localPosition
			end

			local var_490_2 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2
				local var_490_4 = Vector3.New(0, 100, 0)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1150ui_story, var_490_4, var_490_3)

				local var_490_5 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_5.x, var_490_5.y, var_490_5.z)

				local var_490_6 = var_490_0.localEulerAngles

				var_490_6.z = 0
				var_490_6.x = 0
				var_490_0.localEulerAngles = var_490_6
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(0, 100, 0)

				local var_490_7 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_7.x, var_490_7.y, var_490_7.z)

				local var_490_8 = var_490_0.localEulerAngles

				var_490_8.z = 0
				var_490_8.x = 0
				var_490_0.localEulerAngles = var_490_8
			end

			local var_490_9 = 0
			local var_490_10 = 1.625

			if var_490_9 < arg_487_1.time_ and arg_487_1.time_ <= var_490_9 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_11 = arg_487_1:GetWordFromCfg(1105005122)
				local var_490_12 = arg_487_1:FormatText(var_490_11.content)

				arg_487_1.text_.text = var_490_12

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_13 = 65
				local var_490_14 = utf8.len(var_490_12)
				local var_490_15 = var_490_13 <= 0 and var_490_10 or var_490_10 * (var_490_14 / var_490_13)

				if var_490_15 > 0 and var_490_10 < var_490_15 then
					arg_487_1.talkMaxDuration = var_490_15

					if var_490_15 + var_490_9 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_15 + var_490_9
					end
				end

				arg_487_1.text_.text = var_490_12
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_16 = math.max(var_490_10, arg_487_1.talkMaxDuration)

			if var_490_9 <= arg_487_1.time_ and arg_487_1.time_ < var_490_9 + var_490_16 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_9) / var_490_16

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_9 + var_490_16 and arg_487_1.time_ < var_490_9 + var_490_16 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play1105005123 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1105005123
		arg_491_1.duration_ = 6.83

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1105005124(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1150ui_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect1150ui_story == nil then
				arg_491_1.var_.characterEffect1150ui_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect1150ui_story and not isNil(var_494_0) then
					arg_491_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect1150ui_story then
				arg_491_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_494_4 = 0

			if var_494_4 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_494_5 = 0

			if var_494_5 < arg_491_1.time_ and arg_491_1.time_ <= var_494_5 + arg_494_0 then
				arg_491_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_494_6 = arg_491_1.actors_["1150ui_story"].transform
			local var_494_7 = 0

			if var_494_7 < arg_491_1.time_ and arg_491_1.time_ <= var_494_7 + arg_494_0 then
				arg_491_1.var_.moveOldPos1150ui_story = var_494_6.localPosition
			end

			local var_494_8 = 0.001

			if var_494_7 <= arg_491_1.time_ and arg_491_1.time_ < var_494_7 + var_494_8 then
				local var_494_9 = (arg_491_1.time_ - var_494_7) / var_494_8
				local var_494_10 = Vector3.New(0, -1.01, -6.2)

				var_494_6.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1150ui_story, var_494_10, var_494_9)

				local var_494_11 = manager.ui.mainCamera.transform.position - var_494_6.position

				var_494_6.forward = Vector3.New(var_494_11.x, var_494_11.y, var_494_11.z)

				local var_494_12 = var_494_6.localEulerAngles

				var_494_12.z = 0
				var_494_12.x = 0
				var_494_6.localEulerAngles = var_494_12
			end

			if arg_491_1.time_ >= var_494_7 + var_494_8 and arg_491_1.time_ < var_494_7 + var_494_8 + arg_494_0 then
				var_494_6.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_494_13 = manager.ui.mainCamera.transform.position - var_494_6.position

				var_494_6.forward = Vector3.New(var_494_13.x, var_494_13.y, var_494_13.z)

				local var_494_14 = var_494_6.localEulerAngles

				var_494_14.z = 0
				var_494_14.x = 0
				var_494_6.localEulerAngles = var_494_14
			end

			local var_494_15 = 0
			local var_494_16 = 0.85

			if var_494_15 < arg_491_1.time_ and arg_491_1.time_ <= var_494_15 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_17 = arg_491_1:FormatText(StoryNameCfg[74].name)

				arg_491_1.leftNameTxt_.text = var_494_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_18 = arg_491_1:GetWordFromCfg(1105005123)
				local var_494_19 = arg_491_1:FormatText(var_494_18.content)

				arg_491_1.text_.text = var_494_19

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_20 = 34
				local var_494_21 = utf8.len(var_494_19)
				local var_494_22 = var_494_20 <= 0 and var_494_16 or var_494_16 * (var_494_21 / var_494_20)

				if var_494_22 > 0 and var_494_16 < var_494_22 then
					arg_491_1.talkMaxDuration = var_494_22

					if var_494_22 + var_494_15 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_22 + var_494_15
					end
				end

				arg_491_1.text_.text = var_494_19
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005123", "story_v_side_new_1105005.awb") ~= 0 then
					local var_494_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005123", "story_v_side_new_1105005.awb") / 1000

					if var_494_23 + var_494_15 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_23 + var_494_15
					end

					if var_494_18.prefab_name ~= "" and arg_491_1.actors_[var_494_18.prefab_name] ~= nil then
						local var_494_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_18.prefab_name].transform, "story_v_side_new_1105005", "1105005123", "story_v_side_new_1105005.awb")

						arg_491_1:RecordAudio("1105005123", var_494_24)
						arg_491_1:RecordAudio("1105005123", var_494_24)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005123", "story_v_side_new_1105005.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005123", "story_v_side_new_1105005.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_25 = math.max(var_494_16, arg_491_1.talkMaxDuration)

			if var_494_15 <= arg_491_1.time_ and arg_491_1.time_ < var_494_15 + var_494_25 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_15) / var_494_25

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_15 + var_494_25 and arg_491_1.time_ < var_494_15 + var_494_25 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play1105005124 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1105005124
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1105005125(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["1150ui_story"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect1150ui_story == nil then
				arg_495_1.var_.characterEffect1150ui_story = var_498_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.characterEffect1150ui_story and not isNil(var_498_0) then
					local var_498_4 = Mathf.Lerp(0, 0.5, var_498_3)

					arg_495_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_495_1.var_.characterEffect1150ui_story.fillRatio = var_498_4
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect1150ui_story then
				local var_498_5 = 0.5

				arg_495_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_495_1.var_.characterEffect1150ui_story.fillRatio = var_498_5
			end

			local var_498_6 = 0
			local var_498_7 = 0.475

			if var_498_6 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_8 = arg_495_1:FormatText(StoryNameCfg[7].name)

				arg_495_1.leftNameTxt_.text = var_498_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_9 = arg_495_1:GetWordFromCfg(1105005124)
				local var_498_10 = arg_495_1:FormatText(var_498_9.content)

				arg_495_1.text_.text = var_498_10

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_11 = 19
				local var_498_12 = utf8.len(var_498_10)
				local var_498_13 = var_498_11 <= 0 and var_498_7 or var_498_7 * (var_498_12 / var_498_11)

				if var_498_13 > 0 and var_498_7 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13

					if var_498_13 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_6
					end
				end

				arg_495_1.text_.text = var_498_10
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_14 = math.max(var_498_7, arg_495_1.talkMaxDuration)

			if var_498_6 <= arg_495_1.time_ and arg_495_1.time_ < var_498_6 + var_498_14 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_6) / var_498_14

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_6 + var_498_14 and arg_495_1.time_ < var_498_6 + var_498_14 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1105005125 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1105005125
		arg_499_1.duration_ = 3.8

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1105005126(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1150ui_story"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1150ui_story == nil then
				arg_499_1.var_.characterEffect1150ui_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 and not isNil(var_502_0) then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.characterEffect1150ui_story and not isNil(var_502_0) then
					arg_499_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and not isNil(var_502_0) and arg_499_1.var_.characterEffect1150ui_story then
				arg_499_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_502_4 = 0

			if var_502_4 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_502_5 = 0
			local var_502_6 = 0.3

			if var_502_5 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_7 = arg_499_1:FormatText(StoryNameCfg[74].name)

				arg_499_1.leftNameTxt_.text = var_502_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_8 = arg_499_1:GetWordFromCfg(1105005125)
				local var_502_9 = arg_499_1:FormatText(var_502_8.content)

				arg_499_1.text_.text = var_502_9

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_10 = 12
				local var_502_11 = utf8.len(var_502_9)
				local var_502_12 = var_502_10 <= 0 and var_502_6 or var_502_6 * (var_502_11 / var_502_10)

				if var_502_12 > 0 and var_502_6 < var_502_12 then
					arg_499_1.talkMaxDuration = var_502_12

					if var_502_12 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_12 + var_502_5
					end
				end

				arg_499_1.text_.text = var_502_9
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005125", "story_v_side_new_1105005.awb") ~= 0 then
					local var_502_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005125", "story_v_side_new_1105005.awb") / 1000

					if var_502_13 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_5
					end

					if var_502_8.prefab_name ~= "" and arg_499_1.actors_[var_502_8.prefab_name] ~= nil then
						local var_502_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_8.prefab_name].transform, "story_v_side_new_1105005", "1105005125", "story_v_side_new_1105005.awb")

						arg_499_1:RecordAudio("1105005125", var_502_14)
						arg_499_1:RecordAudio("1105005125", var_502_14)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005125", "story_v_side_new_1105005.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005125", "story_v_side_new_1105005.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_15 = math.max(var_502_6, arg_499_1.talkMaxDuration)

			if var_502_5 <= arg_499_1.time_ and arg_499_1.time_ < var_502_5 + var_502_15 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_5) / var_502_15

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_5 + var_502_15 and arg_499_1.time_ < var_502_5 + var_502_15 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1105005126 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1105005126
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1105005127(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1150ui_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1150ui_story == nil then
				arg_503_1.var_.characterEffect1150ui_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect1150ui_story and not isNil(var_506_0) then
					local var_506_4 = Mathf.Lerp(0, 0.5, var_506_3)

					arg_503_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1150ui_story.fillRatio = var_506_4
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1150ui_story then
				local var_506_5 = 0.5

				arg_503_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1150ui_story.fillRatio = var_506_5
			end

			local var_506_6 = 0
			local var_506_7 = 0.175

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_8 = arg_503_1:FormatText(StoryNameCfg[7].name)

				arg_503_1.leftNameTxt_.text = var_506_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_9 = arg_503_1:GetWordFromCfg(1105005126)
				local var_506_10 = arg_503_1:FormatText(var_506_9.content)

				arg_503_1.text_.text = var_506_10

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_11 = 7
				local var_506_12 = utf8.len(var_506_10)
				local var_506_13 = var_506_11 <= 0 and var_506_7 or var_506_7 * (var_506_12 / var_506_11)

				if var_506_13 > 0 and var_506_7 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_6 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_6
					end
				end

				arg_503_1.text_.text = var_506_10
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_14 = math.max(var_506_7, arg_503_1.talkMaxDuration)

			if var_506_6 <= arg_503_1.time_ and arg_503_1.time_ < var_506_6 + var_506_14 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_6) / var_506_14

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_6 + var_506_14 and arg_503_1.time_ < var_506_6 + var_506_14 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1105005127 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1105005127
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1105005128(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1150ui_story"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect1150ui_story == nil then
				arg_507_1.var_.characterEffect1150ui_story = var_510_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.2

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.characterEffect1150ui_story and not isNil(var_510_0) then
					local var_510_4 = Mathf.Lerp(0, 0.5, var_510_3)

					arg_507_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1150ui_story.fillRatio = var_510_4
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect1150ui_story then
				local var_510_5 = 0.5

				arg_507_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1150ui_story.fillRatio = var_510_5
			end

			local var_510_6 = 0

			if var_510_6 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				arg_507_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_510_7 = 0

			if var_510_7 < arg_507_1.time_ and arg_507_1.time_ <= var_510_7 + arg_510_0 then
				arg_507_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_510_8 = 0
			local var_510_9 = 0.9

			if var_510_8 < arg_507_1.time_ and arg_507_1.time_ <= var_510_8 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_10 = arg_507_1:GetWordFromCfg(1105005127)
				local var_510_11 = arg_507_1:FormatText(var_510_10.content)

				arg_507_1.text_.text = var_510_11

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_12 = 36
				local var_510_13 = utf8.len(var_510_11)
				local var_510_14 = var_510_12 <= 0 and var_510_9 or var_510_9 * (var_510_13 / var_510_12)

				if var_510_14 > 0 and var_510_9 < var_510_14 then
					arg_507_1.talkMaxDuration = var_510_14

					if var_510_14 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_14 + var_510_8
					end
				end

				arg_507_1.text_.text = var_510_11
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_15 = math.max(var_510_9, arg_507_1.talkMaxDuration)

			if var_510_8 <= arg_507_1.time_ and arg_507_1.time_ < var_510_8 + var_510_15 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_8) / var_510_15

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_8 + var_510_15 and arg_507_1.time_ < var_510_8 + var_510_15 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1105005128 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1105005128
		arg_511_1.duration_ = 6.17

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1105005129(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1150ui_story"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1150ui_story == nil then
				arg_511_1.var_.characterEffect1150ui_story = var_514_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.characterEffect1150ui_story and not isNil(var_514_0) then
					arg_511_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1150ui_story then
				arg_511_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_514_4 = 0
			local var_514_5 = 0.575

			if var_514_4 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_6 = arg_511_1:FormatText(StoryNameCfg[74].name)

				arg_511_1.leftNameTxt_.text = var_514_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_7 = arg_511_1:GetWordFromCfg(1105005128)
				local var_514_8 = arg_511_1:FormatText(var_514_7.content)

				arg_511_1.text_.text = var_514_8

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 23
				local var_514_10 = utf8.len(var_514_8)
				local var_514_11 = var_514_9 <= 0 and var_514_5 or var_514_5 * (var_514_10 / var_514_9)

				if var_514_11 > 0 and var_514_5 < var_514_11 then
					arg_511_1.talkMaxDuration = var_514_11

					if var_514_11 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_11 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_8
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005128", "story_v_side_new_1105005.awb") ~= 0 then
					local var_514_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005128", "story_v_side_new_1105005.awb") / 1000

					if var_514_12 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_12 + var_514_4
					end

					if var_514_7.prefab_name ~= "" and arg_511_1.actors_[var_514_7.prefab_name] ~= nil then
						local var_514_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_7.prefab_name].transform, "story_v_side_new_1105005", "1105005128", "story_v_side_new_1105005.awb")

						arg_511_1:RecordAudio("1105005128", var_514_13)
						arg_511_1:RecordAudio("1105005128", var_514_13)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005128", "story_v_side_new_1105005.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005128", "story_v_side_new_1105005.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_14 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_14 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_14

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_14 and arg_511_1.time_ < var_514_4 + var_514_14 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1105005129 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1105005129
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1105005130(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1150ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1150ui_story == nil then
				arg_515_1.var_.characterEffect1150ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect1150ui_story and not isNil(var_518_0) then
					local var_518_4 = Mathf.Lerp(0, 0.5, var_518_3)

					arg_515_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1150ui_story.fillRatio = var_518_4
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1150ui_story then
				local var_518_5 = 0.5

				arg_515_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1150ui_story.fillRatio = var_518_5
			end

			local var_518_6 = 0
			local var_518_7 = 0.475

			if var_518_6 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_8 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_9 = arg_515_1:GetWordFromCfg(1105005129)
				local var_518_10 = arg_515_1:FormatText(var_518_9.content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 19
				local var_518_12 = utf8.len(var_518_10)
				local var_518_13 = var_518_11 <= 0 and var_518_7 or var_518_7 * (var_518_12 / var_518_11)

				if var_518_13 > 0 and var_518_7 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1105005130 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1105005130
		arg_519_1.duration_ = 2.13

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1105005131(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1150ui_story"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1150ui_story == nil then
				arg_519_1.var_.characterEffect1150ui_story = var_522_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.characterEffect1150ui_story and not isNil(var_522_0) then
					arg_519_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1150ui_story then
				arg_519_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_522_4 = 0

			if var_522_4 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_522_5 = 0

			if var_522_5 < arg_519_1.time_ and arg_519_1.time_ <= var_522_5 + arg_522_0 then
				arg_519_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_522_6 = 0
			local var_522_7 = 0.225

			if var_522_6 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_8 = arg_519_1:FormatText(StoryNameCfg[74].name)

				arg_519_1.leftNameTxt_.text = var_522_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_9 = arg_519_1:GetWordFromCfg(1105005130)
				local var_522_10 = arg_519_1:FormatText(var_522_9.content)

				arg_519_1.text_.text = var_522_10

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_11 = 9
				local var_522_12 = utf8.len(var_522_10)
				local var_522_13 = var_522_11 <= 0 and var_522_7 or var_522_7 * (var_522_12 / var_522_11)

				if var_522_13 > 0 and var_522_7 < var_522_13 then
					arg_519_1.talkMaxDuration = var_522_13

					if var_522_13 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_10
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005130", "story_v_side_new_1105005.awb") ~= 0 then
					local var_522_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005130", "story_v_side_new_1105005.awb") / 1000

					if var_522_14 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_14 + var_522_6
					end

					if var_522_9.prefab_name ~= "" and arg_519_1.actors_[var_522_9.prefab_name] ~= nil then
						local var_522_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_9.prefab_name].transform, "story_v_side_new_1105005", "1105005130", "story_v_side_new_1105005.awb")

						arg_519_1:RecordAudio("1105005130", var_522_15)
						arg_519_1:RecordAudio("1105005130", var_522_15)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005130", "story_v_side_new_1105005.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005130", "story_v_side_new_1105005.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_16 and arg_519_1.time_ < var_522_6 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1105005131 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1105005131
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1105005132(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1150ui_story"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1150ui_story == nil then
				arg_523_1.var_.characterEffect1150ui_story = var_526_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.characterEffect1150ui_story and not isNil(var_526_0) then
					local var_526_4 = Mathf.Lerp(0, 0.5, var_526_3)

					arg_523_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1150ui_story.fillRatio = var_526_4
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1150ui_story then
				local var_526_5 = 0.5

				arg_523_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1150ui_story.fillRatio = var_526_5
			end

			local var_526_6 = 0
			local var_526_7 = 0.525

			if var_526_6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_6 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_8 = arg_523_1:FormatText(StoryNameCfg[7].name)

				arg_523_1.leftNameTxt_.text = var_526_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_9 = arg_523_1:GetWordFromCfg(1105005131)
				local var_526_10 = arg_523_1:FormatText(var_526_9.content)

				arg_523_1.text_.text = var_526_10

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_11 = 21
				local var_526_12 = utf8.len(var_526_10)
				local var_526_13 = var_526_11 <= 0 and var_526_7 or var_526_7 * (var_526_12 / var_526_11)

				if var_526_13 > 0 and var_526_7 < var_526_13 then
					arg_523_1.talkMaxDuration = var_526_13

					if var_526_13 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_13 + var_526_6
					end
				end

				arg_523_1.text_.text = var_526_10
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_14 = math.max(var_526_7, arg_523_1.talkMaxDuration)

			if var_526_6 <= arg_523_1.time_ and arg_523_1.time_ < var_526_6 + var_526_14 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_6) / var_526_14

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_6 + var_526_14 and arg_523_1.time_ < var_526_6 + var_526_14 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1105005132 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1105005132
		arg_527_1.duration_ = 1.87

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1105005133(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1150ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1150ui_story == nil then
				arg_527_1.var_.characterEffect1150ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect1150ui_story and not isNil(var_530_0) then
					arg_527_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1150ui_story then
				arg_527_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_530_4 = 0
			local var_530_5 = 0.225

			if var_530_4 < arg_527_1.time_ and arg_527_1.time_ <= var_530_4 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_6 = arg_527_1:FormatText(StoryNameCfg[74].name)

				arg_527_1.leftNameTxt_.text = var_530_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_7 = arg_527_1:GetWordFromCfg(1105005132)
				local var_530_8 = arg_527_1:FormatText(var_530_7.content)

				arg_527_1.text_.text = var_530_8

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_9 = 9
				local var_530_10 = utf8.len(var_530_8)
				local var_530_11 = var_530_9 <= 0 and var_530_5 or var_530_5 * (var_530_10 / var_530_9)

				if var_530_11 > 0 and var_530_5 < var_530_11 then
					arg_527_1.talkMaxDuration = var_530_11

					if var_530_11 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_11 + var_530_4
					end
				end

				arg_527_1.text_.text = var_530_8
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005132", "story_v_side_new_1105005.awb") ~= 0 then
					local var_530_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005132", "story_v_side_new_1105005.awb") / 1000

					if var_530_12 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_12 + var_530_4
					end

					if var_530_7.prefab_name ~= "" and arg_527_1.actors_[var_530_7.prefab_name] ~= nil then
						local var_530_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_7.prefab_name].transform, "story_v_side_new_1105005", "1105005132", "story_v_side_new_1105005.awb")

						arg_527_1:RecordAudio("1105005132", var_530_13)
						arg_527_1:RecordAudio("1105005132", var_530_13)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005132", "story_v_side_new_1105005.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005132", "story_v_side_new_1105005.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_14 = math.max(var_530_5, arg_527_1.talkMaxDuration)

			if var_530_4 <= arg_527_1.time_ and arg_527_1.time_ < var_530_4 + var_530_14 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_4) / var_530_14

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_4 + var_530_14 and arg_527_1.time_ < var_530_4 + var_530_14 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1105005133 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1105005133
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1105005134(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1150ui_story"]
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect1150ui_story == nil then
				arg_531_1.var_.characterEffect1150ui_story = var_534_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.2

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 and not isNil(var_534_0) then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2

				if arg_531_1.var_.characterEffect1150ui_story and not isNil(var_534_0) then
					local var_534_4 = Mathf.Lerp(0, 0.5, var_534_3)

					arg_531_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1150ui_story.fillRatio = var_534_4
				end
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect1150ui_story then
				local var_534_5 = 0.5

				arg_531_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1150ui_story.fillRatio = var_534_5
			end

			local var_534_6 = 0
			local var_534_7 = 0.475

			if var_534_6 < arg_531_1.time_ and arg_531_1.time_ <= var_534_6 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_8 = arg_531_1:FormatText(StoryNameCfg[7].name)

				arg_531_1.leftNameTxt_.text = var_534_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_9 = arg_531_1:GetWordFromCfg(1105005133)
				local var_534_10 = arg_531_1:FormatText(var_534_9.content)

				arg_531_1.text_.text = var_534_10

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_11 = 19
				local var_534_12 = utf8.len(var_534_10)
				local var_534_13 = var_534_11 <= 0 and var_534_7 or var_534_7 * (var_534_12 / var_534_11)

				if var_534_13 > 0 and var_534_7 < var_534_13 then
					arg_531_1.talkMaxDuration = var_534_13

					if var_534_13 + var_534_6 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_6
					end
				end

				arg_531_1.text_.text = var_534_10
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_14 = math.max(var_534_7, arg_531_1.talkMaxDuration)

			if var_534_6 <= arg_531_1.time_ and arg_531_1.time_ < var_534_6 + var_534_14 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_6) / var_534_14

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_6 + var_534_14 and arg_531_1.time_ < var_534_6 + var_534_14 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1105005134 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1105005134
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1105005135(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1150ui_story"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos1150ui_story = var_538_0.localPosition
			end

			local var_538_2 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(0, 100, 0)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1150ui_story, var_538_4, var_538_3)

				local var_538_5 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_5.x, var_538_5.y, var_538_5.z)

				local var_538_6 = var_538_0.localEulerAngles

				var_538_6.z = 0
				var_538_6.x = 0
				var_538_0.localEulerAngles = var_538_6
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0, 100, 0)

				local var_538_7 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_7.x, var_538_7.y, var_538_7.z)

				local var_538_8 = var_538_0.localEulerAngles

				var_538_8.z = 0
				var_538_8.x = 0
				var_538_0.localEulerAngles = var_538_8
			end

			local var_538_9 = 0
			local var_538_10 = 0.8

			if var_538_9 < arg_535_1.time_ and arg_535_1.time_ <= var_538_9 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_11 = arg_535_1:GetWordFromCfg(1105005134)
				local var_538_12 = arg_535_1:FormatText(var_538_11.content)

				arg_535_1.text_.text = var_538_12

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_13 = 32
				local var_538_14 = utf8.len(var_538_12)
				local var_538_15 = var_538_13 <= 0 and var_538_10 or var_538_10 * (var_538_14 / var_538_13)

				if var_538_15 > 0 and var_538_10 < var_538_15 then
					arg_535_1.talkMaxDuration = var_538_15

					if var_538_15 + var_538_9 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_15 + var_538_9
					end
				end

				arg_535_1.text_.text = var_538_12
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_16 = math.max(var_538_10, arg_535_1.talkMaxDuration)

			if var_538_9 <= arg_535_1.time_ and arg_535_1.time_ < var_538_9 + var_538_16 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_9) / var_538_16

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_9 + var_538_16 and arg_535_1.time_ < var_538_9 + var_538_16 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1105005135 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1105005135
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1105005136(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 1.05

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_2 = arg_539_1:FormatText(StoryNameCfg[7].name)

				arg_539_1.leftNameTxt_.text = var_542_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:GetWordFromCfg(1105005135)
				local var_542_4 = arg_539_1:FormatText(var_542_3.content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 42
				local var_542_6 = utf8.len(var_542_4)
				local var_542_7 = var_542_5 <= 0 and var_542_1 or var_542_1 * (var_542_6 / var_542_5)

				if var_542_7 > 0 and var_542_1 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_8 and arg_539_1.time_ < var_542_0 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1105005136 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1105005136
		arg_543_1.duration_ = 3.8

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1105005137(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1150ui_story"]
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 and not isNil(var_546_0) and arg_543_1.var_.characterEffect1150ui_story == nil then
				arg_543_1.var_.characterEffect1150ui_story = var_546_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_2 = 0.200000002980232

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 and not isNil(var_546_0) then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2

				if arg_543_1.var_.characterEffect1150ui_story and not isNil(var_546_0) then
					arg_543_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 and not isNil(var_546_0) and arg_543_1.var_.characterEffect1150ui_story then
				arg_543_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_546_4 = 0

			if var_546_4 < arg_543_1.time_ and arg_543_1.time_ <= var_546_4 + arg_546_0 then
				arg_543_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_546_5 = arg_543_1.actors_["1150ui_story"].transform
			local var_546_6 = 0

			if var_546_6 < arg_543_1.time_ and arg_543_1.time_ <= var_546_6 + arg_546_0 then
				arg_543_1.var_.moveOldPos1150ui_story = var_546_5.localPosition
			end

			local var_546_7 = 0.001

			if var_546_6 <= arg_543_1.time_ and arg_543_1.time_ < var_546_6 + var_546_7 then
				local var_546_8 = (arg_543_1.time_ - var_546_6) / var_546_7
				local var_546_9 = Vector3.New(0, -1.01, -6.2)

				var_546_5.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1150ui_story, var_546_9, var_546_8)

				local var_546_10 = manager.ui.mainCamera.transform.position - var_546_5.position

				var_546_5.forward = Vector3.New(var_546_10.x, var_546_10.y, var_546_10.z)

				local var_546_11 = var_546_5.localEulerAngles

				var_546_11.z = 0
				var_546_11.x = 0
				var_546_5.localEulerAngles = var_546_11
			end

			if arg_543_1.time_ >= var_546_6 + var_546_7 and arg_543_1.time_ < var_546_6 + var_546_7 + arg_546_0 then
				var_546_5.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_546_12 = manager.ui.mainCamera.transform.position - var_546_5.position

				var_546_5.forward = Vector3.New(var_546_12.x, var_546_12.y, var_546_12.z)

				local var_546_13 = var_546_5.localEulerAngles

				var_546_13.z = 0
				var_546_13.x = 0
				var_546_5.localEulerAngles = var_546_13
			end

			local var_546_14 = 0
			local var_546_15 = 0.55

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_16 = arg_543_1:FormatText(StoryNameCfg[74].name)

				arg_543_1.leftNameTxt_.text = var_546_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_17 = arg_543_1:GetWordFromCfg(1105005136)
				local var_546_18 = arg_543_1:FormatText(var_546_17.content)

				arg_543_1.text_.text = var_546_18

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_19 = 22
				local var_546_20 = utf8.len(var_546_18)
				local var_546_21 = var_546_19 <= 0 and var_546_15 or var_546_15 * (var_546_20 / var_546_19)

				if var_546_21 > 0 and var_546_15 < var_546_21 then
					arg_543_1.talkMaxDuration = var_546_21

					if var_546_21 + var_546_14 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_21 + var_546_14
					end
				end

				arg_543_1.text_.text = var_546_18
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005136", "story_v_side_new_1105005.awb") ~= 0 then
					local var_546_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005136", "story_v_side_new_1105005.awb") / 1000

					if var_546_22 + var_546_14 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_22 + var_546_14
					end

					if var_546_17.prefab_name ~= "" and arg_543_1.actors_[var_546_17.prefab_name] ~= nil then
						local var_546_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_17.prefab_name].transform, "story_v_side_new_1105005", "1105005136", "story_v_side_new_1105005.awb")

						arg_543_1:RecordAudio("1105005136", var_546_23)
						arg_543_1:RecordAudio("1105005136", var_546_23)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005136", "story_v_side_new_1105005.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005136", "story_v_side_new_1105005.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_24 = math.max(var_546_15, arg_543_1.talkMaxDuration)

			if var_546_14 <= arg_543_1.time_ and arg_543_1.time_ < var_546_14 + var_546_24 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_14) / var_546_24

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_14 + var_546_24 and arg_543_1.time_ < var_546_14 + var_546_24 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play1105005137 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1105005137
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1105005138(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1150ui_story"].transform
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.var_.moveOldPos1150ui_story = var_550_0.localPosition
			end

			local var_550_2 = 0.001

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2
				local var_550_4 = Vector3.New(0, 100, 0)

				var_550_0.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1150ui_story, var_550_4, var_550_3)

				local var_550_5 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_5.x, var_550_5.y, var_550_5.z)

				local var_550_6 = var_550_0.localEulerAngles

				var_550_6.z = 0
				var_550_6.x = 0
				var_550_0.localEulerAngles = var_550_6
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 then
				var_550_0.localPosition = Vector3.New(0, 100, 0)

				local var_550_7 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_7.x, var_550_7.y, var_550_7.z)

				local var_550_8 = var_550_0.localEulerAngles

				var_550_8.z = 0
				var_550_8.x = 0
				var_550_0.localEulerAngles = var_550_8
			end

			local var_550_9 = 0
			local var_550_10 = 0.35

			if var_550_9 < arg_547_1.time_ and arg_547_1.time_ <= var_550_9 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_11 = arg_547_1:FormatText(StoryNameCfg[7].name)

				arg_547_1.leftNameTxt_.text = var_550_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_12 = arg_547_1:GetWordFromCfg(1105005137)
				local var_550_13 = arg_547_1:FormatText(var_550_12.content)

				arg_547_1.text_.text = var_550_13

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_14 = 14
				local var_550_15 = utf8.len(var_550_13)
				local var_550_16 = var_550_14 <= 0 and var_550_10 or var_550_10 * (var_550_15 / var_550_14)

				if var_550_16 > 0 and var_550_10 < var_550_16 then
					arg_547_1.talkMaxDuration = var_550_16

					if var_550_16 + var_550_9 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_16 + var_550_9
					end
				end

				arg_547_1.text_.text = var_550_13
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_17 = math.max(var_550_10, arg_547_1.talkMaxDuration)

			if var_550_9 <= arg_547_1.time_ and arg_547_1.time_ < var_550_9 + var_550_17 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_9) / var_550_17

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_9 + var_550_17 and arg_547_1.time_ < var_550_9 + var_550_17 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play1105005138 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1105005138
		arg_551_1.duration_ = 15.2

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1105005139(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = "ST17"

			if arg_551_1.bgs_[var_554_0] == nil then
				local var_554_1 = Object.Instantiate(arg_551_1.paintGo_)

				var_554_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_554_0)
				var_554_1.name = var_554_0
				var_554_1.transform.parent = arg_551_1.stage_.transform
				var_554_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_551_1.bgs_[var_554_0] = var_554_1
			end

			local var_554_2 = 2

			if var_554_2 < arg_551_1.time_ and arg_551_1.time_ <= var_554_2 + arg_554_0 then
				local var_554_3 = manager.ui.mainCamera.transform.localPosition
				local var_554_4 = Vector3.New(0, 0, 10) + Vector3.New(var_554_3.x, var_554_3.y, 0)
				local var_554_5 = arg_551_1.bgs_.ST17

				var_554_5.transform.localPosition = var_554_4
				var_554_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_554_6 = var_554_5:GetComponent("SpriteRenderer")

				if var_554_6 and var_554_6.sprite then
					local var_554_7 = (var_554_5.transform.localPosition - var_554_3).z
					local var_554_8 = manager.ui.mainCameraCom_
					local var_554_9 = 2 * var_554_7 * Mathf.Tan(var_554_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_554_10 = var_554_9 * var_554_8.aspect
					local var_554_11 = var_554_6.sprite.bounds.size.x
					local var_554_12 = var_554_6.sprite.bounds.size.y
					local var_554_13 = var_554_10 / var_554_11
					local var_554_14 = var_554_9 / var_554_12
					local var_554_15 = var_554_14 < var_554_13 and var_554_13 or var_554_14

					var_554_5.transform.localScale = Vector3.New(var_554_15, var_554_15, 0)
				end

				for iter_554_0, iter_554_1 in pairs(arg_551_1.bgs_) do
					if iter_554_0 ~= "ST17" then
						iter_554_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_554_16 = 4.03400000184774

			if var_554_16 < arg_551_1.time_ and arg_551_1.time_ <= var_554_16 + arg_554_0 then
				arg_551_1.allBtn_.enabled = false
			end

			local var_554_17 = 0.3

			if arg_551_1.time_ >= var_554_16 + var_554_17 and arg_551_1.time_ < var_554_16 + var_554_17 + arg_554_0 then
				arg_551_1.allBtn_.enabled = true
			end

			local var_554_18 = 0

			if var_554_18 < arg_551_1.time_ and arg_551_1.time_ <= var_554_18 + arg_554_0 then
				arg_551_1.mask_.enabled = true
				arg_551_1.mask_.raycastTarget = true

				arg_551_1:SetGaussion(false)
			end

			local var_554_19 = 2

			if var_554_18 <= arg_551_1.time_ and arg_551_1.time_ < var_554_18 + var_554_19 then
				local var_554_20 = (arg_551_1.time_ - var_554_18) / var_554_19
				local var_554_21 = Color.New(0, 0, 0)

				var_554_21.a = Mathf.Lerp(0, 1, var_554_20)
				arg_551_1.mask_.color = var_554_21
			end

			if arg_551_1.time_ >= var_554_18 + var_554_19 and arg_551_1.time_ < var_554_18 + var_554_19 + arg_554_0 then
				local var_554_22 = Color.New(0, 0, 0)

				var_554_22.a = 1
				arg_551_1.mask_.color = var_554_22
			end

			local var_554_23 = 2

			if var_554_23 < arg_551_1.time_ and arg_551_1.time_ <= var_554_23 + arg_554_0 then
				arg_551_1.mask_.enabled = true
				arg_551_1.mask_.raycastTarget = true

				arg_551_1:SetGaussion(false)
			end

			local var_554_24 = 2

			if var_554_23 <= arg_551_1.time_ and arg_551_1.time_ < var_554_23 + var_554_24 then
				local var_554_25 = (arg_551_1.time_ - var_554_23) / var_554_24
				local var_554_26 = Color.New(0, 0, 0)

				var_554_26.a = Mathf.Lerp(1, 0, var_554_25)
				arg_551_1.mask_.color = var_554_26
			end

			if arg_551_1.time_ >= var_554_23 + var_554_24 and arg_551_1.time_ < var_554_23 + var_554_24 + arg_554_0 then
				local var_554_27 = Color.New(0, 0, 0)
				local var_554_28 = 0

				arg_551_1.mask_.enabled = false
				var_554_27.a = var_554_28
				arg_551_1.mask_.color = var_554_27
			end

			local var_554_29 = "115001ui_story"

			if arg_551_1.actors_[var_554_29] == nil then
				local var_554_30 = Asset.Load("Char/" .. "115001ui_story")

				if not isNil(var_554_30) then
					local var_554_31 = Object.Instantiate(Asset.Load("Char/" .. "115001ui_story"), arg_551_1.stage_.transform)

					var_554_31.name = var_554_29
					var_554_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_551_1.actors_[var_554_29] = var_554_31

					local var_554_32 = var_554_31:GetComponentInChildren(typeof(CharacterEffect))

					var_554_32.enabled = true

					local var_554_33 = GameObjectTools.GetOrAddComponent(var_554_31, typeof(DynamicBoneHelper))

					if var_554_33 then
						var_554_33:EnableDynamicBone(false)
					end

					arg_551_1:ShowWeapon(var_554_32.transform, false)

					arg_551_1.var_[var_554_29 .. "Animator"] = var_554_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_551_1.var_[var_554_29 .. "Animator"].applyRootMotion = true
					arg_551_1.var_[var_554_29 .. "LipSync"] = var_554_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_554_34 = arg_551_1.actors_["115001ui_story"].transform
			local var_554_35 = 4

			if var_554_35 < arg_551_1.time_ and arg_551_1.time_ <= var_554_35 + arg_554_0 then
				arg_551_1.var_.moveOldPos115001ui_story = var_554_34.localPosition

				local var_554_36 = "115001ui_story"

				arg_551_1:ShowWeapon(arg_551_1.var_[var_554_36 .. "Animator"].transform, false)
			end

			local var_554_37 = 0.001

			if var_554_35 <= arg_551_1.time_ and arg_551_1.time_ < var_554_35 + var_554_37 then
				local var_554_38 = (arg_551_1.time_ - var_554_35) / var_554_37
				local var_554_39 = Vector3.New(0, -1.033, -6.3)

				var_554_34.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos115001ui_story, var_554_39, var_554_38)

				local var_554_40 = manager.ui.mainCamera.transform.position - var_554_34.position

				var_554_34.forward = Vector3.New(var_554_40.x, var_554_40.y, var_554_40.z)

				local var_554_41 = var_554_34.localEulerAngles

				var_554_41.z = 0
				var_554_41.x = 0
				var_554_34.localEulerAngles = var_554_41
			end

			if arg_551_1.time_ >= var_554_35 + var_554_37 and arg_551_1.time_ < var_554_35 + var_554_37 + arg_554_0 then
				var_554_34.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_554_42 = manager.ui.mainCamera.transform.position - var_554_34.position

				var_554_34.forward = Vector3.New(var_554_42.x, var_554_42.y, var_554_42.z)

				local var_554_43 = var_554_34.localEulerAngles

				var_554_43.z = 0
				var_554_43.x = 0
				var_554_34.localEulerAngles = var_554_43
			end

			local var_554_44 = arg_551_1.actors_["115001ui_story"]
			local var_554_45 = 4

			if var_554_45 < arg_551_1.time_ and arg_551_1.time_ <= var_554_45 + arg_554_0 and not isNil(var_554_44) and arg_551_1.var_.characterEffect115001ui_story == nil then
				arg_551_1.var_.characterEffect115001ui_story = var_554_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_46 = 0.200000002980232

			if var_554_45 <= arg_551_1.time_ and arg_551_1.time_ < var_554_45 + var_554_46 and not isNil(var_554_44) then
				local var_554_47 = (arg_551_1.time_ - var_554_45) / var_554_46

				if arg_551_1.var_.characterEffect115001ui_story and not isNil(var_554_44) then
					arg_551_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= var_554_45 + var_554_46 and arg_551_1.time_ < var_554_45 + var_554_46 + arg_554_0 and not isNil(var_554_44) and arg_551_1.var_.characterEffect115001ui_story then
				arg_551_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_554_48 = 4

			if var_554_48 < arg_551_1.time_ and arg_551_1.time_ <= var_554_48 + arg_554_0 then
				arg_551_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_554_49 = 4

			if var_554_49 < arg_551_1.time_ and arg_551_1.time_ <= var_554_49 + arg_554_0 then
				arg_551_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_551_1.frameCnt_ <= 1 then
				arg_551_1.dialog_:SetActive(false)
			end

			local var_554_50 = 4
			local var_554_51 = 1.325

			if var_554_50 < arg_551_1.time_ and arg_551_1.time_ <= var_554_50 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0

				arg_551_1.dialog_:SetActive(true)

				arg_551_1.dialogCg_.alpha = 0

				local var_554_52 = LeanTween.value(arg_551_1.dialog_, 0, 1, 0.3)

				var_554_52:setOnUpdate(LuaHelper.FloatAction(function(arg_555_0)
					arg_551_1.dialogCg_.alpha = arg_555_0
				end))
				var_554_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_551_1.dialog_)
					var_554_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_551_1.duration_ = arg_551_1.duration_ + 0.3

				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_53 = arg_551_1:FormatText(StoryNameCfg[74].name)

				arg_551_1.leftNameTxt_.text = var_554_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_54 = arg_551_1:GetWordFromCfg(1105005138)
				local var_554_55 = arg_551_1:FormatText(var_554_54.content)

				arg_551_1.text_.text = var_554_55

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_56 = 53
				local var_554_57 = utf8.len(var_554_55)
				local var_554_58 = var_554_56 <= 0 and var_554_51 or var_554_51 * (var_554_57 / var_554_56)

				if var_554_58 > 0 and var_554_51 < var_554_58 then
					arg_551_1.talkMaxDuration = var_554_58
					var_554_50 = var_554_50 + 0.3

					if var_554_58 + var_554_50 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_58 + var_554_50
					end
				end

				arg_551_1.text_.text = var_554_55
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005138", "story_v_side_new_1105005.awb") ~= 0 then
					local var_554_59 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005138", "story_v_side_new_1105005.awb") / 1000

					if var_554_59 + var_554_50 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_59 + var_554_50
					end

					if var_554_54.prefab_name ~= "" and arg_551_1.actors_[var_554_54.prefab_name] ~= nil then
						local var_554_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_54.prefab_name].transform, "story_v_side_new_1105005", "1105005138", "story_v_side_new_1105005.awb")

						arg_551_1:RecordAudio("1105005138", var_554_60)
						arg_551_1:RecordAudio("1105005138", var_554_60)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005138", "story_v_side_new_1105005.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005138", "story_v_side_new_1105005.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_61 = var_554_50 + 0.3
			local var_554_62 = math.max(var_554_51, arg_551_1.talkMaxDuration)

			if var_554_61 <= arg_551_1.time_ and arg_551_1.time_ < var_554_61 + var_554_62 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_61) / var_554_62

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_61 + var_554_62 and arg_551_1.time_ < var_554_61 + var_554_62 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play1105005139 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1105005139
		arg_557_1.duration_ = 1.77

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1105005140(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 0.25

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_2 = arg_557_1:FormatText(StoryNameCfg[74].name)

				arg_557_1.leftNameTxt_.text = var_560_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_3 = arg_557_1:GetWordFromCfg(1105005139)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 10
				local var_560_6 = utf8.len(var_560_4)
				local var_560_7 = var_560_5 <= 0 and var_560_1 or var_560_1 * (var_560_6 / var_560_5)

				if var_560_7 > 0 and var_560_1 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005139", "story_v_side_new_1105005.awb") ~= 0 then
					local var_560_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005139", "story_v_side_new_1105005.awb") / 1000

					if var_560_8 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_0
					end

					if var_560_3.prefab_name ~= "" and arg_557_1.actors_[var_560_3.prefab_name] ~= nil then
						local var_560_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_3.prefab_name].transform, "story_v_side_new_1105005", "1105005139", "story_v_side_new_1105005.awb")

						arg_557_1:RecordAudio("1105005139", var_560_9)
						arg_557_1:RecordAudio("1105005139", var_560_9)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005139", "story_v_side_new_1105005.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005139", "story_v_side_new_1105005.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_10 and arg_557_1.time_ < var_560_0 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1105005140 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1105005140
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1105005141(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["115001ui_story"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect115001ui_story == nil then
				arg_561_1.var_.characterEffect115001ui_story = var_564_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.characterEffect115001ui_story and not isNil(var_564_0) then
					local var_564_4 = Mathf.Lerp(0, 0.5, var_564_3)

					arg_561_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_561_1.var_.characterEffect115001ui_story.fillRatio = var_564_4
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect115001ui_story then
				local var_564_5 = 0.5

				arg_561_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_561_1.var_.characterEffect115001ui_story.fillRatio = var_564_5
			end

			local var_564_6 = 0
			local var_564_7 = 0.35

			if var_564_6 < arg_561_1.time_ and arg_561_1.time_ <= var_564_6 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_8 = arg_561_1:FormatText(StoryNameCfg[7].name)

				arg_561_1.leftNameTxt_.text = var_564_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_9 = arg_561_1:GetWordFromCfg(1105005140)
				local var_564_10 = arg_561_1:FormatText(var_564_9.content)

				arg_561_1.text_.text = var_564_10

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_11 = 14
				local var_564_12 = utf8.len(var_564_10)
				local var_564_13 = var_564_11 <= 0 and var_564_7 or var_564_7 * (var_564_12 / var_564_11)

				if var_564_13 > 0 and var_564_7 < var_564_13 then
					arg_561_1.talkMaxDuration = var_564_13

					if var_564_13 + var_564_6 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_13 + var_564_6
					end
				end

				arg_561_1.text_.text = var_564_10
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_14 = math.max(var_564_7, arg_561_1.talkMaxDuration)

			if var_564_6 <= arg_561_1.time_ and arg_561_1.time_ < var_564_6 + var_564_14 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_6) / var_564_14

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_6 + var_564_14 and arg_561_1.time_ < var_564_6 + var_564_14 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1105005141 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1105005141
		arg_565_1.duration_ = 2

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1105005142(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["115001ui_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect115001ui_story == nil then
				arg_565_1.var_.characterEffect115001ui_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect115001ui_story and not isNil(var_568_0) then
					arg_565_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect115001ui_story then
				arg_565_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_568_4 = 0

			if var_568_4 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_568_5 = 0
			local var_568_6 = 0.2

			if var_568_5 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_7 = arg_565_1:FormatText(StoryNameCfg[74].name)

				arg_565_1.leftNameTxt_.text = var_568_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_8 = arg_565_1:GetWordFromCfg(1105005141)
				local var_568_9 = arg_565_1:FormatText(var_568_8.content)

				arg_565_1.text_.text = var_568_9

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_10 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005141", "story_v_side_new_1105005.awb") ~= 0 then
					local var_568_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005141", "story_v_side_new_1105005.awb") / 1000

					if var_568_13 + var_568_5 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_13 + var_568_5
					end

					if var_568_8.prefab_name ~= "" and arg_565_1.actors_[var_568_8.prefab_name] ~= nil then
						local var_568_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_8.prefab_name].transform, "story_v_side_new_1105005", "1105005141", "story_v_side_new_1105005.awb")

						arg_565_1:RecordAudio("1105005141", var_568_14)
						arg_565_1:RecordAudio("1105005141", var_568_14)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005141", "story_v_side_new_1105005.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005141", "story_v_side_new_1105005.awb")
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
	Play1105005142 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1105005142
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1105005143(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["115001ui_story"].transform
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.var_.moveOldPos115001ui_story = var_572_0.localPosition
			end

			local var_572_2 = 0.001

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2
				local var_572_4 = Vector3.New(0, 100, 0)

				var_572_0.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos115001ui_story, var_572_4, var_572_3)

				local var_572_5 = manager.ui.mainCamera.transform.position - var_572_0.position

				var_572_0.forward = Vector3.New(var_572_5.x, var_572_5.y, var_572_5.z)

				local var_572_6 = var_572_0.localEulerAngles

				var_572_6.z = 0
				var_572_6.x = 0
				var_572_0.localEulerAngles = var_572_6
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 then
				var_572_0.localPosition = Vector3.New(0, 100, 0)

				local var_572_7 = manager.ui.mainCamera.transform.position - var_572_0.position

				var_572_0.forward = Vector3.New(var_572_7.x, var_572_7.y, var_572_7.z)

				local var_572_8 = var_572_0.localEulerAngles

				var_572_8.z = 0
				var_572_8.x = 0
				var_572_0.localEulerAngles = var_572_8
			end

			local var_572_9 = 0
			local var_572_10 = 1.075

			if var_572_9 < arg_569_1.time_ and arg_569_1.time_ <= var_572_9 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_11 = arg_569_1:GetWordFromCfg(1105005142)
				local var_572_12 = arg_569_1:FormatText(var_572_11.content)

				arg_569_1.text_.text = var_572_12

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_13 = 43
				local var_572_14 = utf8.len(var_572_12)
				local var_572_15 = var_572_13 <= 0 and var_572_10 or var_572_10 * (var_572_14 / var_572_13)

				if var_572_15 > 0 and var_572_10 < var_572_15 then
					arg_569_1.talkMaxDuration = var_572_15

					if var_572_15 + var_572_9 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_15 + var_572_9
					end
				end

				arg_569_1.text_.text = var_572_12
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_16 = math.max(var_572_10, arg_569_1.talkMaxDuration)

			if var_572_9 <= arg_569_1.time_ and arg_569_1.time_ < var_572_9 + var_572_16 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_9) / var_572_16

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_9 + var_572_16 and arg_569_1.time_ < var_572_9 + var_572_16 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1105005143 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1105005143
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1105005144(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.825

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[7].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(1105005143)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 33
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
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_8 and arg_573_1.time_ < var_576_0 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1105005144 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1105005144
		arg_577_1.duration_ = 4.33

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1105005145(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["115001ui_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect115001ui_story == nil then
				arg_577_1.var_.characterEffect115001ui_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect115001ui_story and not isNil(var_580_0) then
					arg_577_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect115001ui_story then
				arg_577_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_580_4 = 0

			if var_580_4 < arg_577_1.time_ and arg_577_1.time_ <= var_580_4 + arg_580_0 then
				arg_577_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_580_5 = arg_577_1.actors_["115001ui_story"].transform
			local var_580_6 = 0

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.var_.moveOldPos115001ui_story = var_580_5.localPosition
			end

			local var_580_7 = 0.001

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_7 then
				local var_580_8 = (arg_577_1.time_ - var_580_6) / var_580_7
				local var_580_9 = Vector3.New(0, -1.033, -6.3)

				var_580_5.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos115001ui_story, var_580_9, var_580_8)

				local var_580_10 = manager.ui.mainCamera.transform.position - var_580_5.position

				var_580_5.forward = Vector3.New(var_580_10.x, var_580_10.y, var_580_10.z)

				local var_580_11 = var_580_5.localEulerAngles

				var_580_11.z = 0
				var_580_11.x = 0
				var_580_5.localEulerAngles = var_580_11
			end

			if arg_577_1.time_ >= var_580_6 + var_580_7 and arg_577_1.time_ < var_580_6 + var_580_7 + arg_580_0 then
				var_580_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_580_12 = manager.ui.mainCamera.transform.position - var_580_5.position

				var_580_5.forward = Vector3.New(var_580_12.x, var_580_12.y, var_580_12.z)

				local var_580_13 = var_580_5.localEulerAngles

				var_580_13.z = 0
				var_580_13.x = 0
				var_580_5.localEulerAngles = var_580_13
			end

			local var_580_14 = 0
			local var_580_15 = 0.525

			if var_580_14 < arg_577_1.time_ and arg_577_1.time_ <= var_580_14 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_16 = arg_577_1:FormatText(StoryNameCfg[74].name)

				arg_577_1.leftNameTxt_.text = var_580_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_17 = arg_577_1:GetWordFromCfg(1105005144)
				local var_580_18 = arg_577_1:FormatText(var_580_17.content)

				arg_577_1.text_.text = var_580_18

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_19 = 21
				local var_580_20 = utf8.len(var_580_18)
				local var_580_21 = var_580_19 <= 0 and var_580_15 or var_580_15 * (var_580_20 / var_580_19)

				if var_580_21 > 0 and var_580_15 < var_580_21 then
					arg_577_1.talkMaxDuration = var_580_21

					if var_580_21 + var_580_14 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_21 + var_580_14
					end
				end

				arg_577_1.text_.text = var_580_18
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005144", "story_v_side_new_1105005.awb") ~= 0 then
					local var_580_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005144", "story_v_side_new_1105005.awb") / 1000

					if var_580_22 + var_580_14 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_22 + var_580_14
					end

					if var_580_17.prefab_name ~= "" and arg_577_1.actors_[var_580_17.prefab_name] ~= nil then
						local var_580_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_17.prefab_name].transform, "story_v_side_new_1105005", "1105005144", "story_v_side_new_1105005.awb")

						arg_577_1:RecordAudio("1105005144", var_580_23)
						arg_577_1:RecordAudio("1105005144", var_580_23)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005144", "story_v_side_new_1105005.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005144", "story_v_side_new_1105005.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_24 = math.max(var_580_15, arg_577_1.talkMaxDuration)

			if var_580_14 <= arg_577_1.time_ and arg_577_1.time_ < var_580_14 + var_580_24 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_14) / var_580_24

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_14 + var_580_24 and arg_577_1.time_ < var_580_14 + var_580_24 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play1105005145 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1105005145
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1105005146(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["115001ui_story"]
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect115001ui_story == nil then
				arg_581_1.var_.characterEffect115001ui_story = var_584_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 and not isNil(var_584_0) then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2

				if arg_581_1.var_.characterEffect115001ui_story and not isNil(var_584_0) then
					local var_584_4 = Mathf.Lerp(0, 0.5, var_584_3)

					arg_581_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_581_1.var_.characterEffect115001ui_story.fillRatio = var_584_4
				end
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect115001ui_story then
				local var_584_5 = 0.5

				arg_581_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_581_1.var_.characterEffect115001ui_story.fillRatio = var_584_5
			end

			local var_584_6 = 0
			local var_584_7 = 1.3

			if var_584_6 < arg_581_1.time_ and arg_581_1.time_ <= var_584_6 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, false)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_8 = arg_581_1:GetWordFromCfg(1105005145)
				local var_584_9 = arg_581_1:FormatText(var_584_8.content)

				arg_581_1.text_.text = var_584_9

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_10 = 52
				local var_584_11 = utf8.len(var_584_9)
				local var_584_12 = var_584_10 <= 0 and var_584_7 or var_584_7 * (var_584_11 / var_584_10)

				if var_584_12 > 0 and var_584_7 < var_584_12 then
					arg_581_1.talkMaxDuration = var_584_12

					if var_584_12 + var_584_6 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_12 + var_584_6
					end
				end

				arg_581_1.text_.text = var_584_9
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_13 = math.max(var_584_7, arg_581_1.talkMaxDuration)

			if var_584_6 <= arg_581_1.time_ and arg_581_1.time_ < var_584_6 + var_584_13 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_6) / var_584_13

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_6 + var_584_13 and arg_581_1.time_ < var_584_6 + var_584_13 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1105005146 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1105005146
		arg_585_1.duration_ = 2.03

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1105005147(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = arg_585_1.actors_["115001ui_story"]
			local var_588_1 = 0

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.characterEffect115001ui_story == nil then
				arg_585_1.var_.characterEffect115001ui_story = var_588_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_2 = 0.200000002980232

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_2 and not isNil(var_588_0) then
				local var_588_3 = (arg_585_1.time_ - var_588_1) / var_588_2

				if arg_585_1.var_.characterEffect115001ui_story and not isNil(var_588_0) then
					arg_585_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= var_588_1 + var_588_2 and arg_585_1.time_ < var_588_1 + var_588_2 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.characterEffect115001ui_story then
				arg_585_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_588_4 = 0
			local var_588_5 = 0.3

			if var_588_4 < arg_585_1.time_ and arg_585_1.time_ <= var_588_4 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_6 = arg_585_1:FormatText(StoryNameCfg[74].name)

				arg_585_1.leftNameTxt_.text = var_588_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_7 = arg_585_1:GetWordFromCfg(1105005146)
				local var_588_8 = arg_585_1:FormatText(var_588_7.content)

				arg_585_1.text_.text = var_588_8

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_9 = 12
				local var_588_10 = utf8.len(var_588_8)
				local var_588_11 = var_588_9 <= 0 and var_588_5 or var_588_5 * (var_588_10 / var_588_9)

				if var_588_11 > 0 and var_588_5 < var_588_11 then
					arg_585_1.talkMaxDuration = var_588_11

					if var_588_11 + var_588_4 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_11 + var_588_4
					end
				end

				arg_585_1.text_.text = var_588_8
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005146", "story_v_side_new_1105005.awb") ~= 0 then
					local var_588_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005146", "story_v_side_new_1105005.awb") / 1000

					if var_588_12 + var_588_4 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_12 + var_588_4
					end

					if var_588_7.prefab_name ~= "" and arg_585_1.actors_[var_588_7.prefab_name] ~= nil then
						local var_588_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_7.prefab_name].transform, "story_v_side_new_1105005", "1105005146", "story_v_side_new_1105005.awb")

						arg_585_1:RecordAudio("1105005146", var_588_13)
						arg_585_1:RecordAudio("1105005146", var_588_13)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005146", "story_v_side_new_1105005.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005146", "story_v_side_new_1105005.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_14 = math.max(var_588_5, arg_585_1.talkMaxDuration)

			if var_588_4 <= arg_585_1.time_ and arg_585_1.time_ < var_588_4 + var_588_14 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_4) / var_588_14

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_4 + var_588_14 and arg_585_1.time_ < var_588_4 + var_588_14 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1105005147 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1105005147
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1105005148(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["115001ui_story"]
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect115001ui_story == nil then
				arg_589_1.var_.characterEffect115001ui_story = var_592_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_2 = 0.200000002980232

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 and not isNil(var_592_0) then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2

				if arg_589_1.var_.characterEffect115001ui_story and not isNil(var_592_0) then
					local var_592_4 = Mathf.Lerp(0, 0.5, var_592_3)

					arg_589_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_589_1.var_.characterEffect115001ui_story.fillRatio = var_592_4
				end
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect115001ui_story then
				local var_592_5 = 0.5

				arg_589_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_589_1.var_.characterEffect115001ui_story.fillRatio = var_592_5
			end

			local var_592_6 = 0
			local var_592_7 = 0.9

			if var_592_6 < arg_589_1.time_ and arg_589_1.time_ <= var_592_6 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_8 = arg_589_1:FormatText(StoryNameCfg[7].name)

				arg_589_1.leftNameTxt_.text = var_592_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_9 = arg_589_1:GetWordFromCfg(1105005147)
				local var_592_10 = arg_589_1:FormatText(var_592_9.content)

				arg_589_1.text_.text = var_592_10

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_11 = 36
				local var_592_12 = utf8.len(var_592_10)
				local var_592_13 = var_592_11 <= 0 and var_592_7 or var_592_7 * (var_592_12 / var_592_11)

				if var_592_13 > 0 and var_592_7 < var_592_13 then
					arg_589_1.talkMaxDuration = var_592_13

					if var_592_13 + var_592_6 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_13 + var_592_6
					end
				end

				arg_589_1.text_.text = var_592_10
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_14 = math.max(var_592_7, arg_589_1.talkMaxDuration)

			if var_592_6 <= arg_589_1.time_ and arg_589_1.time_ < var_592_6 + var_592_14 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_6) / var_592_14

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_6 + var_592_14 and arg_589_1.time_ < var_592_6 + var_592_14 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1105005148 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1105005148
		arg_593_1.duration_ = 2

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1105005149(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = arg_593_1.actors_["115001ui_story"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect115001ui_story == nil then
				arg_593_1.var_.characterEffect115001ui_story = var_596_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.characterEffect115001ui_story and not isNil(var_596_0) then
					arg_593_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect115001ui_story then
				arg_593_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_596_4 = 0

			if var_596_4 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_596_5 = 0

			if var_596_5 < arg_593_1.time_ and arg_593_1.time_ <= var_596_5 + arg_596_0 then
				arg_593_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_596_6 = 0
			local var_596_7 = 0.15

			if var_596_6 < arg_593_1.time_ and arg_593_1.time_ <= var_596_6 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_8 = arg_593_1:FormatText(StoryNameCfg[74].name)

				arg_593_1.leftNameTxt_.text = var_596_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_9 = arg_593_1:GetWordFromCfg(1105005148)
				local var_596_10 = arg_593_1:FormatText(var_596_9.content)

				arg_593_1.text_.text = var_596_10

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_11 = 6
				local var_596_12 = utf8.len(var_596_10)
				local var_596_13 = var_596_11 <= 0 and var_596_7 or var_596_7 * (var_596_12 / var_596_11)

				if var_596_13 > 0 and var_596_7 < var_596_13 then
					arg_593_1.talkMaxDuration = var_596_13

					if var_596_13 + var_596_6 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_13 + var_596_6
					end
				end

				arg_593_1.text_.text = var_596_10
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005148", "story_v_side_new_1105005.awb") ~= 0 then
					local var_596_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005148", "story_v_side_new_1105005.awb") / 1000

					if var_596_14 + var_596_6 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_14 + var_596_6
					end

					if var_596_9.prefab_name ~= "" and arg_593_1.actors_[var_596_9.prefab_name] ~= nil then
						local var_596_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_9.prefab_name].transform, "story_v_side_new_1105005", "1105005148", "story_v_side_new_1105005.awb")

						arg_593_1:RecordAudio("1105005148", var_596_15)
						arg_593_1:RecordAudio("1105005148", var_596_15)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005148", "story_v_side_new_1105005.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005148", "story_v_side_new_1105005.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_16 = math.max(var_596_7, arg_593_1.talkMaxDuration)

			if var_596_6 <= arg_593_1.time_ and arg_593_1.time_ < var_596_6 + var_596_16 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_6) / var_596_16

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_6 + var_596_16 and arg_593_1.time_ < var_596_6 + var_596_16 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1105005149 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1105005149
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1105005150(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["115001ui_story"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect115001ui_story == nil then
				arg_597_1.var_.characterEffect115001ui_story = var_600_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.200000002980232

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.characterEffect115001ui_story and not isNil(var_600_0) then
					local var_600_4 = Mathf.Lerp(0, 0.5, var_600_3)

					arg_597_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_597_1.var_.characterEffect115001ui_story.fillRatio = var_600_4
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect115001ui_story then
				local var_600_5 = 0.5

				arg_597_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_597_1.var_.characterEffect115001ui_story.fillRatio = var_600_5
			end

			local var_600_6 = 0
			local var_600_7 = 1.15

			if var_600_6 < arg_597_1.time_ and arg_597_1.time_ <= var_600_6 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_8 = arg_597_1:GetWordFromCfg(1105005149)
				local var_600_9 = arg_597_1:FormatText(var_600_8.content)

				arg_597_1.text_.text = var_600_9

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_10 = 46
				local var_600_11 = utf8.len(var_600_9)
				local var_600_12 = var_600_10 <= 0 and var_600_7 or var_600_7 * (var_600_11 / var_600_10)

				if var_600_12 > 0 and var_600_7 < var_600_12 then
					arg_597_1.talkMaxDuration = var_600_12

					if var_600_12 + var_600_6 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_12 + var_600_6
					end
				end

				arg_597_1.text_.text = var_600_9
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_13 = math.max(var_600_7, arg_597_1.talkMaxDuration)

			if var_600_6 <= arg_597_1.time_ and arg_597_1.time_ < var_600_6 + var_600_13 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_6) / var_600_13

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_6 + var_600_13 and arg_597_1.time_ < var_600_6 + var_600_13 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1105005150 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1105005150
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1105005151(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0
			local var_604_1 = 0.625

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_2 = arg_601_1:FormatText(StoryNameCfg[7].name)

				arg_601_1.leftNameTxt_.text = var_604_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_3 = arg_601_1:GetWordFromCfg(1105005150)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 25
				local var_604_6 = utf8.len(var_604_4)
				local var_604_7 = var_604_5 <= 0 and var_604_1 or var_604_1 * (var_604_6 / var_604_5)

				if var_604_7 > 0 and var_604_1 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_0
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_8 = math.max(var_604_1, arg_601_1.talkMaxDuration)

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_8 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_0) / var_604_8

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_0 + var_604_8 and arg_601_1.time_ < var_604_0 + var_604_8 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1105005151 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1105005151
		arg_605_1.duration_ = 2.9

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1105005152(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = arg_605_1.actors_["115001ui_story"].transform
			local var_608_1 = 0

			if var_608_1 < arg_605_1.time_ and arg_605_1.time_ <= var_608_1 + arg_608_0 then
				arg_605_1.var_.moveOldPos115001ui_story = var_608_0.localPosition
			end

			local var_608_2 = 0.001

			if var_608_1 <= arg_605_1.time_ and arg_605_1.time_ < var_608_1 + var_608_2 then
				local var_608_3 = (arg_605_1.time_ - var_608_1) / var_608_2
				local var_608_4 = Vector3.New(0, -1.033, -6.3)

				var_608_0.localPosition = Vector3.Lerp(arg_605_1.var_.moveOldPos115001ui_story, var_608_4, var_608_3)

				local var_608_5 = manager.ui.mainCamera.transform.position - var_608_0.position

				var_608_0.forward = Vector3.New(var_608_5.x, var_608_5.y, var_608_5.z)

				local var_608_6 = var_608_0.localEulerAngles

				var_608_6.z = 0
				var_608_6.x = 0
				var_608_0.localEulerAngles = var_608_6
			end

			if arg_605_1.time_ >= var_608_1 + var_608_2 and arg_605_1.time_ < var_608_1 + var_608_2 + arg_608_0 then
				var_608_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_608_7 = manager.ui.mainCamera.transform.position - var_608_0.position

				var_608_0.forward = Vector3.New(var_608_7.x, var_608_7.y, var_608_7.z)

				local var_608_8 = var_608_0.localEulerAngles

				var_608_8.z = 0
				var_608_8.x = 0
				var_608_0.localEulerAngles = var_608_8
			end

			local var_608_9 = arg_605_1.actors_["115001ui_story"]
			local var_608_10 = 0

			if var_608_10 < arg_605_1.time_ and arg_605_1.time_ <= var_608_10 + arg_608_0 and not isNil(var_608_9) and arg_605_1.var_.characterEffect115001ui_story == nil then
				arg_605_1.var_.characterEffect115001ui_story = var_608_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_11 = 0.200000002980232

			if var_608_10 <= arg_605_1.time_ and arg_605_1.time_ < var_608_10 + var_608_11 and not isNil(var_608_9) then
				local var_608_12 = (arg_605_1.time_ - var_608_10) / var_608_11

				if arg_605_1.var_.characterEffect115001ui_story and not isNil(var_608_9) then
					arg_605_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= var_608_10 + var_608_11 and arg_605_1.time_ < var_608_10 + var_608_11 + arg_608_0 and not isNil(var_608_9) and arg_605_1.var_.characterEffect115001ui_story then
				arg_605_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_608_13 = 0

			if var_608_13 < arg_605_1.time_ and arg_605_1.time_ <= var_608_13 + arg_608_0 then
				arg_605_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_608_14 = 0

			if var_608_14 < arg_605_1.time_ and arg_605_1.time_ <= var_608_14 + arg_608_0 then
				arg_605_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_608_15 = 0
			local var_608_16 = 0.175

			if var_608_15 < arg_605_1.time_ and arg_605_1.time_ <= var_608_15 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_17 = arg_605_1:FormatText(StoryNameCfg[74].name)

				arg_605_1.leftNameTxt_.text = var_608_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_18 = arg_605_1:GetWordFromCfg(1105005151)
				local var_608_19 = arg_605_1:FormatText(var_608_18.content)

				arg_605_1.text_.text = var_608_19

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_20 = 7
				local var_608_21 = utf8.len(var_608_19)
				local var_608_22 = var_608_20 <= 0 and var_608_16 or var_608_16 * (var_608_21 / var_608_20)

				if var_608_22 > 0 and var_608_16 < var_608_22 then
					arg_605_1.talkMaxDuration = var_608_22

					if var_608_22 + var_608_15 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_22 + var_608_15
					end
				end

				arg_605_1.text_.text = var_608_19
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005151", "story_v_side_new_1105005.awb") ~= 0 then
					local var_608_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005151", "story_v_side_new_1105005.awb") / 1000

					if var_608_23 + var_608_15 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_23 + var_608_15
					end

					if var_608_18.prefab_name ~= "" and arg_605_1.actors_[var_608_18.prefab_name] ~= nil then
						local var_608_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_18.prefab_name].transform, "story_v_side_new_1105005", "1105005151", "story_v_side_new_1105005.awb")

						arg_605_1:RecordAudio("1105005151", var_608_24)
						arg_605_1:RecordAudio("1105005151", var_608_24)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005151", "story_v_side_new_1105005.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005151", "story_v_side_new_1105005.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_25 = math.max(var_608_16, arg_605_1.talkMaxDuration)

			if var_608_15 <= arg_605_1.time_ and arg_605_1.time_ < var_608_15 + var_608_25 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_15) / var_608_25

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_15 + var_608_25 and arg_605_1.time_ < var_608_15 + var_608_25 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_605_1:InitPlayNodeList()
	end,
	Play1105005152 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1105005152
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1105005153(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = arg_609_1.actors_["115001ui_story"].transform
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.var_.moveOldPos115001ui_story = var_612_0.localPosition
			end

			local var_612_2 = 0.001

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_2 then
				local var_612_3 = (arg_609_1.time_ - var_612_1) / var_612_2
				local var_612_4 = Vector3.New(0, 100, 0)

				var_612_0.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos115001ui_story, var_612_4, var_612_3)

				local var_612_5 = manager.ui.mainCamera.transform.position - var_612_0.position

				var_612_0.forward = Vector3.New(var_612_5.x, var_612_5.y, var_612_5.z)

				local var_612_6 = var_612_0.localEulerAngles

				var_612_6.z = 0
				var_612_6.x = 0
				var_612_0.localEulerAngles = var_612_6
			end

			if arg_609_1.time_ >= var_612_1 + var_612_2 and arg_609_1.time_ < var_612_1 + var_612_2 + arg_612_0 then
				var_612_0.localPosition = Vector3.New(0, 100, 0)

				local var_612_7 = manager.ui.mainCamera.transform.position - var_612_0.position

				var_612_0.forward = Vector3.New(var_612_7.x, var_612_7.y, var_612_7.z)

				local var_612_8 = var_612_0.localEulerAngles

				var_612_8.z = 0
				var_612_8.x = 0
				var_612_0.localEulerAngles = var_612_8
			end

			local var_612_9 = 0
			local var_612_10 = 1.6

			if var_612_9 < arg_609_1.time_ and arg_609_1.time_ <= var_612_9 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_11 = arg_609_1:GetWordFromCfg(1105005152)
				local var_612_12 = arg_609_1:FormatText(var_612_11.content)

				arg_609_1.text_.text = var_612_12

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_13 = 64
				local var_612_14 = utf8.len(var_612_12)
				local var_612_15 = var_612_13 <= 0 and var_612_10 or var_612_10 * (var_612_14 / var_612_13)

				if var_612_15 > 0 and var_612_10 < var_612_15 then
					arg_609_1.talkMaxDuration = var_612_15

					if var_612_15 + var_612_9 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_15 + var_612_9
					end
				end

				arg_609_1.text_.text = var_612_12
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_16 = math.max(var_612_10, arg_609_1.talkMaxDuration)

			if var_612_9 <= arg_609_1.time_ and arg_609_1.time_ < var_612_9 + var_612_16 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_9) / var_612_16

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_9 + var_612_16 and arg_609_1.time_ < var_612_9 + var_612_16 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play1105005153 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1105005153
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1105005154(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.175

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[7].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:GetWordFromCfg(1105005153)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 7
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_8 and arg_613_1.time_ < var_616_0 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1105005154 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1105005154
		arg_617_1.duration_ = 2

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1105005155(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = arg_617_1.actors_["115001ui_story"]
			local var_620_1 = 0

			if var_620_1 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect115001ui_story == nil then
				arg_617_1.var_.characterEffect115001ui_story = var_620_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_2 and not isNil(var_620_0) then
				local var_620_3 = (arg_617_1.time_ - var_620_1) / var_620_2

				if arg_617_1.var_.characterEffect115001ui_story and not isNil(var_620_0) then
					arg_617_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= var_620_1 + var_620_2 and arg_617_1.time_ < var_620_1 + var_620_2 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect115001ui_story then
				arg_617_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_620_4 = 0

			if var_620_4 < arg_617_1.time_ and arg_617_1.time_ <= var_620_4 + arg_620_0 then
				arg_617_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_620_5 = arg_617_1.actors_["115001ui_story"].transform
			local var_620_6 = 0

			if var_620_6 < arg_617_1.time_ and arg_617_1.time_ <= var_620_6 + arg_620_0 then
				arg_617_1.var_.moveOldPos115001ui_story = var_620_5.localPosition
			end

			local var_620_7 = 0.001

			if var_620_6 <= arg_617_1.time_ and arg_617_1.time_ < var_620_6 + var_620_7 then
				local var_620_8 = (arg_617_1.time_ - var_620_6) / var_620_7
				local var_620_9 = Vector3.New(0, -1.033, -6.3)

				var_620_5.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos115001ui_story, var_620_9, var_620_8)

				local var_620_10 = manager.ui.mainCamera.transform.position - var_620_5.position

				var_620_5.forward = Vector3.New(var_620_10.x, var_620_10.y, var_620_10.z)

				local var_620_11 = var_620_5.localEulerAngles

				var_620_11.z = 0
				var_620_11.x = 0
				var_620_5.localEulerAngles = var_620_11
			end

			if arg_617_1.time_ >= var_620_6 + var_620_7 and arg_617_1.time_ < var_620_6 + var_620_7 + arg_620_0 then
				var_620_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_620_12 = manager.ui.mainCamera.transform.position - var_620_5.position

				var_620_5.forward = Vector3.New(var_620_12.x, var_620_12.y, var_620_12.z)

				local var_620_13 = var_620_5.localEulerAngles

				var_620_13.z = 0
				var_620_13.x = 0
				var_620_5.localEulerAngles = var_620_13
			end

			local var_620_14 = 0
			local var_620_15 = 0.125

			if var_620_14 < arg_617_1.time_ and arg_617_1.time_ <= var_620_14 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_16 = arg_617_1:FormatText(StoryNameCfg[74].name)

				arg_617_1.leftNameTxt_.text = var_620_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_17 = arg_617_1:GetWordFromCfg(1105005154)
				local var_620_18 = arg_617_1:FormatText(var_620_17.content)

				arg_617_1.text_.text = var_620_18

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_19 = 5
				local var_620_20 = utf8.len(var_620_18)
				local var_620_21 = var_620_19 <= 0 and var_620_15 or var_620_15 * (var_620_20 / var_620_19)

				if var_620_21 > 0 and var_620_15 < var_620_21 then
					arg_617_1.talkMaxDuration = var_620_21

					if var_620_21 + var_620_14 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_21 + var_620_14
					end
				end

				arg_617_1.text_.text = var_620_18
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005154", "story_v_side_new_1105005.awb") ~= 0 then
					local var_620_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005154", "story_v_side_new_1105005.awb") / 1000

					if var_620_22 + var_620_14 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_22 + var_620_14
					end

					if var_620_17.prefab_name ~= "" and arg_617_1.actors_[var_620_17.prefab_name] ~= nil then
						local var_620_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_17.prefab_name].transform, "story_v_side_new_1105005", "1105005154", "story_v_side_new_1105005.awb")

						arg_617_1:RecordAudio("1105005154", var_620_23)
						arg_617_1:RecordAudio("1105005154", var_620_23)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005154", "story_v_side_new_1105005.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005154", "story_v_side_new_1105005.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_24 = math.max(var_620_15, arg_617_1.talkMaxDuration)

			if var_620_14 <= arg_617_1.time_ and arg_617_1.time_ < var_620_14 + var_620_24 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_14) / var_620_24

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_14 + var_620_24 and arg_617_1.time_ < var_620_14 + var_620_24 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	Play1105005155 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1105005155
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1105005156(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = arg_621_1.actors_["115001ui_story"].transform
			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.var_.moveOldPos115001ui_story = var_624_0.localPosition
			end

			local var_624_2 = 0.001

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_2 then
				local var_624_3 = (arg_621_1.time_ - var_624_1) / var_624_2
				local var_624_4 = Vector3.New(0, 100, 0)

				var_624_0.localPosition = Vector3.Lerp(arg_621_1.var_.moveOldPos115001ui_story, var_624_4, var_624_3)

				local var_624_5 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_5.x, var_624_5.y, var_624_5.z)

				local var_624_6 = var_624_0.localEulerAngles

				var_624_6.z = 0
				var_624_6.x = 0
				var_624_0.localEulerAngles = var_624_6
			end

			if arg_621_1.time_ >= var_624_1 + var_624_2 and arg_621_1.time_ < var_624_1 + var_624_2 + arg_624_0 then
				var_624_0.localPosition = Vector3.New(0, 100, 0)

				local var_624_7 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_7.x, var_624_7.y, var_624_7.z)

				local var_624_8 = var_624_0.localEulerAngles

				var_624_8.z = 0
				var_624_8.x = 0
				var_624_0.localEulerAngles = var_624_8
			end

			local var_624_9 = 0
			local var_624_10 = 1.325

			if var_624_9 < arg_621_1.time_ and arg_621_1.time_ <= var_624_9 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, false)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_11 = arg_621_1:GetWordFromCfg(1105005155)
				local var_624_12 = arg_621_1:FormatText(var_624_11.content)

				arg_621_1.text_.text = var_624_12

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_13 = 53
				local var_624_14 = utf8.len(var_624_12)
				local var_624_15 = var_624_13 <= 0 and var_624_10 or var_624_10 * (var_624_14 / var_624_13)

				if var_624_15 > 0 and var_624_10 < var_624_15 then
					arg_621_1.talkMaxDuration = var_624_15

					if var_624_15 + var_624_9 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_15 + var_624_9
					end
				end

				arg_621_1.text_.text = var_624_12
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_16 = math.max(var_624_10, arg_621_1.talkMaxDuration)

			if var_624_9 <= arg_621_1.time_ and arg_621_1.time_ < var_624_9 + var_624_16 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_9) / var_624_16

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_9 + var_624_16 and arg_621_1.time_ < var_624_9 + var_624_16 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_621_1:InitPlayNodeList()
	end,
	Play1105005156 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1105005156
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1105005157(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0
			local var_628_1 = 0.875

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, false)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_2 = arg_625_1:GetWordFromCfg(1105005156)
				local var_628_3 = arg_625_1:FormatText(var_628_2.content)

				arg_625_1.text_.text = var_628_3

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_4 = 35
				local var_628_5 = utf8.len(var_628_3)
				local var_628_6 = var_628_4 <= 0 and var_628_1 or var_628_1 * (var_628_5 / var_628_4)

				if var_628_6 > 0 and var_628_1 < var_628_6 then
					arg_625_1.talkMaxDuration = var_628_6

					if var_628_6 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_6 + var_628_0
					end
				end

				arg_625_1.text_.text = var_628_3
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_7 = math.max(var_628_1, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_7 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_0) / var_628_7

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_7 and arg_625_1.time_ < var_628_0 + var_628_7 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1105005157 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1105005157
		arg_629_1.duration_ = 1

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"

			SetActive(arg_629_1.choicesGo_, true)

			for iter_630_0, iter_630_1 in ipairs(arg_629_1.choices_) do
				local var_630_0 = iter_630_0 <= 2

				SetActive(iter_630_1.go, var_630_0)
			end

			arg_629_1.choices_[1].txt.text = arg_629_1:FormatText(StoryChoiceCfg[1062].name)
			arg_629_1.choices_[2].txt.text = arg_629_1:FormatText(StoryChoiceCfg[1063].name)
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1105005158(arg_629_1)
			end

			if arg_631_0 == 2 then
				arg_629_0:Play1105005158(arg_629_1)
			end

			arg_629_1:RecordChoiceLog(1105005157, 1062, 1063)
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.allBtn_.enabled = false
			end

			local var_632_1 = 1

			if arg_629_1.time_ >= var_632_0 + var_632_1 and arg_629_1.time_ < var_632_0 + var_632_1 + arg_632_0 then
				arg_629_1.allBtn_.enabled = true
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1105005158 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1105005158
		arg_633_1.duration_ = 3.5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1105005159(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["115001ui_story"].transform
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.var_.moveOldPos115001ui_story = var_636_0.localPosition
			end

			local var_636_2 = 0.001

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2
				local var_636_4 = Vector3.New(0, -1.033, -6.3)

				var_636_0.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos115001ui_story, var_636_4, var_636_3)

				local var_636_5 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_5.x, var_636_5.y, var_636_5.z)

				local var_636_6 = var_636_0.localEulerAngles

				var_636_6.z = 0
				var_636_6.x = 0
				var_636_0.localEulerAngles = var_636_6
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				var_636_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_636_7 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_7.x, var_636_7.y, var_636_7.z)

				local var_636_8 = var_636_0.localEulerAngles

				var_636_8.z = 0
				var_636_8.x = 0
				var_636_0.localEulerAngles = var_636_8
			end

			local var_636_9 = arg_633_1.actors_["115001ui_story"]
			local var_636_10 = 0

			if var_636_10 < arg_633_1.time_ and arg_633_1.time_ <= var_636_10 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect115001ui_story == nil then
				arg_633_1.var_.characterEffect115001ui_story = var_636_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_11 = 0.200000002980232

			if var_636_10 <= arg_633_1.time_ and arg_633_1.time_ < var_636_10 + var_636_11 and not isNil(var_636_9) then
				local var_636_12 = (arg_633_1.time_ - var_636_10) / var_636_11

				if arg_633_1.var_.characterEffect115001ui_story and not isNil(var_636_9) then
					arg_633_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_10 + var_636_11 and arg_633_1.time_ < var_636_10 + var_636_11 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect115001ui_story then
				arg_633_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_636_13 = "115001ui_story"

			if arg_633_1.actors_[var_636_13] == nil then
				local var_636_14 = Asset.Load("Char/" .. "115001ui_story")

				if not isNil(var_636_14) then
					local var_636_15 = Object.Instantiate(Asset.Load("Char/" .. "115001ui_story"), arg_633_1.stage_.transform)

					var_636_15.name = var_636_13
					var_636_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_633_1.actors_[var_636_13] = var_636_15

					local var_636_16 = var_636_15:GetComponentInChildren(typeof(CharacterEffect))

					var_636_16.enabled = true

					local var_636_17 = GameObjectTools.GetOrAddComponent(var_636_15, typeof(DynamicBoneHelper))

					if var_636_17 then
						var_636_17:EnableDynamicBone(false)
					end

					arg_633_1:ShowWeapon(var_636_16.transform, false)

					arg_633_1.var_[var_636_13 .. "Animator"] = var_636_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_633_1.var_[var_636_13 .. "Animator"].applyRootMotion = true
					arg_633_1.var_[var_636_13 .. "LipSync"] = var_636_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_636_18 = 0

			if var_636_18 < arg_633_1.time_ and arg_633_1.time_ <= var_636_18 + arg_636_0 then
				arg_633_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_636_19 = 0
			local var_636_20 = 0.4

			if var_636_19 < arg_633_1.time_ and arg_633_1.time_ <= var_636_19 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_21 = arg_633_1:FormatText(StoryNameCfg[74].name)

				arg_633_1.leftNameTxt_.text = var_636_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_22 = arg_633_1:GetWordFromCfg(1105005158)
				local var_636_23 = arg_633_1:FormatText(var_636_22.content)

				arg_633_1.text_.text = var_636_23

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_24 = 16
				local var_636_25 = utf8.len(var_636_23)
				local var_636_26 = var_636_24 <= 0 and var_636_20 or var_636_20 * (var_636_25 / var_636_24)

				if var_636_26 > 0 and var_636_20 < var_636_26 then
					arg_633_1.talkMaxDuration = var_636_26

					if var_636_26 + var_636_19 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_26 + var_636_19
					end
				end

				arg_633_1.text_.text = var_636_23
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005158", "story_v_side_new_1105005.awb") ~= 0 then
					local var_636_27 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005158", "story_v_side_new_1105005.awb") / 1000

					if var_636_27 + var_636_19 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_27 + var_636_19
					end

					if var_636_22.prefab_name ~= "" and arg_633_1.actors_[var_636_22.prefab_name] ~= nil then
						local var_636_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_22.prefab_name].transform, "story_v_side_new_1105005", "1105005158", "story_v_side_new_1105005.awb")

						arg_633_1:RecordAudio("1105005158", var_636_28)
						arg_633_1:RecordAudio("1105005158", var_636_28)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005158", "story_v_side_new_1105005.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005158", "story_v_side_new_1105005.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_29 = math.max(var_636_20, arg_633_1.talkMaxDuration)

			if var_636_19 <= arg_633_1.time_ and arg_633_1.time_ < var_636_19 + var_636_29 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_19) / var_636_29

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_19 + var_636_29 and arg_633_1.time_ < var_636_19 + var_636_29 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play1105005159 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1105005159
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1105005160(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["115001ui_story"].transform
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.var_.moveOldPos115001ui_story = var_640_0.localPosition
			end

			local var_640_2 = 0.001

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2
				local var_640_4 = Vector3.New(0, 100, 0)

				var_640_0.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos115001ui_story, var_640_4, var_640_3)

				local var_640_5 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_5.x, var_640_5.y, var_640_5.z)

				local var_640_6 = var_640_0.localEulerAngles

				var_640_6.z = 0
				var_640_6.x = 0
				var_640_0.localEulerAngles = var_640_6
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 then
				var_640_0.localPosition = Vector3.New(0, 100, 0)

				local var_640_7 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_7.x, var_640_7.y, var_640_7.z)

				local var_640_8 = var_640_0.localEulerAngles

				var_640_8.z = 0
				var_640_8.x = 0
				var_640_0.localEulerAngles = var_640_8
			end

			local var_640_9 = 0
			local var_640_10 = 1.6

			if var_640_9 < arg_637_1.time_ and arg_637_1.time_ <= var_640_9 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_11 = arg_637_1:GetWordFromCfg(1105005159)
				local var_640_12 = arg_637_1:FormatText(var_640_11.content)

				arg_637_1.text_.text = var_640_12

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_13 = 64
				local var_640_14 = utf8.len(var_640_12)
				local var_640_15 = var_640_13 <= 0 and var_640_10 or var_640_10 * (var_640_14 / var_640_13)

				if var_640_15 > 0 and var_640_10 < var_640_15 then
					arg_637_1.talkMaxDuration = var_640_15

					if var_640_15 + var_640_9 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_15 + var_640_9
					end
				end

				arg_637_1.text_.text = var_640_12
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_16 = math.max(var_640_10, arg_637_1.talkMaxDuration)

			if var_640_9 <= arg_637_1.time_ and arg_637_1.time_ < var_640_9 + var_640_16 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_9) / var_640_16

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_9 + var_640_16 and arg_637_1.time_ < var_640_9 + var_640_16 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_637_1:InitPlayNodeList()
	end,
	Play1105005160 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1105005160
		arg_641_1.duration_ = 3.73

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1105005161(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = arg_641_1.actors_["115001ui_story"]
			local var_644_1 = 0

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect115001ui_story == nil then
				arg_641_1.var_.characterEffect115001ui_story = var_644_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.200000002980232

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_2 and not isNil(var_644_0) then
				local var_644_3 = (arg_641_1.time_ - var_644_1) / var_644_2

				if arg_641_1.var_.characterEffect115001ui_story and not isNil(var_644_0) then
					arg_641_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_1 + var_644_2 and arg_641_1.time_ < var_644_1 + var_644_2 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect115001ui_story then
				arg_641_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_644_4 = arg_641_1.actors_["115001ui_story"].transform
			local var_644_5 = 0

			if var_644_5 < arg_641_1.time_ and arg_641_1.time_ <= var_644_5 + arg_644_0 then
				arg_641_1.var_.moveOldPos115001ui_story = var_644_4.localPosition
			end

			local var_644_6 = 0.001

			if var_644_5 <= arg_641_1.time_ and arg_641_1.time_ < var_644_5 + var_644_6 then
				local var_644_7 = (arg_641_1.time_ - var_644_5) / var_644_6
				local var_644_8 = Vector3.New(0, -1.033, -6.3)

				var_644_4.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos115001ui_story, var_644_8, var_644_7)

				local var_644_9 = manager.ui.mainCamera.transform.position - var_644_4.position

				var_644_4.forward = Vector3.New(var_644_9.x, var_644_9.y, var_644_9.z)

				local var_644_10 = var_644_4.localEulerAngles

				var_644_10.z = 0
				var_644_10.x = 0
				var_644_4.localEulerAngles = var_644_10
			end

			if arg_641_1.time_ >= var_644_5 + var_644_6 and arg_641_1.time_ < var_644_5 + var_644_6 + arg_644_0 then
				var_644_4.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_644_11 = manager.ui.mainCamera.transform.position - var_644_4.position

				var_644_4.forward = Vector3.New(var_644_11.x, var_644_11.y, var_644_11.z)

				local var_644_12 = var_644_4.localEulerAngles

				var_644_12.z = 0
				var_644_12.x = 0
				var_644_4.localEulerAngles = var_644_12
			end

			local var_644_13 = 0
			local var_644_14 = 0.375

			if var_644_13 < arg_641_1.time_ and arg_641_1.time_ <= var_644_13 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_15 = arg_641_1:FormatText(StoryNameCfg[74].name)

				arg_641_1.leftNameTxt_.text = var_644_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_16 = arg_641_1:GetWordFromCfg(1105005160)
				local var_644_17 = arg_641_1:FormatText(var_644_16.content)

				arg_641_1.text_.text = var_644_17

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_18 = 15
				local var_644_19 = utf8.len(var_644_17)
				local var_644_20 = var_644_18 <= 0 and var_644_14 or var_644_14 * (var_644_19 / var_644_18)

				if var_644_20 > 0 and var_644_14 < var_644_20 then
					arg_641_1.talkMaxDuration = var_644_20

					if var_644_20 + var_644_13 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_20 + var_644_13
					end
				end

				arg_641_1.text_.text = var_644_17
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005160", "story_v_side_new_1105005.awb") ~= 0 then
					local var_644_21 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005160", "story_v_side_new_1105005.awb") / 1000

					if var_644_21 + var_644_13 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_21 + var_644_13
					end

					if var_644_16.prefab_name ~= "" and arg_641_1.actors_[var_644_16.prefab_name] ~= nil then
						local var_644_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_16.prefab_name].transform, "story_v_side_new_1105005", "1105005160", "story_v_side_new_1105005.awb")

						arg_641_1:RecordAudio("1105005160", var_644_22)
						arg_641_1:RecordAudio("1105005160", var_644_22)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005160", "story_v_side_new_1105005.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005160", "story_v_side_new_1105005.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_23 = math.max(var_644_14, arg_641_1.talkMaxDuration)

			if var_644_13 <= arg_641_1.time_ and arg_641_1.time_ < var_644_13 + var_644_23 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_13) / var_644_23

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_13 + var_644_23 and arg_641_1.time_ < var_644_13 + var_644_23 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play1105005161 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1105005161
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1105005162(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = arg_645_1.actors_["115001ui_story"].transform
			local var_648_1 = 0

			if var_648_1 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 then
				arg_645_1.var_.moveOldPos115001ui_story = var_648_0.localPosition
			end

			local var_648_2 = 0.001

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_2 then
				local var_648_3 = (arg_645_1.time_ - var_648_1) / var_648_2
				local var_648_4 = Vector3.New(0, 100, 0)

				var_648_0.localPosition = Vector3.Lerp(arg_645_1.var_.moveOldPos115001ui_story, var_648_4, var_648_3)

				local var_648_5 = manager.ui.mainCamera.transform.position - var_648_0.position

				var_648_0.forward = Vector3.New(var_648_5.x, var_648_5.y, var_648_5.z)

				local var_648_6 = var_648_0.localEulerAngles

				var_648_6.z = 0
				var_648_6.x = 0
				var_648_0.localEulerAngles = var_648_6
			end

			if arg_645_1.time_ >= var_648_1 + var_648_2 and arg_645_1.time_ < var_648_1 + var_648_2 + arg_648_0 then
				var_648_0.localPosition = Vector3.New(0, 100, 0)

				local var_648_7 = manager.ui.mainCamera.transform.position - var_648_0.position

				var_648_0.forward = Vector3.New(var_648_7.x, var_648_7.y, var_648_7.z)

				local var_648_8 = var_648_0.localEulerAngles

				var_648_8.z = 0
				var_648_8.x = 0
				var_648_0.localEulerAngles = var_648_8
			end

			local var_648_9 = 0
			local var_648_10 = 0.85

			if var_648_9 < arg_645_1.time_ and arg_645_1.time_ <= var_648_9 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_11 = arg_645_1:GetWordFromCfg(1105005161)
				local var_648_12 = arg_645_1:FormatText(var_648_11.content)

				arg_645_1.text_.text = var_648_12

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_13 = 34
				local var_648_14 = utf8.len(var_648_12)
				local var_648_15 = var_648_13 <= 0 and var_648_10 or var_648_10 * (var_648_14 / var_648_13)

				if var_648_15 > 0 and var_648_10 < var_648_15 then
					arg_645_1.talkMaxDuration = var_648_15

					if var_648_15 + var_648_9 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_15 + var_648_9
					end
				end

				arg_645_1.text_.text = var_648_12
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_16 = math.max(var_648_10, arg_645_1.talkMaxDuration)

			if var_648_9 <= arg_645_1.time_ and arg_645_1.time_ < var_648_9 + var_648_16 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_9) / var_648_16

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_9 + var_648_16 and arg_645_1.time_ < var_648_9 + var_648_16 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_645_1:InitPlayNodeList()
	end,
	Play1105005162 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1105005162
		arg_649_1.duration_ = 9

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1105005163(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 4

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.allBtn_.enabled = false
			end

			local var_652_1 = 0.3

			if arg_649_1.time_ >= var_652_0 + var_652_1 and arg_649_1.time_ < var_652_0 + var_652_1 + arg_652_0 then
				arg_649_1.allBtn_.enabled = true
			end

			local var_652_2 = "ST68"

			if arg_649_1.bgs_[var_652_2] == nil then
				local var_652_3 = Object.Instantiate(arg_649_1.paintGo_)

				var_652_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_652_2)
				var_652_3.name = var_652_2
				var_652_3.transform.parent = arg_649_1.stage_.transform
				var_652_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_649_1.bgs_[var_652_2] = var_652_3
			end

			local var_652_4 = 2

			if var_652_4 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				local var_652_5 = manager.ui.mainCamera.transform.localPosition
				local var_652_6 = Vector3.New(0, 0, 10) + Vector3.New(var_652_5.x, var_652_5.y, 0)
				local var_652_7 = arg_649_1.bgs_.ST68

				var_652_7.transform.localPosition = var_652_6
				var_652_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_652_8 = var_652_7:GetComponent("SpriteRenderer")

				if var_652_8 and var_652_8.sprite then
					local var_652_9 = (var_652_7.transform.localPosition - var_652_5).z
					local var_652_10 = manager.ui.mainCameraCom_
					local var_652_11 = 2 * var_652_9 * Mathf.Tan(var_652_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_652_12 = var_652_11 * var_652_10.aspect
					local var_652_13 = var_652_8.sprite.bounds.size.x
					local var_652_14 = var_652_8.sprite.bounds.size.y
					local var_652_15 = var_652_12 / var_652_13
					local var_652_16 = var_652_11 / var_652_14
					local var_652_17 = var_652_16 < var_652_15 and var_652_15 or var_652_16

					var_652_7.transform.localScale = Vector3.New(var_652_17, var_652_17, 0)
				end

				for iter_652_0, iter_652_1 in pairs(arg_649_1.bgs_) do
					if iter_652_0 ~= "ST68" then
						iter_652_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_652_18 = 0

			if var_652_18 < arg_649_1.time_ and arg_649_1.time_ <= var_652_18 + arg_652_0 then
				arg_649_1.mask_.enabled = true
				arg_649_1.mask_.raycastTarget = true

				arg_649_1:SetGaussion(false)
			end

			local var_652_19 = 2

			if var_652_18 <= arg_649_1.time_ and arg_649_1.time_ < var_652_18 + var_652_19 then
				local var_652_20 = (arg_649_1.time_ - var_652_18) / var_652_19
				local var_652_21 = Color.New(0, 0, 0)

				var_652_21.a = Mathf.Lerp(0, 1, var_652_20)
				arg_649_1.mask_.color = var_652_21
			end

			if arg_649_1.time_ >= var_652_18 + var_652_19 and arg_649_1.time_ < var_652_18 + var_652_19 + arg_652_0 then
				local var_652_22 = Color.New(0, 0, 0)

				var_652_22.a = 1
				arg_649_1.mask_.color = var_652_22
			end

			local var_652_23 = 2

			if var_652_23 < arg_649_1.time_ and arg_649_1.time_ <= var_652_23 + arg_652_0 then
				arg_649_1.mask_.enabled = true
				arg_649_1.mask_.raycastTarget = true

				arg_649_1:SetGaussion(false)
			end

			local var_652_24 = 2

			if var_652_23 <= arg_649_1.time_ and arg_649_1.time_ < var_652_23 + var_652_24 then
				local var_652_25 = (arg_649_1.time_ - var_652_23) / var_652_24
				local var_652_26 = Color.New(0, 0, 0)

				var_652_26.a = Mathf.Lerp(1, 0, var_652_25)
				arg_649_1.mask_.color = var_652_26
			end

			if arg_649_1.time_ >= var_652_23 + var_652_24 and arg_649_1.time_ < var_652_23 + var_652_24 + arg_652_0 then
				local var_652_27 = Color.New(0, 0, 0)
				local var_652_28 = 0

				arg_649_1.mask_.enabled = false
				var_652_27.a = var_652_28
				arg_649_1.mask_.color = var_652_27
			end

			if arg_649_1.frameCnt_ <= 1 then
				arg_649_1.dialog_:SetActive(false)
			end

			local var_652_29 = 4
			local var_652_30 = 0.95

			if var_652_29 < arg_649_1.time_ and arg_649_1.time_ <= var_652_29 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0

				arg_649_1.dialog_:SetActive(true)

				arg_649_1.dialogCg_.alpha = 0

				local var_652_31 = LeanTween.value(arg_649_1.dialog_, 0, 1, 0.3)

				var_652_31:setOnUpdate(LuaHelper.FloatAction(function(arg_653_0)
					arg_649_1.dialogCg_.alpha = arg_653_0
				end))
				var_652_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_649_1.dialog_)
					var_652_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_649_1.duration_ = arg_649_1.duration_ + 0.3

				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_32 = arg_649_1:GetWordFromCfg(1105005162)
				local var_652_33 = arg_649_1:FormatText(var_652_32.content)

				arg_649_1.text_.text = var_652_33

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_34 = 38
				local var_652_35 = utf8.len(var_652_33)
				local var_652_36 = var_652_34 <= 0 and var_652_30 or var_652_30 * (var_652_35 / var_652_34)

				if var_652_36 > 0 and var_652_30 < var_652_36 then
					arg_649_1.talkMaxDuration = var_652_36
					var_652_29 = var_652_29 + 0.3

					if var_652_36 + var_652_29 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_36 + var_652_29
					end
				end

				arg_649_1.text_.text = var_652_33
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_37 = var_652_29 + 0.3
			local var_652_38 = math.max(var_652_30, arg_649_1.talkMaxDuration)

			if var_652_37 <= arg_649_1.time_ and arg_649_1.time_ < var_652_37 + var_652_38 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_37) / var_652_38

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_37 + var_652_38 and arg_649_1.time_ < var_652_37 + var_652_38 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1105005163 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1105005163
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1105005164(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0
			local var_658_1 = 0.425

			if var_658_0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_2 = arg_655_1:FormatText(StoryNameCfg[7].name)

				arg_655_1.leftNameTxt_.text = var_658_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_3 = arg_655_1:GetWordFromCfg(1105005163)
				local var_658_4 = arg_655_1:FormatText(var_658_3.content)

				arg_655_1.text_.text = var_658_4

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 17
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
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_8 = math.max(var_658_1, arg_655_1.talkMaxDuration)

			if var_658_0 <= arg_655_1.time_ and arg_655_1.time_ < var_658_0 + var_658_8 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_0) / var_658_8

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_0 + var_658_8 and arg_655_1.time_ < var_658_0 + var_658_8 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1105005164 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1105005164
		arg_659_1.duration_ = 2

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1105005165(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = arg_659_1.actors_["115001ui_story"].transform
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 then
				arg_659_1.var_.moveOldPos115001ui_story = var_662_0.localPosition
			end

			local var_662_2 = 0.001

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_2 then
				local var_662_3 = (arg_659_1.time_ - var_662_1) / var_662_2
				local var_662_4 = Vector3.New(0, -1.033, -6.3)

				var_662_0.localPosition = Vector3.Lerp(arg_659_1.var_.moveOldPos115001ui_story, var_662_4, var_662_3)

				local var_662_5 = manager.ui.mainCamera.transform.position - var_662_0.position

				var_662_0.forward = Vector3.New(var_662_5.x, var_662_5.y, var_662_5.z)

				local var_662_6 = var_662_0.localEulerAngles

				var_662_6.z = 0
				var_662_6.x = 0
				var_662_0.localEulerAngles = var_662_6
			end

			if arg_659_1.time_ >= var_662_1 + var_662_2 and arg_659_1.time_ < var_662_1 + var_662_2 + arg_662_0 then
				var_662_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_662_7 = manager.ui.mainCamera.transform.position - var_662_0.position

				var_662_0.forward = Vector3.New(var_662_7.x, var_662_7.y, var_662_7.z)

				local var_662_8 = var_662_0.localEulerAngles

				var_662_8.z = 0
				var_662_8.x = 0
				var_662_0.localEulerAngles = var_662_8
			end

			local var_662_9 = arg_659_1.actors_["115001ui_story"]
			local var_662_10 = 0

			if var_662_10 < arg_659_1.time_ and arg_659_1.time_ <= var_662_10 + arg_662_0 and not isNil(var_662_9) and arg_659_1.var_.characterEffect115001ui_story == nil then
				arg_659_1.var_.characterEffect115001ui_story = var_662_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_11 = 0.200000002980232

			if var_662_10 <= arg_659_1.time_ and arg_659_1.time_ < var_662_10 + var_662_11 and not isNil(var_662_9) then
				local var_662_12 = (arg_659_1.time_ - var_662_10) / var_662_11

				if arg_659_1.var_.characterEffect115001ui_story and not isNil(var_662_9) then
					arg_659_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= var_662_10 + var_662_11 and arg_659_1.time_ < var_662_10 + var_662_11 + arg_662_0 and not isNil(var_662_9) and arg_659_1.var_.characterEffect115001ui_story then
				arg_659_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_662_13 = 0

			if var_662_13 < arg_659_1.time_ and arg_659_1.time_ <= var_662_13 + arg_662_0 then
				arg_659_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			local var_662_14 = 0

			if var_662_14 < arg_659_1.time_ and arg_659_1.time_ <= var_662_14 + arg_662_0 then
				arg_659_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_662_15 = 0
			local var_662_16 = 0.2

			if var_662_15 < arg_659_1.time_ and arg_659_1.time_ <= var_662_15 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_17 = arg_659_1:FormatText(StoryNameCfg[74].name)

				arg_659_1.leftNameTxt_.text = var_662_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_18 = arg_659_1:GetWordFromCfg(1105005164)
				local var_662_19 = arg_659_1:FormatText(var_662_18.content)

				arg_659_1.text_.text = var_662_19

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_20 = 8
				local var_662_21 = utf8.len(var_662_19)
				local var_662_22 = var_662_20 <= 0 and var_662_16 or var_662_16 * (var_662_21 / var_662_20)

				if var_662_22 > 0 and var_662_16 < var_662_22 then
					arg_659_1.talkMaxDuration = var_662_22

					if var_662_22 + var_662_15 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_22 + var_662_15
					end
				end

				arg_659_1.text_.text = var_662_19
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005164", "story_v_side_new_1105005.awb") ~= 0 then
					local var_662_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005164", "story_v_side_new_1105005.awb") / 1000

					if var_662_23 + var_662_15 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_23 + var_662_15
					end

					if var_662_18.prefab_name ~= "" and arg_659_1.actors_[var_662_18.prefab_name] ~= nil then
						local var_662_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_18.prefab_name].transform, "story_v_side_new_1105005", "1105005164", "story_v_side_new_1105005.awb")

						arg_659_1:RecordAudio("1105005164", var_662_24)
						arg_659_1:RecordAudio("1105005164", var_662_24)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005164", "story_v_side_new_1105005.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005164", "story_v_side_new_1105005.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_25 = math.max(var_662_16, arg_659_1.talkMaxDuration)

			if var_662_15 <= arg_659_1.time_ and arg_659_1.time_ < var_662_15 + var_662_25 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_15) / var_662_25

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_15 + var_662_25 and arg_659_1.time_ < var_662_15 + var_662_25 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_659_1:InitPlayNodeList()
	end,
	Play1105005165 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1105005165
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1105005166(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = arg_663_1.actors_["115001ui_story"]
			local var_666_1 = 0

			if var_666_1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect115001ui_story == nil then
				arg_663_1.var_.characterEffect115001ui_story = var_666_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_2 and not isNil(var_666_0) then
				local var_666_3 = (arg_663_1.time_ - var_666_1) / var_666_2

				if arg_663_1.var_.characterEffect115001ui_story and not isNil(var_666_0) then
					local var_666_4 = Mathf.Lerp(0, 0.5, var_666_3)

					arg_663_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_663_1.var_.characterEffect115001ui_story.fillRatio = var_666_4
				end
			end

			if arg_663_1.time_ >= var_666_1 + var_666_2 and arg_663_1.time_ < var_666_1 + var_666_2 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect115001ui_story then
				local var_666_5 = 0.5

				arg_663_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_663_1.var_.characterEffect115001ui_story.fillRatio = var_666_5
			end

			local var_666_6 = 0
			local var_666_7 = 1.125

			if var_666_6 < arg_663_1.time_ and arg_663_1.time_ <= var_666_6 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_8 = arg_663_1:FormatText(StoryNameCfg[7].name)

				arg_663_1.leftNameTxt_.text = var_666_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_9 = arg_663_1:GetWordFromCfg(1105005165)
				local var_666_10 = arg_663_1:FormatText(var_666_9.content)

				arg_663_1.text_.text = var_666_10

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_11 = 45
				local var_666_12 = utf8.len(var_666_10)
				local var_666_13 = var_666_11 <= 0 and var_666_7 or var_666_7 * (var_666_12 / var_666_11)

				if var_666_13 > 0 and var_666_7 < var_666_13 then
					arg_663_1.talkMaxDuration = var_666_13

					if var_666_13 + var_666_6 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_13 + var_666_6
					end
				end

				arg_663_1.text_.text = var_666_10
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_14 = math.max(var_666_7, arg_663_1.talkMaxDuration)

			if var_666_6 <= arg_663_1.time_ and arg_663_1.time_ < var_666_6 + var_666_14 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_6) / var_666_14

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_6 + var_666_14 and arg_663_1.time_ < var_666_6 + var_666_14 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play1105005166 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1105005166
		arg_667_1.duration_ = 2

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1105005167(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = arg_667_1.actors_["115001ui_story"]
			local var_670_1 = 0

			if var_670_1 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 and not isNil(var_670_0) and arg_667_1.var_.characterEffect115001ui_story == nil then
				arg_667_1.var_.characterEffect115001ui_story = var_670_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.200000002980232

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_2 and not isNil(var_670_0) then
				local var_670_3 = (arg_667_1.time_ - var_670_1) / var_670_2

				if arg_667_1.var_.characterEffect115001ui_story and not isNil(var_670_0) then
					arg_667_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= var_670_1 + var_670_2 and arg_667_1.time_ < var_670_1 + var_670_2 + arg_670_0 and not isNil(var_670_0) and arg_667_1.var_.characterEffect115001ui_story then
				arg_667_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_670_4 = 0

			if var_670_4 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_670_5 = 0
			local var_670_6 = 0.225

			if var_670_5 < arg_667_1.time_ and arg_667_1.time_ <= var_670_5 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_7 = arg_667_1:FormatText(StoryNameCfg[74].name)

				arg_667_1.leftNameTxt_.text = var_670_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_8 = arg_667_1:GetWordFromCfg(1105005166)
				local var_670_9 = arg_667_1:FormatText(var_670_8.content)

				arg_667_1.text_.text = var_670_9

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_10 = 9
				local var_670_11 = utf8.len(var_670_9)
				local var_670_12 = var_670_10 <= 0 and var_670_6 or var_670_6 * (var_670_11 / var_670_10)

				if var_670_12 > 0 and var_670_6 < var_670_12 then
					arg_667_1.talkMaxDuration = var_670_12

					if var_670_12 + var_670_5 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_12 + var_670_5
					end
				end

				arg_667_1.text_.text = var_670_9
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005166", "story_v_side_new_1105005.awb") ~= 0 then
					local var_670_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005166", "story_v_side_new_1105005.awb") / 1000

					if var_670_13 + var_670_5 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_13 + var_670_5
					end

					if var_670_8.prefab_name ~= "" and arg_667_1.actors_[var_670_8.prefab_name] ~= nil then
						local var_670_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_8.prefab_name].transform, "story_v_side_new_1105005", "1105005166", "story_v_side_new_1105005.awb")

						arg_667_1:RecordAudio("1105005166", var_670_14)
						arg_667_1:RecordAudio("1105005166", var_670_14)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005166", "story_v_side_new_1105005.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005166", "story_v_side_new_1105005.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_15 = math.max(var_670_6, arg_667_1.talkMaxDuration)

			if var_670_5 <= arg_667_1.time_ and arg_667_1.time_ < var_670_5 + var_670_15 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_5) / var_670_15

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_5 + var_670_15 and arg_667_1.time_ < var_670_5 + var_670_15 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1105005167 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1105005167
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1105005168(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["115001ui_story"].transform
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 then
				arg_671_1.var_.moveOldPos115001ui_story = var_674_0.localPosition
			end

			local var_674_2 = 0.001

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2
				local var_674_4 = Vector3.New(0, 100, 0)

				var_674_0.localPosition = Vector3.Lerp(arg_671_1.var_.moveOldPos115001ui_story, var_674_4, var_674_3)

				local var_674_5 = manager.ui.mainCamera.transform.position - var_674_0.position

				var_674_0.forward = Vector3.New(var_674_5.x, var_674_5.y, var_674_5.z)

				local var_674_6 = var_674_0.localEulerAngles

				var_674_6.z = 0
				var_674_6.x = 0
				var_674_0.localEulerAngles = var_674_6
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 then
				var_674_0.localPosition = Vector3.New(0, 100, 0)

				local var_674_7 = manager.ui.mainCamera.transform.position - var_674_0.position

				var_674_0.forward = Vector3.New(var_674_7.x, var_674_7.y, var_674_7.z)

				local var_674_8 = var_674_0.localEulerAngles

				var_674_8.z = 0
				var_674_8.x = 0
				var_674_0.localEulerAngles = var_674_8
			end

			local var_674_9 = 0
			local var_674_10 = 0.975

			if var_674_9 < arg_671_1.time_ and arg_671_1.time_ <= var_674_9 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_11 = arg_671_1:GetWordFromCfg(1105005167)
				local var_674_12 = arg_671_1:FormatText(var_674_11.content)

				arg_671_1.text_.text = var_674_12

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_13 = 39
				local var_674_14 = utf8.len(var_674_12)
				local var_674_15 = var_674_13 <= 0 and var_674_10 or var_674_10 * (var_674_14 / var_674_13)

				if var_674_15 > 0 and var_674_10 < var_674_15 then
					arg_671_1.talkMaxDuration = var_674_15

					if var_674_15 + var_674_9 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_15 + var_674_9
					end
				end

				arg_671_1.text_.text = var_674_12
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_16 = math.max(var_674_10, arg_671_1.talkMaxDuration)

			if var_674_9 <= arg_671_1.time_ and arg_671_1.time_ < var_674_9 + var_674_16 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_9) / var_674_16

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_9 + var_674_16 and arg_671_1.time_ < var_674_9 + var_674_16 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_671_1:InitPlayNodeList()
	end,
	Play1105005168 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1105005168
		arg_675_1.duration_ = 5.3

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1105005169(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["115001ui_story"]
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 and not isNil(var_678_0) and arg_675_1.var_.characterEffect115001ui_story == nil then
				arg_675_1.var_.characterEffect115001ui_story = var_678_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_2 = 0.200000002980232

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_2 and not isNil(var_678_0) then
				local var_678_3 = (arg_675_1.time_ - var_678_1) / var_678_2

				if arg_675_1.var_.characterEffect115001ui_story and not isNil(var_678_0) then
					arg_675_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= var_678_1 + var_678_2 and arg_675_1.time_ < var_678_1 + var_678_2 + arg_678_0 and not isNil(var_678_0) and arg_675_1.var_.characterEffect115001ui_story then
				arg_675_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_678_4 = arg_675_1.actors_["115001ui_story"].transform
			local var_678_5 = 0

			if var_678_5 < arg_675_1.time_ and arg_675_1.time_ <= var_678_5 + arg_678_0 then
				arg_675_1.var_.moveOldPos115001ui_story = var_678_4.localPosition
			end

			local var_678_6 = 0.001

			if var_678_5 <= arg_675_1.time_ and arg_675_1.time_ < var_678_5 + var_678_6 then
				local var_678_7 = (arg_675_1.time_ - var_678_5) / var_678_6
				local var_678_8 = Vector3.New(0, -1.033, -6.3)

				var_678_4.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos115001ui_story, var_678_8, var_678_7)

				local var_678_9 = manager.ui.mainCamera.transform.position - var_678_4.position

				var_678_4.forward = Vector3.New(var_678_9.x, var_678_9.y, var_678_9.z)

				local var_678_10 = var_678_4.localEulerAngles

				var_678_10.z = 0
				var_678_10.x = 0
				var_678_4.localEulerAngles = var_678_10
			end

			if arg_675_1.time_ >= var_678_5 + var_678_6 and arg_675_1.time_ < var_678_5 + var_678_6 + arg_678_0 then
				var_678_4.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_678_11 = manager.ui.mainCamera.transform.position - var_678_4.position

				var_678_4.forward = Vector3.New(var_678_11.x, var_678_11.y, var_678_11.z)

				local var_678_12 = var_678_4.localEulerAngles

				var_678_12.z = 0
				var_678_12.x = 0
				var_678_4.localEulerAngles = var_678_12
			end

			local var_678_13 = 0
			local var_678_14 = 0.65

			if var_678_13 < arg_675_1.time_ and arg_675_1.time_ <= var_678_13 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_15 = arg_675_1:FormatText(StoryNameCfg[74].name)

				arg_675_1.leftNameTxt_.text = var_678_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_16 = arg_675_1:GetWordFromCfg(1105005168)
				local var_678_17 = arg_675_1:FormatText(var_678_16.content)

				arg_675_1.text_.text = var_678_17

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_18 = 26
				local var_678_19 = utf8.len(var_678_17)
				local var_678_20 = var_678_18 <= 0 and var_678_14 or var_678_14 * (var_678_19 / var_678_18)

				if var_678_20 > 0 and var_678_14 < var_678_20 then
					arg_675_1.talkMaxDuration = var_678_20

					if var_678_20 + var_678_13 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_20 + var_678_13
					end
				end

				arg_675_1.text_.text = var_678_17
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005168", "story_v_side_new_1105005.awb") ~= 0 then
					local var_678_21 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005168", "story_v_side_new_1105005.awb") / 1000

					if var_678_21 + var_678_13 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_21 + var_678_13
					end

					if var_678_16.prefab_name ~= "" and arg_675_1.actors_[var_678_16.prefab_name] ~= nil then
						local var_678_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_16.prefab_name].transform, "story_v_side_new_1105005", "1105005168", "story_v_side_new_1105005.awb")

						arg_675_1:RecordAudio("1105005168", var_678_22)
						arg_675_1:RecordAudio("1105005168", var_678_22)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005168", "story_v_side_new_1105005.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005168", "story_v_side_new_1105005.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_23 = math.max(var_678_14, arg_675_1.talkMaxDuration)

			if var_678_13 <= arg_675_1.time_ and arg_675_1.time_ < var_678_13 + var_678_23 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_13) / var_678_23

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_13 + var_678_23 and arg_675_1.time_ < var_678_13 + var_678_23 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play1105005169 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1105005169
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1105005170(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["115001ui_story"]
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.characterEffect115001ui_story == nil then
				arg_679_1.var_.characterEffect115001ui_story = var_682_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 and not isNil(var_682_0) then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2

				if arg_679_1.var_.characterEffect115001ui_story and not isNil(var_682_0) then
					local var_682_4 = Mathf.Lerp(0, 0.5, var_682_3)

					arg_679_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_679_1.var_.characterEffect115001ui_story.fillRatio = var_682_4
				end
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.characterEffect115001ui_story then
				local var_682_5 = 0.5

				arg_679_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_679_1.var_.characterEffect115001ui_story.fillRatio = var_682_5
			end

			local var_682_6 = 0
			local var_682_7 = 0.275

			if var_682_6 < arg_679_1.time_ and arg_679_1.time_ <= var_682_6 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_8 = arg_679_1:FormatText(StoryNameCfg[7].name)

				arg_679_1.leftNameTxt_.text = var_682_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, true)
				arg_679_1.iconController_:SetSelectedState("hero")

				arg_679_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_679_1.callingController_:SetSelectedState("normal")

				arg_679_1.keyicon_.color = Color.New(1, 1, 1)
				arg_679_1.icon_.color = Color.New(1, 1, 1)

				local var_682_9 = arg_679_1:GetWordFromCfg(1105005169)
				local var_682_10 = arg_679_1:FormatText(var_682_9.content)

				arg_679_1.text_.text = var_682_10

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_11 = 11
				local var_682_12 = utf8.len(var_682_10)
				local var_682_13 = var_682_11 <= 0 and var_682_7 or var_682_7 * (var_682_12 / var_682_11)

				if var_682_13 > 0 and var_682_7 < var_682_13 then
					arg_679_1.talkMaxDuration = var_682_13

					if var_682_13 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_13 + var_682_6
					end
				end

				arg_679_1.text_.text = var_682_10
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_14 = math.max(var_682_7, arg_679_1.talkMaxDuration)

			if var_682_6 <= arg_679_1.time_ and arg_679_1.time_ < var_682_6 + var_682_14 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_6) / var_682_14

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_6 + var_682_14 and arg_679_1.time_ < var_682_6 + var_682_14 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1105005170 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1105005170
		arg_683_1.duration_ = 2

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1105005171(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["115001ui_story"]
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect115001ui_story == nil then
				arg_683_1.var_.characterEffect115001ui_story = var_686_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_2 = 0.200000002980232

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 and not isNil(var_686_0) then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2

				if arg_683_1.var_.characterEffect115001ui_story and not isNil(var_686_0) then
					arg_683_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect115001ui_story then
				arg_683_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_686_4 = 0

			if var_686_4 < arg_683_1.time_ and arg_683_1.time_ <= var_686_4 + arg_686_0 then
				arg_683_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action5_1")
			end

			local var_686_5 = 0

			if var_686_5 < arg_683_1.time_ and arg_683_1.time_ <= var_686_5 + arg_686_0 then
				arg_683_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_686_6 = 0
			local var_686_7 = 0.15

			if var_686_6 < arg_683_1.time_ and arg_683_1.time_ <= var_686_6 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_8 = arg_683_1:FormatText(StoryNameCfg[74].name)

				arg_683_1.leftNameTxt_.text = var_686_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_9 = arg_683_1:GetWordFromCfg(1105005170)
				local var_686_10 = arg_683_1:FormatText(var_686_9.content)

				arg_683_1.text_.text = var_686_10

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005170", "story_v_side_new_1105005.awb") ~= 0 then
					local var_686_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005170", "story_v_side_new_1105005.awb") / 1000

					if var_686_14 + var_686_6 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_14 + var_686_6
					end

					if var_686_9.prefab_name ~= "" and arg_683_1.actors_[var_686_9.prefab_name] ~= nil then
						local var_686_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_9.prefab_name].transform, "story_v_side_new_1105005", "1105005170", "story_v_side_new_1105005.awb")

						arg_683_1:RecordAudio("1105005170", var_686_15)
						arg_683_1:RecordAudio("1105005170", var_686_15)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005170", "story_v_side_new_1105005.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005170", "story_v_side_new_1105005.awb")
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
	Play1105005171 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1105005171
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1105005172(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["115001ui_story"].transform
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 then
				arg_687_1.var_.moveOldPos115001ui_story = var_690_0.localPosition
			end

			local var_690_2 = 0.001

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2
				local var_690_4 = Vector3.New(0, 100, 0)

				var_690_0.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos115001ui_story, var_690_4, var_690_3)

				local var_690_5 = manager.ui.mainCamera.transform.position - var_690_0.position

				var_690_0.forward = Vector3.New(var_690_5.x, var_690_5.y, var_690_5.z)

				local var_690_6 = var_690_0.localEulerAngles

				var_690_6.z = 0
				var_690_6.x = 0
				var_690_0.localEulerAngles = var_690_6
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 then
				var_690_0.localPosition = Vector3.New(0, 100, 0)

				local var_690_7 = manager.ui.mainCamera.transform.position - var_690_0.position

				var_690_0.forward = Vector3.New(var_690_7.x, var_690_7.y, var_690_7.z)

				local var_690_8 = var_690_0.localEulerAngles

				var_690_8.z = 0
				var_690_8.x = 0
				var_690_0.localEulerAngles = var_690_8
			end

			local var_690_9 = 0
			local var_690_10 = 0.825

			if var_690_9 < arg_687_1.time_ and arg_687_1.time_ <= var_690_9 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, false)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_11 = arg_687_1:GetWordFromCfg(1105005171)
				local var_690_12 = arg_687_1:FormatText(var_690_11.content)

				arg_687_1.text_.text = var_690_12

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_13 = 33
				local var_690_14 = utf8.len(var_690_12)
				local var_690_15 = var_690_13 <= 0 and var_690_10 or var_690_10 * (var_690_14 / var_690_13)

				if var_690_15 > 0 and var_690_10 < var_690_15 then
					arg_687_1.talkMaxDuration = var_690_15

					if var_690_15 + var_690_9 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_15 + var_690_9
					end
				end

				arg_687_1.text_.text = var_690_12
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_16 = math.max(var_690_10, arg_687_1.talkMaxDuration)

			if var_690_9 <= arg_687_1.time_ and arg_687_1.time_ < var_690_9 + var_690_16 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_9) / var_690_16

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_9 + var_690_16 and arg_687_1.time_ < var_690_9 + var_690_16 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_687_1:InitPlayNodeList()
	end,
	Play1105005172 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1105005172
		arg_691_1.duration_ = 11.3

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1105005173(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["115001ui_story"]
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect115001ui_story == nil then
				arg_691_1.var_.characterEffect115001ui_story = var_694_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 and not isNil(var_694_0) then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2

				if arg_691_1.var_.characterEffect115001ui_story and not isNil(var_694_0) then
					arg_691_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect115001ui_story then
				arg_691_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_694_4 = arg_691_1.actors_["115001ui_story"].transform
			local var_694_5 = 0

			if var_694_5 < arg_691_1.time_ and arg_691_1.time_ <= var_694_5 + arg_694_0 then
				arg_691_1.var_.moveOldPos115001ui_story = var_694_4.localPosition
			end

			local var_694_6 = 0.001

			if var_694_5 <= arg_691_1.time_ and arg_691_1.time_ < var_694_5 + var_694_6 then
				local var_694_7 = (arg_691_1.time_ - var_694_5) / var_694_6
				local var_694_8 = Vector3.New(0, -1.033, -6.3)

				var_694_4.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos115001ui_story, var_694_8, var_694_7)

				local var_694_9 = manager.ui.mainCamera.transform.position - var_694_4.position

				var_694_4.forward = Vector3.New(var_694_9.x, var_694_9.y, var_694_9.z)

				local var_694_10 = var_694_4.localEulerAngles

				var_694_10.z = 0
				var_694_10.x = 0
				var_694_4.localEulerAngles = var_694_10
			end

			if arg_691_1.time_ >= var_694_5 + var_694_6 and arg_691_1.time_ < var_694_5 + var_694_6 + arg_694_0 then
				var_694_4.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_694_11 = manager.ui.mainCamera.transform.position - var_694_4.position

				var_694_4.forward = Vector3.New(var_694_11.x, var_694_11.y, var_694_11.z)

				local var_694_12 = var_694_4.localEulerAngles

				var_694_12.z = 0
				var_694_12.x = 0
				var_694_4.localEulerAngles = var_694_12
			end

			local var_694_13 = 0

			if var_694_13 < arg_691_1.time_ and arg_691_1.time_ <= var_694_13 + arg_694_0 then
				arg_691_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_694_14 = 0

			if var_694_14 < arg_691_1.time_ and arg_691_1.time_ <= var_694_14 + arg_694_0 then
				arg_691_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150actionlink/1150action453")
			end

			local var_694_15 = 0
			local var_694_16 = 1.275

			if var_694_15 < arg_691_1.time_ and arg_691_1.time_ <= var_694_15 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_17 = arg_691_1:FormatText(StoryNameCfg[74].name)

				arg_691_1.leftNameTxt_.text = var_694_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_18 = arg_691_1:GetWordFromCfg(1105005172)
				local var_694_19 = arg_691_1:FormatText(var_694_18.content)

				arg_691_1.text_.text = var_694_19

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_20 = 51
				local var_694_21 = utf8.len(var_694_19)
				local var_694_22 = var_694_20 <= 0 and var_694_16 or var_694_16 * (var_694_21 / var_694_20)

				if var_694_22 > 0 and var_694_16 < var_694_22 then
					arg_691_1.talkMaxDuration = var_694_22

					if var_694_22 + var_694_15 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_22 + var_694_15
					end
				end

				arg_691_1.text_.text = var_694_19
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005172", "story_v_side_new_1105005.awb") ~= 0 then
					local var_694_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005172", "story_v_side_new_1105005.awb") / 1000

					if var_694_23 + var_694_15 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_23 + var_694_15
					end

					if var_694_18.prefab_name ~= "" and arg_691_1.actors_[var_694_18.prefab_name] ~= nil then
						local var_694_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_18.prefab_name].transform, "story_v_side_new_1105005", "1105005172", "story_v_side_new_1105005.awb")

						arg_691_1:RecordAudio("1105005172", var_694_24)
						arg_691_1:RecordAudio("1105005172", var_694_24)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005172", "story_v_side_new_1105005.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005172", "story_v_side_new_1105005.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_25 = math.max(var_694_16, arg_691_1.talkMaxDuration)

			if var_694_15 <= arg_691_1.time_ and arg_691_1.time_ < var_694_15 + var_694_25 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_15) / var_694_25

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_15 + var_694_25 and arg_691_1.time_ < var_694_15 + var_694_25 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play1105005173 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1105005173
		arg_695_1.duration_ = 9.77

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1105005174(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0
			local var_698_1 = 1.325

			if var_698_0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_2 = arg_695_1:FormatText(StoryNameCfg[74].name)

				arg_695_1.leftNameTxt_.text = var_698_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_3 = arg_695_1:GetWordFromCfg(1105005173)
				local var_698_4 = arg_695_1:FormatText(var_698_3.content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 53
				local var_698_6 = utf8.len(var_698_4)
				local var_698_7 = var_698_5 <= 0 and var_698_1 or var_698_1 * (var_698_6 / var_698_5)

				if var_698_7 > 0 and var_698_1 < var_698_7 then
					arg_695_1.talkMaxDuration = var_698_7

					if var_698_7 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_7 + var_698_0
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005173", "story_v_side_new_1105005.awb") ~= 0 then
					local var_698_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005173", "story_v_side_new_1105005.awb") / 1000

					if var_698_8 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_8 + var_698_0
					end

					if var_698_3.prefab_name ~= "" and arg_695_1.actors_[var_698_3.prefab_name] ~= nil then
						local var_698_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_3.prefab_name].transform, "story_v_side_new_1105005", "1105005173", "story_v_side_new_1105005.awb")

						arg_695_1:RecordAudio("1105005173", var_698_9)
						arg_695_1:RecordAudio("1105005173", var_698_9)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005173", "story_v_side_new_1105005.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005173", "story_v_side_new_1105005.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_10 = math.max(var_698_1, arg_695_1.talkMaxDuration)

			if var_698_0 <= arg_695_1.time_ and arg_695_1.time_ < var_698_0 + var_698_10 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_0) / var_698_10

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_0 + var_698_10 and arg_695_1.time_ < var_698_0 + var_698_10 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1105005174 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1105005174
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1105005175(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["115001ui_story"]
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect115001ui_story == nil then
				arg_699_1.var_.characterEffect115001ui_story = var_702_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 and not isNil(var_702_0) then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2

				if arg_699_1.var_.characterEffect115001ui_story and not isNil(var_702_0) then
					local var_702_4 = Mathf.Lerp(0, 0.5, var_702_3)

					arg_699_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_699_1.var_.characterEffect115001ui_story.fillRatio = var_702_4
				end
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect115001ui_story then
				local var_702_5 = 0.5

				arg_699_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_699_1.var_.characterEffect115001ui_story.fillRatio = var_702_5
			end

			local var_702_6 = 0
			local var_702_7 = 0.775

			if var_702_6 < arg_699_1.time_ and arg_699_1.time_ <= var_702_6 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_8 = arg_699_1:FormatText(StoryNameCfg[7].name)

				arg_699_1.leftNameTxt_.text = var_702_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, true)
				arg_699_1.iconController_:SetSelectedState("hero")

				arg_699_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_699_1.callingController_:SetSelectedState("normal")

				arg_699_1.keyicon_.color = Color.New(1, 1, 1)
				arg_699_1.icon_.color = Color.New(1, 1, 1)

				local var_702_9 = arg_699_1:GetWordFromCfg(1105005174)
				local var_702_10 = arg_699_1:FormatText(var_702_9.content)

				arg_699_1.text_.text = var_702_10

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_11 = 31
				local var_702_12 = utf8.len(var_702_10)
				local var_702_13 = var_702_11 <= 0 and var_702_7 or var_702_7 * (var_702_12 / var_702_11)

				if var_702_13 > 0 and var_702_7 < var_702_13 then
					arg_699_1.talkMaxDuration = var_702_13

					if var_702_13 + var_702_6 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_13 + var_702_6
					end
				end

				arg_699_1.text_.text = var_702_10
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_14 = math.max(var_702_7, arg_699_1.talkMaxDuration)

			if var_702_6 <= arg_699_1.time_ and arg_699_1.time_ < var_702_6 + var_702_14 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_6) / var_702_14

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_6 + var_702_14 and arg_699_1.time_ < var_702_6 + var_702_14 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1105005175 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1105005175
		arg_703_1.duration_ = 2.13

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1105005176(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["115001ui_story"]
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect115001ui_story == nil then
				arg_703_1.var_.characterEffect115001ui_story = var_706_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 and not isNil(var_706_0) then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2

				if arg_703_1.var_.characterEffect115001ui_story and not isNil(var_706_0) then
					arg_703_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect115001ui_story then
				arg_703_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_706_4 = 0

			if var_706_4 < arg_703_1.time_ and arg_703_1.time_ <= var_706_4 + arg_706_0 then
				arg_703_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action3_2")
			end

			local var_706_5 = 0

			if var_706_5 < arg_703_1.time_ and arg_703_1.time_ <= var_706_5 + arg_706_0 then
				arg_703_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_706_6 = 0
			local var_706_7 = 0.3

			if var_706_6 < arg_703_1.time_ and arg_703_1.time_ <= var_706_6 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_8 = arg_703_1:FormatText(StoryNameCfg[74].name)

				arg_703_1.leftNameTxt_.text = var_706_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_9 = arg_703_1:GetWordFromCfg(1105005175)
				local var_706_10 = arg_703_1:FormatText(var_706_9.content)

				arg_703_1.text_.text = var_706_10

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_11 = 12
				local var_706_12 = utf8.len(var_706_10)
				local var_706_13 = var_706_11 <= 0 and var_706_7 or var_706_7 * (var_706_12 / var_706_11)

				if var_706_13 > 0 and var_706_7 < var_706_13 then
					arg_703_1.talkMaxDuration = var_706_13

					if var_706_13 + var_706_6 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_13 + var_706_6
					end
				end

				arg_703_1.text_.text = var_706_10
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005175", "story_v_side_new_1105005.awb") ~= 0 then
					local var_706_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005175", "story_v_side_new_1105005.awb") / 1000

					if var_706_14 + var_706_6 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_14 + var_706_6
					end

					if var_706_9.prefab_name ~= "" and arg_703_1.actors_[var_706_9.prefab_name] ~= nil then
						local var_706_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_9.prefab_name].transform, "story_v_side_new_1105005", "1105005175", "story_v_side_new_1105005.awb")

						arg_703_1:RecordAudio("1105005175", var_706_15)
						arg_703_1:RecordAudio("1105005175", var_706_15)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005175", "story_v_side_new_1105005.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005175", "story_v_side_new_1105005.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_16 = math.max(var_706_7, arg_703_1.talkMaxDuration)

			if var_706_6 <= arg_703_1.time_ and arg_703_1.time_ < var_706_6 + var_706_16 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_6) / var_706_16

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_6 + var_706_16 and arg_703_1.time_ < var_706_6 + var_706_16 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play1105005176 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1105005176
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1105005177(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["115001ui_story"].transform
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.var_.moveOldPos115001ui_story = var_710_0.localPosition
			end

			local var_710_2 = 0.001

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2
				local var_710_4 = Vector3.New(0, 100, 0)

				var_710_0.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos115001ui_story, var_710_4, var_710_3)

				local var_710_5 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_5.x, var_710_5.y, var_710_5.z)

				local var_710_6 = var_710_0.localEulerAngles

				var_710_6.z = 0
				var_710_6.x = 0
				var_710_0.localEulerAngles = var_710_6
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 then
				var_710_0.localPosition = Vector3.New(0, 100, 0)

				local var_710_7 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_7.x, var_710_7.y, var_710_7.z)

				local var_710_8 = var_710_0.localEulerAngles

				var_710_8.z = 0
				var_710_8.x = 0
				var_710_0.localEulerAngles = var_710_8
			end

			local var_710_9 = 0
			local var_710_10 = 1.1

			if var_710_9 < arg_707_1.time_ and arg_707_1.time_ <= var_710_9 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_11 = arg_707_1:GetWordFromCfg(1105005176)
				local var_710_12 = arg_707_1:FormatText(var_710_11.content)

				arg_707_1.text_.text = var_710_12

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_13 = 44
				local var_710_14 = utf8.len(var_710_12)
				local var_710_15 = var_710_13 <= 0 and var_710_10 or var_710_10 * (var_710_14 / var_710_13)

				if var_710_15 > 0 and var_710_10 < var_710_15 then
					arg_707_1.talkMaxDuration = var_710_15

					if var_710_15 + var_710_9 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_15 + var_710_9
					end
				end

				arg_707_1.text_.text = var_710_12
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_16 = math.max(var_710_10, arg_707_1.talkMaxDuration)

			if var_710_9 <= arg_707_1.time_ and arg_707_1.time_ < var_710_9 + var_710_16 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_9) / var_710_16

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_9 + var_710_16 and arg_707_1.time_ < var_710_9 + var_710_16 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play1105005177 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1105005177
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1105005178(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0
			local var_714_1 = 0.625

			if var_714_0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, false)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_2 = arg_711_1:GetWordFromCfg(1105005177)
				local var_714_3 = arg_711_1:FormatText(var_714_2.content)

				arg_711_1.text_.text = var_714_3

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_4 = 25
				local var_714_5 = utf8.len(var_714_3)
				local var_714_6 = var_714_4 <= 0 and var_714_1 or var_714_1 * (var_714_5 / var_714_4)

				if var_714_6 > 0 and var_714_1 < var_714_6 then
					arg_711_1.talkMaxDuration = var_714_6

					if var_714_6 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_6 + var_714_0
					end
				end

				arg_711_1.text_.text = var_714_3
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_7 = math.max(var_714_1, arg_711_1.talkMaxDuration)

			if var_714_0 <= arg_711_1.time_ and arg_711_1.time_ < var_714_0 + var_714_7 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_0) / var_714_7

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_0 + var_714_7 and arg_711_1.time_ < var_714_0 + var_714_7 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1105005178 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1105005178
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1105005179(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0
			local var_718_1 = 0.725

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_2 = arg_715_1:FormatText(StoryNameCfg[7].name)

				arg_715_1.leftNameTxt_.text = var_718_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, true)
				arg_715_1.iconController_:SetSelectedState("hero")

				arg_715_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_715_1.callingController_:SetSelectedState("normal")

				arg_715_1.keyicon_.color = Color.New(1, 1, 1)
				arg_715_1.icon_.color = Color.New(1, 1, 1)

				local var_718_3 = arg_715_1:GetWordFromCfg(1105005178)
				local var_718_4 = arg_715_1:FormatText(var_718_3.content)

				arg_715_1.text_.text = var_718_4

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_5 = 29
				local var_718_6 = utf8.len(var_718_4)
				local var_718_7 = var_718_5 <= 0 and var_718_1 or var_718_1 * (var_718_6 / var_718_5)

				if var_718_7 > 0 and var_718_1 < var_718_7 then
					arg_715_1.talkMaxDuration = var_718_7

					if var_718_7 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_7 + var_718_0
					end
				end

				arg_715_1.text_.text = var_718_4
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_8 = math.max(var_718_1, arg_715_1.talkMaxDuration)

			if var_718_0 <= arg_715_1.time_ and arg_715_1.time_ < var_718_0 + var_718_8 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_0) / var_718_8

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_0 + var_718_8 and arg_715_1.time_ < var_718_0 + var_718_8 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play1105005179 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1105005179
		arg_719_1.duration_ = 7.97

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1105005180(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_722_1 = arg_719_1.actors_["115001ui_story"]
			local var_722_2 = 0

			if var_722_2 < arg_719_1.time_ and arg_719_1.time_ <= var_722_2 + arg_722_0 and not isNil(var_722_1) and arg_719_1.var_.characterEffect115001ui_story == nil then
				arg_719_1.var_.characterEffect115001ui_story = var_722_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_3 = 0.200000002980232

			if var_722_2 <= arg_719_1.time_ and arg_719_1.time_ < var_722_2 + var_722_3 and not isNil(var_722_1) then
				local var_722_4 = (arg_719_1.time_ - var_722_2) / var_722_3

				if arg_719_1.var_.characterEffect115001ui_story and not isNil(var_722_1) then
					arg_719_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= var_722_2 + var_722_3 and arg_719_1.time_ < var_722_2 + var_722_3 + arg_722_0 and not isNil(var_722_1) and arg_719_1.var_.characterEffect115001ui_story then
				arg_719_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_722_5 = arg_719_1.actors_["115001ui_story"].transform
			local var_722_6 = 0

			if var_722_6 < arg_719_1.time_ and arg_719_1.time_ <= var_722_6 + arg_722_0 then
				arg_719_1.var_.moveOldPos115001ui_story = var_722_5.localPosition
			end

			local var_722_7 = 0.001

			if var_722_6 <= arg_719_1.time_ and arg_719_1.time_ < var_722_6 + var_722_7 then
				local var_722_8 = (arg_719_1.time_ - var_722_6) / var_722_7
				local var_722_9 = Vector3.New(0, -1.033, -6.3)

				var_722_5.localPosition = Vector3.Lerp(arg_719_1.var_.moveOldPos115001ui_story, var_722_9, var_722_8)

				local var_722_10 = manager.ui.mainCamera.transform.position - var_722_5.position

				var_722_5.forward = Vector3.New(var_722_10.x, var_722_10.y, var_722_10.z)

				local var_722_11 = var_722_5.localEulerAngles

				var_722_11.z = 0
				var_722_11.x = 0
				var_722_5.localEulerAngles = var_722_11
			end

			if arg_719_1.time_ >= var_722_6 + var_722_7 and arg_719_1.time_ < var_722_6 + var_722_7 + arg_722_0 then
				var_722_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_722_12 = manager.ui.mainCamera.transform.position - var_722_5.position

				var_722_5.forward = Vector3.New(var_722_12.x, var_722_12.y, var_722_12.z)

				local var_722_13 = var_722_5.localEulerAngles

				var_722_13.z = 0
				var_722_13.x = 0
				var_722_5.localEulerAngles = var_722_13
			end

			local var_722_14 = 0
			local var_722_15 = 0.875

			if var_722_14 < arg_719_1.time_ and arg_719_1.time_ <= var_722_14 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_16 = arg_719_1:FormatText(StoryNameCfg[74].name)

				arg_719_1.leftNameTxt_.text = var_722_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_17 = arg_719_1:GetWordFromCfg(1105005179)
				local var_722_18 = arg_719_1:FormatText(var_722_17.content)

				arg_719_1.text_.text = var_722_18

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_19 = 35
				local var_722_20 = utf8.len(var_722_18)
				local var_722_21 = var_722_19 <= 0 and var_722_15 or var_722_15 * (var_722_20 / var_722_19)

				if var_722_21 > 0 and var_722_15 < var_722_21 then
					arg_719_1.talkMaxDuration = var_722_21

					if var_722_21 + var_722_14 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_21 + var_722_14
					end
				end

				arg_719_1.text_.text = var_722_18
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005179", "story_v_side_new_1105005.awb") ~= 0 then
					local var_722_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005179", "story_v_side_new_1105005.awb") / 1000

					if var_722_22 + var_722_14 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_22 + var_722_14
					end

					if var_722_17.prefab_name ~= "" and arg_719_1.actors_[var_722_17.prefab_name] ~= nil then
						local var_722_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_17.prefab_name].transform, "story_v_side_new_1105005", "1105005179", "story_v_side_new_1105005.awb")

						arg_719_1:RecordAudio("1105005179", var_722_23)
						arg_719_1:RecordAudio("1105005179", var_722_23)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005179", "story_v_side_new_1105005.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005179", "story_v_side_new_1105005.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_24 = math.max(var_722_15, arg_719_1.talkMaxDuration)

			if var_722_14 <= arg_719_1.time_ and arg_719_1.time_ < var_722_14 + var_722_24 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_14) / var_722_24

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_14 + var_722_24 and arg_719_1.time_ < var_722_14 + var_722_24 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_719_1:InitPlayNodeList()
	end,
	Play1105005180 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1105005180
		arg_723_1.duration_ = 5.53

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1105005181(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0
			local var_726_1 = 0.55

			if var_726_0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_2 = arg_723_1:FormatText(StoryNameCfg[74].name)

				arg_723_1.leftNameTxt_.text = var_726_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_3 = arg_723_1:GetWordFromCfg(1105005180)
				local var_726_4 = arg_723_1:FormatText(var_726_3.content)

				arg_723_1.text_.text = var_726_4

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_5 = 22
				local var_726_6 = utf8.len(var_726_4)
				local var_726_7 = var_726_5 <= 0 and var_726_1 or var_726_1 * (var_726_6 / var_726_5)

				if var_726_7 > 0 and var_726_1 < var_726_7 then
					arg_723_1.talkMaxDuration = var_726_7

					if var_726_7 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_7 + var_726_0
					end
				end

				arg_723_1.text_.text = var_726_4
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005180", "story_v_side_new_1105005.awb") ~= 0 then
					local var_726_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005180", "story_v_side_new_1105005.awb") / 1000

					if var_726_8 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_8 + var_726_0
					end

					if var_726_3.prefab_name ~= "" and arg_723_1.actors_[var_726_3.prefab_name] ~= nil then
						local var_726_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_3.prefab_name].transform, "story_v_side_new_1105005", "1105005180", "story_v_side_new_1105005.awb")

						arg_723_1:RecordAudio("1105005180", var_726_9)
						arg_723_1:RecordAudio("1105005180", var_726_9)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005180", "story_v_side_new_1105005.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005180", "story_v_side_new_1105005.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_10 = math.max(var_726_1, arg_723_1.talkMaxDuration)

			if var_726_0 <= arg_723_1.time_ and arg_723_1.time_ < var_726_0 + var_726_10 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_0) / var_726_10

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_0 + var_726_10 and arg_723_1.time_ < var_726_0 + var_726_10 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play1105005181 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 1105005181
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play1105005182(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = arg_727_1.actors_["115001ui_story"].transform
			local var_730_1 = 0

			if var_730_1 < arg_727_1.time_ and arg_727_1.time_ <= var_730_1 + arg_730_0 then
				arg_727_1.var_.moveOldPos115001ui_story = var_730_0.localPosition
			end

			local var_730_2 = 0.001

			if var_730_1 <= arg_727_1.time_ and arg_727_1.time_ < var_730_1 + var_730_2 then
				local var_730_3 = (arg_727_1.time_ - var_730_1) / var_730_2
				local var_730_4 = Vector3.New(0, 100, 0)

				var_730_0.localPosition = Vector3.Lerp(arg_727_1.var_.moveOldPos115001ui_story, var_730_4, var_730_3)

				local var_730_5 = manager.ui.mainCamera.transform.position - var_730_0.position

				var_730_0.forward = Vector3.New(var_730_5.x, var_730_5.y, var_730_5.z)

				local var_730_6 = var_730_0.localEulerAngles

				var_730_6.z = 0
				var_730_6.x = 0
				var_730_0.localEulerAngles = var_730_6
			end

			if arg_727_1.time_ >= var_730_1 + var_730_2 and arg_727_1.time_ < var_730_1 + var_730_2 + arg_730_0 then
				var_730_0.localPosition = Vector3.New(0, 100, 0)

				local var_730_7 = manager.ui.mainCamera.transform.position - var_730_0.position

				var_730_0.forward = Vector3.New(var_730_7.x, var_730_7.y, var_730_7.z)

				local var_730_8 = var_730_0.localEulerAngles

				var_730_8.z = 0
				var_730_8.x = 0
				var_730_0.localEulerAngles = var_730_8
			end

			local var_730_9 = 0
			local var_730_10 = 1.45

			if var_730_9 < arg_727_1.time_ and arg_727_1.time_ <= var_730_9 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, false)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_11 = arg_727_1:GetWordFromCfg(1105005181)
				local var_730_12 = arg_727_1:FormatText(var_730_11.content)

				arg_727_1.text_.text = var_730_12

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_13 = 58
				local var_730_14 = utf8.len(var_730_12)
				local var_730_15 = var_730_13 <= 0 and var_730_10 or var_730_10 * (var_730_14 / var_730_13)

				if var_730_15 > 0 and var_730_10 < var_730_15 then
					arg_727_1.talkMaxDuration = var_730_15

					if var_730_15 + var_730_9 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_15 + var_730_9
					end
				end

				arg_727_1.text_.text = var_730_12
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_16 = math.max(var_730_10, arg_727_1.talkMaxDuration)

			if var_730_9 <= arg_727_1.time_ and arg_727_1.time_ < var_730_9 + var_730_16 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_9) / var_730_16

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_9 + var_730_16 and arg_727_1.time_ < var_730_9 + var_730_16 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_727_1:InitPlayNodeList()
	end,
	Play1105005182 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 1105005182
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play1105005183(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0
			local var_734_1 = 0.775

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_2 = arg_731_1:FormatText(StoryNameCfg[7].name)

				arg_731_1.leftNameTxt_.text = var_734_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, true)
				arg_731_1.iconController_:SetSelectedState("hero")

				arg_731_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_731_1.callingController_:SetSelectedState("normal")

				arg_731_1.keyicon_.color = Color.New(1, 1, 1)
				arg_731_1.icon_.color = Color.New(1, 1, 1)

				local var_734_3 = arg_731_1:GetWordFromCfg(1105005182)
				local var_734_4 = arg_731_1:FormatText(var_734_3.content)

				arg_731_1.text_.text = var_734_4

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_5 = 31
				local var_734_6 = utf8.len(var_734_4)
				local var_734_7 = var_734_5 <= 0 and var_734_1 or var_734_1 * (var_734_6 / var_734_5)

				if var_734_7 > 0 and var_734_1 < var_734_7 then
					arg_731_1.talkMaxDuration = var_734_7

					if var_734_7 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_7 + var_734_0
					end
				end

				arg_731_1.text_.text = var_734_4
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_8 = math.max(var_734_1, arg_731_1.talkMaxDuration)

			if var_734_0 <= arg_731_1.time_ and arg_731_1.time_ < var_734_0 + var_734_8 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_0) / var_734_8

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_0 + var_734_8 and arg_731_1.time_ < var_734_0 + var_734_8 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play1105005183 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 1105005183
		arg_735_1.duration_ = 9

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play1105005184(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = 4

			if var_738_0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_0 + arg_738_0 then
				arg_735_1.allBtn_.enabled = false
			end

			local var_738_1 = 0.3

			if arg_735_1.time_ >= var_738_0 + var_738_1 and arg_735_1.time_ < var_738_0 + var_738_1 + arg_738_0 then
				arg_735_1.allBtn_.enabled = true
			end

			local var_738_2 = "ST11"

			if arg_735_1.bgs_[var_738_2] == nil then
				local var_738_3 = Object.Instantiate(arg_735_1.paintGo_)

				var_738_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_738_2)
				var_738_3.name = var_738_2
				var_738_3.transform.parent = arg_735_1.stage_.transform
				var_738_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_735_1.bgs_[var_738_2] = var_738_3
			end

			local var_738_4 = 2

			if var_738_4 < arg_735_1.time_ and arg_735_1.time_ <= var_738_4 + arg_738_0 then
				local var_738_5 = manager.ui.mainCamera.transform.localPosition
				local var_738_6 = Vector3.New(0, 0, 10) + Vector3.New(var_738_5.x, var_738_5.y, 0)
				local var_738_7 = arg_735_1.bgs_.ST11

				var_738_7.transform.localPosition = var_738_6
				var_738_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_738_8 = var_738_7:GetComponent("SpriteRenderer")

				if var_738_8 and var_738_8.sprite then
					local var_738_9 = (var_738_7.transform.localPosition - var_738_5).z
					local var_738_10 = manager.ui.mainCameraCom_
					local var_738_11 = 2 * var_738_9 * Mathf.Tan(var_738_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_738_12 = var_738_11 * var_738_10.aspect
					local var_738_13 = var_738_8.sprite.bounds.size.x
					local var_738_14 = var_738_8.sprite.bounds.size.y
					local var_738_15 = var_738_12 / var_738_13
					local var_738_16 = var_738_11 / var_738_14
					local var_738_17 = var_738_16 < var_738_15 and var_738_15 or var_738_16

					var_738_7.transform.localScale = Vector3.New(var_738_17, var_738_17, 0)
				end

				for iter_738_0, iter_738_1 in pairs(arg_735_1.bgs_) do
					if iter_738_0 ~= "ST11" then
						iter_738_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_738_18 = 0

			if var_738_18 < arg_735_1.time_ and arg_735_1.time_ <= var_738_18 + arg_738_0 then
				arg_735_1.mask_.enabled = true
				arg_735_1.mask_.raycastTarget = true

				arg_735_1:SetGaussion(false)
			end

			local var_738_19 = 2

			if var_738_18 <= arg_735_1.time_ and arg_735_1.time_ < var_738_18 + var_738_19 then
				local var_738_20 = (arg_735_1.time_ - var_738_18) / var_738_19
				local var_738_21 = Color.New(0, 0, 0)

				var_738_21.a = Mathf.Lerp(0, 1, var_738_20)
				arg_735_1.mask_.color = var_738_21
			end

			if arg_735_1.time_ >= var_738_18 + var_738_19 and arg_735_1.time_ < var_738_18 + var_738_19 + arg_738_0 then
				local var_738_22 = Color.New(0, 0, 0)

				var_738_22.a = 1
				arg_735_1.mask_.color = var_738_22
			end

			local var_738_23 = 2

			if var_738_23 < arg_735_1.time_ and arg_735_1.time_ <= var_738_23 + arg_738_0 then
				arg_735_1.mask_.enabled = true
				arg_735_1.mask_.raycastTarget = true

				arg_735_1:SetGaussion(false)
			end

			local var_738_24 = 2

			if var_738_23 <= arg_735_1.time_ and arg_735_1.time_ < var_738_23 + var_738_24 then
				local var_738_25 = (arg_735_1.time_ - var_738_23) / var_738_24
				local var_738_26 = Color.New(0, 0, 0)

				var_738_26.a = Mathf.Lerp(1, 0, var_738_25)
				arg_735_1.mask_.color = var_738_26
			end

			if arg_735_1.time_ >= var_738_23 + var_738_24 and arg_735_1.time_ < var_738_23 + var_738_24 + arg_738_0 then
				local var_738_27 = Color.New(0, 0, 0)
				local var_738_28 = 0

				arg_735_1.mask_.enabled = false
				var_738_27.a = var_738_28
				arg_735_1.mask_.color = var_738_27
			end

			if arg_735_1.frameCnt_ <= 1 then
				arg_735_1.dialog_:SetActive(false)
			end

			local var_738_29 = 4
			local var_738_30 = 0.725

			if var_738_29 < arg_735_1.time_ and arg_735_1.time_ <= var_738_29 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0

				arg_735_1.dialog_:SetActive(true)

				arg_735_1.dialogCg_.alpha = 0

				local var_738_31 = LeanTween.value(arg_735_1.dialog_, 0, 1, 0.3)

				var_738_31:setOnUpdate(LuaHelper.FloatAction(function(arg_739_0)
					arg_735_1.dialogCg_.alpha = arg_739_0
				end))
				var_738_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_735_1.dialog_)
					var_738_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_735_1.duration_ = arg_735_1.duration_ + 0.3

				SetActive(arg_735_1.leftNameGo_, false)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_32 = arg_735_1:GetWordFromCfg(1105005183)
				local var_738_33 = arg_735_1:FormatText(var_738_32.content)

				arg_735_1.text_.text = var_738_33

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_34 = 29
				local var_738_35 = utf8.len(var_738_33)
				local var_738_36 = var_738_34 <= 0 and var_738_30 or var_738_30 * (var_738_35 / var_738_34)

				if var_738_36 > 0 and var_738_30 < var_738_36 then
					arg_735_1.talkMaxDuration = var_738_36
					var_738_29 = var_738_29 + 0.3

					if var_738_36 + var_738_29 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_36 + var_738_29
					end
				end

				arg_735_1.text_.text = var_738_33
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_37 = var_738_29 + 0.3
			local var_738_38 = math.max(var_738_30, arg_735_1.talkMaxDuration)

			if var_738_37 <= arg_735_1.time_ and arg_735_1.time_ < var_738_37 + var_738_38 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_37) / var_738_38

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_37 + var_738_38 and arg_735_1.time_ < var_738_37 + var_738_38 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play1105005184 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1105005184
		arg_741_1.duration_ = 6.93

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1105005185(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = arg_741_1.actors_["115001ui_story"].transform
			local var_744_1 = 0

			if var_744_1 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 then
				arg_741_1.var_.moveOldPos115001ui_story = var_744_0.localPosition
			end

			local var_744_2 = 0.001

			if var_744_1 <= arg_741_1.time_ and arg_741_1.time_ < var_744_1 + var_744_2 then
				local var_744_3 = (arg_741_1.time_ - var_744_1) / var_744_2
				local var_744_4 = Vector3.New(0, -1.033, -6.3)

				var_744_0.localPosition = Vector3.Lerp(arg_741_1.var_.moveOldPos115001ui_story, var_744_4, var_744_3)

				local var_744_5 = manager.ui.mainCamera.transform.position - var_744_0.position

				var_744_0.forward = Vector3.New(var_744_5.x, var_744_5.y, var_744_5.z)

				local var_744_6 = var_744_0.localEulerAngles

				var_744_6.z = 0
				var_744_6.x = 0
				var_744_0.localEulerAngles = var_744_6
			end

			if arg_741_1.time_ >= var_744_1 + var_744_2 and arg_741_1.time_ < var_744_1 + var_744_2 + arg_744_0 then
				var_744_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_744_7 = manager.ui.mainCamera.transform.position - var_744_0.position

				var_744_0.forward = Vector3.New(var_744_7.x, var_744_7.y, var_744_7.z)

				local var_744_8 = var_744_0.localEulerAngles

				var_744_8.z = 0
				var_744_8.x = 0
				var_744_0.localEulerAngles = var_744_8
			end

			local var_744_9 = arg_741_1.actors_["115001ui_story"]
			local var_744_10 = 0

			if var_744_10 < arg_741_1.time_ and arg_741_1.time_ <= var_744_10 + arg_744_0 and not isNil(var_744_9) and arg_741_1.var_.characterEffect115001ui_story == nil then
				arg_741_1.var_.characterEffect115001ui_story = var_744_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_11 = 0.200000002980232

			if var_744_10 <= arg_741_1.time_ and arg_741_1.time_ < var_744_10 + var_744_11 and not isNil(var_744_9) then
				local var_744_12 = (arg_741_1.time_ - var_744_10) / var_744_11

				if arg_741_1.var_.characterEffect115001ui_story and not isNil(var_744_9) then
					arg_741_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_741_1.time_ >= var_744_10 + var_744_11 and arg_741_1.time_ < var_744_10 + var_744_11 + arg_744_0 and not isNil(var_744_9) and arg_741_1.var_.characterEffect115001ui_story then
				arg_741_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_744_13 = 0

			if var_744_13 < arg_741_1.time_ and arg_741_1.time_ <= var_744_13 + arg_744_0 then
				arg_741_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_744_14 = 0

			if var_744_14 < arg_741_1.time_ and arg_741_1.time_ <= var_744_14 + arg_744_0 then
				arg_741_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_1")
			end

			local var_744_15 = 0
			local var_744_16 = 0.8

			if var_744_15 < arg_741_1.time_ and arg_741_1.time_ <= var_744_15 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_17 = arg_741_1:FormatText(StoryNameCfg[74].name)

				arg_741_1.leftNameTxt_.text = var_744_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_18 = arg_741_1:GetWordFromCfg(1105005184)
				local var_744_19 = arg_741_1:FormatText(var_744_18.content)

				arg_741_1.text_.text = var_744_19

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_20 = 32
				local var_744_21 = utf8.len(var_744_19)
				local var_744_22 = var_744_20 <= 0 and var_744_16 or var_744_16 * (var_744_21 / var_744_20)

				if var_744_22 > 0 and var_744_16 < var_744_22 then
					arg_741_1.talkMaxDuration = var_744_22

					if var_744_22 + var_744_15 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_22 + var_744_15
					end
				end

				arg_741_1.text_.text = var_744_19
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005184", "story_v_side_new_1105005.awb") ~= 0 then
					local var_744_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005184", "story_v_side_new_1105005.awb") / 1000

					if var_744_23 + var_744_15 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_23 + var_744_15
					end

					if var_744_18.prefab_name ~= "" and arg_741_1.actors_[var_744_18.prefab_name] ~= nil then
						local var_744_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_18.prefab_name].transform, "story_v_side_new_1105005", "1105005184", "story_v_side_new_1105005.awb")

						arg_741_1:RecordAudio("1105005184", var_744_24)
						arg_741_1:RecordAudio("1105005184", var_744_24)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005184", "story_v_side_new_1105005.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005184", "story_v_side_new_1105005.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_25 = math.max(var_744_16, arg_741_1.talkMaxDuration)

			if var_744_15 <= arg_741_1.time_ and arg_741_1.time_ < var_744_15 + var_744_25 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_15) / var_744_25

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_15 + var_744_25 and arg_741_1.time_ < var_744_15 + var_744_25 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_741_1:InitPlayNodeList()
	end,
	Play1105005185 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1105005185
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1105005186(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = arg_745_1.actors_["115001ui_story"]
			local var_748_1 = 0

			if var_748_1 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 and not isNil(var_748_0) and arg_745_1.var_.characterEffect115001ui_story == nil then
				arg_745_1.var_.characterEffect115001ui_story = var_748_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_748_2 = 0.2

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_2 and not isNil(var_748_0) then
				local var_748_3 = (arg_745_1.time_ - var_748_1) / var_748_2

				if arg_745_1.var_.characterEffect115001ui_story and not isNil(var_748_0) then
					local var_748_4 = Mathf.Lerp(0, 0.5, var_748_3)

					arg_745_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_745_1.var_.characterEffect115001ui_story.fillRatio = var_748_4
				end
			end

			if arg_745_1.time_ >= var_748_1 + var_748_2 and arg_745_1.time_ < var_748_1 + var_748_2 + arg_748_0 and not isNil(var_748_0) and arg_745_1.var_.characterEffect115001ui_story then
				local var_748_5 = 0.5

				arg_745_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_745_1.var_.characterEffect115001ui_story.fillRatio = var_748_5
			end

			local var_748_6 = 0
			local var_748_7 = 0.2

			if var_748_6 < arg_745_1.time_ and arg_745_1.time_ <= var_748_6 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				local var_748_8 = arg_745_1:FormatText(StoryNameCfg[7].name)

				arg_745_1.leftNameTxt_.text = var_748_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, true)
				arg_745_1.iconController_:SetSelectedState("hero")

				arg_745_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_745_1.callingController_:SetSelectedState("normal")

				arg_745_1.keyicon_.color = Color.New(1, 1, 1)
				arg_745_1.icon_.color = Color.New(1, 1, 1)

				local var_748_9 = arg_745_1:GetWordFromCfg(1105005185)
				local var_748_10 = arg_745_1:FormatText(var_748_9.content)

				arg_745_1.text_.text = var_748_10

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_11 = 8
				local var_748_12 = utf8.len(var_748_10)
				local var_748_13 = var_748_11 <= 0 and var_748_7 or var_748_7 * (var_748_12 / var_748_11)

				if var_748_13 > 0 and var_748_7 < var_748_13 then
					arg_745_1.talkMaxDuration = var_748_13

					if var_748_13 + var_748_6 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_13 + var_748_6
					end
				end

				arg_745_1.text_.text = var_748_10
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_14 = math.max(var_748_7, arg_745_1.talkMaxDuration)

			if var_748_6 <= arg_745_1.time_ and arg_745_1.time_ < var_748_6 + var_748_14 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_6) / var_748_14

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_6 + var_748_14 and arg_745_1.time_ < var_748_6 + var_748_14 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play1105005186 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1105005186
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1105005187(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0
			local var_752_1 = 1.2

			if var_752_0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_0 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, false)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_2 = arg_749_1:GetWordFromCfg(1105005186)
				local var_752_3 = arg_749_1:FormatText(var_752_2.content)

				arg_749_1.text_.text = var_752_3

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_4 = 48
				local var_752_5 = utf8.len(var_752_3)
				local var_752_6 = var_752_4 <= 0 and var_752_1 or var_752_1 * (var_752_5 / var_752_4)

				if var_752_6 > 0 and var_752_1 < var_752_6 then
					arg_749_1.talkMaxDuration = var_752_6

					if var_752_6 + var_752_0 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_6 + var_752_0
					end
				end

				arg_749_1.text_.text = var_752_3
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_7 = math.max(var_752_1, arg_749_1.talkMaxDuration)

			if var_752_0 <= arg_749_1.time_ and arg_749_1.time_ < var_752_0 + var_752_7 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_0) / var_752_7

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_0 + var_752_7 and arg_749_1.time_ < var_752_0 + var_752_7 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play1105005187 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1105005187
		arg_753_1.duration_ = 11.2

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1105005188(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = arg_753_1.actors_["115001ui_story"]
			local var_756_1 = 0

			if var_756_1 < arg_753_1.time_ and arg_753_1.time_ <= var_756_1 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect115001ui_story == nil then
				arg_753_1.var_.characterEffect115001ui_story = var_756_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_2 = 0.200000002980232

			if var_756_1 <= arg_753_1.time_ and arg_753_1.time_ < var_756_1 + var_756_2 and not isNil(var_756_0) then
				local var_756_3 = (arg_753_1.time_ - var_756_1) / var_756_2

				if arg_753_1.var_.characterEffect115001ui_story and not isNil(var_756_0) then
					arg_753_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_753_1.time_ >= var_756_1 + var_756_2 and arg_753_1.time_ < var_756_1 + var_756_2 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect115001ui_story then
				arg_753_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_756_4 = 0
			local var_756_5 = 1.125

			if var_756_4 < arg_753_1.time_ and arg_753_1.time_ <= var_756_4 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				local var_756_6 = arg_753_1:FormatText(StoryNameCfg[74].name)

				arg_753_1.leftNameTxt_.text = var_756_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, false)
				arg_753_1.callingController_:SetSelectedState("normal")

				local var_756_7 = arg_753_1:GetWordFromCfg(1105005187)
				local var_756_8 = arg_753_1:FormatText(var_756_7.content)

				arg_753_1.text_.text = var_756_8

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_9 = 45
				local var_756_10 = utf8.len(var_756_8)
				local var_756_11 = var_756_9 <= 0 and var_756_5 or var_756_5 * (var_756_10 / var_756_9)

				if var_756_11 > 0 and var_756_5 < var_756_11 then
					arg_753_1.talkMaxDuration = var_756_11

					if var_756_11 + var_756_4 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_11 + var_756_4
					end
				end

				arg_753_1.text_.text = var_756_8
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005187", "story_v_side_new_1105005.awb") ~= 0 then
					local var_756_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005187", "story_v_side_new_1105005.awb") / 1000

					if var_756_12 + var_756_4 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_12 + var_756_4
					end

					if var_756_7.prefab_name ~= "" and arg_753_1.actors_[var_756_7.prefab_name] ~= nil then
						local var_756_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_753_1.actors_[var_756_7.prefab_name].transform, "story_v_side_new_1105005", "1105005187", "story_v_side_new_1105005.awb")

						arg_753_1:RecordAudio("1105005187", var_756_13)
						arg_753_1:RecordAudio("1105005187", var_756_13)
					else
						arg_753_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005187", "story_v_side_new_1105005.awb")
					end

					arg_753_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005187", "story_v_side_new_1105005.awb")
				end

				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_14 = math.max(var_756_5, arg_753_1.talkMaxDuration)

			if var_756_4 <= arg_753_1.time_ and arg_753_1.time_ < var_756_4 + var_756_14 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_4) / var_756_14

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_4 + var_756_14 and arg_753_1.time_ < var_756_4 + var_756_14 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1105005188 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1105005188
		arg_757_1.duration_ = 3.13

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1105005189(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 0
			local var_760_1 = 0.275

			if var_760_0 < arg_757_1.time_ and arg_757_1.time_ <= var_760_0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				local var_760_2 = arg_757_1:FormatText(StoryNameCfg[74].name)

				arg_757_1.leftNameTxt_.text = var_760_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_3 = arg_757_1:GetWordFromCfg(1105005188)
				local var_760_4 = arg_757_1:FormatText(var_760_3.content)

				arg_757_1.text_.text = var_760_4

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_5 = 11
				local var_760_6 = utf8.len(var_760_4)
				local var_760_7 = var_760_5 <= 0 and var_760_1 or var_760_1 * (var_760_6 / var_760_5)

				if var_760_7 > 0 and var_760_1 < var_760_7 then
					arg_757_1.talkMaxDuration = var_760_7

					if var_760_7 + var_760_0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_7 + var_760_0
					end
				end

				arg_757_1.text_.text = var_760_4
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005188", "story_v_side_new_1105005.awb") ~= 0 then
					local var_760_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005188", "story_v_side_new_1105005.awb") / 1000

					if var_760_8 + var_760_0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_8 + var_760_0
					end

					if var_760_3.prefab_name ~= "" and arg_757_1.actors_[var_760_3.prefab_name] ~= nil then
						local var_760_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_757_1.actors_[var_760_3.prefab_name].transform, "story_v_side_new_1105005", "1105005188", "story_v_side_new_1105005.awb")

						arg_757_1:RecordAudio("1105005188", var_760_9)
						arg_757_1:RecordAudio("1105005188", var_760_9)
					else
						arg_757_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005188", "story_v_side_new_1105005.awb")
					end

					arg_757_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005188", "story_v_side_new_1105005.awb")
				end

				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_10 = math.max(var_760_1, arg_757_1.talkMaxDuration)

			if var_760_0 <= arg_757_1.time_ and arg_757_1.time_ < var_760_0 + var_760_10 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_0) / var_760_10

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_0 + var_760_10 and arg_757_1.time_ < var_760_0 + var_760_10 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play1105005189 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1105005189
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1105005190(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = arg_761_1.actors_["115001ui_story"]
			local var_764_1 = 0

			if var_764_1 < arg_761_1.time_ and arg_761_1.time_ <= var_764_1 + arg_764_0 and not isNil(var_764_0) and arg_761_1.var_.characterEffect115001ui_story == nil then
				arg_761_1.var_.characterEffect115001ui_story = var_764_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_764_2 = 0.2

			if var_764_1 <= arg_761_1.time_ and arg_761_1.time_ < var_764_1 + var_764_2 and not isNil(var_764_0) then
				local var_764_3 = (arg_761_1.time_ - var_764_1) / var_764_2

				if arg_761_1.var_.characterEffect115001ui_story and not isNil(var_764_0) then
					local var_764_4 = Mathf.Lerp(0, 0.5, var_764_3)

					arg_761_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_761_1.var_.characterEffect115001ui_story.fillRatio = var_764_4
				end
			end

			if arg_761_1.time_ >= var_764_1 + var_764_2 and arg_761_1.time_ < var_764_1 + var_764_2 + arg_764_0 and not isNil(var_764_0) and arg_761_1.var_.characterEffect115001ui_story then
				local var_764_5 = 0.5

				arg_761_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_761_1.var_.characterEffect115001ui_story.fillRatio = var_764_5
			end

			local var_764_6 = 0
			local var_764_7 = 0.45

			if var_764_6 < arg_761_1.time_ and arg_761_1.time_ <= var_764_6 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				local var_764_8 = arg_761_1:FormatText(StoryNameCfg[7].name)

				arg_761_1.leftNameTxt_.text = var_764_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_9 = arg_761_1:GetWordFromCfg(1105005189)
				local var_764_10 = arg_761_1:FormatText(var_764_9.content)

				arg_761_1.text_.text = var_764_10

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_11 = 18
				local var_764_12 = utf8.len(var_764_10)
				local var_764_13 = var_764_11 <= 0 and var_764_7 or var_764_7 * (var_764_12 / var_764_11)

				if var_764_13 > 0 and var_764_7 < var_764_13 then
					arg_761_1.talkMaxDuration = var_764_13

					if var_764_13 + var_764_6 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_13 + var_764_6
					end
				end

				arg_761_1.text_.text = var_764_10
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_14 = math.max(var_764_7, arg_761_1.talkMaxDuration)

			if var_764_6 <= arg_761_1.time_ and arg_761_1.time_ < var_764_6 + var_764_14 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_6) / var_764_14

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_6 + var_764_14 and arg_761_1.time_ < var_764_6 + var_764_14 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1105005190 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1105005190
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1105005191(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = 0
			local var_768_1 = 0.725

			if var_768_0 < arg_765_1.time_ and arg_765_1.time_ <= var_768_0 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, false)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_765_1.iconTrs_.gameObject, false)
				arg_765_1.callingController_:SetSelectedState("normal")

				local var_768_2 = arg_765_1:GetWordFromCfg(1105005190)
				local var_768_3 = arg_765_1:FormatText(var_768_2.content)

				arg_765_1.text_.text = var_768_3

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_4 = 29
				local var_768_5 = utf8.len(var_768_3)
				local var_768_6 = var_768_4 <= 0 and var_768_1 or var_768_1 * (var_768_5 / var_768_4)

				if var_768_6 > 0 and var_768_1 < var_768_6 then
					arg_765_1.talkMaxDuration = var_768_6

					if var_768_6 + var_768_0 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_6 + var_768_0
					end
				end

				arg_765_1.text_.text = var_768_3
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_7 = math.max(var_768_1, arg_765_1.talkMaxDuration)

			if var_768_0 <= arg_765_1.time_ and arg_765_1.time_ < var_768_0 + var_768_7 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_0) / var_768_7

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_0 + var_768_7 and arg_765_1.time_ < var_768_0 + var_768_7 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1105005191 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1105005191
		arg_769_1.duration_ = 12.77

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1105005192(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = arg_769_1.actors_["115001ui_story"]
			local var_772_1 = 0

			if var_772_1 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 and not isNil(var_772_0) and arg_769_1.var_.characterEffect115001ui_story == nil then
				arg_769_1.var_.characterEffect115001ui_story = var_772_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_2 = 0.200000002980232

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_2 and not isNil(var_772_0) then
				local var_772_3 = (arg_769_1.time_ - var_772_1) / var_772_2

				if arg_769_1.var_.characterEffect115001ui_story and not isNil(var_772_0) then
					arg_769_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_769_1.time_ >= var_772_1 + var_772_2 and arg_769_1.time_ < var_772_1 + var_772_2 + arg_772_0 and not isNil(var_772_0) and arg_769_1.var_.characterEffect115001ui_story then
				arg_769_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_772_4 = 0

			if var_772_4 < arg_769_1.time_ and arg_769_1.time_ <= var_772_4 + arg_772_0 then
				arg_769_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action2_2")
			end

			local var_772_5 = arg_769_1.actors_["115001ui_story"].transform
			local var_772_6 = 0

			if var_772_6 < arg_769_1.time_ and arg_769_1.time_ <= var_772_6 + arg_772_0 then
				arg_769_1.var_.moveOldPos115001ui_story = var_772_5.localPosition
			end

			local var_772_7 = 0.001

			if var_772_6 <= arg_769_1.time_ and arg_769_1.time_ < var_772_6 + var_772_7 then
				local var_772_8 = (arg_769_1.time_ - var_772_6) / var_772_7
				local var_772_9 = Vector3.New(0, -1.033, -6.3)

				var_772_5.localPosition = Vector3.Lerp(arg_769_1.var_.moveOldPos115001ui_story, var_772_9, var_772_8)

				local var_772_10 = manager.ui.mainCamera.transform.position - var_772_5.position

				var_772_5.forward = Vector3.New(var_772_10.x, var_772_10.y, var_772_10.z)

				local var_772_11 = var_772_5.localEulerAngles

				var_772_11.z = 0
				var_772_11.x = 0
				var_772_5.localEulerAngles = var_772_11
			end

			if arg_769_1.time_ >= var_772_6 + var_772_7 and arg_769_1.time_ < var_772_6 + var_772_7 + arg_772_0 then
				var_772_5.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_772_12 = manager.ui.mainCamera.transform.position - var_772_5.position

				var_772_5.forward = Vector3.New(var_772_12.x, var_772_12.y, var_772_12.z)

				local var_772_13 = var_772_5.localEulerAngles

				var_772_13.z = 0
				var_772_13.x = 0
				var_772_5.localEulerAngles = var_772_13
			end

			local var_772_14 = 0
			local var_772_15 = 1.1

			if var_772_14 < arg_769_1.time_ and arg_769_1.time_ <= var_772_14 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				local var_772_16 = arg_769_1:FormatText(StoryNameCfg[74].name)

				arg_769_1.leftNameTxt_.text = var_772_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_17 = arg_769_1:GetWordFromCfg(1105005191)
				local var_772_18 = arg_769_1:FormatText(var_772_17.content)

				arg_769_1.text_.text = var_772_18

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_19 = 44
				local var_772_20 = utf8.len(var_772_18)
				local var_772_21 = var_772_19 <= 0 and var_772_15 or var_772_15 * (var_772_20 / var_772_19)

				if var_772_21 > 0 and var_772_15 < var_772_21 then
					arg_769_1.talkMaxDuration = var_772_21

					if var_772_21 + var_772_14 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_21 + var_772_14
					end
				end

				arg_769_1.text_.text = var_772_18
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005191", "story_v_side_new_1105005.awb") ~= 0 then
					local var_772_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005191", "story_v_side_new_1105005.awb") / 1000

					if var_772_22 + var_772_14 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_22 + var_772_14
					end

					if var_772_17.prefab_name ~= "" and arg_769_1.actors_[var_772_17.prefab_name] ~= nil then
						local var_772_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_769_1.actors_[var_772_17.prefab_name].transform, "story_v_side_new_1105005", "1105005191", "story_v_side_new_1105005.awb")

						arg_769_1:RecordAudio("1105005191", var_772_23)
						arg_769_1:RecordAudio("1105005191", var_772_23)
					else
						arg_769_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005191", "story_v_side_new_1105005.awb")
					end

					arg_769_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005191", "story_v_side_new_1105005.awb")
				end

				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_24 = math.max(var_772_15, arg_769_1.talkMaxDuration)

			if var_772_14 <= arg_769_1.time_ and arg_769_1.time_ < var_772_14 + var_772_24 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_14) / var_772_24

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_14 + var_772_24 and arg_769_1.time_ < var_772_14 + var_772_24 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_769_1:InitPlayNodeList()
	end,
	Play1105005192 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1105005192
		arg_773_1.duration_ = 10.13

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1105005193(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = 0
			local var_776_1 = 1.15

			if var_776_0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_0 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				local var_776_2 = arg_773_1:FormatText(StoryNameCfg[74].name)

				arg_773_1.leftNameTxt_.text = var_776_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_3 = arg_773_1:GetWordFromCfg(1105005192)
				local var_776_4 = arg_773_1:FormatText(var_776_3.content)

				arg_773_1.text_.text = var_776_4

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_5 = 46
				local var_776_6 = utf8.len(var_776_4)
				local var_776_7 = var_776_5 <= 0 and var_776_1 or var_776_1 * (var_776_6 / var_776_5)

				if var_776_7 > 0 and var_776_1 < var_776_7 then
					arg_773_1.talkMaxDuration = var_776_7

					if var_776_7 + var_776_0 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_7 + var_776_0
					end
				end

				arg_773_1.text_.text = var_776_4
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005192", "story_v_side_new_1105005.awb") ~= 0 then
					local var_776_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005192", "story_v_side_new_1105005.awb") / 1000

					if var_776_8 + var_776_0 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_8 + var_776_0
					end

					if var_776_3.prefab_name ~= "" and arg_773_1.actors_[var_776_3.prefab_name] ~= nil then
						local var_776_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_3.prefab_name].transform, "story_v_side_new_1105005", "1105005192", "story_v_side_new_1105005.awb")

						arg_773_1:RecordAudio("1105005192", var_776_9)
						arg_773_1:RecordAudio("1105005192", var_776_9)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005192", "story_v_side_new_1105005.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005192", "story_v_side_new_1105005.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_10 = math.max(var_776_1, arg_773_1.talkMaxDuration)

			if var_776_0 <= arg_773_1.time_ and arg_773_1.time_ < var_776_0 + var_776_10 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_0) / var_776_10

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_0 + var_776_10 and arg_773_1.time_ < var_776_0 + var_776_10 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play1105005193 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1105005193
		arg_777_1.duration_ = 11.6

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1105005194(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0
			local var_780_1 = 1.225

			if var_780_0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				local var_780_2 = arg_777_1:FormatText(StoryNameCfg[74].name)

				arg_777_1.leftNameTxt_.text = var_780_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, false)
				arg_777_1.callingController_:SetSelectedState("normal")

				local var_780_3 = arg_777_1:GetWordFromCfg(1105005193)
				local var_780_4 = arg_777_1:FormatText(var_780_3.content)

				arg_777_1.text_.text = var_780_4

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_5 = 49
				local var_780_6 = utf8.len(var_780_4)
				local var_780_7 = var_780_5 <= 0 and var_780_1 or var_780_1 * (var_780_6 / var_780_5)

				if var_780_7 > 0 and var_780_1 < var_780_7 then
					arg_777_1.talkMaxDuration = var_780_7

					if var_780_7 + var_780_0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_7 + var_780_0
					end
				end

				arg_777_1.text_.text = var_780_4
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005193", "story_v_side_new_1105005.awb") ~= 0 then
					local var_780_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005193", "story_v_side_new_1105005.awb") / 1000

					if var_780_8 + var_780_0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_8 + var_780_0
					end

					if var_780_3.prefab_name ~= "" and arg_777_1.actors_[var_780_3.prefab_name] ~= nil then
						local var_780_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_777_1.actors_[var_780_3.prefab_name].transform, "story_v_side_new_1105005", "1105005193", "story_v_side_new_1105005.awb")

						arg_777_1:RecordAudio("1105005193", var_780_9)
						arg_777_1:RecordAudio("1105005193", var_780_9)
					else
						arg_777_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005193", "story_v_side_new_1105005.awb")
					end

					arg_777_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005193", "story_v_side_new_1105005.awb")
				end

				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_10 = math.max(var_780_1, arg_777_1.talkMaxDuration)

			if var_780_0 <= arg_777_1.time_ and arg_777_1.time_ < var_780_0 + var_780_10 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_0) / var_780_10

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_0 + var_780_10 and arg_777_1.time_ < var_780_0 + var_780_10 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1105005194 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1105005194
		arg_781_1.duration_ = 9.07

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1105005195(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0
			local var_784_1 = 0.875

			if var_784_0 < arg_781_1.time_ and arg_781_1.time_ <= var_784_0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				local var_784_2 = arg_781_1:FormatText(StoryNameCfg[74].name)

				arg_781_1.leftNameTxt_.text = var_784_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, false)
				arg_781_1.callingController_:SetSelectedState("normal")

				local var_784_3 = arg_781_1:GetWordFromCfg(1105005194)
				local var_784_4 = arg_781_1:FormatText(var_784_3.content)

				arg_781_1.text_.text = var_784_4

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_5 = 35
				local var_784_6 = utf8.len(var_784_4)
				local var_784_7 = var_784_5 <= 0 and var_784_1 or var_784_1 * (var_784_6 / var_784_5)

				if var_784_7 > 0 and var_784_1 < var_784_7 then
					arg_781_1.talkMaxDuration = var_784_7

					if var_784_7 + var_784_0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_7 + var_784_0
					end
				end

				arg_781_1.text_.text = var_784_4
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005194", "story_v_side_new_1105005.awb") ~= 0 then
					local var_784_8 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005194", "story_v_side_new_1105005.awb") / 1000

					if var_784_8 + var_784_0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_8 + var_784_0
					end

					if var_784_3.prefab_name ~= "" and arg_781_1.actors_[var_784_3.prefab_name] ~= nil then
						local var_784_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_781_1.actors_[var_784_3.prefab_name].transform, "story_v_side_new_1105005", "1105005194", "story_v_side_new_1105005.awb")

						arg_781_1:RecordAudio("1105005194", var_784_9)
						arg_781_1:RecordAudio("1105005194", var_784_9)
					else
						arg_781_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005194", "story_v_side_new_1105005.awb")
					end

					arg_781_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005194", "story_v_side_new_1105005.awb")
				end

				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_10 = math.max(var_784_1, arg_781_1.talkMaxDuration)

			if var_784_0 <= arg_781_1.time_ and arg_781_1.time_ < var_784_0 + var_784_10 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_0) / var_784_10

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_0 + var_784_10 and arg_781_1.time_ < var_784_0 + var_784_10 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play1105005195 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1105005195
		arg_785_1.duration_ = 5

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1105005196(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = arg_785_1.actors_["115001ui_story"]
			local var_788_1 = 0

			if var_788_1 < arg_785_1.time_ and arg_785_1.time_ <= var_788_1 + arg_788_0 and not isNil(var_788_0) and arg_785_1.var_.characterEffect115001ui_story == nil then
				arg_785_1.var_.characterEffect115001ui_story = var_788_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_2 = 0.200000002980232

			if var_788_1 <= arg_785_1.time_ and arg_785_1.time_ < var_788_1 + var_788_2 and not isNil(var_788_0) then
				local var_788_3 = (arg_785_1.time_ - var_788_1) / var_788_2

				if arg_785_1.var_.characterEffect115001ui_story and not isNil(var_788_0) then
					local var_788_4 = Mathf.Lerp(0, 0.5, var_788_3)

					arg_785_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_785_1.var_.characterEffect115001ui_story.fillRatio = var_788_4
				end
			end

			if arg_785_1.time_ >= var_788_1 + var_788_2 and arg_785_1.time_ < var_788_1 + var_788_2 + arg_788_0 and not isNil(var_788_0) and arg_785_1.var_.characterEffect115001ui_story then
				local var_788_5 = 0.5

				arg_785_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_785_1.var_.characterEffect115001ui_story.fillRatio = var_788_5
			end

			local var_788_6 = 0
			local var_788_7 = 0.2

			if var_788_6 < arg_785_1.time_ and arg_785_1.time_ <= var_788_6 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				local var_788_8 = arg_785_1:FormatText(StoryNameCfg[7].name)

				arg_785_1.leftNameTxt_.text = var_788_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, true)
				arg_785_1.iconController_:SetSelectedState("hero")

				arg_785_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_785_1.callingController_:SetSelectedState("normal")

				arg_785_1.keyicon_.color = Color.New(1, 1, 1)
				arg_785_1.icon_.color = Color.New(1, 1, 1)

				local var_788_9 = arg_785_1:GetWordFromCfg(1105005195)
				local var_788_10 = arg_785_1:FormatText(var_788_9.content)

				arg_785_1.text_.text = var_788_10

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_11 = 8
				local var_788_12 = utf8.len(var_788_10)
				local var_788_13 = var_788_11 <= 0 and var_788_7 or var_788_7 * (var_788_12 / var_788_11)

				if var_788_13 > 0 and var_788_7 < var_788_13 then
					arg_785_1.talkMaxDuration = var_788_13

					if var_788_13 + var_788_6 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_13 + var_788_6
					end
				end

				arg_785_1.text_.text = var_788_10
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_14 = math.max(var_788_7, arg_785_1.talkMaxDuration)

			if var_788_6 <= arg_785_1.time_ and arg_785_1.time_ < var_788_6 + var_788_14 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_6) / var_788_14

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_6 + var_788_14 and arg_785_1.time_ < var_788_6 + var_788_14 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1105005196 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1105005196
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1105005197(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			local var_792_0 = 0
			local var_792_1 = 0.975

			if var_792_0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_0 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				local var_792_2 = arg_789_1:FormatText(StoryNameCfg[7].name)

				arg_789_1.leftNameTxt_.text = var_792_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, true)
				arg_789_1.iconController_:SetSelectedState("hero")

				arg_789_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_789_1.callingController_:SetSelectedState("normal")

				arg_789_1.keyicon_.color = Color.New(1, 1, 1)
				arg_789_1.icon_.color = Color.New(1, 1, 1)

				local var_792_3 = arg_789_1:GetWordFromCfg(1105005196)
				local var_792_4 = arg_789_1:FormatText(var_792_3.content)

				arg_789_1.text_.text = var_792_4

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_5 = 39
				local var_792_6 = utf8.len(var_792_4)
				local var_792_7 = var_792_5 <= 0 and var_792_1 or var_792_1 * (var_792_6 / var_792_5)

				if var_792_7 > 0 and var_792_1 < var_792_7 then
					arg_789_1.talkMaxDuration = var_792_7

					if var_792_7 + var_792_0 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_7 + var_792_0
					end
				end

				arg_789_1.text_.text = var_792_4
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_8 = math.max(var_792_1, arg_789_1.talkMaxDuration)

			if var_792_0 <= arg_789_1.time_ and arg_789_1.time_ < var_792_0 + var_792_8 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_0) / var_792_8

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_0 + var_792_8 and arg_789_1.time_ < var_792_0 + var_792_8 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play1105005197 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1105005197
		arg_793_1.duration_ = 5.03

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play1105005198(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			local var_796_0 = arg_793_1.actors_["115001ui_story"]
			local var_796_1 = 0

			if var_796_1 < arg_793_1.time_ and arg_793_1.time_ <= var_796_1 + arg_796_0 and not isNil(var_796_0) and arg_793_1.var_.characterEffect115001ui_story == nil then
				arg_793_1.var_.characterEffect115001ui_story = var_796_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_2 = 0.200000002980232

			if var_796_1 <= arg_793_1.time_ and arg_793_1.time_ < var_796_1 + var_796_2 and not isNil(var_796_0) then
				local var_796_3 = (arg_793_1.time_ - var_796_1) / var_796_2

				if arg_793_1.var_.characterEffect115001ui_story and not isNil(var_796_0) then
					arg_793_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_793_1.time_ >= var_796_1 + var_796_2 and arg_793_1.time_ < var_796_1 + var_796_2 + arg_796_0 and not isNil(var_796_0) and arg_793_1.var_.characterEffect115001ui_story then
				arg_793_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_796_4 = 0

			if var_796_4 < arg_793_1.time_ and arg_793_1.time_ <= var_796_4 + arg_796_0 then
				arg_793_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_796_5 = 0
			local var_796_6 = 0.35

			if var_796_5 < arg_793_1.time_ and arg_793_1.time_ <= var_796_5 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				local var_796_7 = arg_793_1:FormatText(StoryNameCfg[74].name)

				arg_793_1.leftNameTxt_.text = var_796_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, false)
				arg_793_1.callingController_:SetSelectedState("normal")

				local var_796_8 = arg_793_1:GetWordFromCfg(1105005197)
				local var_796_9 = arg_793_1:FormatText(var_796_8.content)

				arg_793_1.text_.text = var_796_9

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_10 = 14
				local var_796_11 = utf8.len(var_796_9)
				local var_796_12 = var_796_10 <= 0 and var_796_6 or var_796_6 * (var_796_11 / var_796_10)

				if var_796_12 > 0 and var_796_6 < var_796_12 then
					arg_793_1.talkMaxDuration = var_796_12

					if var_796_12 + var_796_5 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_12 + var_796_5
					end
				end

				arg_793_1.text_.text = var_796_9
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005197", "story_v_side_new_1105005.awb") ~= 0 then
					local var_796_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005197", "story_v_side_new_1105005.awb") / 1000

					if var_796_13 + var_796_5 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_13 + var_796_5
					end

					if var_796_8.prefab_name ~= "" and arg_793_1.actors_[var_796_8.prefab_name] ~= nil then
						local var_796_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_793_1.actors_[var_796_8.prefab_name].transform, "story_v_side_new_1105005", "1105005197", "story_v_side_new_1105005.awb")

						arg_793_1:RecordAudio("1105005197", var_796_14)
						arg_793_1:RecordAudio("1105005197", var_796_14)
					else
						arg_793_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005197", "story_v_side_new_1105005.awb")
					end

					arg_793_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005197", "story_v_side_new_1105005.awb")
				end

				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_15 = math.max(var_796_6, arg_793_1.talkMaxDuration)

			if var_796_5 <= arg_793_1.time_ and arg_793_1.time_ < var_796_5 + var_796_15 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_5) / var_796_15

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_5 + var_796_15 and arg_793_1.time_ < var_796_5 + var_796_15 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play1105005198 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1105005198
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1105005199(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			local var_800_0 = arg_797_1.actors_["115001ui_story"].transform
			local var_800_1 = 0

			if var_800_1 < arg_797_1.time_ and arg_797_1.time_ <= var_800_1 + arg_800_0 then
				arg_797_1.var_.moveOldPos115001ui_story = var_800_0.localPosition
			end

			local var_800_2 = 0.001

			if var_800_1 <= arg_797_1.time_ and arg_797_1.time_ < var_800_1 + var_800_2 then
				local var_800_3 = (arg_797_1.time_ - var_800_1) / var_800_2
				local var_800_4 = Vector3.New(0, 100, 0)

				var_800_0.localPosition = Vector3.Lerp(arg_797_1.var_.moveOldPos115001ui_story, var_800_4, var_800_3)

				local var_800_5 = manager.ui.mainCamera.transform.position - var_800_0.position

				var_800_0.forward = Vector3.New(var_800_5.x, var_800_5.y, var_800_5.z)

				local var_800_6 = var_800_0.localEulerAngles

				var_800_6.z = 0
				var_800_6.x = 0
				var_800_0.localEulerAngles = var_800_6
			end

			if arg_797_1.time_ >= var_800_1 + var_800_2 and arg_797_1.time_ < var_800_1 + var_800_2 + arg_800_0 then
				var_800_0.localPosition = Vector3.New(0, 100, 0)

				local var_800_7 = manager.ui.mainCamera.transform.position - var_800_0.position

				var_800_0.forward = Vector3.New(var_800_7.x, var_800_7.y, var_800_7.z)

				local var_800_8 = var_800_0.localEulerAngles

				var_800_8.z = 0
				var_800_8.x = 0
				var_800_0.localEulerAngles = var_800_8
			end

			local var_800_9 = 0
			local var_800_10 = 1.65

			if var_800_9 < arg_797_1.time_ and arg_797_1.time_ <= var_800_9 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, false)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_11 = arg_797_1:GetWordFromCfg(1105005198)
				local var_800_12 = arg_797_1:FormatText(var_800_11.content)

				arg_797_1.text_.text = var_800_12

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_13 = 66
				local var_800_14 = utf8.len(var_800_12)
				local var_800_15 = var_800_13 <= 0 and var_800_10 or var_800_10 * (var_800_14 / var_800_13)

				if var_800_15 > 0 and var_800_10 < var_800_15 then
					arg_797_1.talkMaxDuration = var_800_15

					if var_800_15 + var_800_9 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_15 + var_800_9
					end
				end

				arg_797_1.text_.text = var_800_12
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_16 = math.max(var_800_10, arg_797_1.talkMaxDuration)

			if var_800_9 <= arg_797_1.time_ and arg_797_1.time_ < var_800_9 + var_800_16 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_9) / var_800_16

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_9 + var_800_16 and arg_797_1.time_ < var_800_9 + var_800_16 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_797_1:InitPlayNodeList()
	end,
	Play1105005199 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1105005199
		arg_801_1.duration_ = 5

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play1105005200(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			local var_804_0 = 0
			local var_804_1 = 1.525

			if var_804_0 < arg_801_1.time_ and arg_801_1.time_ <= var_804_0 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, false)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_801_1.iconTrs_.gameObject, false)
				arg_801_1.callingController_:SetSelectedState("normal")

				local var_804_2 = arg_801_1:GetWordFromCfg(1105005199)
				local var_804_3 = arg_801_1:FormatText(var_804_2.content)

				arg_801_1.text_.text = var_804_3

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_4 = 61
				local var_804_5 = utf8.len(var_804_3)
				local var_804_6 = var_804_4 <= 0 and var_804_1 or var_804_1 * (var_804_5 / var_804_4)

				if var_804_6 > 0 and var_804_1 < var_804_6 then
					arg_801_1.talkMaxDuration = var_804_6

					if var_804_6 + var_804_0 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_6 + var_804_0
					end
				end

				arg_801_1.text_.text = var_804_3
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)
				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_7 = math.max(var_804_1, arg_801_1.talkMaxDuration)

			if var_804_0 <= arg_801_1.time_ and arg_801_1.time_ < var_804_0 + var_804_7 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_0) / var_804_7

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_0 + var_804_7 and arg_801_1.time_ < var_804_0 + var_804_7 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play1105005200 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1105005200
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1105005201(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			local var_808_0 = 0
			local var_808_1 = 1.425

			if var_808_0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_0 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, false)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_2 = arg_805_1:GetWordFromCfg(1105005200)
				local var_808_3 = arg_805_1:FormatText(var_808_2.content)

				arg_805_1.text_.text = var_808_3

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_4 = 57
				local var_808_5 = utf8.len(var_808_3)
				local var_808_6 = var_808_4 <= 0 and var_808_1 or var_808_1 * (var_808_5 / var_808_4)

				if var_808_6 > 0 and var_808_1 < var_808_6 then
					arg_805_1.talkMaxDuration = var_808_6

					if var_808_6 + var_808_0 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_6 + var_808_0
					end
				end

				arg_805_1.text_.text = var_808_3
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_7 = math.max(var_808_1, arg_805_1.talkMaxDuration)

			if var_808_0 <= arg_805_1.time_ and arg_805_1.time_ < var_808_0 + var_808_7 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_0) / var_808_7

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_0 + var_808_7 and arg_805_1.time_ < var_808_0 + var_808_7 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {}

		arg_805_1:InitPlayNodeList()
	end,
	Play1105005201 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1105005201
		arg_809_1.duration_ = 8.5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1105005202(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = arg_809_1.actors_["115001ui_story"].transform
			local var_812_1 = 0

			if var_812_1 < arg_809_1.time_ and arg_809_1.time_ <= var_812_1 + arg_812_0 then
				arg_809_1.var_.moveOldPos115001ui_story = var_812_0.localPosition
			end

			local var_812_2 = 0.001

			if var_812_1 <= arg_809_1.time_ and arg_809_1.time_ < var_812_1 + var_812_2 then
				local var_812_3 = (arg_809_1.time_ - var_812_1) / var_812_2
				local var_812_4 = Vector3.New(0, -1.033, -6.3)

				var_812_0.localPosition = Vector3.Lerp(arg_809_1.var_.moveOldPos115001ui_story, var_812_4, var_812_3)

				local var_812_5 = manager.ui.mainCamera.transform.position - var_812_0.position

				var_812_0.forward = Vector3.New(var_812_5.x, var_812_5.y, var_812_5.z)

				local var_812_6 = var_812_0.localEulerAngles

				var_812_6.z = 0
				var_812_6.x = 0
				var_812_0.localEulerAngles = var_812_6
			end

			if arg_809_1.time_ >= var_812_1 + var_812_2 and arg_809_1.time_ < var_812_1 + var_812_2 + arg_812_0 then
				var_812_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_812_7 = manager.ui.mainCamera.transform.position - var_812_0.position

				var_812_0.forward = Vector3.New(var_812_7.x, var_812_7.y, var_812_7.z)

				local var_812_8 = var_812_0.localEulerAngles

				var_812_8.z = 0
				var_812_8.x = 0
				var_812_0.localEulerAngles = var_812_8
			end

			local var_812_9 = arg_809_1.actors_["115001ui_story"]
			local var_812_10 = 0

			if var_812_10 < arg_809_1.time_ and arg_809_1.time_ <= var_812_10 + arg_812_0 and not isNil(var_812_9) and arg_809_1.var_.characterEffect115001ui_story == nil then
				arg_809_1.var_.characterEffect115001ui_story = var_812_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_812_11 = 0.200000002980232

			if var_812_10 <= arg_809_1.time_ and arg_809_1.time_ < var_812_10 + var_812_11 and not isNil(var_812_9) then
				local var_812_12 = (arg_809_1.time_ - var_812_10) / var_812_11

				if arg_809_1.var_.characterEffect115001ui_story and not isNil(var_812_9) then
					arg_809_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_809_1.time_ >= var_812_10 + var_812_11 and arg_809_1.time_ < var_812_10 + var_812_11 + arg_812_0 and not isNil(var_812_9) and arg_809_1.var_.characterEffect115001ui_story then
				arg_809_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_812_13 = 0

			if var_812_13 < arg_809_1.time_ and arg_809_1.time_ <= var_812_13 + arg_812_0 then
				arg_809_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_812_14 = 0
			local var_812_15 = 0.8

			if var_812_14 < arg_809_1.time_ and arg_809_1.time_ <= var_812_14 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				local var_812_16 = arg_809_1:FormatText(StoryNameCfg[74].name)

				arg_809_1.leftNameTxt_.text = var_812_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, false)
				arg_809_1.callingController_:SetSelectedState("normal")

				local var_812_17 = arg_809_1:GetWordFromCfg(1105005201)
				local var_812_18 = arg_809_1:FormatText(var_812_17.content)

				arg_809_1.text_.text = var_812_18

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_19 = 32
				local var_812_20 = utf8.len(var_812_18)
				local var_812_21 = var_812_19 <= 0 and var_812_15 or var_812_15 * (var_812_20 / var_812_19)

				if var_812_21 > 0 and var_812_15 < var_812_21 then
					arg_809_1.talkMaxDuration = var_812_21

					if var_812_21 + var_812_14 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_21 + var_812_14
					end
				end

				arg_809_1.text_.text = var_812_18
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005201", "story_v_side_new_1105005.awb") ~= 0 then
					local var_812_22 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005201", "story_v_side_new_1105005.awb") / 1000

					if var_812_22 + var_812_14 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_22 + var_812_14
					end

					if var_812_17.prefab_name ~= "" and arg_809_1.actors_[var_812_17.prefab_name] ~= nil then
						local var_812_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_809_1.actors_[var_812_17.prefab_name].transform, "story_v_side_new_1105005", "1105005201", "story_v_side_new_1105005.awb")

						arg_809_1:RecordAudio("1105005201", var_812_23)
						arg_809_1:RecordAudio("1105005201", var_812_23)
					else
						arg_809_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005201", "story_v_side_new_1105005.awb")
					end

					arg_809_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005201", "story_v_side_new_1105005.awb")
				end

				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_24 = math.max(var_812_15, arg_809_1.talkMaxDuration)

			if var_812_14 <= arg_809_1.time_ and arg_809_1.time_ < var_812_14 + var_812_24 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_14) / var_812_24

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_14 + var_812_24 and arg_809_1.time_ < var_812_14 + var_812_24 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_809_1:InitPlayNodeList()
	end,
	Play1105005202 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1105005202
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1105005203(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = arg_813_1.actors_["115001ui_story"]
			local var_816_1 = 0

			if var_816_1 < arg_813_1.time_ and arg_813_1.time_ <= var_816_1 + arg_816_0 and not isNil(var_816_0) and arg_813_1.var_.characterEffect115001ui_story == nil then
				arg_813_1.var_.characterEffect115001ui_story = var_816_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_816_2 = 0.200000002980232

			if var_816_1 <= arg_813_1.time_ and arg_813_1.time_ < var_816_1 + var_816_2 and not isNil(var_816_0) then
				local var_816_3 = (arg_813_1.time_ - var_816_1) / var_816_2

				if arg_813_1.var_.characterEffect115001ui_story and not isNil(var_816_0) then
					local var_816_4 = Mathf.Lerp(0, 0.5, var_816_3)

					arg_813_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_813_1.var_.characterEffect115001ui_story.fillRatio = var_816_4
				end
			end

			if arg_813_1.time_ >= var_816_1 + var_816_2 and arg_813_1.time_ < var_816_1 + var_816_2 + arg_816_0 and not isNil(var_816_0) and arg_813_1.var_.characterEffect115001ui_story then
				local var_816_5 = 0.5

				arg_813_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_813_1.var_.characterEffect115001ui_story.fillRatio = var_816_5
			end

			local var_816_6 = 0
			local var_816_7 = 0.5

			if var_816_6 < arg_813_1.time_ and arg_813_1.time_ <= var_816_6 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				local var_816_8 = arg_813_1:FormatText(StoryNameCfg[7].name)

				arg_813_1.leftNameTxt_.text = var_816_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_9 = arg_813_1:GetWordFromCfg(1105005202)
				local var_816_10 = arg_813_1:FormatText(var_816_9.content)

				arg_813_1.text_.text = var_816_10

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_11 = 20
				local var_816_12 = utf8.len(var_816_10)
				local var_816_13 = var_816_11 <= 0 and var_816_7 or var_816_7 * (var_816_12 / var_816_11)

				if var_816_13 > 0 and var_816_7 < var_816_13 then
					arg_813_1.talkMaxDuration = var_816_13

					if var_816_13 + var_816_6 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_13 + var_816_6
					end
				end

				arg_813_1.text_.text = var_816_10
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_14 = math.max(var_816_7, arg_813_1.talkMaxDuration)

			if var_816_6 <= arg_813_1.time_ and arg_813_1.time_ < var_816_6 + var_816_14 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_6) / var_816_14

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_6 + var_816_14 and arg_813_1.time_ < var_816_6 + var_816_14 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	Play1105005203 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 1105005203
		arg_817_1.duration_ = 4.73

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play1105005204(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			local var_820_0 = arg_817_1.actors_["115001ui_story"]
			local var_820_1 = 0

			if var_820_1 < arg_817_1.time_ and arg_817_1.time_ <= var_820_1 + arg_820_0 and not isNil(var_820_0) and arg_817_1.var_.characterEffect115001ui_story == nil then
				arg_817_1.var_.characterEffect115001ui_story = var_820_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_2 = 0.200000002980232

			if var_820_1 <= arg_817_1.time_ and arg_817_1.time_ < var_820_1 + var_820_2 and not isNil(var_820_0) then
				local var_820_3 = (arg_817_1.time_ - var_820_1) / var_820_2

				if arg_817_1.var_.characterEffect115001ui_story and not isNil(var_820_0) then
					arg_817_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_817_1.time_ >= var_820_1 + var_820_2 and arg_817_1.time_ < var_820_1 + var_820_2 + arg_820_0 and not isNil(var_820_0) and arg_817_1.var_.characterEffect115001ui_story then
				arg_817_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_820_4 = 0

			if var_820_4 < arg_817_1.time_ and arg_817_1.time_ <= var_820_4 + arg_820_0 then
				arg_817_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_820_5 = 0
			local var_820_6 = 0.325

			if var_820_5 < arg_817_1.time_ and arg_817_1.time_ <= var_820_5 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				local var_820_7 = arg_817_1:FormatText(StoryNameCfg[74].name)

				arg_817_1.leftNameTxt_.text = var_820_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_8 = arg_817_1:GetWordFromCfg(1105005203)
				local var_820_9 = arg_817_1:FormatText(var_820_8.content)

				arg_817_1.text_.text = var_820_9

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_10 = 13
				local var_820_11 = utf8.len(var_820_9)
				local var_820_12 = var_820_10 <= 0 and var_820_6 or var_820_6 * (var_820_11 / var_820_10)

				if var_820_12 > 0 and var_820_6 < var_820_12 then
					arg_817_1.talkMaxDuration = var_820_12

					if var_820_12 + var_820_5 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_12 + var_820_5
					end
				end

				arg_817_1.text_.text = var_820_9
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005203", "story_v_side_new_1105005.awb") ~= 0 then
					local var_820_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005203", "story_v_side_new_1105005.awb") / 1000

					if var_820_13 + var_820_5 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_13 + var_820_5
					end

					if var_820_8.prefab_name ~= "" and arg_817_1.actors_[var_820_8.prefab_name] ~= nil then
						local var_820_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_817_1.actors_[var_820_8.prefab_name].transform, "story_v_side_new_1105005", "1105005203", "story_v_side_new_1105005.awb")

						arg_817_1:RecordAudio("1105005203", var_820_14)
						arg_817_1:RecordAudio("1105005203", var_820_14)
					else
						arg_817_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005203", "story_v_side_new_1105005.awb")
					end

					arg_817_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005203", "story_v_side_new_1105005.awb")
				end

				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_15 = math.max(var_820_6, arg_817_1.talkMaxDuration)

			if var_820_5 <= arg_817_1.time_ and arg_817_1.time_ < var_820_5 + var_820_15 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_5) / var_820_15

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_5 + var_820_15 and arg_817_1.time_ < var_820_5 + var_820_15 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {}

		arg_817_1:InitPlayNodeList()
	end,
	Play1105005204 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 1105005204
		arg_821_1.duration_ = 5

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play1105005205(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = arg_821_1.actors_["115001ui_story"]
			local var_824_1 = 0

			if var_824_1 < arg_821_1.time_ and arg_821_1.time_ <= var_824_1 + arg_824_0 and not isNil(var_824_0) and arg_821_1.var_.characterEffect115001ui_story == nil then
				arg_821_1.var_.characterEffect115001ui_story = var_824_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_824_2 = 0.2

			if var_824_1 <= arg_821_1.time_ and arg_821_1.time_ < var_824_1 + var_824_2 and not isNil(var_824_0) then
				local var_824_3 = (arg_821_1.time_ - var_824_1) / var_824_2

				if arg_821_1.var_.characterEffect115001ui_story and not isNil(var_824_0) then
					local var_824_4 = Mathf.Lerp(0, 0.5, var_824_3)

					arg_821_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_821_1.var_.characterEffect115001ui_story.fillRatio = var_824_4
				end
			end

			if arg_821_1.time_ >= var_824_1 + var_824_2 and arg_821_1.time_ < var_824_1 + var_824_2 + arg_824_0 and not isNil(var_824_0) and arg_821_1.var_.characterEffect115001ui_story then
				local var_824_5 = 0.5

				arg_821_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_821_1.var_.characterEffect115001ui_story.fillRatio = var_824_5
			end

			local var_824_6 = 0
			local var_824_7 = 1.3

			if var_824_6 < arg_821_1.time_ and arg_821_1.time_ <= var_824_6 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, false)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_8 = arg_821_1:GetWordFromCfg(1105005204)
				local var_824_9 = arg_821_1:FormatText(var_824_8.content)

				arg_821_1.text_.text = var_824_9

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_10 = 52
				local var_824_11 = utf8.len(var_824_9)
				local var_824_12 = var_824_10 <= 0 and var_824_7 or var_824_7 * (var_824_11 / var_824_10)

				if var_824_12 > 0 and var_824_7 < var_824_12 then
					arg_821_1.talkMaxDuration = var_824_12

					if var_824_12 + var_824_6 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_12 + var_824_6
					end
				end

				arg_821_1.text_.text = var_824_9
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_13 = math.max(var_824_7, arg_821_1.talkMaxDuration)

			if var_824_6 <= arg_821_1.time_ and arg_821_1.time_ < var_824_6 + var_824_13 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_6) / var_824_13

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_6 + var_824_13 and arg_821_1.time_ < var_824_6 + var_824_13 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {}

		arg_821_1:InitPlayNodeList()
	end,
	Play1105005205 = function(arg_825_0, arg_825_1)
		arg_825_1.time_ = 0
		arg_825_1.frameCnt_ = 0
		arg_825_1.state_ = "playing"
		arg_825_1.curTalkId_ = 1105005205
		arg_825_1.duration_ = 10.53

		SetActive(arg_825_1.tipsGo_, false)

		function arg_825_1.onSingleLineFinish_()
			arg_825_1.onSingleLineUpdate_ = nil
			arg_825_1.onSingleLineFinish_ = nil
			arg_825_1.state_ = "waiting"
		end

		function arg_825_1.playNext_(arg_827_0)
			if arg_827_0 == 1 then
				arg_825_0:Play1105005206(arg_825_1)
			end
		end

		function arg_825_1.onSingleLineUpdate_(arg_828_0)
			local var_828_0 = arg_825_1.actors_["115001ui_story"]
			local var_828_1 = 0

			if var_828_1 < arg_825_1.time_ and arg_825_1.time_ <= var_828_1 + arg_828_0 and not isNil(var_828_0) and arg_825_1.var_.characterEffect115001ui_story == nil then
				arg_825_1.var_.characterEffect115001ui_story = var_828_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_828_2 = 0.200000002980232

			if var_828_1 <= arg_825_1.time_ and arg_825_1.time_ < var_828_1 + var_828_2 and not isNil(var_828_0) then
				local var_828_3 = (arg_825_1.time_ - var_828_1) / var_828_2

				if arg_825_1.var_.characterEffect115001ui_story and not isNil(var_828_0) then
					arg_825_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_825_1.time_ >= var_828_1 + var_828_2 and arg_825_1.time_ < var_828_1 + var_828_2 + arg_828_0 and not isNil(var_828_0) and arg_825_1.var_.characterEffect115001ui_story then
				arg_825_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_828_4 = 0

			if var_828_4 < arg_825_1.time_ and arg_825_1.time_ <= var_828_4 + arg_828_0 then
				arg_825_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_828_5 = 0
			local var_828_6 = 0.975

			if var_828_5 < arg_825_1.time_ and arg_825_1.time_ <= var_828_5 + arg_828_0 then
				arg_825_1.talkMaxDuration = 0
				arg_825_1.dialogCg_.alpha = 1

				arg_825_1.dialog_:SetActive(true)
				SetActive(arg_825_1.leftNameGo_, true)

				local var_828_7 = arg_825_1:FormatText(StoryNameCfg[74].name)

				arg_825_1.leftNameTxt_.text = var_828_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_825_1.leftNameTxt_.transform)

				arg_825_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_825_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_825_1:RecordName(arg_825_1.leftNameTxt_.text)
				SetActive(arg_825_1.iconTrs_.gameObject, false)
				arg_825_1.callingController_:SetSelectedState("normal")

				local var_828_8 = arg_825_1:GetWordFromCfg(1105005205)
				local var_828_9 = arg_825_1:FormatText(var_828_8.content)

				arg_825_1.text_.text = var_828_9

				LuaForUtil.ClearLinePrefixSymbol(arg_825_1.text_)

				local var_828_10 = 39
				local var_828_11 = utf8.len(var_828_9)
				local var_828_12 = var_828_10 <= 0 and var_828_6 or var_828_6 * (var_828_11 / var_828_10)

				if var_828_12 > 0 and var_828_6 < var_828_12 then
					arg_825_1.talkMaxDuration = var_828_12

					if var_828_12 + var_828_5 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_12 + var_828_5
					end
				end

				arg_825_1.text_.text = var_828_9
				arg_825_1.typewritter.percent = 0

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005205", "story_v_side_new_1105005.awb") ~= 0 then
					local var_828_13 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005205", "story_v_side_new_1105005.awb") / 1000

					if var_828_13 + var_828_5 > arg_825_1.duration_ then
						arg_825_1.duration_ = var_828_13 + var_828_5
					end

					if var_828_8.prefab_name ~= "" and arg_825_1.actors_[var_828_8.prefab_name] ~= nil then
						local var_828_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_825_1.actors_[var_828_8.prefab_name].transform, "story_v_side_new_1105005", "1105005205", "story_v_side_new_1105005.awb")

						arg_825_1:RecordAudio("1105005205", var_828_14)
						arg_825_1:RecordAudio("1105005205", var_828_14)
					else
						arg_825_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005205", "story_v_side_new_1105005.awb")
					end

					arg_825_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005205", "story_v_side_new_1105005.awb")
				end

				arg_825_1:RecordContent(arg_825_1.text_.text)
			end

			local var_828_15 = math.max(var_828_6, arg_825_1.talkMaxDuration)

			if var_828_5 <= arg_825_1.time_ and arg_825_1.time_ < var_828_5 + var_828_15 then
				arg_825_1.typewritter.percent = (arg_825_1.time_ - var_828_5) / var_828_15

				arg_825_1.typewritter:SetDirty()
			end

			if arg_825_1.time_ >= var_828_5 + var_828_15 and arg_825_1.time_ < var_828_5 + var_828_15 + arg_828_0 then
				arg_825_1.typewritter.percent = 1

				arg_825_1.typewritter:SetDirty()
				arg_825_1:ShowNextGo(true)
			end
		end

		arg_825_1.nodeConfigList_ = {}

		arg_825_1:InitPlayNodeList()
	end,
	Play1105005206 = function(arg_829_0, arg_829_1)
		arg_829_1.time_ = 0
		arg_829_1.frameCnt_ = 0
		arg_829_1.state_ = "playing"
		arg_829_1.curTalkId_ = 1105005206
		arg_829_1.duration_ = 5

		SetActive(arg_829_1.tipsGo_, false)

		function arg_829_1.onSingleLineFinish_()
			arg_829_1.onSingleLineUpdate_ = nil
			arg_829_1.onSingleLineFinish_ = nil
			arg_829_1.state_ = "waiting"
		end

		function arg_829_1.playNext_(arg_831_0)
			if arg_831_0 == 1 then
				arg_829_0:Play1105005207(arg_829_1)
			end
		end

		function arg_829_1.onSingleLineUpdate_(arg_832_0)
			local var_832_0 = arg_829_1.actors_["115001ui_story"]
			local var_832_1 = 0

			if var_832_1 < arg_829_1.time_ and arg_829_1.time_ <= var_832_1 + arg_832_0 and not isNil(var_832_0) and arg_829_1.var_.characterEffect115001ui_story == nil then
				arg_829_1.var_.characterEffect115001ui_story = var_832_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_832_2 = 0.200000002980232

			if var_832_1 <= arg_829_1.time_ and arg_829_1.time_ < var_832_1 + var_832_2 and not isNil(var_832_0) then
				local var_832_3 = (arg_829_1.time_ - var_832_1) / var_832_2

				if arg_829_1.var_.characterEffect115001ui_story and not isNil(var_832_0) then
					local var_832_4 = Mathf.Lerp(0, 0.5, var_832_3)

					arg_829_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_829_1.var_.characterEffect115001ui_story.fillRatio = var_832_4
				end
			end

			if arg_829_1.time_ >= var_832_1 + var_832_2 and arg_829_1.time_ < var_832_1 + var_832_2 + arg_832_0 and not isNil(var_832_0) and arg_829_1.var_.characterEffect115001ui_story then
				local var_832_5 = 0.5

				arg_829_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_829_1.var_.characterEffect115001ui_story.fillRatio = var_832_5
			end

			local var_832_6 = 0
			local var_832_7 = 0.9

			if var_832_6 < arg_829_1.time_ and arg_829_1.time_ <= var_832_6 + arg_832_0 then
				arg_829_1.talkMaxDuration = 0
				arg_829_1.dialogCg_.alpha = 1

				arg_829_1.dialog_:SetActive(true)
				SetActive(arg_829_1.leftNameGo_, true)

				local var_832_8 = arg_829_1:FormatText(StoryNameCfg[7].name)

				arg_829_1.leftNameTxt_.text = var_832_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_829_1.leftNameTxt_.transform)

				arg_829_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_829_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_829_1:RecordName(arg_829_1.leftNameTxt_.text)
				SetActive(arg_829_1.iconTrs_.gameObject, true)
				arg_829_1.iconController_:SetSelectedState("hero")

				arg_829_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_829_1.callingController_:SetSelectedState("normal")

				arg_829_1.keyicon_.color = Color.New(1, 1, 1)
				arg_829_1.icon_.color = Color.New(1, 1, 1)

				local var_832_9 = arg_829_1:GetWordFromCfg(1105005206)
				local var_832_10 = arg_829_1:FormatText(var_832_9.content)

				arg_829_1.text_.text = var_832_10

				LuaForUtil.ClearLinePrefixSymbol(arg_829_1.text_)

				local var_832_11 = 36
				local var_832_12 = utf8.len(var_832_10)
				local var_832_13 = var_832_11 <= 0 and var_832_7 or var_832_7 * (var_832_12 / var_832_11)

				if var_832_13 > 0 and var_832_7 < var_832_13 then
					arg_829_1.talkMaxDuration = var_832_13

					if var_832_13 + var_832_6 > arg_829_1.duration_ then
						arg_829_1.duration_ = var_832_13 + var_832_6
					end
				end

				arg_829_1.text_.text = var_832_10
				arg_829_1.typewritter.percent = 0

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(false)
				arg_829_1:RecordContent(arg_829_1.text_.text)
			end

			local var_832_14 = math.max(var_832_7, arg_829_1.talkMaxDuration)

			if var_832_6 <= arg_829_1.time_ and arg_829_1.time_ < var_832_6 + var_832_14 then
				arg_829_1.typewritter.percent = (arg_829_1.time_ - var_832_6) / var_832_14

				arg_829_1.typewritter:SetDirty()
			end

			if arg_829_1.time_ >= var_832_6 + var_832_14 and arg_829_1.time_ < var_832_6 + var_832_14 + arg_832_0 then
				arg_829_1.typewritter.percent = 1

				arg_829_1.typewritter:SetDirty()
				arg_829_1:ShowNextGo(true)
			end
		end

		arg_829_1.nodeConfigList_ = {}

		arg_829_1:InitPlayNodeList()
	end,
	Play1105005207 = function(arg_833_0, arg_833_1)
		arg_833_1.time_ = 0
		arg_833_1.frameCnt_ = 0
		arg_833_1.state_ = "playing"
		arg_833_1.curTalkId_ = 1105005207
		arg_833_1.duration_ = 5.27

		SetActive(arg_833_1.tipsGo_, false)

		function arg_833_1.onSingleLineFinish_()
			arg_833_1.onSingleLineUpdate_ = nil
			arg_833_1.onSingleLineFinish_ = nil
			arg_833_1.state_ = "waiting"
		end

		function arg_833_1.playNext_(arg_835_0)
			if arg_835_0 == 1 then
				arg_833_0:Play1105005208(arg_833_1)
			end
		end

		function arg_833_1.onSingleLineUpdate_(arg_836_0)
			local var_836_0 = arg_833_1.actors_["115001ui_story"]
			local var_836_1 = 0

			if var_836_1 < arg_833_1.time_ and arg_833_1.time_ <= var_836_1 + arg_836_0 and not isNil(var_836_0) and arg_833_1.var_.characterEffect115001ui_story == nil then
				arg_833_1.var_.characterEffect115001ui_story = var_836_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_836_2 = 0.200000002980232

			if var_836_1 <= arg_833_1.time_ and arg_833_1.time_ < var_836_1 + var_836_2 and not isNil(var_836_0) then
				local var_836_3 = (arg_833_1.time_ - var_836_1) / var_836_2

				if arg_833_1.var_.characterEffect115001ui_story and not isNil(var_836_0) then
					arg_833_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_833_1.time_ >= var_836_1 + var_836_2 and arg_833_1.time_ < var_836_1 + var_836_2 + arg_836_0 and not isNil(var_836_0) and arg_833_1.var_.characterEffect115001ui_story then
				arg_833_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_836_4 = 0

			if var_836_4 < arg_833_1.time_ and arg_833_1.time_ <= var_836_4 + arg_836_0 then
				arg_833_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			local var_836_5 = 0

			if var_836_5 < arg_833_1.time_ and arg_833_1.time_ <= var_836_5 + arg_836_0 then
				arg_833_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_836_6 = 0
			local var_836_7 = 0.5

			if var_836_6 < arg_833_1.time_ and arg_833_1.time_ <= var_836_6 + arg_836_0 then
				arg_833_1.talkMaxDuration = 0
				arg_833_1.dialogCg_.alpha = 1

				arg_833_1.dialog_:SetActive(true)
				SetActive(arg_833_1.leftNameGo_, true)

				local var_836_8 = arg_833_1:FormatText(StoryNameCfg[74].name)

				arg_833_1.leftNameTxt_.text = var_836_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_833_1.leftNameTxt_.transform)

				arg_833_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_833_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_833_1:RecordName(arg_833_1.leftNameTxt_.text)
				SetActive(arg_833_1.iconTrs_.gameObject, false)
				arg_833_1.callingController_:SetSelectedState("normal")

				local var_836_9 = arg_833_1:GetWordFromCfg(1105005207)
				local var_836_10 = arg_833_1:FormatText(var_836_9.content)

				arg_833_1.text_.text = var_836_10

				LuaForUtil.ClearLinePrefixSymbol(arg_833_1.text_)

				local var_836_11 = 20
				local var_836_12 = utf8.len(var_836_10)
				local var_836_13 = var_836_11 <= 0 and var_836_7 or var_836_7 * (var_836_12 / var_836_11)

				if var_836_13 > 0 and var_836_7 < var_836_13 then
					arg_833_1.talkMaxDuration = var_836_13

					if var_836_13 + var_836_6 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_13 + var_836_6
					end
				end

				arg_833_1.text_.text = var_836_10
				arg_833_1.typewritter.percent = 0

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005207", "story_v_side_new_1105005.awb") ~= 0 then
					local var_836_14 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005207", "story_v_side_new_1105005.awb") / 1000

					if var_836_14 + var_836_6 > arg_833_1.duration_ then
						arg_833_1.duration_ = var_836_14 + var_836_6
					end

					if var_836_9.prefab_name ~= "" and arg_833_1.actors_[var_836_9.prefab_name] ~= nil then
						local var_836_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_833_1.actors_[var_836_9.prefab_name].transform, "story_v_side_new_1105005", "1105005207", "story_v_side_new_1105005.awb")

						arg_833_1:RecordAudio("1105005207", var_836_15)
						arg_833_1:RecordAudio("1105005207", var_836_15)
					else
						arg_833_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005207", "story_v_side_new_1105005.awb")
					end

					arg_833_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005207", "story_v_side_new_1105005.awb")
				end

				arg_833_1:RecordContent(arg_833_1.text_.text)
			end

			local var_836_16 = math.max(var_836_7, arg_833_1.talkMaxDuration)

			if var_836_6 <= arg_833_1.time_ and arg_833_1.time_ < var_836_6 + var_836_16 then
				arg_833_1.typewritter.percent = (arg_833_1.time_ - var_836_6) / var_836_16

				arg_833_1.typewritter:SetDirty()
			end

			if arg_833_1.time_ >= var_836_6 + var_836_16 and arg_833_1.time_ < var_836_6 + var_836_16 + arg_836_0 then
				arg_833_1.typewritter.percent = 1

				arg_833_1.typewritter:SetDirty()
				arg_833_1:ShowNextGo(true)
			end
		end

		arg_833_1.nodeConfigList_ = {}

		arg_833_1:InitPlayNodeList()
	end,
	Play1105005208 = function(arg_837_0, arg_837_1)
		arg_837_1.time_ = 0
		arg_837_1.frameCnt_ = 0
		arg_837_1.state_ = "playing"
		arg_837_1.curTalkId_ = 1105005208
		arg_837_1.duration_ = 5

		SetActive(arg_837_1.tipsGo_, false)

		function arg_837_1.onSingleLineFinish_()
			arg_837_1.onSingleLineUpdate_ = nil
			arg_837_1.onSingleLineFinish_ = nil
			arg_837_1.state_ = "waiting"
		end

		function arg_837_1.playNext_(arg_839_0)
			if arg_839_0 == 1 then
				arg_837_0:Play1105005209(arg_837_1)
			end
		end

		function arg_837_1.onSingleLineUpdate_(arg_840_0)
			local var_840_0 = arg_837_1.actors_["115001ui_story"].transform
			local var_840_1 = 0

			if var_840_1 < arg_837_1.time_ and arg_837_1.time_ <= var_840_1 + arg_840_0 then
				arg_837_1.var_.moveOldPos115001ui_story = var_840_0.localPosition
			end

			local var_840_2 = 0.001

			if var_840_1 <= arg_837_1.time_ and arg_837_1.time_ < var_840_1 + var_840_2 then
				local var_840_3 = (arg_837_1.time_ - var_840_1) / var_840_2
				local var_840_4 = Vector3.New(0, 100, 0)

				var_840_0.localPosition = Vector3.Lerp(arg_837_1.var_.moveOldPos115001ui_story, var_840_4, var_840_3)

				local var_840_5 = manager.ui.mainCamera.transform.position - var_840_0.position

				var_840_0.forward = Vector3.New(var_840_5.x, var_840_5.y, var_840_5.z)

				local var_840_6 = var_840_0.localEulerAngles

				var_840_6.z = 0
				var_840_6.x = 0
				var_840_0.localEulerAngles = var_840_6
			end

			if arg_837_1.time_ >= var_840_1 + var_840_2 and arg_837_1.time_ < var_840_1 + var_840_2 + arg_840_0 then
				var_840_0.localPosition = Vector3.New(0, 100, 0)

				local var_840_7 = manager.ui.mainCamera.transform.position - var_840_0.position

				var_840_0.forward = Vector3.New(var_840_7.x, var_840_7.y, var_840_7.z)

				local var_840_8 = var_840_0.localEulerAngles

				var_840_8.z = 0
				var_840_8.x = 0
				var_840_0.localEulerAngles = var_840_8
			end

			local var_840_9 = 0
			local var_840_10 = 0.225

			if var_840_9 < arg_837_1.time_ and arg_837_1.time_ <= var_840_9 + arg_840_0 then
				arg_837_1.talkMaxDuration = 0
				arg_837_1.dialogCg_.alpha = 1

				arg_837_1.dialog_:SetActive(true)
				SetActive(arg_837_1.leftNameGo_, true)

				local var_840_11 = arg_837_1:FormatText(StoryNameCfg[7].name)

				arg_837_1.leftNameTxt_.text = var_840_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_837_1.leftNameTxt_.transform)

				arg_837_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_837_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_837_1:RecordName(arg_837_1.leftNameTxt_.text)
				SetActive(arg_837_1.iconTrs_.gameObject, true)
				arg_837_1.iconController_:SetSelectedState("hero")

				arg_837_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_837_1.callingController_:SetSelectedState("normal")

				arg_837_1.keyicon_.color = Color.New(1, 1, 1)
				arg_837_1.icon_.color = Color.New(1, 1, 1)

				local var_840_12 = arg_837_1:GetWordFromCfg(1105005208)
				local var_840_13 = arg_837_1:FormatText(var_840_12.content)

				arg_837_1.text_.text = var_840_13

				LuaForUtil.ClearLinePrefixSymbol(arg_837_1.text_)

				local var_840_14 = 9
				local var_840_15 = utf8.len(var_840_13)
				local var_840_16 = var_840_14 <= 0 and var_840_10 or var_840_10 * (var_840_15 / var_840_14)

				if var_840_16 > 0 and var_840_10 < var_840_16 then
					arg_837_1.talkMaxDuration = var_840_16

					if var_840_16 + var_840_9 > arg_837_1.duration_ then
						arg_837_1.duration_ = var_840_16 + var_840_9
					end
				end

				arg_837_1.text_.text = var_840_13
				arg_837_1.typewritter.percent = 0

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(false)
				arg_837_1:RecordContent(arg_837_1.text_.text)
			end

			local var_840_17 = math.max(var_840_10, arg_837_1.talkMaxDuration)

			if var_840_9 <= arg_837_1.time_ and arg_837_1.time_ < var_840_9 + var_840_17 then
				arg_837_1.typewritter.percent = (arg_837_1.time_ - var_840_9) / var_840_17

				arg_837_1.typewritter:SetDirty()
			end

			if arg_837_1.time_ >= var_840_9 + var_840_17 and arg_837_1.time_ < var_840_9 + var_840_17 + arg_840_0 then
				arg_837_1.typewritter.percent = 1

				arg_837_1.typewritter:SetDirty()
				arg_837_1:ShowNextGo(true)
			end
		end

		arg_837_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_837_1:InitPlayNodeList()
	end,
	Play1105005209 = function(arg_841_0, arg_841_1)
		arg_841_1.time_ = 0
		arg_841_1.frameCnt_ = 0
		arg_841_1.state_ = "playing"
		arg_841_1.curTalkId_ = 1105005209
		arg_841_1.duration_ = 5

		SetActive(arg_841_1.tipsGo_, false)

		function arg_841_1.onSingleLineFinish_()
			arg_841_1.onSingleLineUpdate_ = nil
			arg_841_1.onSingleLineFinish_ = nil
			arg_841_1.state_ = "waiting"
		end

		function arg_841_1.playNext_(arg_843_0)
			if arg_843_0 == 1 then
				arg_841_0:Play1105005210(arg_841_1)
			end
		end

		function arg_841_1.onSingleLineUpdate_(arg_844_0)
			local var_844_0 = 0
			local var_844_1 = 0.675

			if var_844_0 < arg_841_1.time_ and arg_841_1.time_ <= var_844_0 + arg_844_0 then
				arg_841_1.talkMaxDuration = 0
				arg_841_1.dialogCg_.alpha = 1

				arg_841_1.dialog_:SetActive(true)
				SetActive(arg_841_1.leftNameGo_, true)

				local var_844_2 = arg_841_1:FormatText(StoryNameCfg[7].name)

				arg_841_1.leftNameTxt_.text = var_844_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_841_1.leftNameTxt_.transform)

				arg_841_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_841_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_841_1:RecordName(arg_841_1.leftNameTxt_.text)
				SetActive(arg_841_1.iconTrs_.gameObject, true)
				arg_841_1.iconController_:SetSelectedState("hero")

				arg_841_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_841_1.callingController_:SetSelectedState("normal")

				arg_841_1.keyicon_.color = Color.New(1, 1, 1)
				arg_841_1.icon_.color = Color.New(1, 1, 1)

				local var_844_3 = arg_841_1:GetWordFromCfg(1105005209)
				local var_844_4 = arg_841_1:FormatText(var_844_3.content)

				arg_841_1.text_.text = var_844_4

				LuaForUtil.ClearLinePrefixSymbol(arg_841_1.text_)

				local var_844_5 = 27
				local var_844_6 = utf8.len(var_844_4)
				local var_844_7 = var_844_5 <= 0 and var_844_1 or var_844_1 * (var_844_6 / var_844_5)

				if var_844_7 > 0 and var_844_1 < var_844_7 then
					arg_841_1.talkMaxDuration = var_844_7

					if var_844_7 + var_844_0 > arg_841_1.duration_ then
						arg_841_1.duration_ = var_844_7 + var_844_0
					end
				end

				arg_841_1.text_.text = var_844_4
				arg_841_1.typewritter.percent = 0

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(false)
				arg_841_1:RecordContent(arg_841_1.text_.text)
			end

			local var_844_8 = math.max(var_844_1, arg_841_1.talkMaxDuration)

			if var_844_0 <= arg_841_1.time_ and arg_841_1.time_ < var_844_0 + var_844_8 then
				arg_841_1.typewritter.percent = (arg_841_1.time_ - var_844_0) / var_844_8

				arg_841_1.typewritter:SetDirty()
			end

			if arg_841_1.time_ >= var_844_0 + var_844_8 and arg_841_1.time_ < var_844_0 + var_844_8 + arg_844_0 then
				arg_841_1.typewritter.percent = 1

				arg_841_1.typewritter:SetDirty()
				arg_841_1:ShowNextGo(true)
			end
		end

		arg_841_1.nodeConfigList_ = {}

		arg_841_1:InitPlayNodeList()
	end,
	Play1105005210 = function(arg_845_0, arg_845_1)
		arg_845_1.time_ = 0
		arg_845_1.frameCnt_ = 0
		arg_845_1.state_ = "playing"
		arg_845_1.curTalkId_ = 1105005210
		arg_845_1.duration_ = 5

		SetActive(arg_845_1.tipsGo_, false)

		function arg_845_1.onSingleLineFinish_()
			arg_845_1.onSingleLineUpdate_ = nil
			arg_845_1.onSingleLineFinish_ = nil
			arg_845_1.state_ = "waiting"
		end

		function arg_845_1.playNext_(arg_847_0)
			if arg_847_0 == 1 then
				arg_845_0:Play1105005211(arg_845_1)
			end
		end

		function arg_845_1.onSingleLineUpdate_(arg_848_0)
			local var_848_0 = 0
			local var_848_1 = 1.625

			if var_848_0 < arg_845_1.time_ and arg_845_1.time_ <= var_848_0 + arg_848_0 then
				arg_845_1.talkMaxDuration = 0
				arg_845_1.dialogCg_.alpha = 1

				arg_845_1.dialog_:SetActive(true)
				SetActive(arg_845_1.leftNameGo_, false)

				arg_845_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_845_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_845_1:RecordName(arg_845_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_845_1.iconTrs_.gameObject, false)
				arg_845_1.callingController_:SetSelectedState("normal")

				local var_848_2 = arg_845_1:GetWordFromCfg(1105005210)
				local var_848_3 = arg_845_1:FormatText(var_848_2.content)

				arg_845_1.text_.text = var_848_3

				LuaForUtil.ClearLinePrefixSymbol(arg_845_1.text_)

				local var_848_4 = 65
				local var_848_5 = utf8.len(var_848_3)
				local var_848_6 = var_848_4 <= 0 and var_848_1 or var_848_1 * (var_848_5 / var_848_4)

				if var_848_6 > 0 and var_848_1 < var_848_6 then
					arg_845_1.talkMaxDuration = var_848_6

					if var_848_6 + var_848_0 > arg_845_1.duration_ then
						arg_845_1.duration_ = var_848_6 + var_848_0
					end
				end

				arg_845_1.text_.text = var_848_3
				arg_845_1.typewritter.percent = 0

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(false)
				arg_845_1:RecordContent(arg_845_1.text_.text)
			end

			local var_848_7 = math.max(var_848_1, arg_845_1.talkMaxDuration)

			if var_848_0 <= arg_845_1.time_ and arg_845_1.time_ < var_848_0 + var_848_7 then
				arg_845_1.typewritter.percent = (arg_845_1.time_ - var_848_0) / var_848_7

				arg_845_1.typewritter:SetDirty()
			end

			if arg_845_1.time_ >= var_848_0 + var_848_7 and arg_845_1.time_ < var_848_0 + var_848_7 + arg_848_0 then
				arg_845_1.typewritter.percent = 1

				arg_845_1.typewritter:SetDirty()
				arg_845_1:ShowNextGo(true)
			end
		end

		arg_845_1.nodeConfigList_ = {}

		arg_845_1:InitPlayNodeList()
	end,
	Play1105005211 = function(arg_849_0, arg_849_1)
		arg_849_1.time_ = 0
		arg_849_1.frameCnt_ = 0
		arg_849_1.state_ = "playing"
		arg_849_1.curTalkId_ = 1105005211
		arg_849_1.duration_ = 5

		SetActive(arg_849_1.tipsGo_, false)

		function arg_849_1.onSingleLineFinish_()
			arg_849_1.onSingleLineUpdate_ = nil
			arg_849_1.onSingleLineFinish_ = nil
			arg_849_1.state_ = "waiting"
		end

		function arg_849_1.playNext_(arg_851_0)
			if arg_851_0 == 1 then
				arg_849_0:Play1105005212(arg_849_1)
			end
		end

		function arg_849_1.onSingleLineUpdate_(arg_852_0)
			local var_852_0 = 0
			local var_852_1 = 0.625

			if var_852_0 < arg_849_1.time_ and arg_849_1.time_ <= var_852_0 + arg_852_0 then
				arg_849_1.talkMaxDuration = 0
				arg_849_1.dialogCg_.alpha = 1

				arg_849_1.dialog_:SetActive(true)
				SetActive(arg_849_1.leftNameGo_, false)

				arg_849_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_849_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_849_1:RecordName(arg_849_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_849_1.iconTrs_.gameObject, false)
				arg_849_1.callingController_:SetSelectedState("normal")

				local var_852_2 = arg_849_1:GetWordFromCfg(1105005211)
				local var_852_3 = arg_849_1:FormatText(var_852_2.content)

				arg_849_1.text_.text = var_852_3

				LuaForUtil.ClearLinePrefixSymbol(arg_849_1.text_)

				local var_852_4 = 25
				local var_852_5 = utf8.len(var_852_3)
				local var_852_6 = var_852_4 <= 0 and var_852_1 or var_852_1 * (var_852_5 / var_852_4)

				if var_852_6 > 0 and var_852_1 < var_852_6 then
					arg_849_1.talkMaxDuration = var_852_6

					if var_852_6 + var_852_0 > arg_849_1.duration_ then
						arg_849_1.duration_ = var_852_6 + var_852_0
					end
				end

				arg_849_1.text_.text = var_852_3
				arg_849_1.typewritter.percent = 0

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(false)
				arg_849_1:RecordContent(arg_849_1.text_.text)
			end

			local var_852_7 = math.max(var_852_1, arg_849_1.talkMaxDuration)

			if var_852_0 <= arg_849_1.time_ and arg_849_1.time_ < var_852_0 + var_852_7 then
				arg_849_1.typewritter.percent = (arg_849_1.time_ - var_852_0) / var_852_7

				arg_849_1.typewritter:SetDirty()
			end

			if arg_849_1.time_ >= var_852_0 + var_852_7 and arg_849_1.time_ < var_852_0 + var_852_7 + arg_852_0 then
				arg_849_1.typewritter.percent = 1

				arg_849_1.typewritter:SetDirty()
				arg_849_1:ShowNextGo(true)
			end
		end

		arg_849_1.nodeConfigList_ = {}

		arg_849_1:InitPlayNodeList()
	end,
	Play1105005212 = function(arg_853_0, arg_853_1)
		arg_853_1.time_ = 0
		arg_853_1.frameCnt_ = 0
		arg_853_1.state_ = "playing"
		arg_853_1.curTalkId_ = 1105005212
		arg_853_1.duration_ = 2

		SetActive(arg_853_1.tipsGo_, false)

		function arg_853_1.onSingleLineFinish_()
			arg_853_1.onSingleLineUpdate_ = nil
			arg_853_1.onSingleLineFinish_ = nil
			arg_853_1.state_ = "waiting"
		end

		function arg_853_1.playNext_(arg_855_0)
			if arg_855_0 == 1 then
				arg_853_0:Play1105005213(arg_853_1)
			end
		end

		function arg_853_1.onSingleLineUpdate_(arg_856_0)
			local var_856_0 = arg_853_1.actors_["115001ui_story"].transform
			local var_856_1 = 0

			if var_856_1 < arg_853_1.time_ and arg_853_1.time_ <= var_856_1 + arg_856_0 then
				arg_853_1.var_.moveOldPos115001ui_story = var_856_0.localPosition
			end

			local var_856_2 = 0.001

			if var_856_1 <= arg_853_1.time_ and arg_853_1.time_ < var_856_1 + var_856_2 then
				local var_856_3 = (arg_853_1.time_ - var_856_1) / var_856_2
				local var_856_4 = Vector3.New(0, -1.033, -6.3)

				var_856_0.localPosition = Vector3.Lerp(arg_853_1.var_.moveOldPos115001ui_story, var_856_4, var_856_3)

				local var_856_5 = manager.ui.mainCamera.transform.position - var_856_0.position

				var_856_0.forward = Vector3.New(var_856_5.x, var_856_5.y, var_856_5.z)

				local var_856_6 = var_856_0.localEulerAngles

				var_856_6.z = 0
				var_856_6.x = 0
				var_856_0.localEulerAngles = var_856_6
			end

			if arg_853_1.time_ >= var_856_1 + var_856_2 and arg_853_1.time_ < var_856_1 + var_856_2 + arg_856_0 then
				var_856_0.localPosition = Vector3.New(0, -1.033, -6.3)

				local var_856_7 = manager.ui.mainCamera.transform.position - var_856_0.position

				var_856_0.forward = Vector3.New(var_856_7.x, var_856_7.y, var_856_7.z)

				local var_856_8 = var_856_0.localEulerAngles

				var_856_8.z = 0
				var_856_8.x = 0
				var_856_0.localEulerAngles = var_856_8
			end

			local var_856_9 = arg_853_1.actors_["115001ui_story"]
			local var_856_10 = 0

			if var_856_10 < arg_853_1.time_ and arg_853_1.time_ <= var_856_10 + arg_856_0 and not isNil(var_856_9) and arg_853_1.var_.characterEffect115001ui_story == nil then
				arg_853_1.var_.characterEffect115001ui_story = var_856_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_856_11 = 0.200000002980232

			if var_856_10 <= arg_853_1.time_ and arg_853_1.time_ < var_856_10 + var_856_11 and not isNil(var_856_9) then
				local var_856_12 = (arg_853_1.time_ - var_856_10) / var_856_11

				if arg_853_1.var_.characterEffect115001ui_story and not isNil(var_856_9) then
					arg_853_1.var_.characterEffect115001ui_story.fillFlat = false
				end
			end

			if arg_853_1.time_ >= var_856_10 + var_856_11 and arg_853_1.time_ < var_856_10 + var_856_11 + arg_856_0 and not isNil(var_856_9) and arg_853_1.var_.characterEffect115001ui_story then
				arg_853_1.var_.characterEffect115001ui_story.fillFlat = false
			end

			local var_856_13 = 0

			if var_856_13 < arg_853_1.time_ and arg_853_1.time_ <= var_856_13 + arg_856_0 then
				arg_853_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			local var_856_14 = 0

			if var_856_14 < arg_853_1.time_ and arg_853_1.time_ <= var_856_14 + arg_856_0 then
				arg_853_1:PlayTimeline("115001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_856_15 = 0
			local var_856_16 = 0.2

			if var_856_15 < arg_853_1.time_ and arg_853_1.time_ <= var_856_15 + arg_856_0 then
				arg_853_1.talkMaxDuration = 0
				arg_853_1.dialogCg_.alpha = 1

				arg_853_1.dialog_:SetActive(true)
				SetActive(arg_853_1.leftNameGo_, true)

				local var_856_17 = arg_853_1:FormatText(StoryNameCfg[74].name)

				arg_853_1.leftNameTxt_.text = var_856_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_853_1.leftNameTxt_.transform)

				arg_853_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_853_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_853_1:RecordName(arg_853_1.leftNameTxt_.text)
				SetActive(arg_853_1.iconTrs_.gameObject, false)
				arg_853_1.callingController_:SetSelectedState("normal")

				local var_856_18 = arg_853_1:GetWordFromCfg(1105005212)
				local var_856_19 = arg_853_1:FormatText(var_856_18.content)

				arg_853_1.text_.text = var_856_19

				LuaForUtil.ClearLinePrefixSymbol(arg_853_1.text_)

				local var_856_20 = 8
				local var_856_21 = utf8.len(var_856_19)
				local var_856_22 = var_856_20 <= 0 and var_856_16 or var_856_16 * (var_856_21 / var_856_20)

				if var_856_22 > 0 and var_856_16 < var_856_22 then
					arg_853_1.talkMaxDuration = var_856_22

					if var_856_22 + var_856_15 > arg_853_1.duration_ then
						arg_853_1.duration_ = var_856_22 + var_856_15
					end
				end

				arg_853_1.text_.text = var_856_19
				arg_853_1.typewritter.percent = 0

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005212", "story_v_side_new_1105005.awb") ~= 0 then
					local var_856_23 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005212", "story_v_side_new_1105005.awb") / 1000

					if var_856_23 + var_856_15 > arg_853_1.duration_ then
						arg_853_1.duration_ = var_856_23 + var_856_15
					end

					if var_856_18.prefab_name ~= "" and arg_853_1.actors_[var_856_18.prefab_name] ~= nil then
						local var_856_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_853_1.actors_[var_856_18.prefab_name].transform, "story_v_side_new_1105005", "1105005212", "story_v_side_new_1105005.awb")

						arg_853_1:RecordAudio("1105005212", var_856_24)
						arg_853_1:RecordAudio("1105005212", var_856_24)
					else
						arg_853_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005212", "story_v_side_new_1105005.awb")
					end

					arg_853_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005212", "story_v_side_new_1105005.awb")
				end

				arg_853_1:RecordContent(arg_853_1.text_.text)
			end

			local var_856_25 = math.max(var_856_16, arg_853_1.talkMaxDuration)

			if var_856_15 <= arg_853_1.time_ and arg_853_1.time_ < var_856_15 + var_856_25 then
				arg_853_1.typewritter.percent = (arg_853_1.time_ - var_856_15) / var_856_25

				arg_853_1.typewritter:SetDirty()
			end

			if arg_853_1.time_ >= var_856_15 + var_856_25 and arg_853_1.time_ < var_856_15 + var_856_25 + arg_856_0 then
				arg_853_1.typewritter.percent = 1

				arg_853_1.typewritter:SetDirty()
				arg_853_1:ShowNextGo(true)
			end
		end

		arg_853_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "115001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_853_1:InitPlayNodeList()
	end,
	Play1105005213 = function(arg_857_0, arg_857_1)
		arg_857_1.time_ = 0
		arg_857_1.frameCnt_ = 0
		arg_857_1.state_ = "playing"
		arg_857_1.curTalkId_ = 1105005213
		arg_857_1.duration_ = 5

		SetActive(arg_857_1.tipsGo_, false)

		function arg_857_1.onSingleLineFinish_()
			arg_857_1.onSingleLineUpdate_ = nil
			arg_857_1.onSingleLineFinish_ = nil
			arg_857_1.state_ = "waiting"
			arg_857_1.auto_ = false
		end

		function arg_857_1.playNext_(arg_859_0)
			arg_857_1.onStoryFinished_()
		end

		function arg_857_1.onSingleLineUpdate_(arg_860_0)
			local var_860_0 = arg_857_1.actors_["115001ui_story"]
			local var_860_1 = 0

			if var_860_1 < arg_857_1.time_ and arg_857_1.time_ <= var_860_1 + arg_860_0 and not isNil(var_860_0) and arg_857_1.var_.characterEffect115001ui_story == nil then
				arg_857_1.var_.characterEffect115001ui_story = var_860_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_860_2 = 0.200000002980232

			if var_860_1 <= arg_857_1.time_ and arg_857_1.time_ < var_860_1 + var_860_2 and not isNil(var_860_0) then
				local var_860_3 = (arg_857_1.time_ - var_860_1) / var_860_2

				if arg_857_1.var_.characterEffect115001ui_story and not isNil(var_860_0) then
					local var_860_4 = Mathf.Lerp(0, 0.5, var_860_3)

					arg_857_1.var_.characterEffect115001ui_story.fillFlat = true
					arg_857_1.var_.characterEffect115001ui_story.fillRatio = var_860_4
				end
			end

			if arg_857_1.time_ >= var_860_1 + var_860_2 and arg_857_1.time_ < var_860_1 + var_860_2 + arg_860_0 and not isNil(var_860_0) and arg_857_1.var_.characterEffect115001ui_story then
				local var_860_5 = 0.5

				arg_857_1.var_.characterEffect115001ui_story.fillFlat = true
				arg_857_1.var_.characterEffect115001ui_story.fillRatio = var_860_5
			end

			local var_860_6 = 0
			local var_860_7 = 0.425

			if var_860_6 < arg_857_1.time_ and arg_857_1.time_ <= var_860_6 + arg_860_0 then
				arg_857_1.talkMaxDuration = 0
				arg_857_1.dialogCg_.alpha = 1

				arg_857_1.dialog_:SetActive(true)
				SetActive(arg_857_1.leftNameGo_, true)

				local var_860_8 = arg_857_1:FormatText(StoryNameCfg[7].name)

				arg_857_1.leftNameTxt_.text = var_860_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_857_1.leftNameTxt_.transform)

				arg_857_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_857_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_857_1:RecordName(arg_857_1.leftNameTxt_.text)
				SetActive(arg_857_1.iconTrs_.gameObject, true)
				arg_857_1.iconController_:SetSelectedState("hero")

				arg_857_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_857_1.callingController_:SetSelectedState("normal")

				arg_857_1.keyicon_.color = Color.New(1, 1, 1)
				arg_857_1.icon_.color = Color.New(1, 1, 1)

				local var_860_9 = arg_857_1:GetWordFromCfg(1105005213)
				local var_860_10 = arg_857_1:FormatText(var_860_9.content)

				arg_857_1.text_.text = var_860_10

				LuaForUtil.ClearLinePrefixSymbol(arg_857_1.text_)

				local var_860_11 = 17
				local var_860_12 = utf8.len(var_860_10)
				local var_860_13 = var_860_11 <= 0 and var_860_7 or var_860_7 * (var_860_12 / var_860_11)

				if var_860_13 > 0 and var_860_7 < var_860_13 then
					arg_857_1.talkMaxDuration = var_860_13

					if var_860_13 + var_860_6 > arg_857_1.duration_ then
						arg_857_1.duration_ = var_860_13 + var_860_6
					end
				end

				arg_857_1.text_.text = var_860_10
				arg_857_1.typewritter.percent = 0

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(false)
				arg_857_1:RecordContent(arg_857_1.text_.text)
			end

			local var_860_14 = math.max(var_860_7, arg_857_1.talkMaxDuration)

			if var_860_6 <= arg_857_1.time_ and arg_857_1.time_ < var_860_6 + var_860_14 then
				arg_857_1.typewritter.percent = (arg_857_1.time_ - var_860_6) / var_860_14

				arg_857_1.typewritter:SetDirty()
			end

			if arg_857_1.time_ >= var_860_6 + var_860_14 and arg_857_1.time_ < var_860_6 + var_860_14 + arg_860_0 then
				arg_857_1.typewritter.percent = 1

				arg_857_1.typewritter:SetDirty()
				arg_857_1:ShowNextGo(true)
			end
		end

		arg_857_1.nodeConfigList_ = {}

		arg_857_1:InitPlayNodeList()
	end,
	Play1105005018 = function(arg_861_0, arg_861_1)
		arg_861_1.time_ = 0
		arg_861_1.frameCnt_ = 0
		arg_861_1.state_ = "playing"
		arg_861_1.curTalkId_ = 1105005018
		arg_861_1.duration_ = 2

		SetActive(arg_861_1.tipsGo_, false)

		function arg_861_1.onSingleLineFinish_()
			arg_861_1.onSingleLineUpdate_ = nil
			arg_861_1.onSingleLineFinish_ = nil
			arg_861_1.state_ = "waiting"
		end

		function arg_861_1.playNext_(arg_863_0)
			if arg_863_0 == 1 then
				arg_861_0:Play1105005019(arg_861_1)
			end
		end

		function arg_861_1.onSingleLineUpdate_(arg_864_0)
			local var_864_0 = arg_861_1.actors_["1150ui_story"]
			local var_864_1 = 0

			if var_864_1 < arg_861_1.time_ and arg_861_1.time_ <= var_864_1 + arg_864_0 and not isNil(var_864_0) and arg_861_1.var_.characterEffect1150ui_story == nil then
				arg_861_1.var_.characterEffect1150ui_story = var_864_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_864_2 = 0.200000002980232

			if var_864_1 <= arg_861_1.time_ and arg_861_1.time_ < var_864_1 + var_864_2 and not isNil(var_864_0) then
				local var_864_3 = (arg_861_1.time_ - var_864_1) / var_864_2

				if arg_861_1.var_.characterEffect1150ui_story and not isNil(var_864_0) then
					arg_861_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_861_1.time_ >= var_864_1 + var_864_2 and arg_861_1.time_ < var_864_1 + var_864_2 + arg_864_0 and not isNil(var_864_0) and arg_861_1.var_.characterEffect1150ui_story then
				arg_861_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_864_4 = "1150ui_story"

			if arg_861_1.actors_[var_864_4] == nil then
				local var_864_5 = Asset.Load("Char/" .. "1150ui_story")

				if not isNil(var_864_5) then
					local var_864_6 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_861_1.stage_.transform)

					var_864_6.name = var_864_4
					var_864_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_861_1.actors_[var_864_4] = var_864_6

					local var_864_7 = var_864_6:GetComponentInChildren(typeof(CharacterEffect))

					var_864_7.enabled = true

					local var_864_8 = GameObjectTools.GetOrAddComponent(var_864_6, typeof(DynamicBoneHelper))

					if var_864_8 then
						var_864_8:EnableDynamicBone(false)
					end

					arg_861_1:ShowWeapon(var_864_7.transform, false)

					arg_861_1.var_[var_864_4 .. "Animator"] = var_864_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_861_1.var_[var_864_4 .. "Animator"].applyRootMotion = true
					arg_861_1.var_[var_864_4 .. "LipSync"] = var_864_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_864_9 = 0

			if var_864_9 < arg_861_1.time_ and arg_861_1.time_ <= var_864_9 + arg_864_0 then
				arg_861_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_864_10 = arg_861_1.actors_["1150ui_story"].transform
			local var_864_11 = 0

			if var_864_11 < arg_861_1.time_ and arg_861_1.time_ <= var_864_11 + arg_864_0 then
				arg_861_1.var_.moveOldPos1150ui_story = var_864_10.localPosition

				local var_864_12 = "1150ui_story"

				arg_861_1:ShowWeapon(arg_861_1.var_[var_864_12 .. "Animator"].transform, false)
			end

			local var_864_13 = 0.001

			if var_864_11 <= arg_861_1.time_ and arg_861_1.time_ < var_864_11 + var_864_13 then
				local var_864_14 = (arg_861_1.time_ - var_864_11) / var_864_13
				local var_864_15 = Vector3.New(0, -1.01, -6.2)

				var_864_10.localPosition = Vector3.Lerp(arg_861_1.var_.moveOldPos1150ui_story, var_864_15, var_864_14)

				local var_864_16 = manager.ui.mainCamera.transform.position - var_864_10.position

				var_864_10.forward = Vector3.New(var_864_16.x, var_864_16.y, var_864_16.z)

				local var_864_17 = var_864_10.localEulerAngles

				var_864_17.z = 0
				var_864_17.x = 0
				var_864_10.localEulerAngles = var_864_17
			end

			if arg_861_1.time_ >= var_864_11 + var_864_13 and arg_861_1.time_ < var_864_11 + var_864_13 + arg_864_0 then
				var_864_10.localPosition = Vector3.New(0, -1.01, -6.2)

				local var_864_18 = manager.ui.mainCamera.transform.position - var_864_10.position

				var_864_10.forward = Vector3.New(var_864_18.x, var_864_18.y, var_864_18.z)

				local var_864_19 = var_864_10.localEulerAngles

				var_864_19.z = 0
				var_864_19.x = 0
				var_864_10.localEulerAngles = var_864_19
			end

			local var_864_20 = 0
			local var_864_21 = 0.1

			if var_864_20 < arg_861_1.time_ and arg_861_1.time_ <= var_864_20 + arg_864_0 then
				arg_861_1.talkMaxDuration = 0
				arg_861_1.dialogCg_.alpha = 1

				arg_861_1.dialog_:SetActive(true)
				SetActive(arg_861_1.leftNameGo_, true)

				local var_864_22 = arg_861_1:FormatText(StoryNameCfg[74].name)

				arg_861_1.leftNameTxt_.text = var_864_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_861_1.leftNameTxt_.transform)

				arg_861_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_861_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_861_1:RecordName(arg_861_1.leftNameTxt_.text)
				SetActive(arg_861_1.iconTrs_.gameObject, false)
				arg_861_1.callingController_:SetSelectedState("normal")

				local var_864_23 = arg_861_1:GetWordFromCfg(1105005018)
				local var_864_24 = arg_861_1:FormatText(var_864_23.content)

				arg_861_1.text_.text = var_864_24

				LuaForUtil.ClearLinePrefixSymbol(arg_861_1.text_)

				local var_864_25 = 4
				local var_864_26 = utf8.len(var_864_24)
				local var_864_27 = var_864_25 <= 0 and var_864_21 or var_864_21 * (var_864_26 / var_864_25)

				if var_864_27 > 0 and var_864_21 < var_864_27 then
					arg_861_1.talkMaxDuration = var_864_27

					if var_864_27 + var_864_20 > arg_861_1.duration_ then
						arg_861_1.duration_ = var_864_27 + var_864_20
					end
				end

				arg_861_1.text_.text = var_864_24
				arg_861_1.typewritter.percent = 0

				arg_861_1.typewritter:SetDirty()
				arg_861_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005018", "story_v_side_new_1105005.awb") ~= 0 then
					local var_864_28 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005018", "story_v_side_new_1105005.awb") / 1000

					if var_864_28 + var_864_20 > arg_861_1.duration_ then
						arg_861_1.duration_ = var_864_28 + var_864_20
					end

					if var_864_23.prefab_name ~= "" and arg_861_1.actors_[var_864_23.prefab_name] ~= nil then
						local var_864_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_861_1.actors_[var_864_23.prefab_name].transform, "story_v_side_new_1105005", "1105005018", "story_v_side_new_1105005.awb")

						arg_861_1:RecordAudio("1105005018", var_864_29)
						arg_861_1:RecordAudio("1105005018", var_864_29)
					else
						arg_861_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005018", "story_v_side_new_1105005.awb")
					end

					arg_861_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005018", "story_v_side_new_1105005.awb")
				end

				arg_861_1:RecordContent(arg_861_1.text_.text)
			end

			local var_864_30 = math.max(var_864_21, arg_861_1.talkMaxDuration)

			if var_864_20 <= arg_861_1.time_ and arg_861_1.time_ < var_864_20 + var_864_30 then
				arg_861_1.typewritter.percent = (arg_861_1.time_ - var_864_20) / var_864_30

				arg_861_1.typewritter:SetDirty()
			end

			if arg_861_1.time_ >= var_864_20 + var_864_30 and arg_861_1.time_ < var_864_20 + var_864_30 + arg_864_0 then
				arg_861_1.typewritter.percent = 1

				arg_861_1.typewritter:SetDirty()
				arg_861_1:ShowNextGo(true)
			end
		end

		arg_861_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_861_1:InitPlayNodeList()
	end,
	Play1105005019 = function(arg_865_0, arg_865_1)
		arg_865_1.time_ = 0
		arg_865_1.frameCnt_ = 0
		arg_865_1.state_ = "playing"
		arg_865_1.curTalkId_ = 1105005019
		arg_865_1.duration_ = 5

		SetActive(arg_865_1.tipsGo_, false)

		function arg_865_1.onSingleLineFinish_()
			arg_865_1.onSingleLineUpdate_ = nil
			arg_865_1.onSingleLineFinish_ = nil
			arg_865_1.state_ = "waiting"
		end

		function arg_865_1.playNext_(arg_867_0)
			if arg_867_0 == 1 then
				arg_865_0:Play1105005020(arg_865_1)
			end
		end

		function arg_865_1.onSingleLineUpdate_(arg_868_0)
			local var_868_0 = arg_865_1.actors_["1150ui_story"]
			local var_868_1 = 0

			if var_868_1 < arg_865_1.time_ and arg_865_1.time_ <= var_868_1 + arg_868_0 and not isNil(var_868_0) and arg_865_1.var_.characterEffect1150ui_story == nil then
				arg_865_1.var_.characterEffect1150ui_story = var_868_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_868_2 = 0.200000002980232

			if var_868_1 <= arg_865_1.time_ and arg_865_1.time_ < var_868_1 + var_868_2 and not isNil(var_868_0) then
				local var_868_3 = (arg_865_1.time_ - var_868_1) / var_868_2

				if arg_865_1.var_.characterEffect1150ui_story and not isNil(var_868_0) then
					local var_868_4 = Mathf.Lerp(0, 0.5, var_868_3)

					arg_865_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_865_1.var_.characterEffect1150ui_story.fillRatio = var_868_4
				end
			end

			if arg_865_1.time_ >= var_868_1 + var_868_2 and arg_865_1.time_ < var_868_1 + var_868_2 + arg_868_0 and not isNil(var_868_0) and arg_865_1.var_.characterEffect1150ui_story then
				local var_868_5 = 0.5

				arg_865_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_865_1.var_.characterEffect1150ui_story.fillRatio = var_868_5
			end

			local var_868_6 = 0
			local var_868_7 = 0.725

			if var_868_6 < arg_865_1.time_ and arg_865_1.time_ <= var_868_6 + arg_868_0 then
				arg_865_1.talkMaxDuration = 0
				arg_865_1.dialogCg_.alpha = 1

				arg_865_1.dialog_:SetActive(true)
				SetActive(arg_865_1.leftNameGo_, false)

				arg_865_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_865_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_865_1:RecordName(arg_865_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_865_1.iconTrs_.gameObject, false)
				arg_865_1.callingController_:SetSelectedState("normal")

				local var_868_8 = arg_865_1:GetWordFromCfg(1105005019)
				local var_868_9 = arg_865_1:FormatText(var_868_8.content)

				arg_865_1.text_.text = var_868_9

				LuaForUtil.ClearLinePrefixSymbol(arg_865_1.text_)

				local var_868_10 = 29
				local var_868_11 = utf8.len(var_868_9)
				local var_868_12 = var_868_10 <= 0 and var_868_7 or var_868_7 * (var_868_11 / var_868_10)

				if var_868_12 > 0 and var_868_7 < var_868_12 then
					arg_865_1.talkMaxDuration = var_868_12

					if var_868_12 + var_868_6 > arg_865_1.duration_ then
						arg_865_1.duration_ = var_868_12 + var_868_6
					end
				end

				arg_865_1.text_.text = var_868_9
				arg_865_1.typewritter.percent = 0

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(false)
				arg_865_1:RecordContent(arg_865_1.text_.text)
			end

			local var_868_13 = math.max(var_868_7, arg_865_1.talkMaxDuration)

			if var_868_6 <= arg_865_1.time_ and arg_865_1.time_ < var_868_6 + var_868_13 then
				arg_865_1.typewritter.percent = (arg_865_1.time_ - var_868_6) / var_868_13

				arg_865_1.typewritter:SetDirty()
			end

			if arg_865_1.time_ >= var_868_6 + var_868_13 and arg_865_1.time_ < var_868_6 + var_868_13 + arg_868_0 then
				arg_865_1.typewritter.percent = 1

				arg_865_1.typewritter:SetDirty()
				arg_865_1:ShowNextGo(true)
			end
		end

		arg_865_1.nodeConfigList_ = {}

		arg_865_1:InitPlayNodeList()
	end,
	Play1105005020 = function(arg_869_0, arg_869_1)
		arg_869_1.time_ = 0
		arg_869_1.frameCnt_ = 0
		arg_869_1.state_ = "playing"
		arg_869_1.curTalkId_ = 1105005020
		arg_869_1.duration_ = 4.97

		SetActive(arg_869_1.tipsGo_, false)

		function arg_869_1.onSingleLineFinish_()
			arg_869_1.onSingleLineUpdate_ = nil
			arg_869_1.onSingleLineFinish_ = nil
			arg_869_1.state_ = "waiting"
		end

		function arg_869_1.playNext_(arg_871_0)
			if arg_871_0 == 1 then
				arg_869_0:Play1105005021(arg_869_1)
			end
		end

		function arg_869_1.onSingleLineUpdate_(arg_872_0)
			local var_872_0 = arg_869_1.actors_["1150ui_story"]
			local var_872_1 = 0

			if var_872_1 < arg_869_1.time_ and arg_869_1.time_ <= var_872_1 + arg_872_0 and not isNil(var_872_0) and arg_869_1.var_.characterEffect1150ui_story == nil then
				arg_869_1.var_.characterEffect1150ui_story = var_872_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_872_2 = 0.200000002980232

			if var_872_1 <= arg_869_1.time_ and arg_869_1.time_ < var_872_1 + var_872_2 and not isNil(var_872_0) then
				local var_872_3 = (arg_869_1.time_ - var_872_1) / var_872_2

				if arg_869_1.var_.characterEffect1150ui_story and not isNil(var_872_0) then
					arg_869_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_869_1.time_ >= var_872_1 + var_872_2 and arg_869_1.time_ < var_872_1 + var_872_2 + arg_872_0 and not isNil(var_872_0) and arg_869_1.var_.characterEffect1150ui_story then
				arg_869_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_872_4 = 0
			local var_872_5 = 0.275

			if var_872_4 < arg_869_1.time_ and arg_869_1.time_ <= var_872_4 + arg_872_0 then
				arg_869_1.talkMaxDuration = 0
				arg_869_1.dialogCg_.alpha = 1

				arg_869_1.dialog_:SetActive(true)
				SetActive(arg_869_1.leftNameGo_, true)

				local var_872_6 = arg_869_1:FormatText(StoryNameCfg[74].name)

				arg_869_1.leftNameTxt_.text = var_872_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_869_1.leftNameTxt_.transform)

				arg_869_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_869_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_869_1:RecordName(arg_869_1.leftNameTxt_.text)
				SetActive(arg_869_1.iconTrs_.gameObject, false)
				arg_869_1.callingController_:SetSelectedState("normal")

				local var_872_7 = arg_869_1:GetWordFromCfg(1105005020)
				local var_872_8 = arg_869_1:FormatText(var_872_7.content)

				arg_869_1.text_.text = var_872_8

				LuaForUtil.ClearLinePrefixSymbol(arg_869_1.text_)

				local var_872_9 = 11
				local var_872_10 = utf8.len(var_872_8)
				local var_872_11 = var_872_9 <= 0 and var_872_5 or var_872_5 * (var_872_10 / var_872_9)

				if var_872_11 > 0 and var_872_5 < var_872_11 then
					arg_869_1.talkMaxDuration = var_872_11

					if var_872_11 + var_872_4 > arg_869_1.duration_ then
						arg_869_1.duration_ = var_872_11 + var_872_4
					end
				end

				arg_869_1.text_.text = var_872_8
				arg_869_1.typewritter.percent = 0

				arg_869_1.typewritter:SetDirty()
				arg_869_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005020", "story_v_side_new_1105005.awb") ~= 0 then
					local var_872_12 = manager.audio:GetVoiceLength("story_v_side_new_1105005", "1105005020", "story_v_side_new_1105005.awb") / 1000

					if var_872_12 + var_872_4 > arg_869_1.duration_ then
						arg_869_1.duration_ = var_872_12 + var_872_4
					end

					if var_872_7.prefab_name ~= "" and arg_869_1.actors_[var_872_7.prefab_name] ~= nil then
						local var_872_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_869_1.actors_[var_872_7.prefab_name].transform, "story_v_side_new_1105005", "1105005020", "story_v_side_new_1105005.awb")

						arg_869_1:RecordAudio("1105005020", var_872_13)
						arg_869_1:RecordAudio("1105005020", var_872_13)
					else
						arg_869_1:AudioAction("play", "voice", "story_v_side_new_1105005", "1105005020", "story_v_side_new_1105005.awb")
					end

					arg_869_1:RecordHistoryTalkVoice("story_v_side_new_1105005", "1105005020", "story_v_side_new_1105005.awb")
				end

				arg_869_1:RecordContent(arg_869_1.text_.text)
			end

			local var_872_14 = math.max(var_872_5, arg_869_1.talkMaxDuration)

			if var_872_4 <= arg_869_1.time_ and arg_869_1.time_ < var_872_4 + var_872_14 then
				arg_869_1.typewritter.percent = (arg_869_1.time_ - var_872_4) / var_872_14

				arg_869_1.typewritter:SetDirty()
			end

			if arg_869_1.time_ >= var_872_4 + var_872_14 and arg_869_1.time_ < var_872_4 + var_872_14 + arg_872_0 then
				arg_869_1.typewritter.percent = 1

				arg_869_1.typewritter:SetDirty()
				arg_869_1:ShowNextGo(true)
			end
		end

		arg_869_1.nodeConfigList_ = {}

		arg_869_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/R5001a",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/ST68",
		"TextureConfig/Background/ST11"
	},
	voices = {
		"story_v_side_new_1105005.awb"
	}
}
