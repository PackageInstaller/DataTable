return {
	Play116421001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116421001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116421002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I06e"

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
				local var_4_5 = arg_1_1.bgs_.I06e

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
					if iter_4_0 ~= "I06e" then
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
			local var_4_23 = 0.666666666666667

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

			local var_4_28 = 0.866666666666667
			local var_4_29 = 1.13333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 2
			local var_4_35 = 0.925

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(116421001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 37
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116421002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116421002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116421003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.125

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(116421002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 45
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play116421003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116421003
		arg_13_1.duration_ = 7.33

		local var_13_0 = {
			zh = 6.166,
			ja = 7.333
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
				arg_13_0:Play116421004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.8

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[264].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(116421003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421003", "story_v_out_116421.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421003", "story_v_out_116421.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_116421", "116421003", "story_v_out_116421.awb")

						arg_13_1:RecordAudio("116421003", var_16_9)
						arg_13_1:RecordAudio("116421003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_116421", "116421003", "story_v_out_116421.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_116421", "116421003", "story_v_out_116421.awb")
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
	Play116421004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116421004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116421005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10014ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["10014ui_story"]
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10014ui_story == nil then
				arg_17_1.var_.characterEffect10014ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_7 = 0.034

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 and not isNil(var_20_5) then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7

				if arg_17_1.var_.characterEffect10014ui_story and not isNil(var_20_5) then
					local var_20_9 = Mathf.Lerp(0, 0.5, var_20_8)

					arg_17_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10014ui_story.fillRatio = var_20_9
				end
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10014ui_story then
				local var_20_10 = 0.5

				arg_17_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10014ui_story.fillRatio = var_20_10
			end

			local var_20_11 = 0
			local var_20_12 = 0.825

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(116421004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 35
				local var_20_16 = utf8.len(var_20_14)
				local var_20_17 = var_20_15 <= 0 and var_20_12 or var_20_12 * (var_20_16 / var_20_15)

				if var_20_17 > 0 and var_20_12 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_18 and arg_17_1.time_ < var_20_11 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116421005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116421005
		arg_21_1.duration_ = 3

		local var_21_0 = {
			zh = 3,
			ja = 2.633333333332
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
				arg_21_0:Play116421006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1029ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1029ui_story"]
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_7 = 0.2

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 and not isNil(var_24_5) then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_24_11 = arg_21_1.actors_["1029ui_story"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos1029ui_story = var_24_11.localPosition
			end

			local var_24_13 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13
				local var_24_15 = Vector3.New(-0.7, -1.09, -6.2)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1029ui_story, var_24_15, var_24_14)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_11.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_11.localEulerAngles = var_24_17
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_24_18 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_18.x, var_24_18.y, var_24_18.z)

				local var_24_19 = var_24_11.localEulerAngles

				var_24_19.z = 0
				var_24_19.x = 0
				var_24_11.localEulerAngles = var_24_19
			end

			local var_24_20 = arg_21_1.actors_["10014ui_story"]
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect10014ui_story == nil then
				arg_21_1.var_.characterEffect10014ui_story = var_24_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_22 = 0.034

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 and not isNil(var_24_20) then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22

				if arg_21_1.var_.characterEffect10014ui_story and not isNil(var_24_20) then
					local var_24_24 = Mathf.Lerp(0, 0.5, var_24_23)

					arg_21_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10014ui_story.fillRatio = var_24_24
				end
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect10014ui_story then
				local var_24_25 = 0.5

				arg_21_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10014ui_story.fillRatio = var_24_25
			end

			local var_24_26 = 0

			if var_24_26 < arg_21_1.time_ and arg_21_1.time_ <= var_24_26 + arg_24_0 then
				arg_21_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_24_27 = 0
			local var_24_28 = 0.175

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_29 = arg_21_1:FormatText(StoryNameCfg[319].name)

				arg_21_1.leftNameTxt_.text = var_24_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_30 = arg_21_1:GetWordFromCfg(116421005)
				local var_24_31 = arg_21_1:FormatText(var_24_30.content)

				arg_21_1.text_.text = var_24_31

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_32 = 7
				local var_24_33 = utf8.len(var_24_31)
				local var_24_34 = var_24_32 <= 0 and var_24_28 or var_24_28 * (var_24_33 / var_24_32)

				if var_24_34 > 0 and var_24_28 < var_24_34 then
					arg_21_1.talkMaxDuration = var_24_34

					if var_24_34 + var_24_27 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_34 + var_24_27
					end
				end

				arg_21_1.text_.text = var_24_31
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421005", "story_v_out_116421.awb") ~= 0 then
					local var_24_35 = manager.audio:GetVoiceLength("story_v_out_116421", "116421005", "story_v_out_116421.awb") / 1000

					if var_24_35 + var_24_27 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_35 + var_24_27
					end

					if var_24_30.prefab_name ~= "" and arg_21_1.actors_[var_24_30.prefab_name] ~= nil then
						local var_24_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_30.prefab_name].transform, "story_v_out_116421", "116421005", "story_v_out_116421.awb")

						arg_21_1:RecordAudio("116421005", var_24_36)
						arg_21_1:RecordAudio("116421005", var_24_36)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116421", "116421005", "story_v_out_116421.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116421", "116421005", "story_v_out_116421.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_37 = math.max(var_24_28, arg_21_1.talkMaxDuration)

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_37 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_27) / var_24_37

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_27 + var_24_37 and arg_21_1.time_ < var_24_27 + var_24_37 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play116421006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116421006
		arg_25_1.duration_ = 7.97

		local var_25_0 = {
			zh = 4.6,
			ja = 7.966
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
				arg_25_0:Play116421007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10014ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10014ui_story == nil then
				arg_25_1.var_.characterEffect10014ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect10014ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10014ui_story then
				arg_25_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["1029ui_story"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.2

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_4) then
					local var_28_8 = Mathf.Lerp(0, 0.5, var_28_7)

					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_8
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1029ui_story then
				local var_28_9 = 0.5

				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = var_28_9
			end

			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_28_11 = 0

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_28_12 = arg_25_1.actors_["10014ui_story"].transform
			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1.var_.moveOldPos10014ui_story = var_28_12.localPosition
			end

			local var_28_14 = 0.001

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_14 then
				local var_28_15 = (arg_25_1.time_ - var_28_13) / var_28_14
				local var_28_16 = Vector3.New(0.7, -1.06, -6.2)

				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10014ui_story, var_28_16, var_28_15)

				local var_28_17 = manager.ui.mainCamera.transform.position - var_28_12.position

				var_28_12.forward = Vector3.New(var_28_17.x, var_28_17.y, var_28_17.z)

				local var_28_18 = var_28_12.localEulerAngles

				var_28_18.z = 0
				var_28_18.x = 0
				var_28_12.localEulerAngles = var_28_18
			end

			if arg_25_1.time_ >= var_28_13 + var_28_14 and arg_25_1.time_ < var_28_13 + var_28_14 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_28_19 = manager.ui.mainCamera.transform.position - var_28_12.position

				var_28_12.forward = Vector3.New(var_28_19.x, var_28_19.y, var_28_19.z)

				local var_28_20 = var_28_12.localEulerAngles

				var_28_20.z = 0
				var_28_20.x = 0
				var_28_12.localEulerAngles = var_28_20
			end

			local var_28_21 = 0
			local var_28_22 = 0.575

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[264].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(116421006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 23
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_22 or var_28_22 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_22 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421006", "story_v_out_116421.awb") ~= 0 then
					local var_28_29 = manager.audio:GetVoiceLength("story_v_out_116421", "116421006", "story_v_out_116421.awb") / 1000

					if var_28_29 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_116421", "116421006", "story_v_out_116421.awb")

						arg_25_1:RecordAudio("116421006", var_28_30)
						arg_25_1:RecordAudio("116421006", var_28_30)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_116421", "116421006", "story_v_out_116421.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_116421", "116421006", "story_v_out_116421.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_21) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_21 + var_28_31 and arg_25_1.time_ < var_28_21 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play116421007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116421007
		arg_29_1.duration_ = 5.47

		local var_29_0 = {
			zh = 5.466,
			ja = 4
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
				arg_29_0:Play116421008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1029ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1029ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_5 = arg_29_1.actors_["10014ui_story"]
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10014ui_story == nil then
				arg_29_1.var_.characterEffect10014ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.2

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 and not isNil(var_32_5) then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7

				if arg_29_1.var_.characterEffect10014ui_story and not isNil(var_32_5) then
					local var_32_9 = Mathf.Lerp(0, 0.5, var_32_8)

					arg_29_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10014ui_story.fillRatio = var_32_9
				end
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10014ui_story then
				local var_32_10 = 0.5

				arg_29_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10014ui_story.fillRatio = var_32_10
			end

			local var_32_11 = 0
			local var_32_12 = 0.575

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(116421007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 23
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421007", "story_v_out_116421.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_116421", "116421007", "story_v_out_116421.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_116421", "116421007", "story_v_out_116421.awb")

						arg_29_1:RecordAudio("116421007", var_32_20)
						arg_29_1:RecordAudio("116421007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_116421", "116421007", "story_v_out_116421.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_116421", "116421007", "story_v_out_116421.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116421008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116421008
		arg_33_1.duration_ = 10.4

		local var_33_0 = {
			zh = 7.566,
			ja = 10.4
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
				arg_33_0:Play116421009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10014ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10014ui_story == nil then
				arg_33_1.var_.characterEffect10014ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10014ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10014ui_story then
				arg_33_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1029ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.2

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect1029ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1029ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1029ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1029ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_36_11 = 0
			local var_36_12 = 0.95

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[264].name)

				arg_33_1.leftNameTxt_.text = var_36_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(116421008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 38
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421008", "story_v_out_116421.awb") ~= 0 then
					local var_36_19 = manager.audio:GetVoiceLength("story_v_out_116421", "116421008", "story_v_out_116421.awb") / 1000

					if var_36_19 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_11
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_116421", "116421008", "story_v_out_116421.awb")

						arg_33_1:RecordAudio("116421008", var_36_20)
						arg_33_1:RecordAudio("116421008", var_36_20)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116421", "116421008", "story_v_out_116421.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116421", "116421008", "story_v_out_116421.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_21 and arg_33_1.time_ < var_36_11 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116421009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116421009
		arg_37_1.duration_ = 5.87

		local var_37_0 = {
			zh = 5.866,
			ja = 4.866
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
				arg_37_0:Play116421010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action425")
			end

			local var_40_2 = 0
			local var_40_3 = 0.8

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_4 = arg_37_1:FormatText(StoryNameCfg[264].name)

				arg_37_1.leftNameTxt_.text = var_40_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(116421009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 32
				local var_40_8 = utf8.len(var_40_6)
				local var_40_9 = var_40_7 <= 0 and var_40_3 or var_40_3 * (var_40_8 / var_40_7)

				if var_40_9 > 0 and var_40_3 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421009", "story_v_out_116421.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_116421", "116421009", "story_v_out_116421.awb") / 1000

					if var_40_10 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_2
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_out_116421", "116421009", "story_v_out_116421.awb")

						arg_37_1:RecordAudio("116421009", var_40_11)
						arg_37_1:RecordAudio("116421009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116421", "116421009", "story_v_out_116421.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116421", "116421009", "story_v_out_116421.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_12 and arg_37_1.time_ < var_40_2 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116421010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116421010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116421011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10014ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10014ui_story == nil then
				arg_41_1.var_.characterEffect10014ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10014ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10014ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10014ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10014ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.55

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(116421010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 22
				local var_44_11 = utf8.len(var_44_9)
				local var_44_12 = var_44_10 <= 0 and var_44_7 or var_44_7 * (var_44_11 / var_44_10)

				if var_44_12 > 0 and var_44_7 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_13 and arg_41_1.time_ < var_44_6 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play116421011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116421011
		arg_45_1.duration_ = 11.43

		local var_45_0 = {
			zh = 10.9,
			ja = 11.433
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
				arg_45_0:Play116421012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_2")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_48_2 = arg_45_1.actors_["10014ui_story"]
			local var_48_3 = 0

			if var_48_3 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect10014ui_story == nil then
				arg_45_1.var_.characterEffect10014ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.2

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_4 and not isNil(var_48_2) then
				local var_48_5 = (arg_45_1.time_ - var_48_3) / var_48_4

				if arg_45_1.var_.characterEffect10014ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_3 + var_48_4 and arg_45_1.time_ < var_48_3 + var_48_4 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect10014ui_story then
				arg_45_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_48_6 = arg_45_1.actors_["1029ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.034

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1029ui_story and not isNil(var_48_6) then
					local var_48_10 = Mathf.Lerp(0, 0.5, var_48_9)

					arg_45_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1029ui_story.fillRatio = var_48_10
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1029ui_story then
				local var_48_11 = 0.5

				arg_45_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1029ui_story.fillRatio = var_48_11
			end

			local var_48_12 = 0
			local var_48_13 = 1.35

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_14 = arg_45_1:FormatText(StoryNameCfg[264].name)

				arg_45_1.leftNameTxt_.text = var_48_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(116421011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 56
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_13 or var_48_13 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_13 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421011", "story_v_out_116421.awb") ~= 0 then
					local var_48_20 = manager.audio:GetVoiceLength("story_v_out_116421", "116421011", "story_v_out_116421.awb") / 1000

					if var_48_20 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_20 + var_48_12
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_116421", "116421011", "story_v_out_116421.awb")

						arg_45_1:RecordAudio("116421011", var_48_21)
						arg_45_1:RecordAudio("116421011", var_48_21)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116421", "116421011", "story_v_out_116421.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116421", "116421011", "story_v_out_116421.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_22 and arg_45_1.time_ < var_48_12 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116421012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116421012
		arg_49_1.duration_ = 7.53

		local var_49_0 = {
			zh = 6.1,
			ja = 7.533
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
				arg_49_0:Play116421013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_1 = arg_49_1.actors_["1029ui_story"].transform
			local var_52_2 = 0

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.var_.moveOldPos1029ui_story = var_52_1.localPosition
			end

			local var_52_3 = 0.001

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_2) / var_52_3
				local var_52_5 = Vector3.New(-0.7, -1.09, -6.2)

				var_52_1.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1029ui_story, var_52_5, var_52_4)

				local var_52_6 = manager.ui.mainCamera.transform.position - var_52_1.position

				var_52_1.forward = Vector3.New(var_52_6.x, var_52_6.y, var_52_6.z)

				local var_52_7 = var_52_1.localEulerAngles

				var_52_7.z = 0
				var_52_7.x = 0
				var_52_1.localEulerAngles = var_52_7
			end

			if arg_49_1.time_ >= var_52_2 + var_52_3 and arg_49_1.time_ < var_52_2 + var_52_3 + arg_52_0 then
				var_52_1.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_52_8 = manager.ui.mainCamera.transform.position - var_52_1.position

				var_52_1.forward = Vector3.New(var_52_8.x, var_52_8.y, var_52_8.z)

				local var_52_9 = var_52_1.localEulerAngles

				var_52_9.z = 0
				var_52_9.x = 0
				var_52_1.localEulerAngles = var_52_9
			end

			local var_52_10 = arg_49_1.actors_["10014ui_story"].transform
			local var_52_11 = 0

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.var_.moveOldPos10014ui_story = var_52_10.localPosition
			end

			local var_52_12 = 0.001

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_11) / var_52_12
				local var_52_14 = Vector3.New(0.7, -1.06, -6.2)

				var_52_10.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10014ui_story, var_52_14, var_52_13)

				local var_52_15 = manager.ui.mainCamera.transform.position - var_52_10.position

				var_52_10.forward = Vector3.New(var_52_15.x, var_52_15.y, var_52_15.z)

				local var_52_16 = var_52_10.localEulerAngles

				var_52_16.z = 0
				var_52_16.x = 0
				var_52_10.localEulerAngles = var_52_16
			end

			if arg_49_1.time_ >= var_52_11 + var_52_12 and arg_49_1.time_ < var_52_11 + var_52_12 + arg_52_0 then
				var_52_10.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_52_17 = manager.ui.mainCamera.transform.position - var_52_10.position

				var_52_10.forward = Vector3.New(var_52_17.x, var_52_17.y, var_52_17.z)

				local var_52_18 = var_52_10.localEulerAngles

				var_52_18.z = 0
				var_52_18.x = 0
				var_52_10.localEulerAngles = var_52_18
			end

			local var_52_19 = arg_49_1.actors_["10014ui_story"]
			local var_52_20 = 0

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 and not isNil(var_52_19) and arg_49_1.var_.characterEffect10014ui_story == nil then
				arg_49_1.var_.characterEffect10014ui_story = var_52_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_21 = 0.2

			if var_52_20 <= arg_49_1.time_ and arg_49_1.time_ < var_52_20 + var_52_21 and not isNil(var_52_19) then
				local var_52_22 = (arg_49_1.time_ - var_52_20) / var_52_21

				if arg_49_1.var_.characterEffect10014ui_story and not isNil(var_52_19) then
					arg_49_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_20 + var_52_21 and arg_49_1.time_ < var_52_20 + var_52_21 + arg_52_0 and not isNil(var_52_19) and arg_49_1.var_.characterEffect10014ui_story then
				arg_49_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_52_23 = 0
			local var_52_24 = 0.775

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[264].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(116421012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 30
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421012", "story_v_out_116421.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_116421", "116421012", "story_v_out_116421.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_116421", "116421012", "story_v_out_116421.awb")

						arg_49_1:RecordAudio("116421012", var_52_32)
						arg_49_1:RecordAudio("116421012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116421", "116421012", "story_v_out_116421.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116421", "116421012", "story_v_out_116421.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play116421013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116421013
		arg_53_1.duration_ = 6.37

		local var_53_0 = {
			zh = 4.666,
			ja = 6.366
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
				arg_53_0:Play116421014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1029ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1029ui_story == nil then
				arg_53_1.var_.characterEffect1029ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1029ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1029ui_story then
				arg_53_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["10014ui_story"]
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10014ui_story == nil then
				arg_53_1.var_.characterEffect10014ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.2

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 and not isNil(var_56_4) then
				local var_56_7 = (arg_53_1.time_ - var_56_5) / var_56_6

				if arg_53_1.var_.characterEffect10014ui_story and not isNil(var_56_4) then
					local var_56_8 = Mathf.Lerp(0, 0.5, var_56_7)

					arg_53_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10014ui_story.fillRatio = var_56_8
				end
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10014ui_story then
				local var_56_9 = 0.5

				arg_53_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10014ui_story.fillRatio = var_56_9
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_11 = 0
			local var_56_12 = 0.525

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[319].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(116421013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 21
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421013", "story_v_out_116421.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_116421", "116421013", "story_v_out_116421.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_116421", "116421013", "story_v_out_116421.awb")

						arg_53_1:RecordAudio("116421013", var_56_20)
						arg_53_1:RecordAudio("116421013", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116421", "116421013", "story_v_out_116421.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116421", "116421013", "story_v_out_116421.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_21 and arg_53_1.time_ < var_56_11 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116421014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116421014
		arg_57_1.duration_ = 15.03

		local var_57_0 = {
			zh = 9.066,
			ja = 15.033
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
				arg_57_0:Play116421015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_1 = 0
			local var_60_2 = 1.175

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_3 = arg_57_1:FormatText(StoryNameCfg[319].name)

				arg_57_1.leftNameTxt_.text = var_60_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(116421014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 47
				local var_60_7 = utf8.len(var_60_5)
				local var_60_8 = var_60_6 <= 0 and var_60_2 or var_60_2 * (var_60_7 / var_60_6)

				if var_60_8 > 0 and var_60_2 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421014", "story_v_out_116421.awb") ~= 0 then
					local var_60_9 = manager.audio:GetVoiceLength("story_v_out_116421", "116421014", "story_v_out_116421.awb") / 1000

					if var_60_9 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_1
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_116421", "116421014", "story_v_out_116421.awb")

						arg_57_1:RecordAudio("116421014", var_60_10)
						arg_57_1:RecordAudio("116421014", var_60_10)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116421", "116421014", "story_v_out_116421.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116421", "116421014", "story_v_out_116421.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_11 and arg_57_1.time_ < var_60_1 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play116421015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116421015
		arg_61_1.duration_ = 7.47

		local var_61_0 = {
			zh = 7.166,
			ja = 7.466
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
				arg_61_0:Play116421016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_1 = 0
			local var_64_2 = 0.925

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_3 = arg_61_1:FormatText(StoryNameCfg[319].name)

				arg_61_1.leftNameTxt_.text = var_64_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(116421015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 37
				local var_64_7 = utf8.len(var_64_5)
				local var_64_8 = var_64_6 <= 0 and var_64_2 or var_64_2 * (var_64_7 / var_64_6)

				if var_64_8 > 0 and var_64_2 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421015", "story_v_out_116421.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_116421", "116421015", "story_v_out_116421.awb") / 1000

					if var_64_9 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_1
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_116421", "116421015", "story_v_out_116421.awb")

						arg_61_1:RecordAudio("116421015", var_64_10)
						arg_61_1:RecordAudio("116421015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116421", "116421015", "story_v_out_116421.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116421", "116421015", "story_v_out_116421.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_11 and arg_61_1.time_ < var_64_1 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play116421016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116421016
		arg_65_1.duration_ = 9.7

		local var_65_0 = {
			zh = 9.7,
			ja = 7.8
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
				arg_65_0:Play116421017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_2 = 0
			local var_68_3 = 1.05

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_4 = arg_65_1:FormatText(StoryNameCfg[319].name)

				arg_65_1.leftNameTxt_.text = var_68_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:GetWordFromCfg(116421016)
				local var_68_6 = arg_65_1:FormatText(var_68_5.content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 42
				local var_68_8 = utf8.len(var_68_6)
				local var_68_9 = var_68_7 <= 0 and var_68_3 or var_68_3 * (var_68_8 / var_68_7)

				if var_68_9 > 0 and var_68_3 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421016", "story_v_out_116421.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_116421", "116421016", "story_v_out_116421.awb") / 1000

					if var_68_10 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_2
					end

					if var_68_5.prefab_name ~= "" and arg_65_1.actors_[var_68_5.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_5.prefab_name].transform, "story_v_out_116421", "116421016", "story_v_out_116421.awb")

						arg_65_1:RecordAudio("116421016", var_68_11)
						arg_65_1:RecordAudio("116421016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116421", "116421016", "story_v_out_116421.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116421", "116421016", "story_v_out_116421.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_12 and arg_65_1.time_ < var_68_2 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116421017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116421017
		arg_69_1.duration_ = 6.33

		local var_69_0 = {
			zh = 5.233,
			ja = 6.333
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
				arg_69_0:Play116421018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_72_1 = 0
			local var_72_2 = 0.5

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[319].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(116421017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 20
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421017", "story_v_out_116421.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_116421", "116421017", "story_v_out_116421.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_116421", "116421017", "story_v_out_116421.awb")

						arg_69_1:RecordAudio("116421017", var_72_10)
						arg_69_1:RecordAudio("116421017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116421", "116421017", "story_v_out_116421.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116421", "116421017", "story_v_out_116421.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116421018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116421018
		arg_73_1.duration_ = 7.27

		local var_73_0 = {
			zh = 2.9,
			ja = 7.266
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
				arg_73_0:Play116421019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_76_2 = arg_73_1.actors_["10014ui_story"]
			local var_76_3 = 0

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect10014ui_story == nil then
				arg_73_1.var_.characterEffect10014ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_4 and not isNil(var_76_2) then
				local var_76_5 = (arg_73_1.time_ - var_76_3) / var_76_4

				if arg_73_1.var_.characterEffect10014ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_3 + var_76_4 and arg_73_1.time_ < var_76_3 + var_76_4 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect10014ui_story then
				arg_73_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_76_6 = arg_73_1.actors_["1029ui_story"]
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1029ui_story == nil then
				arg_73_1.var_.characterEffect1029ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.2

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 and not isNil(var_76_6) then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8

				if arg_73_1.var_.characterEffect1029ui_story and not isNil(var_76_6) then
					local var_76_10 = Mathf.Lerp(0, 0.5, var_76_9)

					arg_73_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1029ui_story.fillRatio = var_76_10
				end
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1029ui_story then
				local var_76_11 = 0.5

				arg_73_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1029ui_story.fillRatio = var_76_11
			end

			local var_76_12 = 0
			local var_76_13 = 0.425

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[264].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(116421018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 17
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421018", "story_v_out_116421.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_116421", "116421018", "story_v_out_116421.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_116421", "116421018", "story_v_out_116421.awb")

						arg_73_1:RecordAudio("116421018", var_76_21)
						arg_73_1:RecordAudio("116421018", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_116421", "116421018", "story_v_out_116421.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_116421", "116421018", "story_v_out_116421.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116421019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116421019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play116421020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10014ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10014ui_story == nil then
				arg_77_1.var_.characterEffect10014ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10014ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10014ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10014ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10014ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.975

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(116421019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 39
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_7 or var_80_7 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_7 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_13 and arg_77_1.time_ < var_80_6 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play116421020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116421020
		arg_81_1.duration_ = 7.17

		local var_81_0 = {
			zh = 4.2,
			ja = 7.166
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
				arg_81_0:Play116421021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10014ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10014ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10014ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, 100, 0)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1029ui_story"].transform
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.var_.moveOldPos1029ui_story = var_84_9.localPosition
			end

			local var_84_11 = 0.001

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11
				local var_84_13 = Vector3.New(0, 100, 0)

				var_84_9.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1029ui_story, var_84_13, var_84_12)

				local var_84_14 = manager.ui.mainCamera.transform.position - var_84_9.position

				var_84_9.forward = Vector3.New(var_84_14.x, var_84_14.y, var_84_14.z)

				local var_84_15 = var_84_9.localEulerAngles

				var_84_15.z = 0
				var_84_15.x = 0
				var_84_9.localEulerAngles = var_84_15
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 then
				var_84_9.localPosition = Vector3.New(0, 100, 0)

				local var_84_16 = manager.ui.mainCamera.transform.position - var_84_9.position

				var_84_9.forward = Vector3.New(var_84_16.x, var_84_16.y, var_84_16.z)

				local var_84_17 = var_84_9.localEulerAngles

				var_84_17.z = 0
				var_84_17.x = 0
				var_84_9.localEulerAngles = var_84_17
			end

			local var_84_18 = manager.ui.mainCamera.transform
			local var_84_19 = 3.33333333333333

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1.var_.shakeOldPos = var_84_18.localPosition
			end

			local var_84_20 = 0.8

			if var_84_19 <= arg_81_1.time_ and arg_81_1.time_ < var_84_19 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_19) / 0.066
				local var_84_22, var_84_23 = math.modf(var_84_21)

				var_84_18.localPosition = Vector3.New(var_84_23 * 0.13, var_84_23 * 0.13, var_84_23 * 0.13) + arg_81_1.var_.shakeOldPos
			end

			if arg_81_1.time_ >= var_84_19 + var_84_20 and arg_81_1.time_ < var_84_19 + var_84_20 + arg_84_0 then
				var_84_18.localPosition = arg_81_1.var_.shakeOldPos
			end

			local var_84_24 = 0
			local var_84_25 = 0.55

			if var_84_24 < arg_81_1.time_ and arg_81_1.time_ <= var_84_24 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_26 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_26:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_27 = arg_81_1:FormatText(StoryNameCfg[264].name)

				arg_81_1.leftNameTxt_.text = var_84_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_28 = arg_81_1:GetWordFromCfg(116421020)
				local var_84_29 = arg_81_1:FormatText(var_84_28.content)

				arg_81_1.text_.text = var_84_29

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_30 = 22
				local var_84_31 = utf8.len(var_84_29)
				local var_84_32 = var_84_30 <= 0 and var_84_25 or var_84_25 * (var_84_31 / var_84_30)

				if var_84_32 > 0 and var_84_25 < var_84_32 then
					arg_81_1.talkMaxDuration = var_84_32
					var_84_24 = var_84_24 + 0.3

					if var_84_32 + var_84_24 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_32 + var_84_24
					end
				end

				arg_81_1.text_.text = var_84_29
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421020", "story_v_out_116421.awb") ~= 0 then
					local var_84_33 = manager.audio:GetVoiceLength("story_v_out_116421", "116421020", "story_v_out_116421.awb") / 1000

					if var_84_33 + var_84_24 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_33 + var_84_24
					end

					if var_84_28.prefab_name ~= "" and arg_81_1.actors_[var_84_28.prefab_name] ~= nil then
						local var_84_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_28.prefab_name].transform, "story_v_out_116421", "116421020", "story_v_out_116421.awb")

						arg_81_1:RecordAudio("116421020", var_84_34)
						arg_81_1:RecordAudio("116421020", var_84_34)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116421", "116421020", "story_v_out_116421.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116421", "116421020", "story_v_out_116421.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_35 = var_84_24 + 0.3
			local var_84_36 = math.max(var_84_25, arg_81_1.talkMaxDuration)

			if var_84_35 <= arg_81_1.time_ and arg_81_1.time_ < var_84_35 + var_84_36 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_35) / var_84_36

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_35 + var_84_36 and arg_81_1.time_ < var_84_35 + var_84_36 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play116421021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116421021
		arg_87_1.duration_ = 6.7

		local var_87_0 = {
			zh = 4.133,
			ja = 6.7
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116421022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "SK0210"

			if arg_87_1.bgs_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_0)
				var_90_1.name = var_90_0
				var_90_1.transform.parent = arg_87_1.stage_.transform
				var_90_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_0] = var_90_1
			end

			local var_90_2 = 0

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				local var_90_3 = manager.ui.mainCamera.transform.localPosition
				local var_90_4 = Vector3.New(0, 0, 10) + Vector3.New(var_90_3.x, var_90_3.y, 0)
				local var_90_5 = arg_87_1.bgs_.SK0210

				var_90_5.transform.localPosition = var_90_4
				var_90_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_6 = var_90_5:GetComponent("SpriteRenderer")

				if var_90_6 and var_90_6.sprite then
					local var_90_7 = (var_90_5.transform.localPosition - var_90_3).z
					local var_90_8 = manager.ui.mainCameraCom_
					local var_90_9 = 2 * var_90_7 * Mathf.Tan(var_90_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_90_10 = var_90_9 * var_90_8.aspect
					local var_90_11 = var_90_6.sprite.bounds.size.x
					local var_90_12 = var_90_6.sprite.bounds.size.y
					local var_90_13 = var_90_10 / var_90_11
					local var_90_14 = var_90_9 / var_90_12
					local var_90_15 = var_90_14 < var_90_13 and var_90_13 or var_90_14

					var_90_5.transform.localScale = Vector3.New(var_90_15, var_90_15, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "SK0210" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_17 = 2

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17
				local var_90_19 = Color.New(0, 0, 0)

				var_90_19.a = Mathf.Lerp(1, 0, var_90_18)
				arg_87_1.mask_.color = var_90_19
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				local var_90_20 = Color.New(0, 0, 0)
				local var_90_21 = 0

				arg_87_1.mask_.enabled = false
				var_90_20.a = var_90_21
				arg_87_1.mask_.color = var_90_20
			end

			local var_90_22 = 0

			if var_90_22 < arg_87_1.time_ and arg_87_1.time_ <= var_90_22 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			local var_90_23 = 2.225

			if arg_87_1.time_ >= var_90_22 + var_90_23 and arg_87_1.time_ < var_90_22 + var_90_23 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_24 = 2
			local var_90_25 = 0.225

			if var_90_24 < arg_87_1.time_ and arg_87_1.time_ <= var_90_24 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_26 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_26:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_27 = arg_87_1:FormatText(StoryNameCfg[264].name)

				arg_87_1.leftNameTxt_.text = var_90_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_28 = arg_87_1:GetWordFromCfg(116421021)
				local var_90_29 = arg_87_1:FormatText(var_90_28.content)

				arg_87_1.text_.text = var_90_29

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_30 = 9
				local var_90_31 = utf8.len(var_90_29)
				local var_90_32 = var_90_30 <= 0 and var_90_25 or var_90_25 * (var_90_31 / var_90_30)

				if var_90_32 > 0 and var_90_25 < var_90_32 then
					arg_87_1.talkMaxDuration = var_90_32
					var_90_24 = var_90_24 + 0.3

					if var_90_32 + var_90_24 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_32 + var_90_24
					end
				end

				arg_87_1.text_.text = var_90_29
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421021", "story_v_out_116421.awb") ~= 0 then
					local var_90_33 = manager.audio:GetVoiceLength("story_v_out_116421", "116421021", "story_v_out_116421.awb") / 1000

					if var_90_33 + var_90_24 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_33 + var_90_24
					end

					if var_90_28.prefab_name ~= "" and arg_87_1.actors_[var_90_28.prefab_name] ~= nil then
						local var_90_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_28.prefab_name].transform, "story_v_out_116421", "116421021", "story_v_out_116421.awb")

						arg_87_1:RecordAudio("116421021", var_90_34)
						arg_87_1:RecordAudio("116421021", var_90_34)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116421", "116421021", "story_v_out_116421.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116421", "116421021", "story_v_out_116421.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_35 = var_90_24 + 0.3
			local var_90_36 = math.max(var_90_25, arg_87_1.talkMaxDuration)

			if var_90_35 <= arg_87_1.time_ and arg_87_1.time_ < var_90_35 + var_90_36 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_35) / var_90_36

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_35 + var_90_36 and arg_87_1.time_ < var_90_35 + var_90_36 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116421022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116421022
		arg_93_1.duration_ = 9.23

		local var_93_0 = {
			zh = 6.8,
			ja = 9.233
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
				arg_93_0:Play116421023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.6

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

				local var_96_3 = arg_93_1:GetWordFromCfg(116421022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421022", "story_v_out_116421.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421022", "story_v_out_116421.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_116421", "116421022", "story_v_out_116421.awb")

						arg_93_1:RecordAudio("116421022", var_96_9)
						arg_93_1:RecordAudio("116421022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116421", "116421022", "story_v_out_116421.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116421", "116421022", "story_v_out_116421.awb")
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
	Play116421023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116421023
		arg_97_1.duration_ = 10.37

		local var_97_0 = {
			zh = 8.633,
			ja = 10.366
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
				arg_97_0:Play116421024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.975

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[319].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(116421023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421023", "story_v_out_116421.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421023", "story_v_out_116421.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_116421", "116421023", "story_v_out_116421.awb")

						arg_97_1:RecordAudio("116421023", var_100_9)
						arg_97_1:RecordAudio("116421023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_116421", "116421023", "story_v_out_116421.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_116421", "116421023", "story_v_out_116421.awb")
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
	Play116421024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116421024
		arg_101_1.duration_ = 7.7

		local var_101_0 = {
			zh = 4.8,
			ja = 7.7
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
				arg_101_0:Play116421025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.5

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

				local var_104_3 = arg_101_1:GetWordFromCfg(116421024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421024", "story_v_out_116421.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421024", "story_v_out_116421.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_116421", "116421024", "story_v_out_116421.awb")

						arg_101_1:RecordAudio("116421024", var_104_9)
						arg_101_1:RecordAudio("116421024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_116421", "116421024", "story_v_out_116421.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_116421", "116421024", "story_v_out_116421.awb")
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
	Play116421025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116421025
		arg_105_1.duration_ = 6.17

		local var_105_0 = {
			zh = 6.166,
			ja = 4.766
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
				arg_105_0:Play116421026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.375

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[264].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(116421025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421025", "story_v_out_116421.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421025", "story_v_out_116421.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_116421", "116421025", "story_v_out_116421.awb")

						arg_105_1:RecordAudio("116421025", var_108_9)
						arg_105_1:RecordAudio("116421025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116421", "116421025", "story_v_out_116421.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116421", "116421025", "story_v_out_116421.awb")
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
	Play116421026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116421026
		arg_109_1.duration_ = 3.9

		local var_109_0 = {
			zh = 3.9,
			ja = 1.8
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
				arg_109_0:Play116421027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.45

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

				local var_112_3 = arg_109_1:GetWordFromCfg(116421026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421026", "story_v_out_116421.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421026", "story_v_out_116421.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_116421", "116421026", "story_v_out_116421.awb")

						arg_109_1:RecordAudio("116421026", var_112_9)
						arg_109_1:RecordAudio("116421026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_116421", "116421026", "story_v_out_116421.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_116421", "116421026", "story_v_out_116421.awb")
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
	Play116421027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116421027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play116421028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.475

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(116421027)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 19
				local var_116_5 = utf8.len(var_116_3)
				local var_116_6 = var_116_4 <= 0 and var_116_1 or var_116_1 * (var_116_5 / var_116_4)

				if var_116_6 > 0 and var_116_1 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_7 and arg_113_1.time_ < var_116_0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play116421028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116421028
		arg_117_1.duration_ = 9.6

		local var_117_0 = {
			zh = 7.333,
			ja = 9.6
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
				arg_117_0:Play116421029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.475

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[264].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(116421028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 19
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421028", "story_v_out_116421.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421028", "story_v_out_116421.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_116421", "116421028", "story_v_out_116421.awb")

						arg_117_1:RecordAudio("116421028", var_120_9)
						arg_117_1:RecordAudio("116421028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_116421", "116421028", "story_v_out_116421.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_116421", "116421028", "story_v_out_116421.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play116421029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116421029
		arg_121_1.duration_ = 7.03

		local var_121_0 = {
			zh = 4.933,
			ja = 7.033
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
				arg_121_0:Play116421030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.475

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[264].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(116421029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421029", "story_v_out_116421.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421029", "story_v_out_116421.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_116421", "116421029", "story_v_out_116421.awb")

						arg_121_1:RecordAudio("116421029", var_124_9)
						arg_121_1:RecordAudio("116421029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_116421", "116421029", "story_v_out_116421.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_116421", "116421029", "story_v_out_116421.awb")
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
	Play116421030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116421030
		arg_125_1.duration_ = 7.53

		local var_125_0 = {
			zh = 4,
			ja = 7.533
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
				arg_125_0:Play116421031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.35

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[264].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(116421030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421030", "story_v_out_116421.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421030", "story_v_out_116421.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_116421", "116421030", "story_v_out_116421.awb")

						arg_125_1:RecordAudio("116421030", var_128_9)
						arg_125_1:RecordAudio("116421030", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_116421", "116421030", "story_v_out_116421.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_116421", "116421030", "story_v_out_116421.awb")
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
	Play116421031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116421031
		arg_129_1.duration_ = 1.4

		local var_129_0 = {
			zh = 1.4,
			ja = 0.999999999999
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
				arg_129_0:Play116421032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.05

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

				local var_132_3 = arg_129_1:GetWordFromCfg(116421031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421031", "story_v_out_116421.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421031", "story_v_out_116421.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_116421", "116421031", "story_v_out_116421.awb")

						arg_129_1:RecordAudio("116421031", var_132_9)
						arg_129_1:RecordAudio("116421031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_116421", "116421031", "story_v_out_116421.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_116421", "116421031", "story_v_out_116421.awb")
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
	Play116421032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116421032
		arg_133_1.duration_ = 9.93

		local var_133_0 = {
			zh = 9.933,
			ja = 7.766
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
				arg_133_0:Play116421033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 2

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_1 = manager.ui.mainCamera.transform.localPosition
				local var_136_2 = Vector3.New(0, 0, 10) + Vector3.New(var_136_1.x, var_136_1.y, 0)
				local var_136_3 = arg_133_1.bgs_.I06e

				var_136_3.transform.localPosition = var_136_2
				var_136_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_4 = var_136_3:GetComponent("SpriteRenderer")

				if var_136_4 and var_136_4.sprite then
					local var_136_5 = (var_136_3.transform.localPosition - var_136_1).z
					local var_136_6 = manager.ui.mainCameraCom_
					local var_136_7 = 2 * var_136_5 * Mathf.Tan(var_136_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_8 = var_136_7 * var_136_6.aspect
					local var_136_9 = var_136_4.sprite.bounds.size.x
					local var_136_10 = var_136_4.sprite.bounds.size.y
					local var_136_11 = var_136_8 / var_136_9
					local var_136_12 = var_136_7 / var_136_10
					local var_136_13 = var_136_12 < var_136_11 and var_136_11 or var_136_12

					var_136_3.transform.localScale = Vector3.New(var_136_13, var_136_13, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "I06e" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_14 = arg_133_1.actors_["1029ui_story"].transform
			local var_136_15 = 4

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.var_.moveOldPos1029ui_story = var_136_14.localPosition
			end

			local var_136_16 = 0.001

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_16 then
				local var_136_17 = (arg_133_1.time_ - var_136_15) / var_136_16
				local var_136_18 = Vector3.New(0, -1.09, -6.2)

				var_136_14.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1029ui_story, var_136_18, var_136_17)

				local var_136_19 = manager.ui.mainCamera.transform.position - var_136_14.position

				var_136_14.forward = Vector3.New(var_136_19.x, var_136_19.y, var_136_19.z)

				local var_136_20 = var_136_14.localEulerAngles

				var_136_20.z = 0
				var_136_20.x = 0
				var_136_14.localEulerAngles = var_136_20
			end

			if arg_133_1.time_ >= var_136_15 + var_136_16 and arg_133_1.time_ < var_136_15 + var_136_16 + arg_136_0 then
				var_136_14.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_136_21 = manager.ui.mainCamera.transform.position - var_136_14.position

				var_136_14.forward = Vector3.New(var_136_21.x, var_136_21.y, var_136_21.z)

				local var_136_22 = var_136_14.localEulerAngles

				var_136_22.z = 0
				var_136_22.x = 0
				var_136_14.localEulerAngles = var_136_22
			end

			local var_136_23 = arg_133_1.actors_["1029ui_story"]
			local var_136_24 = 4

			if var_136_24 < arg_133_1.time_ and arg_133_1.time_ <= var_136_24 + arg_136_0 and not isNil(var_136_23) and arg_133_1.var_.characterEffect1029ui_story == nil then
				arg_133_1.var_.characterEffect1029ui_story = var_136_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_25 = 0.2

			if var_136_24 <= arg_133_1.time_ and arg_133_1.time_ < var_136_24 + var_136_25 and not isNil(var_136_23) then
				local var_136_26 = (arg_133_1.time_ - var_136_24) / var_136_25

				if arg_133_1.var_.characterEffect1029ui_story and not isNil(var_136_23) then
					arg_133_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_24 + var_136_25 and arg_133_1.time_ < var_136_24 + var_136_25 + arg_136_0 and not isNil(var_136_23) and arg_133_1.var_.characterEffect1029ui_story then
				arg_133_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_136_27 = 4

			if var_136_27 < arg_133_1.time_ and arg_133_1.time_ <= var_136_27 + arg_136_0 then
				arg_133_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_136_28 = 4

			if var_136_28 < arg_133_1.time_ and arg_133_1.time_ <= var_136_28 + arg_136_0 then
				arg_133_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_136_29 = 0

			if var_136_29 < arg_133_1.time_ and arg_133_1.time_ <= var_136_29 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_30 = 2

			if var_136_29 <= arg_133_1.time_ and arg_133_1.time_ < var_136_29 + var_136_30 then
				local var_136_31 = (arg_133_1.time_ - var_136_29) / var_136_30
				local var_136_32 = Color.New(0, 0, 0)

				var_136_32.a = Mathf.Lerp(0, 1, var_136_31)
				arg_133_1.mask_.color = var_136_32
			end

			if arg_133_1.time_ >= var_136_29 + var_136_30 and arg_133_1.time_ < var_136_29 + var_136_30 + arg_136_0 then
				local var_136_33 = Color.New(0, 0, 0)

				var_136_33.a = 1
				arg_133_1.mask_.color = var_136_33
			end

			local var_136_34 = 2

			if var_136_34 < arg_133_1.time_ and arg_133_1.time_ <= var_136_34 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_35 = 2

			if var_136_34 <= arg_133_1.time_ and arg_133_1.time_ < var_136_34 + var_136_35 then
				local var_136_36 = (arg_133_1.time_ - var_136_34) / var_136_35
				local var_136_37 = Color.New(0, 0, 0)

				var_136_37.a = Mathf.Lerp(1, 0, var_136_36)
				arg_133_1.mask_.color = var_136_37
			end

			if arg_133_1.time_ >= var_136_34 + var_136_35 and arg_133_1.time_ < var_136_34 + var_136_35 + arg_136_0 then
				local var_136_38 = Color.New(0, 0, 0)
				local var_136_39 = 0

				arg_133_1.mask_.enabled = false
				var_136_38.a = var_136_39
				arg_133_1.mask_.color = var_136_38
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_40 = 4
			local var_136_41 = 0.525

			if var_136_40 < arg_133_1.time_ and arg_133_1.time_ <= var_136_40 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_42 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_42:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_43 = arg_133_1:FormatText(StoryNameCfg[319].name)

				arg_133_1.leftNameTxt_.text = var_136_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_44 = arg_133_1:GetWordFromCfg(116421032)
				local var_136_45 = arg_133_1:FormatText(var_136_44.content)

				arg_133_1.text_.text = var_136_45

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_46 = 21
				local var_136_47 = utf8.len(var_136_45)
				local var_136_48 = var_136_46 <= 0 and var_136_41 or var_136_41 * (var_136_47 / var_136_46)

				if var_136_48 > 0 and var_136_41 < var_136_48 then
					arg_133_1.talkMaxDuration = var_136_48
					var_136_40 = var_136_40 + 0.3

					if var_136_48 + var_136_40 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_48 + var_136_40
					end
				end

				arg_133_1.text_.text = var_136_45
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421032", "story_v_out_116421.awb") ~= 0 then
					local var_136_49 = manager.audio:GetVoiceLength("story_v_out_116421", "116421032", "story_v_out_116421.awb") / 1000

					if var_136_49 + var_136_40 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_49 + var_136_40
					end

					if var_136_44.prefab_name ~= "" and arg_133_1.actors_[var_136_44.prefab_name] ~= nil then
						local var_136_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_44.prefab_name].transform, "story_v_out_116421", "116421032", "story_v_out_116421.awb")

						arg_133_1:RecordAudio("116421032", var_136_50)
						arg_133_1:RecordAudio("116421032", var_136_50)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_116421", "116421032", "story_v_out_116421.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_116421", "116421032", "story_v_out_116421.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_51 = var_136_40 + 0.3
			local var_136_52 = math.max(var_136_41, arg_133_1.talkMaxDuration)

			if var_136_51 <= arg_133_1.time_ and arg_133_1.time_ < var_136_51 + var_136_52 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_51) / var_136_52

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_51 + var_136_52 and arg_133_1.time_ < var_136_51 + var_136_52 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play116421033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116421033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116421034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1029ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1029ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, 100, 0)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1029ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, 100, 0)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = 0
			local var_142_10 = 0.55

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_11 = arg_139_1:GetWordFromCfg(116421033)
				local var_142_12 = arg_139_1:FormatText(var_142_11.content)

				arg_139_1.text_.text = var_142_12

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 22
				local var_142_14 = utf8.len(var_142_12)
				local var_142_15 = var_142_13 <= 0 and var_142_10 or var_142_10 * (var_142_14 / var_142_13)

				if var_142_15 > 0 and var_142_10 < var_142_15 then
					arg_139_1.talkMaxDuration = var_142_15

					if var_142_15 + var_142_9 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_15 + var_142_9
					end
				end

				arg_139_1.text_.text = var_142_12
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_10, arg_139_1.talkMaxDuration)

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_9) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_9 + var_142_16 and arg_139_1.time_ < var_142_9 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play116421034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116421034
		arg_143_1.duration_ = 7.57

		local var_143_0 = {
			zh = 5.8,
			ja = 7.566
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play116421035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.45

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[264].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(116421034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421034", "story_v_out_116421.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_116421", "116421034", "story_v_out_116421.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_116421", "116421034", "story_v_out_116421.awb")

						arg_143_1:RecordAudio("116421034", var_146_9)
						arg_143_1:RecordAudio("116421034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_116421", "116421034", "story_v_out_116421.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_116421", "116421034", "story_v_out_116421.awb")
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
	Play116421035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116421035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116421036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.25

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(116421035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 50
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play116421036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116421036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116421037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.375

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(116421036)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 15
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116421037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116421037
		arg_155_1.duration_ = 5.5

		local var_155_0 = {
			zh = 3.933,
			ja = 5.5
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
			arg_155_1.auto_ = false
		end

		function arg_155_1.playNext_(arg_157_0)
			arg_155_1.onStoryFinished_()
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10014ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10014ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, -1.06, -6.2)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10014ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["10014ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.2

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect10014ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_158_15 = 0
			local var_158_16 = 0.325

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[264].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(116421037)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 13
				local var_158_21 = utf8.len(var_158_19)
				local var_158_22 = var_158_20 <= 0 and var_158_16 or var_158_16 * (var_158_21 / var_158_20)

				if var_158_22 > 0 and var_158_16 < var_158_22 then
					arg_155_1.talkMaxDuration = var_158_22

					if var_158_22 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_19
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116421", "116421037", "story_v_out_116421.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_116421", "116421037", "story_v_out_116421.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_116421", "116421037", "story_v_out_116421.awb")

						arg_155_1:RecordAudio("116421037", var_158_24)
						arg_155_1:RecordAudio("116421037", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_116421", "116421037", "story_v_out_116421.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_116421", "116421037", "story_v_out_116421.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_25 and arg_155_1.time_ < var_158_15 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06e",
		"TextureConfig/Background/SK0210"
	},
	voices = {
		"story_v_out_116421.awb"
	}
}
