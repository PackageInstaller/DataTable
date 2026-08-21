return {
	Play421052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421052001
		arg_1_1.duration_ = 4.7

		local var_1_0 = {
			zh = 3.233,
			ja = 4.7
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
				arg_1_0:Play421052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B10a"

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
				local var_4_5 = arg_1_1.bgs_.B10a

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
					if iter_4_0 ~= "B10a" then
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

			local var_4_22 = 0.1
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.3

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

			local var_4_32 = 0.433333333333333
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_4_3_story_talk", "bgm_activity_4_3_story_talk")

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

			local var_4_38 = 2
			local var_4_39 = 0.075

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(421052001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052001", "story_v_out_421052.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_421052", "421052001", "story_v_out_421052.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_421052", "421052001", "story_v_out_421052.awb")

						arg_1_1:RecordAudio("421052001", var_4_48)
						arg_1_1:RecordAudio("421052001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421052", "421052001", "story_v_out_421052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421052", "421052001", "story_v_out_421052.awb")
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
	Play421052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421052002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.1
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_121_04", "se_story_121_04_gunreadygroup", "")
			end

			local var_12_4 = 0
			local var_12_5 = 0.9

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:GetWordFromCfg(421052002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 36
				local var_12_9 = utf8.len(var_12_7)
				local var_12_10 = var_12_8 <= 0 and var_12_5 or var_12_5 * (var_12_9 / var_12_8)

				if var_12_10 > 0 and var_12_5 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_11 and arg_9_1.time_ < var_12_4 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play421052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421052003
		arg_13_1.duration_ = 11.8

		local var_13_0 = {
			zh = 8.233,
			ja = 11.8
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
				arg_13_0:Play421052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1047ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1047ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1047ui_story = var_16_5.localPosition

				local var_16_7 = "1047ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_7 .. "Animator"].transform, false)
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -1.13, -6.2)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1047ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14
			end

			local var_16_15 = arg_13_1.actors_["1047ui_story"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1047ui_story == nil then
				arg_13_1.var_.characterEffect1047ui_story = var_16_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_17 = 0.200000002980232

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.characterEffect1047ui_story and not isNil(var_16_15) then
					arg_13_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1047ui_story then
				arg_13_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_21 = 0
			local var_16_22 = 0.925

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_23 = arg_13_1:FormatText(StoryNameCfg[1296].name)

				arg_13_1.leftNameTxt_.text = var_16_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_24 = arg_13_1:GetWordFromCfg(421052003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 37
				local var_16_27 = utf8.len(var_16_25)
				local var_16_28 = var_16_26 <= 0 and var_16_22 or var_16_22 * (var_16_27 / var_16_26)

				if var_16_28 > 0 and var_16_22 < var_16_28 then
					arg_13_1.talkMaxDuration = var_16_28

					if var_16_28 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_21
					end
				end

				arg_13_1.text_.text = var_16_25
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052003", "story_v_out_421052.awb") ~= 0 then
					local var_16_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052003", "story_v_out_421052.awb") / 1000

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end

					if var_16_24.prefab_name ~= "" and arg_13_1.actors_[var_16_24.prefab_name] ~= nil then
						local var_16_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_24.prefab_name].transform, "story_v_out_421052", "421052003", "story_v_out_421052.awb")

						arg_13_1:RecordAudio("421052003", var_16_30)
						arg_13_1:RecordAudio("421052003", var_16_30)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421052", "421052003", "story_v_out_421052.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421052", "421052003", "story_v_out_421052.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_31 = math.max(var_16_22, arg_13_1.talkMaxDuration)

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_31 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_21) / var_16_31

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_21 + var_16_31 and arg_13_1.time_ < var_16_21 + var_16_31 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play421052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421052004
		arg_17_1.duration_ = 9.5

		local var_17_0 = {
			zh = 5.066,
			ja = 9.5
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
				arg_17_0:Play421052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1047ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1047ui_story == nil then
				arg_17_1.var_.characterEffect1047ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1047ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1047ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1047ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1047ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.45

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[1314].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(421052004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 18
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052004", "story_v_out_421052.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052004", "story_v_out_421052.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_421052", "421052004", "story_v_out_421052.awb")

						arg_17_1:RecordAudio("421052004", var_20_15)
						arg_17_1:RecordAudio("421052004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421052", "421052004", "story_v_out_421052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421052", "421052004", "story_v_out_421052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play421052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421052005
		arg_21_1.duration_ = 10.17

		local var_21_0 = {
			zh = 7.866,
			ja = 10.166
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
				arg_21_0:Play421052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1047ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.13, -6.2)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1047ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_15 = 0
			local var_24_16 = 0.8

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[1296].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(421052005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 32
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052005", "story_v_out_421052.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052005", "story_v_out_421052.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_421052", "421052005", "story_v_out_421052.awb")

						arg_21_1:RecordAudio("421052005", var_24_24)
						arg_21_1:RecordAudio("421052005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421052", "421052005", "story_v_out_421052.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421052", "421052005", "story_v_out_421052.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play421052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421052006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1047ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0
			local var_28_10 = 1.175

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_11 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_11

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

				local var_28_12 = arg_25_1:GetWordFromCfg(421052006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_14 = 23
				local var_28_15 = utf8.len(var_28_13)
				local var_28_16 = var_28_14 <= 0 and var_28_10 or var_28_10 * (var_28_15 / var_28_14)

				if var_28_16 > 0 and var_28_10 < var_28_16 then
					arg_25_1.talkMaxDuration = var_28_16

					if var_28_16 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_9) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_9 + var_28_17 and arg_25_1.time_ < var_28_9 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play421052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421052007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			zh = 1.833,
			ja = 3.366
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
				arg_29_0:Play421052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.2

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1314].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(421052007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052007", "story_v_out_421052.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052007", "story_v_out_421052.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_421052", "421052007", "story_v_out_421052.awb")

						arg_29_1:RecordAudio("421052007", var_32_9)
						arg_29_1:RecordAudio("421052007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421052", "421052007", "story_v_out_421052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421052", "421052007", "story_v_out_421052.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play421052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421052008
		arg_33_1.duration_ = 6.27

		local var_33_0 = {
			zh = 5.633,
			ja = 6.266
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
				arg_33_0:Play421052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "10102ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["10102ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos10102ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(-0.7, -0.985, -6.275)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10102ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = arg_33_1.actors_["10102ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect10102ui_story == nil then
				arg_33_1.var_.characterEffect10102ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect10102ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect10102ui_story then
				arg_33_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_20 = 0
			local var_36_21 = 0.725

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_22 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(421052008)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 29
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052008", "story_v_out_421052.awb") ~= 0 then
					local var_36_28 = manager.audio:GetVoiceLength("story_v_out_421052", "421052008", "story_v_out_421052.awb") / 1000

					if var_36_28 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_20
					end

					if var_36_23.prefab_name ~= "" and arg_33_1.actors_[var_36_23.prefab_name] ~= nil then
						local var_36_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_23.prefab_name].transform, "story_v_out_421052", "421052008", "story_v_out_421052.awb")

						arg_33_1:RecordAudio("421052008", var_36_29)
						arg_33_1:RecordAudio("421052008", var_36_29)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421052", "421052008", "story_v_out_421052.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421052", "421052008", "story_v_out_421052.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_30 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_30

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_30 and arg_33_1.time_ < var_36_20 + var_36_30 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play421052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421052009
		arg_37_1.duration_ = 16.23

		local var_37_0 = {
			zh = 9.9,
			ja = 16.233
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
				arg_37_0:Play421052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1047ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0.74, -1.13, -6.2)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1047ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1047ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_40_13 = arg_37_1.actors_["10102ui_story"]
			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 and not isNil(var_40_13) and arg_37_1.var_.characterEffect10102ui_story == nil then
				arg_37_1.var_.characterEffect10102ui_story = var_40_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_15 = 0.200000002980232

			if var_40_14 <= arg_37_1.time_ and arg_37_1.time_ < var_40_14 + var_40_15 and not isNil(var_40_13) then
				local var_40_16 = (arg_37_1.time_ - var_40_14) / var_40_15

				if arg_37_1.var_.characterEffect10102ui_story and not isNil(var_40_13) then
					local var_40_17 = Mathf.Lerp(0, 0.5, var_40_16)

					arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10102ui_story.fillRatio = var_40_17
				end
			end

			if arg_37_1.time_ >= var_40_14 + var_40_15 and arg_37_1.time_ < var_40_14 + var_40_15 + arg_40_0 and not isNil(var_40_13) and arg_37_1.var_.characterEffect10102ui_story then
				local var_40_18 = 0.5

				arg_37_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10102ui_story.fillRatio = var_40_18
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_21 = 0
			local var_40_22 = 1.2

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_23 = arg_37_1:FormatText(StoryNameCfg[1296].name)

				arg_37_1.leftNameTxt_.text = var_40_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(421052009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052009", "story_v_out_421052.awb") ~= 0 then
					local var_40_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052009", "story_v_out_421052.awb") / 1000

					if var_40_29 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_21
					end

					if var_40_24.prefab_name ~= "" and arg_37_1.actors_[var_40_24.prefab_name] ~= nil then
						local var_40_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_24.prefab_name].transform, "story_v_out_421052", "421052009", "story_v_out_421052.awb")

						arg_37_1:RecordAudio("421052009", var_40_30)
						arg_37_1:RecordAudio("421052009", var_40_30)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421052", "421052009", "story_v_out_421052.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421052", "421052009", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
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
	Play421052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421052010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1047ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1047ui_story == nil then
				arg_41_1.var_.characterEffect1047ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1047ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1047ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1047ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1047ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.25

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(421052010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 10
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play421052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421052011
		arg_45_1.duration_ = 5.97

		local var_45_0 = {
			zh = 5.166,
			ja = 5.966
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
				arg_45_0:Play421052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1047ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1047ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.74, -1.13, -6.2)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1047ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1047ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1047ui_story == nil then
				arg_45_1.var_.characterEffect1047ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1047ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1047ui_story then
				arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_15 = 0
			local var_48_16 = 0.475

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[1296].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(421052011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052011", "story_v_out_421052.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052011", "story_v_out_421052.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_421052", "421052011", "story_v_out_421052.awb")

						arg_45_1:RecordAudio("421052011", var_48_24)
						arg_45_1:RecordAudio("421052011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421052", "421052011", "story_v_out_421052.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421052", "421052011", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
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
	Play421052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421052012
		arg_49_1.duration_ = 12.83

		local var_49_0 = {
			zh = 8.633,
			ja = 12.833
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
				arg_49_0:Play421052013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "B07b"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 2

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.B07b

				var_52_5.transform.localPosition = var_52_4
				var_52_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_6 = var_52_5:GetComponent("SpriteRenderer")

				if var_52_6 and var_52_6.sprite then
					local var_52_7 = (var_52_5.transform.localPosition - var_52_3).z
					local var_52_8 = manager.ui.mainCameraCom_
					local var_52_9 = 2 * var_52_7 * Mathf.Tan(var_52_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_10 = var_52_9 * var_52_8.aspect
					local var_52_11 = var_52_6.sprite.bounds.size.x
					local var_52_12 = var_52_6.sprite.bounds.size.y
					local var_52_13 = var_52_10 / var_52_11
					local var_52_14 = var_52_9 / var_52_12
					local var_52_15 = var_52_14 < var_52_13 and var_52_13 or var_52_14

					var_52_5.transform.localScale = Vector3.New(var_52_15, var_52_15, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "B07b" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 4

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_17 = 0.3

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_18 = 0

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_19 = 2

			if var_52_18 <= arg_49_1.time_ and arg_49_1.time_ < var_52_18 + var_52_19 then
				local var_52_20 = (arg_49_1.time_ - var_52_18) / var_52_19
				local var_52_21 = Color.New(0, 0, 0)

				var_52_21.a = Mathf.Lerp(0, 1, var_52_20)
				arg_49_1.mask_.color = var_52_21
			end

			if arg_49_1.time_ >= var_52_18 + var_52_19 and arg_49_1.time_ < var_52_18 + var_52_19 + arg_52_0 then
				local var_52_22 = Color.New(0, 0, 0)

				var_52_22.a = 1
				arg_49_1.mask_.color = var_52_22
			end

			local var_52_23 = 2

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_24 = 2

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_24 then
				local var_52_25 = (arg_49_1.time_ - var_52_23) / var_52_24
				local var_52_26 = Color.New(0, 0, 0)

				var_52_26.a = Mathf.Lerp(1, 0, var_52_25)
				arg_49_1.mask_.color = var_52_26
			end

			if arg_49_1.time_ >= var_52_23 + var_52_24 and arg_49_1.time_ < var_52_23 + var_52_24 + arg_52_0 then
				local var_52_27 = Color.New(0, 0, 0)
				local var_52_28 = 0

				arg_49_1.mask_.enabled = false
				var_52_27.a = var_52_28
				arg_49_1.mask_.color = var_52_27
			end

			local var_52_29 = arg_49_1.actors_["1047ui_story"].transform
			local var_52_30 = 3.66666666666667

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.var_.moveOldPos1047ui_story = var_52_29.localPosition
			end

			local var_52_31 = 0.001

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_31 then
				local var_52_32 = (arg_49_1.time_ - var_52_30) / var_52_31
				local var_52_33 = Vector3.New(0, -1.13, -6.2)

				var_52_29.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1047ui_story, var_52_33, var_52_32)

				local var_52_34 = manager.ui.mainCamera.transform.position - var_52_29.position

				var_52_29.forward = Vector3.New(var_52_34.x, var_52_34.y, var_52_34.z)

				local var_52_35 = var_52_29.localEulerAngles

				var_52_35.z = 0
				var_52_35.x = 0
				var_52_29.localEulerAngles = var_52_35
			end

			if arg_49_1.time_ >= var_52_30 + var_52_31 and arg_49_1.time_ < var_52_30 + var_52_31 + arg_52_0 then
				var_52_29.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_52_36 = manager.ui.mainCamera.transform.position - var_52_29.position

				var_52_29.forward = Vector3.New(var_52_36.x, var_52_36.y, var_52_36.z)

				local var_52_37 = var_52_29.localEulerAngles

				var_52_37.z = 0
				var_52_37.x = 0
				var_52_29.localEulerAngles = var_52_37
			end

			local var_52_38 = arg_49_1.actors_["1047ui_story"]
			local var_52_39 = 3.66666666666667

			if var_52_39 < arg_49_1.time_ and arg_49_1.time_ <= var_52_39 + arg_52_0 and not isNil(var_52_38) and arg_49_1.var_.characterEffect1047ui_story == nil then
				arg_49_1.var_.characterEffect1047ui_story = var_52_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_40 = 0.200000002980232

			if var_52_39 <= arg_49_1.time_ and arg_49_1.time_ < var_52_39 + var_52_40 and not isNil(var_52_38) then
				local var_52_41 = (arg_49_1.time_ - var_52_39) / var_52_40

				if arg_49_1.var_.characterEffect1047ui_story and not isNil(var_52_38) then
					arg_49_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_39 + var_52_40 and arg_49_1.time_ < var_52_39 + var_52_40 + arg_52_0 and not isNil(var_52_38) and arg_49_1.var_.characterEffect1047ui_story then
				arg_49_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_52_42 = 3.66666666666667

			if var_52_42 < arg_49_1.time_ and arg_49_1.time_ <= var_52_42 + arg_52_0 then
				arg_49_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_52_43 = 3.66666666666667

			if var_52_43 < arg_49_1.time_ and arg_49_1.time_ <= var_52_43 + arg_52_0 then
				arg_49_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_52_44 = arg_49_1.actors_["1047ui_story"].transform
			local var_52_45 = 2

			if var_52_45 < arg_49_1.time_ and arg_49_1.time_ <= var_52_45 + arg_52_0 then
				arg_49_1.var_.moveOldPos1047ui_story = var_52_44.localPosition
			end

			local var_52_46 = 0.001

			if var_52_45 <= arg_49_1.time_ and arg_49_1.time_ < var_52_45 + var_52_46 then
				local var_52_47 = (arg_49_1.time_ - var_52_45) / var_52_46
				local var_52_48 = Vector3.New(0, 100, 0)

				var_52_44.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1047ui_story, var_52_48, var_52_47)

				local var_52_49 = manager.ui.mainCamera.transform.position - var_52_44.position

				var_52_44.forward = Vector3.New(var_52_49.x, var_52_49.y, var_52_49.z)

				local var_52_50 = var_52_44.localEulerAngles

				var_52_50.z = 0
				var_52_50.x = 0
				var_52_44.localEulerAngles = var_52_50
			end

			if arg_49_1.time_ >= var_52_45 + var_52_46 and arg_49_1.time_ < var_52_45 + var_52_46 + arg_52_0 then
				var_52_44.localPosition = Vector3.New(0, 100, 0)

				local var_52_51 = manager.ui.mainCamera.transform.position - var_52_44.position

				var_52_44.forward = Vector3.New(var_52_51.x, var_52_51.y, var_52_51.z)

				local var_52_52 = var_52_44.localEulerAngles

				var_52_52.z = 0
				var_52_52.x = 0
				var_52_44.localEulerAngles = var_52_52
			end

			local var_52_53 = arg_49_1.actors_["10102ui_story"].transform
			local var_52_54 = 2

			if var_52_54 < arg_49_1.time_ and arg_49_1.time_ <= var_52_54 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102ui_story = var_52_53.localPosition
			end

			local var_52_55 = 0.001

			if var_52_54 <= arg_49_1.time_ and arg_49_1.time_ < var_52_54 + var_52_55 then
				local var_52_56 = (arg_49_1.time_ - var_52_54) / var_52_55
				local var_52_57 = Vector3.New(0, 100, 0)

				var_52_53.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102ui_story, var_52_57, var_52_56)

				local var_52_58 = manager.ui.mainCamera.transform.position - var_52_53.position

				var_52_53.forward = Vector3.New(var_52_58.x, var_52_58.y, var_52_58.z)

				local var_52_59 = var_52_53.localEulerAngles

				var_52_59.z = 0
				var_52_59.x = 0
				var_52_53.localEulerAngles = var_52_59
			end

			if arg_49_1.time_ >= var_52_54 + var_52_55 and arg_49_1.time_ < var_52_54 + var_52_55 + arg_52_0 then
				var_52_53.localPosition = Vector3.New(0, 100, 0)

				local var_52_60 = manager.ui.mainCamera.transform.position - var_52_53.position

				var_52_53.forward = Vector3.New(var_52_60.x, var_52_60.y, var_52_60.z)

				local var_52_61 = var_52_53.localEulerAngles

				var_52_61.z = 0
				var_52_61.x = 0
				var_52_53.localEulerAngles = var_52_61
			end

			local var_52_62 = 0.1
			local var_52_63 = 1

			if var_52_62 < arg_49_1.time_ and arg_49_1.time_ <= var_52_62 + arg_52_0 then
				local var_52_64 = "stop"
				local var_52_65 = "effect"

				arg_49_1:AudioAction(var_52_64, var_52_65, "se_story_140", "se_story_140_amb_street02", "")
			end

			local var_52_66 = 1.63333333333333
			local var_52_67 = 1

			if var_52_66 < arg_49_1.time_ and arg_49_1.time_ <= var_52_66 + arg_52_0 then
				local var_52_68 = "play"
				local var_52_69 = "effect"

				arg_49_1:AudioAction(var_52_68, var_52_69, "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_70 = 4
			local var_52_71 = 0.6

			if var_52_70 < arg_49_1.time_ and arg_49_1.time_ <= var_52_70 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_72 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_72:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_73 = arg_49_1:FormatText(StoryNameCfg[1296].name)

				arg_49_1.leftNameTxt_.text = var_52_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_74 = arg_49_1:GetWordFromCfg(421052012)
				local var_52_75 = arg_49_1:FormatText(var_52_74.content)

				arg_49_1.text_.text = var_52_75

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_76 = 24
				local var_52_77 = utf8.len(var_52_75)
				local var_52_78 = var_52_76 <= 0 and var_52_71 or var_52_71 * (var_52_77 / var_52_76)

				if var_52_78 > 0 and var_52_71 < var_52_78 then
					arg_49_1.talkMaxDuration = var_52_78
					var_52_70 = var_52_70 + 0.3

					if var_52_78 + var_52_70 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_78 + var_52_70
					end
				end

				arg_49_1.text_.text = var_52_75
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052012", "story_v_out_421052.awb") ~= 0 then
					local var_52_79 = manager.audio:GetVoiceLength("story_v_out_421052", "421052012", "story_v_out_421052.awb") / 1000

					if var_52_79 + var_52_70 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_79 + var_52_70
					end

					if var_52_74.prefab_name ~= "" and arg_49_1.actors_[var_52_74.prefab_name] ~= nil then
						local var_52_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_74.prefab_name].transform, "story_v_out_421052", "421052012", "story_v_out_421052.awb")

						arg_49_1:RecordAudio("421052012", var_52_80)
						arg_49_1:RecordAudio("421052012", var_52_80)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421052", "421052012", "story_v_out_421052.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421052", "421052012", "story_v_out_421052.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_81 = var_52_70 + 0.3
			local var_52_82 = math.max(var_52_71, arg_49_1.talkMaxDuration)

			if var_52_81 <= arg_49_1.time_ and arg_49_1.time_ < var_52_81 + var_52_82 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_81) / var_52_82

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_81 + var_52_82 and arg_49_1.time_ < var_52_81 + var_52_82 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play421052013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 421052013
		arg_55_1.duration_ = 8

		local var_55_0 = {
			zh = 5.3,
			ja = 8
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
				arg_55_0:Play421052014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1047ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1047ui_story == nil then
				arg_55_1.var_.characterEffect1047ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1047ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1047ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1047ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1047ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 0.55

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_8 = arg_55_1:FormatText(StoryNameCfg[1314].name)

				arg_55_1.leftNameTxt_.text = var_58_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_9 = arg_55_1:GetWordFromCfg(421052013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 22
				local var_58_12 = utf8.len(var_58_10)
				local var_58_13 = var_58_11 <= 0 and var_58_7 or var_58_7 * (var_58_12 / var_58_11)

				if var_58_13 > 0 and var_58_7 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052013", "story_v_out_421052.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052013", "story_v_out_421052.awb") / 1000

					if var_58_14 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_6
					end

					if var_58_9.prefab_name ~= "" and arg_55_1.actors_[var_58_9.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_9.prefab_name].transform, "story_v_out_421052", "421052013", "story_v_out_421052.awb")

						arg_55_1:RecordAudio("421052013", var_58_15)
						arg_55_1:RecordAudio("421052013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_421052", "421052013", "story_v_out_421052.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_421052", "421052013", "story_v_out_421052.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_16 and arg_55_1.time_ < var_58_6 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play421052014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 421052014
		arg_59_1.duration_ = 6.17

		local var_59_0 = {
			zh = 4.1,
			ja = 6.166
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
				arg_59_0:Play421052015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1047ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1047ui_story == nil then
				arg_59_1.var_.characterEffect1047ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1047ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1047ui_story then
				arg_59_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_62_4 = 0

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_62_5 = 0
			local var_62_6 = 0.7

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_7 = arg_59_1:FormatText(StoryNameCfg[1296].name)

				arg_59_1.leftNameTxt_.text = var_62_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(421052014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 28
				local var_62_11 = utf8.len(var_62_9)
				local var_62_12 = var_62_10 <= 0 and var_62_6 or var_62_6 * (var_62_11 / var_62_10)

				if var_62_12 > 0 and var_62_6 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_5
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052014", "story_v_out_421052.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_421052", "421052014", "story_v_out_421052.awb") / 1000

					if var_62_13 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_5
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_421052", "421052014", "story_v_out_421052.awb")

						arg_59_1:RecordAudio("421052014", var_62_14)
						arg_59_1:RecordAudio("421052014", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_421052", "421052014", "story_v_out_421052.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_421052", "421052014", "story_v_out_421052.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_15 = math.max(var_62_6, arg_59_1.talkMaxDuration)

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_5) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_5 + var_62_15 and arg_59_1.time_ < var_62_5 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play421052015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 421052015
		arg_63_1.duration_ = 4.43

		local var_63_0 = {
			zh = 2.866,
			ja = 4.433
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
				arg_63_0:Play421052016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1047ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1047ui_story == nil then
				arg_63_1.var_.characterEffect1047ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1047ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1047ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1047ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1047ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.15

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[1314].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(421052015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052015", "story_v_out_421052.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052015", "story_v_out_421052.awb") / 1000

					if var_66_14 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_6
					end

					if var_66_9.prefab_name ~= "" and arg_63_1.actors_[var_66_9.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_9.prefab_name].transform, "story_v_out_421052", "421052015", "story_v_out_421052.awb")

						arg_63_1:RecordAudio("421052015", var_66_15)
						arg_63_1:RecordAudio("421052015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_421052", "421052015", "story_v_out_421052.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_421052", "421052015", "story_v_out_421052.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_16 and arg_63_1.time_ < var_66_6 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play421052016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 421052016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play421052017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1047ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1047ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1047ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = 0
			local var_70_10 = 0.775

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_11 = arg_67_1:GetWordFromCfg(421052016)
				local var_70_12 = arg_67_1:FormatText(var_70_11.content)

				arg_67_1.text_.text = var_70_12

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 31
				local var_70_14 = utf8.len(var_70_12)
				local var_70_15 = var_70_13 <= 0 and var_70_10 or var_70_10 * (var_70_14 / var_70_13)

				if var_70_15 > 0 and var_70_10 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_9 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_9
					end
				end

				arg_67_1.text_.text = var_70_12
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_10, arg_67_1.talkMaxDuration)

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_9) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_9 + var_70_16 and arg_67_1.time_ < var_70_9 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play421052017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 421052017
		arg_71_1.duration_ = 4.47

		local var_71_0 = {
			zh = 3.1,
			ja = 4.466
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
				arg_71_0:Play421052018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1047ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1047ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -1.13, -6.2)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1047ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1047ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1047ui_story == nil then
				arg_71_1.var_.characterEffect1047ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1047ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1047ui_story then
				arg_71_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_74_15 = 0
			local var_74_16 = 0.3

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[1296].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(421052017)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 12
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052017", "story_v_out_421052.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052017", "story_v_out_421052.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_421052", "421052017", "story_v_out_421052.awb")

						arg_71_1:RecordAudio("421052017", var_74_24)
						arg_71_1:RecordAudio("421052017", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_421052", "421052017", "story_v_out_421052.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_421052", "421052017", "story_v_out_421052.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play421052018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 421052018
		arg_75_1.duration_ = 16.57

		local var_75_0 = {
			zh = 12.8,
			ja = 16.566
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
				arg_75_0:Play421052019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1047ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1047ui_story == nil then
				arg_75_1.var_.characterEffect1047ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1047ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1047ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1047ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1047ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 1.2

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[1314].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(421052018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 48
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052018", "story_v_out_421052.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052018", "story_v_out_421052.awb") / 1000

					if var_78_14 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_6
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_421052", "421052018", "story_v_out_421052.awb")

						arg_75_1:RecordAudio("421052018", var_78_15)
						arg_75_1:RecordAudio("421052018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_421052", "421052018", "story_v_out_421052.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_421052", "421052018", "story_v_out_421052.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_16 and arg_75_1.time_ < var_78_6 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play421052019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 421052019
		arg_79_1.duration_ = 11.1

		local var_79_0 = {
			zh = 7.733,
			ja = 11.1
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play421052020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1047ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1047ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, -1.13, -6.2)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1047ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1047ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1047ui_story == nil then
				arg_79_1.var_.characterEffect1047ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1047ui_story and not isNil(var_82_9) then
					arg_79_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1047ui_story then
				arg_79_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_82_13 = 0

			if var_82_13 < arg_79_1.time_ and arg_79_1.time_ <= var_82_13 + arg_82_0 then
				arg_79_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_82_15 = 0
			local var_82_16 = 0.825

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_17 = arg_79_1:FormatText(StoryNameCfg[1296].name)

				arg_79_1.leftNameTxt_.text = var_82_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_18 = arg_79_1:GetWordFromCfg(421052019)
				local var_82_19 = arg_79_1:FormatText(var_82_18.content)

				arg_79_1.text_.text = var_82_19

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_20 = 33
				local var_82_21 = utf8.len(var_82_19)
				local var_82_22 = var_82_20 <= 0 and var_82_16 or var_82_16 * (var_82_21 / var_82_20)

				if var_82_22 > 0 and var_82_16 < var_82_22 then
					arg_79_1.talkMaxDuration = var_82_22

					if var_82_22 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_22 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_19
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052019", "story_v_out_421052.awb") ~= 0 then
					local var_82_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052019", "story_v_out_421052.awb") / 1000

					if var_82_23 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_23 + var_82_15
					end

					if var_82_18.prefab_name ~= "" and arg_79_1.actors_[var_82_18.prefab_name] ~= nil then
						local var_82_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_18.prefab_name].transform, "story_v_out_421052", "421052019", "story_v_out_421052.awb")

						arg_79_1:RecordAudio("421052019", var_82_24)
						arg_79_1:RecordAudio("421052019", var_82_24)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_421052", "421052019", "story_v_out_421052.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_421052", "421052019", "story_v_out_421052.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_25 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_25 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_25

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_25 and arg_79_1.time_ < var_82_15 + var_82_25 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play421052020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 421052020
		arg_83_1.duration_ = 9.47

		local var_83_0 = {
			zh = 9.466,
			ja = 8.4
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play421052021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1047ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1047ui_story == nil then
				arg_83_1.var_.characterEffect1047ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1047ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1047ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1047ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1047ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.775

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[1314].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_9 = arg_83_1:GetWordFromCfg(421052020)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 31
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052020", "story_v_out_421052.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052020", "story_v_out_421052.awb") / 1000

					if var_86_14 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_6
					end

					if var_86_9.prefab_name ~= "" and arg_83_1.actors_[var_86_9.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_9.prefab_name].transform, "story_v_out_421052", "421052020", "story_v_out_421052.awb")

						arg_83_1:RecordAudio("421052020", var_86_15)
						arg_83_1:RecordAudio("421052020", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_421052", "421052020", "story_v_out_421052.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_421052", "421052020", "story_v_out_421052.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_16 and arg_83_1.time_ < var_86_6 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play421052021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 421052021
		arg_87_1.duration_ = 16.13

		local var_87_0 = {
			zh = 11.733,
			ja = 16.133
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
				arg_87_0:Play421052022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1047ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1047ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -1.13, -6.2)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1047ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["1047ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1047ui_story == nil then
				arg_87_1.var_.characterEffect1047ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect1047ui_story and not isNil(var_90_9) then
					arg_87_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1047ui_story then
				arg_87_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_90_14 = 0

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_90_15 = 0
			local var_90_16 = 1.2

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_17 = arg_87_1:FormatText(StoryNameCfg[1296].name)

				arg_87_1.leftNameTxt_.text = var_90_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_18 = arg_87_1:GetWordFromCfg(421052021)
				local var_90_19 = arg_87_1:FormatText(var_90_18.content)

				arg_87_1.text_.text = var_90_19

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 48
				local var_90_21 = utf8.len(var_90_19)
				local var_90_22 = var_90_20 <= 0 and var_90_16 or var_90_16 * (var_90_21 / var_90_20)

				if var_90_22 > 0 and var_90_16 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22

					if var_90_22 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_19
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052021", "story_v_out_421052.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052021", "story_v_out_421052.awb") / 1000

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end

					if var_90_18.prefab_name ~= "" and arg_87_1.actors_[var_90_18.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_18.prefab_name].transform, "story_v_out_421052", "421052021", "story_v_out_421052.awb")

						arg_87_1:RecordAudio("421052021", var_90_24)
						arg_87_1:RecordAudio("421052021", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_421052", "421052021", "story_v_out_421052.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_421052", "421052021", "story_v_out_421052.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_25 and arg_87_1.time_ < var_90_15 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421052022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 421052022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play421052023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1047ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1047ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1047ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = 0
			local var_94_10 = 1.3

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_11 = arg_91_1:GetWordFromCfg(421052022)
				local var_94_12 = arg_91_1:FormatText(var_94_11.content)

				arg_91_1.text_.text = var_94_12

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 52
				local var_94_14 = utf8.len(var_94_12)
				local var_94_15 = var_94_13 <= 0 and var_94_10 or var_94_10 * (var_94_14 / var_94_13)

				if var_94_15 > 0 and var_94_10 < var_94_15 then
					arg_91_1.talkMaxDuration = var_94_15

					if var_94_15 + var_94_9 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_9
					end
				end

				arg_91_1.text_.text = var_94_12
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_10, arg_91_1.talkMaxDuration)

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_9) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_9 + var_94_16 and arg_91_1.time_ < var_94_9 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play421052023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 421052023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play421052024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.85

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_2

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

				local var_98_3 = arg_95_1:GetWordFromCfg(421052023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 34
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play421052024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 421052024
		arg_99_1.duration_ = 10.4

		local var_99_0 = {
			zh = 6.833,
			ja = 10.4
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
				arg_99_0:Play421052025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.675

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1314].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(421052024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052024", "story_v_out_421052.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052024", "story_v_out_421052.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_421052", "421052024", "story_v_out_421052.awb")

						arg_99_1:RecordAudio("421052024", var_102_9)
						arg_99_1:RecordAudio("421052024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_421052", "421052024", "story_v_out_421052.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_421052", "421052024", "story_v_out_421052.awb")
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
	Play421052025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 421052025
		arg_103_1.duration_ = 5.77

		local var_103_0 = {
			zh = 4.233,
			ja = 5.766
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
				arg_103_0:Play421052026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1047ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1047ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, -1.13, -6.2)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1047ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1047ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1047ui_story == nil then
				arg_103_1.var_.characterEffect1047ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1047ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1047ui_story then
				arg_103_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_106_13 = 0

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_106_15 = 0
			local var_106_16 = 0.525

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[1296].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(421052025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052025", "story_v_out_421052.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052025", "story_v_out_421052.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_421052", "421052025", "story_v_out_421052.awb")

						arg_103_1:RecordAudio("421052025", var_106_24)
						arg_103_1:RecordAudio("421052025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_421052", "421052025", "story_v_out_421052.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_421052", "421052025", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play421052026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 421052026
		arg_107_1.duration_ = 13.1

		local var_107_0 = {
			zh = 9.933,
			ja = 13.1
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
				arg_107_0:Play421052027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1047ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1047ui_story == nil then
				arg_107_1.var_.characterEffect1047ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1047ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1047ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1047ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1047ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.95

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[1314].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_9 = arg_107_1:GetWordFromCfg(421052026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052026", "story_v_out_421052.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052026", "story_v_out_421052.awb") / 1000

					if var_110_14 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_6
					end

					if var_110_9.prefab_name ~= "" and arg_107_1.actors_[var_110_9.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_9.prefab_name].transform, "story_v_out_421052", "421052026", "story_v_out_421052.awb")

						arg_107_1:RecordAudio("421052026", var_110_15)
						arg_107_1:RecordAudio("421052026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_421052", "421052026", "story_v_out_421052.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_421052", "421052026", "story_v_out_421052.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_16 and arg_107_1.time_ < var_110_6 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play421052027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 421052027
		arg_111_1.duration_ = 10.6

		local var_111_0 = {
			zh = 9.366,
			ja = 10.6
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
				arg_111_0:Play421052028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.85

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[1314].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(421052027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 34
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052027", "story_v_out_421052.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052027", "story_v_out_421052.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_421052", "421052027", "story_v_out_421052.awb")

						arg_111_1:RecordAudio("421052027", var_114_9)
						arg_111_1:RecordAudio("421052027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_421052", "421052027", "story_v_out_421052.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_421052", "421052027", "story_v_out_421052.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play421052028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 421052028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play421052029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.1

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(421052028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 4
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play421052029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 421052029
		arg_119_1.duration_ = 9.3

		local var_119_0 = {
			zh = 8.233,
			ja = 9.3
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
				arg_119_0:Play421052030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.825

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[1314].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(421052029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052029", "story_v_out_421052.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052029", "story_v_out_421052.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_421052", "421052029", "story_v_out_421052.awb")

						arg_119_1:RecordAudio("421052029", var_122_9)
						arg_119_1:RecordAudio("421052029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_421052", "421052029", "story_v_out_421052.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_421052", "421052029", "story_v_out_421052.awb")
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
	Play421052030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 421052030
		arg_123_1.duration_ = 9.07

		local var_123_0 = {
			zh = 5.766,
			ja = 9.066
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
				arg_123_0:Play421052031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1047ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1047ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, -1.13, -6.2)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1047ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1047ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1047ui_story == nil then
				arg_123_1.var_.characterEffect1047ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect1047ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect1047ui_story then
				arg_123_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_126_15 = 0
			local var_126_16 = 0.75

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_17 = arg_123_1:FormatText(StoryNameCfg[1296].name)

				arg_123_1.leftNameTxt_.text = var_126_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_18 = arg_123_1:GetWordFromCfg(421052030)
				local var_126_19 = arg_123_1:FormatText(var_126_18.content)

				arg_123_1.text_.text = var_126_19

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_20 = 30
				local var_126_21 = utf8.len(var_126_19)
				local var_126_22 = var_126_20 <= 0 and var_126_16 or var_126_16 * (var_126_21 / var_126_20)

				if var_126_22 > 0 and var_126_16 < var_126_22 then
					arg_123_1.talkMaxDuration = var_126_22

					if var_126_22 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_22 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_19
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052030", "story_v_out_421052.awb") ~= 0 then
					local var_126_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052030", "story_v_out_421052.awb") / 1000

					if var_126_23 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_15
					end

					if var_126_18.prefab_name ~= "" and arg_123_1.actors_[var_126_18.prefab_name] ~= nil then
						local var_126_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_18.prefab_name].transform, "story_v_out_421052", "421052030", "story_v_out_421052.awb")

						arg_123_1:RecordAudio("421052030", var_126_24)
						arg_123_1:RecordAudio("421052030", var_126_24)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_421052", "421052030", "story_v_out_421052.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_421052", "421052030", "story_v_out_421052.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_25 and arg_123_1.time_ < var_126_15 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421052031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 421052031
		arg_127_1.duration_ = 21.03

		local var_127_0 = {
			zh = 18.066,
			ja = 21.033
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
				arg_127_0:Play421052032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1047ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1047ui_story == nil then
				arg_127_1.var_.characterEffect1047ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1047ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1047ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1047ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1047ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 1.5

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[1314].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(421052031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 60
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052031", "story_v_out_421052.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052031", "story_v_out_421052.awb") / 1000

					if var_130_14 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_6
					end

					if var_130_9.prefab_name ~= "" and arg_127_1.actors_[var_130_9.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_9.prefab_name].transform, "story_v_out_421052", "421052031", "story_v_out_421052.awb")

						arg_127_1:RecordAudio("421052031", var_130_15)
						arg_127_1:RecordAudio("421052031", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_421052", "421052031", "story_v_out_421052.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_421052", "421052031", "story_v_out_421052.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_16 and arg_127_1.time_ < var_130_6 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play421052032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 421052032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play421052033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.3

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(421052032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 12
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
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play421052033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 421052033
		arg_135_1.duration_ = 7.37

		local var_135_0 = {
			zh = 6,
			ja = 7.366
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
				arg_135_0:Play421052034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.55

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1314].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(421052033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052033", "story_v_out_421052.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052033", "story_v_out_421052.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_421052", "421052033", "story_v_out_421052.awb")

						arg_135_1:RecordAudio("421052033", var_138_9)
						arg_135_1:RecordAudio("421052033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_421052", "421052033", "story_v_out_421052.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_421052", "421052033", "story_v_out_421052.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play421052034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 421052034
		arg_139_1.duration_ = 8.13

		local var_139_0 = {
			zh = 6.466,
			ja = 8.133
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play421052035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1047ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1047ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -1.13, -6.2)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1047ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1047ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1047ui_story == nil then
				arg_139_1.var_.characterEffect1047ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1047ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1047ui_story then
				arg_139_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_142_15 = 0
			local var_142_16 = 0.775

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[1296].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(421052034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 31
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052034", "story_v_out_421052.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052034", "story_v_out_421052.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_421052", "421052034", "story_v_out_421052.awb")

						arg_139_1:RecordAudio("421052034", var_142_24)
						arg_139_1:RecordAudio("421052034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_421052", "421052034", "story_v_out_421052.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_421052", "421052034", "story_v_out_421052.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play421052035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 421052035
		arg_143_1.duration_ = 14.97

		local var_143_0 = {
			zh = 10.1,
			ja = 14.966
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
				arg_143_0:Play421052036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1047ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1047ui_story == nil then
				arg_143_1.var_.characterEffect1047ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1047ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1047ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1047ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1047ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 1.075

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[1314].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(421052035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 43
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052035", "story_v_out_421052.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052035", "story_v_out_421052.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_out_421052", "421052035", "story_v_out_421052.awb")

						arg_143_1:RecordAudio("421052035", var_146_15)
						arg_143_1:RecordAudio("421052035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_421052", "421052035", "story_v_out_421052.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_421052", "421052035", "story_v_out_421052.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play421052036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421052036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play421052037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1047ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, 100, 0)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, 100, 0)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = 0
			local var_150_10 = 0.625

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_11 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_12 = arg_147_1:GetWordFromCfg(421052036)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_14 = 25
				local var_150_15 = utf8.len(var_150_13)
				local var_150_16 = var_150_14 <= 0 and var_150_10 or var_150_10 * (var_150_15 / var_150_14)

				if var_150_16 > 0 and var_150_10 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16

					if var_150_16 + var_150_9 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_9
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_17 = math.max(var_150_10, arg_147_1.talkMaxDuration)

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_17 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_9) / var_150_17

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_9 + var_150_17 and arg_147_1.time_ < var_150_9 + var_150_17 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play421052037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421052037
		arg_151_1.duration_ = 6

		local var_151_0 = {
			zh = 4.133,
			ja = 6
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play421052038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.4

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[1314].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(421052037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 16
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052037", "story_v_out_421052.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052037", "story_v_out_421052.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_421052", "421052037", "story_v_out_421052.awb")

						arg_151_1:RecordAudio("421052037", var_154_9)
						arg_151_1:RecordAudio("421052037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_421052", "421052037", "story_v_out_421052.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_421052", "421052037", "story_v_out_421052.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play421052038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421052038
		arg_155_1.duration_ = 24.77

		local var_155_0 = {
			zh = 22.9,
			ja = 24.766
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
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421052039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.925

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[1314].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(421052038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 77
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052038", "story_v_out_421052.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052038", "story_v_out_421052.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_421052", "421052038", "story_v_out_421052.awb")

						arg_155_1:RecordAudio("421052038", var_158_9)
						arg_155_1:RecordAudio("421052038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_421052", "421052038", "story_v_out_421052.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_421052", "421052038", "story_v_out_421052.awb")
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
	Play421052039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421052039
		arg_159_1.duration_ = 14

		local var_159_0 = {
			zh = 14,
			ja = 12.433
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play421052040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.3

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[1314].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(421052039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052039", "story_v_out_421052.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052039", "story_v_out_421052.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_421052", "421052039", "story_v_out_421052.awb")

						arg_159_1:RecordAudio("421052039", var_162_9)
						arg_159_1:RecordAudio("421052039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_421052", "421052039", "story_v_out_421052.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_421052", "421052039", "story_v_out_421052.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play421052040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 421052040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play421052041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.5

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

				local var_166_3 = arg_163_1:GetWordFromCfg(421052040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 20
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
	Play421052041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 421052041
		arg_167_1.duration_ = 19.57

		local var_167_0 = {
			zh = 16.333,
			ja = 19.566
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play421052042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.475

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[1314].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(421052041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 59
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052041", "story_v_out_421052.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052041", "story_v_out_421052.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_421052", "421052041", "story_v_out_421052.awb")

						arg_167_1:RecordAudio("421052041", var_170_9)
						arg_167_1:RecordAudio("421052041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_421052", "421052041", "story_v_out_421052.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_421052", "421052041", "story_v_out_421052.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play421052042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 421052042
		arg_171_1.duration_ = 11.6

		local var_171_0 = {
			zh = 8.633,
			ja = 11.6
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play421052043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.825

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[1314].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(421052042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052042", "story_v_out_421052.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052042", "story_v_out_421052.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_421052", "421052042", "story_v_out_421052.awb")

						arg_171_1:RecordAudio("421052042", var_174_9)
						arg_171_1:RecordAudio("421052042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_421052", "421052042", "story_v_out_421052.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_421052", "421052042", "story_v_out_421052.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play421052043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 421052043
		arg_175_1.duration_ = 7.33

		local var_175_0 = {
			zh = 6.633,
			ja = 7.333
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play421052044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1047ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1047ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, -1.13, -6.2)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1047ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1047ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1047ui_story == nil then
				arg_175_1.var_.characterEffect1047ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1047ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1047ui_story then
				arg_175_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_178_15 = 0
			local var_178_16 = 1.4

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[1296].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(421052043)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 28
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052043", "story_v_out_421052.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052043", "story_v_out_421052.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_421052", "421052043", "story_v_out_421052.awb")

						arg_175_1:RecordAudio("421052043", var_178_24)
						arg_175_1:RecordAudio("421052043", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_421052", "421052043", "story_v_out_421052.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_421052", "421052043", "story_v_out_421052.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421052044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 421052044
		arg_179_1.duration_ = 8.57

		local var_179_0 = {
			zh = 5.2,
			ja = 8.566
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play421052045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1047ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1047ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(0, -1.13, -6.2)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1047ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 then
				arg_179_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_182_11 = 0
			local var_182_12 = 1.25

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_13 = arg_179_1:FormatText(StoryNameCfg[1296].name)

				arg_179_1.leftNameTxt_.text = var_182_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_14 = arg_179_1:GetWordFromCfg(421052044)
				local var_182_15 = arg_179_1:FormatText(var_182_14.content)

				arg_179_1.text_.text = var_182_15

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 28
				local var_182_17 = utf8.len(var_182_15)
				local var_182_18 = var_182_16 <= 0 and var_182_12 or var_182_12 * (var_182_17 / var_182_16)

				if var_182_18 > 0 and var_182_12 < var_182_18 then
					arg_179_1.talkMaxDuration = var_182_18

					if var_182_18 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_15
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052044", "story_v_out_421052.awb") ~= 0 then
					local var_182_19 = manager.audio:GetVoiceLength("story_v_out_421052", "421052044", "story_v_out_421052.awb") / 1000

					if var_182_19 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_19 + var_182_11
					end

					if var_182_14.prefab_name ~= "" and arg_179_1.actors_[var_182_14.prefab_name] ~= nil then
						local var_182_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_14.prefab_name].transform, "story_v_out_421052", "421052044", "story_v_out_421052.awb")

						arg_179_1:RecordAudio("421052044", var_182_20)
						arg_179_1:RecordAudio("421052044", var_182_20)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_421052", "421052044", "story_v_out_421052.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_421052", "421052044", "story_v_out_421052.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_21 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_21 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_21

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_21 and arg_179_1.time_ < var_182_11 + var_182_21 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play421052045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 421052045
		arg_183_1.duration_ = 9.33

		local var_183_0 = {
			zh = 6.566,
			ja = 9.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play421052046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1047ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1047ui_story == nil then
				arg_183_1.var_.characterEffect1047ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1047ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1047ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1047ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1047ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.65

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[1314].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(421052045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052045", "story_v_out_421052.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052045", "story_v_out_421052.awb") / 1000

					if var_186_14 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_6
					end

					if var_186_9.prefab_name ~= "" and arg_183_1.actors_[var_186_9.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_9.prefab_name].transform, "story_v_out_421052", "421052045", "story_v_out_421052.awb")

						arg_183_1:RecordAudio("421052045", var_186_15)
						arg_183_1:RecordAudio("421052045", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_421052", "421052045", "story_v_out_421052.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_421052", "421052045", "story_v_out_421052.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_16 and arg_183_1.time_ < var_186_6 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play421052046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 421052046
		arg_187_1.duration_ = 4.37

		local var_187_0 = {
			zh = 3.6,
			ja = 4.366
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play421052047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1047ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1047ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, -1.13, -6.2)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1047ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["1047ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1047ui_story == nil then
				arg_187_1.var_.characterEffect1047ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect1047ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect1047ui_story then
				arg_187_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_190_15 = 0
			local var_190_16 = 0.325

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[1296].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(421052046)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 13
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052046", "story_v_out_421052.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052046", "story_v_out_421052.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_421052", "421052046", "story_v_out_421052.awb")

						arg_187_1:RecordAudio("421052046", var_190_24)
						arg_187_1:RecordAudio("421052046", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_421052", "421052046", "story_v_out_421052.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_421052", "421052046", "story_v_out_421052.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play421052047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 421052047
		arg_191_1.duration_ = 13.53

		local var_191_0 = {
			zh = 9.7,
			ja = 13.533
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play421052048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1047ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1047ui_story == nil then
				arg_191_1.var_.characterEffect1047ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1047ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1047ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1047ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1047ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 1

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[1314].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(421052047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052047", "story_v_out_421052.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052047", "story_v_out_421052.awb") / 1000

					if var_194_14 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_6
					end

					if var_194_9.prefab_name ~= "" and arg_191_1.actors_[var_194_9.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_9.prefab_name].transform, "story_v_out_421052", "421052047", "story_v_out_421052.awb")

						arg_191_1:RecordAudio("421052047", var_194_15)
						arg_191_1:RecordAudio("421052047", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_421052", "421052047", "story_v_out_421052.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_421052", "421052047", "story_v_out_421052.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_16 and arg_191_1.time_ < var_194_6 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play421052048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 421052048
		arg_195_1.duration_ = 6.5

		local var_195_0 = {
			zh = 4.266,
			ja = 6.5
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play421052049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1047ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1047ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, -1.13, -6.2)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1047ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1047ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1047ui_story == nil then
				arg_195_1.var_.characterEffect1047ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1047ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1047ui_story then
				arg_195_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_198_15 = 0
			local var_198_16 = 0.5

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[1296].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(421052048)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 20
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052048", "story_v_out_421052.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052048", "story_v_out_421052.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_out_421052", "421052048", "story_v_out_421052.awb")

						arg_195_1:RecordAudio("421052048", var_198_24)
						arg_195_1:RecordAudio("421052048", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_421052", "421052048", "story_v_out_421052.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_421052", "421052048", "story_v_out_421052.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_25 and arg_195_1.time_ < var_198_15 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421052049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 421052049
		arg_199_1.duration_ = 10.33

		local var_199_0 = {
			zh = 6.4,
			ja = 10.333
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play421052050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1047ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1047ui_story == nil then
				arg_199_1.var_.characterEffect1047ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1047ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1047ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1047ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1047ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.575

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[1314].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(421052049)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 23
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052049", "story_v_out_421052.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052049", "story_v_out_421052.awb") / 1000

					if var_202_14 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_6
					end

					if var_202_9.prefab_name ~= "" and arg_199_1.actors_[var_202_9.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_9.prefab_name].transform, "story_v_out_421052", "421052049", "story_v_out_421052.awb")

						arg_199_1:RecordAudio("421052049", var_202_15)
						arg_199_1:RecordAudio("421052049", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_421052", "421052049", "story_v_out_421052.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_421052", "421052049", "story_v_out_421052.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_16 and arg_199_1.time_ < var_202_6 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play421052050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 421052050
		arg_203_1.duration_ = 8

		local var_203_0 = {
			zh = 7.033,
			ja = 8
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play421052051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1047ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1047ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -1.13, -6.2)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1047ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1047ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1047ui_story == nil then
				arg_203_1.var_.characterEffect1047ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1047ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1047ui_story then
				arg_203_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_206_15 = 0
			local var_206_16 = 0.775

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[1296].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(421052050)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 31
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052050", "story_v_out_421052.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052050", "story_v_out_421052.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_421052", "421052050", "story_v_out_421052.awb")

						arg_203_1:RecordAudio("421052050", var_206_24)
						arg_203_1:RecordAudio("421052050", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_421052", "421052050", "story_v_out_421052.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_421052", "421052050", "story_v_out_421052.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play421052051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 421052051
		arg_207_1.duration_ = 1.83

		local var_207_0 = {
			zh = 1.466,
			ja = 1.833
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play421052052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1047ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1047ui_story == nil then
				arg_207_1.var_.characterEffect1047ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1047ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1047ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1047ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1047ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0
			local var_210_7 = 0.125

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_8 = arg_207_1:FormatText(StoryNameCfg[1314].name)

				arg_207_1.leftNameTxt_.text = var_210_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(421052051)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 5
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_7 or var_210_7 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_7 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052051", "story_v_out_421052.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052051", "story_v_out_421052.awb") / 1000

					if var_210_14 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_6
					end

					if var_210_9.prefab_name ~= "" and arg_207_1.actors_[var_210_9.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_9.prefab_name].transform, "story_v_out_421052", "421052051", "story_v_out_421052.awb")

						arg_207_1:RecordAudio("421052051", var_210_15)
						arg_207_1:RecordAudio("421052051", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_421052", "421052051", "story_v_out_421052.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_421052", "421052051", "story_v_out_421052.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_16 and arg_207_1.time_ < var_210_6 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play421052052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 421052052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play421052053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.475

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(421052052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 19
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play421052053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 421052053
		arg_215_1.duration_ = 8.6

		local var_215_0 = {
			zh = 6.7,
			ja = 8.6
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play421052054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.7

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[1314].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(421052053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 28
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052053", "story_v_out_421052.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052053", "story_v_out_421052.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_421052", "421052053", "story_v_out_421052.awb")

						arg_215_1:RecordAudio("421052053", var_218_9)
						arg_215_1:RecordAudio("421052053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_421052", "421052053", "story_v_out_421052.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_421052", "421052053", "story_v_out_421052.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play421052054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 421052054
		arg_219_1.duration_ = 7.8

		local var_219_0 = {
			zh = 6.3,
			ja = 7.8
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
				arg_219_0:Play421052055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1047ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1047ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, -1.13, -6.2)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1047ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1047ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1047ui_story == nil then
				arg_219_1.var_.characterEffect1047ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1047ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1047ui_story then
				arg_219_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_222_15 = 0
			local var_222_16 = 0.7

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_17 = arg_219_1:FormatText(StoryNameCfg[1296].name)

				arg_219_1.leftNameTxt_.text = var_222_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_18 = arg_219_1:GetWordFromCfg(421052054)
				local var_222_19 = arg_219_1:FormatText(var_222_18.content)

				arg_219_1.text_.text = var_222_19

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 28
				local var_222_21 = utf8.len(var_222_19)
				local var_222_22 = var_222_20 <= 0 and var_222_16 or var_222_16 * (var_222_21 / var_222_20)

				if var_222_22 > 0 and var_222_16 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22

					if var_222_22 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_19
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052054", "story_v_out_421052.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052054", "story_v_out_421052.awb") / 1000

					if var_222_23 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_15
					end

					if var_222_18.prefab_name ~= "" and arg_219_1.actors_[var_222_18.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_18.prefab_name].transform, "story_v_out_421052", "421052054", "story_v_out_421052.awb")

						arg_219_1:RecordAudio("421052054", var_222_24)
						arg_219_1:RecordAudio("421052054", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_421052", "421052054", "story_v_out_421052.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_421052", "421052054", "story_v_out_421052.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_25 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_25

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_25 and arg_219_1.time_ < var_222_15 + var_222_25 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play421052055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 421052055
		arg_223_1.duration_ = 17.5

		local var_223_0 = {
			zh = 10,
			ja = 17.5
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
				arg_223_0:Play421052056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1047ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1047ui_story == nil then
				arg_223_1.var_.characterEffect1047ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1047ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1047ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1047ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1047ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.825

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[1314].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(421052055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 33
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052055", "story_v_out_421052.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052055", "story_v_out_421052.awb") / 1000

					if var_226_14 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_6
					end

					if var_226_9.prefab_name ~= "" and arg_223_1.actors_[var_226_9.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_9.prefab_name].transform, "story_v_out_421052", "421052055", "story_v_out_421052.awb")

						arg_223_1:RecordAudio("421052055", var_226_15)
						arg_223_1:RecordAudio("421052055", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_421052", "421052055", "story_v_out_421052.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_421052", "421052055", "story_v_out_421052.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_16 and arg_223_1.time_ < var_226_6 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play421052056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 421052056
		arg_227_1.duration_ = 20.1

		local var_227_0 = {
			zh = 14.7,
			ja = 20.1
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
				arg_227_0:Play421052057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1047ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1047ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, -1.13, -6.2)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1047ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1047ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1047ui_story == nil then
				arg_227_1.var_.characterEffect1047ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1047ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1047ui_story then
				arg_227_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_230_15 = 0
			local var_230_16 = 1.6

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[1296].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_18 = arg_227_1:GetWordFromCfg(421052056)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 64
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052056", "story_v_out_421052.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052056", "story_v_out_421052.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_421052", "421052056", "story_v_out_421052.awb")

						arg_227_1:RecordAudio("421052056", var_230_24)
						arg_227_1:RecordAudio("421052056", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_421052", "421052056", "story_v_out_421052.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_421052", "421052056", "story_v_out_421052.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play421052057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 421052057
		arg_231_1.duration_ = 16.6

		local var_231_0 = {
			zh = 7.9,
			ja = 16.6
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
				arg_231_0:Play421052058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.925

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[1296].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:GetWordFromCfg(421052057)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052057", "story_v_out_421052.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052057", "story_v_out_421052.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_421052", "421052057", "story_v_out_421052.awb")

						arg_231_1:RecordAudio("421052057", var_234_9)
						arg_231_1:RecordAudio("421052057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_421052", "421052057", "story_v_out_421052.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_421052", "421052057", "story_v_out_421052.awb")
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
	Play421052058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421052058
		arg_235_1.duration_ = 12.67

		local var_235_0 = {
			zh = 5.7,
			ja = 12.666
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
				arg_235_0:Play421052059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1047ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1047ui_story == nil then
				arg_235_1.var_.characterEffect1047ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1047ui_story and not isNil(var_238_0) then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1047ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1047ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1047ui_story.fillRatio = var_238_5
			end

			local var_238_6 = 0
			local var_238_7 = 0.55

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[1314].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_9 = arg_235_1:GetWordFromCfg(421052058)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 22
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052058", "story_v_out_421052.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_421052", "421052058", "story_v_out_421052.awb") / 1000

					if var_238_14 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_6
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_421052", "421052058", "story_v_out_421052.awb")

						arg_235_1:RecordAudio("421052058", var_238_15)
						arg_235_1:RecordAudio("421052058", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_421052", "421052058", "story_v_out_421052.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_421052", "421052058", "story_v_out_421052.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_16 and arg_235_1.time_ < var_238_6 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play421052059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421052059
		arg_239_1.duration_ = 13.17

		local var_239_0 = {
			zh = 9.5,
			ja = 13.166
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
				arg_239_0:Play421052060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1047ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1047ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.13, -6.2)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1047ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1047ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1047ui_story == nil then
				arg_239_1.var_.characterEffect1047ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1047ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1047ui_story then
				arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_242_15 = 0
			local var_242_16 = 0.925

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[1296].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(421052059)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 37
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052059", "story_v_out_421052.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052059", "story_v_out_421052.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_421052", "421052059", "story_v_out_421052.awb")

						arg_239_1:RecordAudio("421052059", var_242_24)
						arg_239_1:RecordAudio("421052059", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_421052", "421052059", "story_v_out_421052.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_421052", "421052059", "story_v_out_421052.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play421052060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 421052060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play421052061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1047ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1047ui_story == nil then
				arg_243_1.var_.characterEffect1047ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1047ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1047ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1047ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1047ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 1.3

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(421052060)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 52
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play421052061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 421052061
		arg_247_1.duration_ = 19.07

		local var_247_0 = {
			zh = 13.133,
			ja = 19.066
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
				arg_247_0:Play421052062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.1

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[1314].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(421052061)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052061", "story_v_out_421052.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052061", "story_v_out_421052.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_421052", "421052061", "story_v_out_421052.awb")

						arg_247_1:RecordAudio("421052061", var_250_9)
						arg_247_1:RecordAudio("421052061", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_421052", "421052061", "story_v_out_421052.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_421052", "421052061", "story_v_out_421052.awb")
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
	Play421052062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 421052062
		arg_251_1.duration_ = 5.7

		local var_251_0 = {
			zh = 4.4,
			ja = 5.7
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
				arg_251_0:Play421052063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1047ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1047ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0, -1.13, -6.2)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1047ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["1047ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1047ui_story == nil then
				arg_251_1.var_.characterEffect1047ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect1047ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1047ui_story then
				arg_251_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_254_13 = 0

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_254_15 = 0
			local var_254_16 = 0.375

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_17 = arg_251_1:FormatText(StoryNameCfg[1296].name)

				arg_251_1.leftNameTxt_.text = var_254_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_18 = arg_251_1:GetWordFromCfg(421052062)
				local var_254_19 = arg_251_1:FormatText(var_254_18.content)

				arg_251_1.text_.text = var_254_19

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_20 = 15
				local var_254_21 = utf8.len(var_254_19)
				local var_254_22 = var_254_20 <= 0 and var_254_16 or var_254_16 * (var_254_21 / var_254_20)

				if var_254_22 > 0 and var_254_16 < var_254_22 then
					arg_251_1.talkMaxDuration = var_254_22

					if var_254_22 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_22 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_19
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052062", "story_v_out_421052.awb") ~= 0 then
					local var_254_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052062", "story_v_out_421052.awb") / 1000

					if var_254_23 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_23 + var_254_15
					end

					if var_254_18.prefab_name ~= "" and arg_251_1.actors_[var_254_18.prefab_name] ~= nil then
						local var_254_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_18.prefab_name].transform, "story_v_out_421052", "421052062", "story_v_out_421052.awb")

						arg_251_1:RecordAudio("421052062", var_254_24)
						arg_251_1:RecordAudio("421052062", var_254_24)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_421052", "421052062", "story_v_out_421052.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_421052", "421052062", "story_v_out_421052.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_25 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_15 <= arg_251_1.time_ and arg_251_1.time_ < var_254_15 + var_254_25 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_15) / var_254_25

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_15 + var_254_25 and arg_251_1.time_ < var_254_15 + var_254_25 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play421052063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 421052063
		arg_255_1.duration_ = 9

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play421052064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = "B08b"

			if arg_255_1.bgs_[var_258_0] == nil then
				local var_258_1 = Object.Instantiate(arg_255_1.paintGo_)

				var_258_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_258_0)
				var_258_1.name = var_258_0
				var_258_1.transform.parent = arg_255_1.stage_.transform
				var_258_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.bgs_[var_258_0] = var_258_1
			end

			local var_258_2 = 2

			if var_258_2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				local var_258_3 = manager.ui.mainCamera.transform.localPosition
				local var_258_4 = Vector3.New(0, 0, 10) + Vector3.New(var_258_3.x, var_258_3.y, 0)
				local var_258_5 = arg_255_1.bgs_.B08b

				var_258_5.transform.localPosition = var_258_4
				var_258_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_6 = var_258_5:GetComponent("SpriteRenderer")

				if var_258_6 and var_258_6.sprite then
					local var_258_7 = (var_258_5.transform.localPosition - var_258_3).z
					local var_258_8 = manager.ui.mainCameraCom_
					local var_258_9 = 2 * var_258_7 * Mathf.Tan(var_258_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_258_10 = var_258_9 * var_258_8.aspect
					local var_258_11 = var_258_6.sprite.bounds.size.x
					local var_258_12 = var_258_6.sprite.bounds.size.y
					local var_258_13 = var_258_10 / var_258_11
					local var_258_14 = var_258_9 / var_258_12
					local var_258_15 = var_258_14 < var_258_13 and var_258_13 or var_258_14

					var_258_5.transform.localScale = Vector3.New(var_258_15, var_258_15, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "B08b" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_16 = 4

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			local var_258_17 = 0.3

			if arg_255_1.time_ >= var_258_16 + var_258_17 and arg_255_1.time_ < var_258_16 + var_258_17 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end

			local var_258_18 = 0

			if var_258_18 < arg_255_1.time_ and arg_255_1.time_ <= var_258_18 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_19 = 2

			if var_258_18 <= arg_255_1.time_ and arg_255_1.time_ < var_258_18 + var_258_19 then
				local var_258_20 = (arg_255_1.time_ - var_258_18) / var_258_19
				local var_258_21 = Color.New(0, 0, 0)

				var_258_21.a = Mathf.Lerp(0, 1, var_258_20)
				arg_255_1.mask_.color = var_258_21
			end

			if arg_255_1.time_ >= var_258_18 + var_258_19 and arg_255_1.time_ < var_258_18 + var_258_19 + arg_258_0 then
				local var_258_22 = Color.New(0, 0, 0)

				var_258_22.a = 1
				arg_255_1.mask_.color = var_258_22
			end

			local var_258_23 = 2

			if var_258_23 < arg_255_1.time_ and arg_255_1.time_ <= var_258_23 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_24 = 2

			if var_258_23 <= arg_255_1.time_ and arg_255_1.time_ < var_258_23 + var_258_24 then
				local var_258_25 = (arg_255_1.time_ - var_258_23) / var_258_24
				local var_258_26 = Color.New(0, 0, 0)

				var_258_26.a = Mathf.Lerp(1, 0, var_258_25)
				arg_255_1.mask_.color = var_258_26
			end

			if arg_255_1.time_ >= var_258_23 + var_258_24 and arg_255_1.time_ < var_258_23 + var_258_24 + arg_258_0 then
				local var_258_27 = Color.New(0, 0, 0)
				local var_258_28 = 0

				arg_255_1.mask_.enabled = false
				var_258_27.a = var_258_28
				arg_255_1.mask_.color = var_258_27
			end

			local var_258_29 = arg_255_1.actors_["1047ui_story"].transform
			local var_258_30 = 2

			if var_258_30 < arg_255_1.time_ and arg_255_1.time_ <= var_258_30 + arg_258_0 then
				arg_255_1.var_.moveOldPos1047ui_story = var_258_29.localPosition
			end

			local var_258_31 = 0.001

			if var_258_30 <= arg_255_1.time_ and arg_255_1.time_ < var_258_30 + var_258_31 then
				local var_258_32 = (arg_255_1.time_ - var_258_30) / var_258_31
				local var_258_33 = Vector3.New(0, 100, 0)

				var_258_29.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1047ui_story, var_258_33, var_258_32)

				local var_258_34 = manager.ui.mainCamera.transform.position - var_258_29.position

				var_258_29.forward = Vector3.New(var_258_34.x, var_258_34.y, var_258_34.z)

				local var_258_35 = var_258_29.localEulerAngles

				var_258_35.z = 0
				var_258_35.x = 0
				var_258_29.localEulerAngles = var_258_35
			end

			if arg_255_1.time_ >= var_258_30 + var_258_31 and arg_255_1.time_ < var_258_30 + var_258_31 + arg_258_0 then
				var_258_29.localPosition = Vector3.New(0, 100, 0)

				local var_258_36 = manager.ui.mainCamera.transform.position - var_258_29.position

				var_258_29.forward = Vector3.New(var_258_36.x, var_258_36.y, var_258_36.z)

				local var_258_37 = var_258_29.localEulerAngles

				var_258_37.z = 0
				var_258_37.x = 0
				var_258_29.localEulerAngles = var_258_37
			end

			local var_258_38 = 0.1
			local var_258_39 = 1

			if var_258_38 < arg_255_1.time_ and arg_255_1.time_ <= var_258_38 + arg_258_0 then
				local var_258_40 = "stop"
				local var_258_41 = "effect"

				arg_255_1:AudioAction(var_258_40, var_258_41, "se_story_1210", "se_story_1210_loop_wind", "")
			end

			local var_258_42 = 1.66666666666667
			local var_258_43 = 1

			if var_258_42 < arg_255_1.time_ and arg_255_1.time_ <= var_258_42 + arg_258_0 then
				local var_258_44 = "play"
				local var_258_45 = "effect"

				arg_255_1:AudioAction(var_258_44, var_258_45, "se_story_140", "se_story_140_amb_lfe", "")
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_46 = 4
			local var_258_47 = 0.85

			if var_258_46 < arg_255_1.time_ and arg_255_1.time_ <= var_258_46 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_48 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_48:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_49 = arg_255_1:GetWordFromCfg(421052063)
				local var_258_50 = arg_255_1:FormatText(var_258_49.content)

				arg_255_1.text_.text = var_258_50

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_51 = 34
				local var_258_52 = utf8.len(var_258_50)
				local var_258_53 = var_258_51 <= 0 and var_258_47 or var_258_47 * (var_258_52 / var_258_51)

				if var_258_53 > 0 and var_258_47 < var_258_53 then
					arg_255_1.talkMaxDuration = var_258_53
					var_258_46 = var_258_46 + 0.3

					if var_258_53 + var_258_46 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_53 + var_258_46
					end
				end

				arg_255_1.text_.text = var_258_50
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_54 = var_258_46 + 0.3
			local var_258_55 = math.max(var_258_47, arg_255_1.talkMaxDuration)

			if var_258_54 <= arg_255_1.time_ and arg_255_1.time_ < var_258_54 + var_258_55 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_54) / var_258_55

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_54 + var_258_55 and arg_255_1.time_ < var_258_54 + var_258_55 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play421052064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 421052064
		arg_261_1.duration_ = 7.1

		local var_261_0 = {
			zh = 6.266,
			ja = 7.1
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
				arg_261_0:Play421052065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10102ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10102ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, -0.985, -6.275)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10102ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["10102ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect10102ui_story == nil then
				arg_261_1.var_.characterEffect10102ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect10102ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect10102ui_story then
				arg_261_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_264_14 = 0

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_15 = 0
			local var_264_16 = 0.55

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[6].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(421052064)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 22
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052064", "story_v_out_421052.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052064", "story_v_out_421052.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_421052", "421052064", "story_v_out_421052.awb")

						arg_261_1:RecordAudio("421052064", var_264_24)
						arg_261_1:RecordAudio("421052064", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_421052", "421052064", "story_v_out_421052.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_421052", "421052064", "story_v_out_421052.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play421052065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 421052065
		arg_265_1.duration_ = 6.13

		local var_265_0 = {
			zh = 4.433,
			ja = 6.133
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
				arg_265_0:Play421052066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10102ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10102ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, 100, 0)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10102ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, 100, 0)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = "10143ui_story"

			if arg_265_1.actors_[var_268_9] == nil then
				local var_268_10 = Asset.Load("Char/" .. "10143ui_story")

				if not isNil(var_268_10) then
					local var_268_11 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_265_1.stage_.transform)

					var_268_11.name = var_268_9
					var_268_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_265_1.actors_[var_268_9] = var_268_11

					local var_268_12 = var_268_11:GetComponentInChildren(typeof(CharacterEffect))

					var_268_12.enabled = true

					local var_268_13 = GameObjectTools.GetOrAddComponent(var_268_11, typeof(DynamicBoneHelper))

					if var_268_13 then
						var_268_13:EnableDynamicBone(false)
					end

					arg_265_1:ShowWeapon(var_268_12.transform, false)

					arg_265_1.var_[var_268_9 .. "Animator"] = var_268_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_265_1.var_[var_268_9 .. "Animator"].applyRootMotion = true
					arg_265_1.var_[var_268_9 .. "LipSync"] = var_268_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_268_14 = arg_265_1.actors_["10143ui_story"].transform
			local var_268_15 = 0

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.var_.moveOldPos10143ui_story = var_268_14.localPosition
			end

			local var_268_16 = 0.001

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_16 then
				local var_268_17 = (arg_265_1.time_ - var_268_15) / var_268_16
				local var_268_18 = Vector3.New(-0.72, -1.06, -6)

				var_268_14.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10143ui_story, var_268_18, var_268_17)

				local var_268_19 = manager.ui.mainCamera.transform.position - var_268_14.position

				var_268_14.forward = Vector3.New(var_268_19.x, var_268_19.y, var_268_19.z)

				local var_268_20 = var_268_14.localEulerAngles

				var_268_20.z = 0
				var_268_20.x = 0
				var_268_14.localEulerAngles = var_268_20
			end

			if arg_265_1.time_ >= var_268_15 + var_268_16 and arg_265_1.time_ < var_268_15 + var_268_16 + arg_268_0 then
				var_268_14.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_268_21 = manager.ui.mainCamera.transform.position - var_268_14.position

				var_268_14.forward = Vector3.New(var_268_21.x, var_268_21.y, var_268_21.z)

				local var_268_22 = var_268_14.localEulerAngles

				var_268_22.z = 0
				var_268_22.x = 0
				var_268_14.localEulerAngles = var_268_22
			end

			local var_268_23 = arg_265_1.actors_["10143ui_story"]
			local var_268_24 = 0

			if var_268_24 < arg_265_1.time_ and arg_265_1.time_ <= var_268_24 + arg_268_0 and not isNil(var_268_23) and arg_265_1.var_.characterEffect10143ui_story == nil then
				arg_265_1.var_.characterEffect10143ui_story = var_268_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_25 = 0.200000002980232

			if var_268_24 <= arg_265_1.time_ and arg_265_1.time_ < var_268_24 + var_268_25 and not isNil(var_268_23) then
				local var_268_26 = (arg_265_1.time_ - var_268_24) / var_268_25

				if arg_265_1.var_.characterEffect10143ui_story and not isNil(var_268_23) then
					arg_265_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_24 + var_268_25 and arg_265_1.time_ < var_268_24 + var_268_25 + arg_268_0 and not isNil(var_268_23) and arg_265_1.var_.characterEffect10143ui_story then
				arg_265_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_268_27 = arg_265_1.actors_["10102ui_story"]
			local var_268_28 = 0

			if var_268_28 < arg_265_1.time_ and arg_265_1.time_ <= var_268_28 + arg_268_0 and not isNil(var_268_27) and arg_265_1.var_.characterEffect10102ui_story == nil then
				arg_265_1.var_.characterEffect10102ui_story = var_268_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_29 = 0.200000002980232

			if var_268_28 <= arg_265_1.time_ and arg_265_1.time_ < var_268_28 + var_268_29 and not isNil(var_268_27) then
				local var_268_30 = (arg_265_1.time_ - var_268_28) / var_268_29

				if arg_265_1.var_.characterEffect10102ui_story and not isNil(var_268_27) then
					local var_268_31 = Mathf.Lerp(0, 0.5, var_268_30)

					arg_265_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10102ui_story.fillRatio = var_268_31
				end
			end

			if arg_265_1.time_ >= var_268_28 + var_268_29 and arg_265_1.time_ < var_268_28 + var_268_29 + arg_268_0 and not isNil(var_268_27) and arg_265_1.var_.characterEffect10102ui_story then
				local var_268_32 = 0.5

				arg_265_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10102ui_story.fillRatio = var_268_32
			end

			local var_268_33 = 0

			if var_268_33 < arg_265_1.time_ and arg_265_1.time_ <= var_268_33 + arg_268_0 then
				arg_265_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_268_34 = 0

			if var_268_34 < arg_265_1.time_ and arg_265_1.time_ <= var_268_34 + arg_268_0 then
				arg_265_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_268_35 = 0
			local var_268_36 = 0.55

			if var_268_35 < arg_265_1.time_ and arg_265_1.time_ <= var_268_35 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_37 = arg_265_1:FormatText(StoryNameCfg[1307].name)

				arg_265_1.leftNameTxt_.text = var_268_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_38 = arg_265_1:GetWordFromCfg(421052065)
				local var_268_39 = arg_265_1:FormatText(var_268_38.content)

				arg_265_1.text_.text = var_268_39

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_40 = 22
				local var_268_41 = utf8.len(var_268_39)
				local var_268_42 = var_268_40 <= 0 and var_268_36 or var_268_36 * (var_268_41 / var_268_40)

				if var_268_42 > 0 and var_268_36 < var_268_42 then
					arg_265_1.talkMaxDuration = var_268_42

					if var_268_42 + var_268_35 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_42 + var_268_35
					end
				end

				arg_265_1.text_.text = var_268_39
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052065", "story_v_out_421052.awb") ~= 0 then
					local var_268_43 = manager.audio:GetVoiceLength("story_v_out_421052", "421052065", "story_v_out_421052.awb") / 1000

					if var_268_43 + var_268_35 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_43 + var_268_35
					end

					if var_268_38.prefab_name ~= "" and arg_265_1.actors_[var_268_38.prefab_name] ~= nil then
						local var_268_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_38.prefab_name].transform, "story_v_out_421052", "421052065", "story_v_out_421052.awb")

						arg_265_1:RecordAudio("421052065", var_268_44)
						arg_265_1:RecordAudio("421052065", var_268_44)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_421052", "421052065", "story_v_out_421052.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_421052", "421052065", "story_v_out_421052.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_45 = math.max(var_268_36, arg_265_1.talkMaxDuration)

			if var_268_35 <= arg_265_1.time_ and arg_265_1.time_ < var_268_35 + var_268_45 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_35) / var_268_45

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_35 + var_268_45 and arg_265_1.time_ < var_268_35 + var_268_45 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play421052066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 421052066
		arg_269_1.duration_ = 6.23

		local var_269_0 = {
			zh = 3.433,
			ja = 6.233
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play421052067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = "10145ui_story"

			if arg_269_1.actors_[var_272_0] == nil then
				local var_272_1 = Asset.Load("Char/" .. "10145ui_story")

				if not isNil(var_272_1) then
					local var_272_2 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_269_1.stage_.transform)

					var_272_2.name = var_272_0
					var_272_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_269_1.actors_[var_272_0] = var_272_2

					local var_272_3 = var_272_2:GetComponentInChildren(typeof(CharacterEffect))

					var_272_3.enabled = true

					local var_272_4 = GameObjectTools.GetOrAddComponent(var_272_2, typeof(DynamicBoneHelper))

					if var_272_4 then
						var_272_4:EnableDynamicBone(false)
					end

					arg_269_1:ShowWeapon(var_272_3.transform, false)

					arg_269_1.var_[var_272_0 .. "Animator"] = var_272_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_269_1.var_[var_272_0 .. "Animator"].applyRootMotion = true
					arg_269_1.var_[var_272_0 .. "LipSync"] = var_272_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_272_5 = arg_269_1.actors_["10145ui_story"].transform
			local var_272_6 = 0

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.var_.moveOldPos10145ui_story = var_272_5.localPosition
			end

			local var_272_7 = 0.001

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_7 then
				local var_272_8 = (arg_269_1.time_ - var_272_6) / var_272_7
				local var_272_9 = Vector3.New(0.78, -1, -6.2)

				var_272_5.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10145ui_story, var_272_9, var_272_8)

				local var_272_10 = manager.ui.mainCamera.transform.position - var_272_5.position

				var_272_5.forward = Vector3.New(var_272_10.x, var_272_10.y, var_272_10.z)

				local var_272_11 = var_272_5.localEulerAngles

				var_272_11.z = 0
				var_272_11.x = 0
				var_272_5.localEulerAngles = var_272_11
			end

			if arg_269_1.time_ >= var_272_6 + var_272_7 and arg_269_1.time_ < var_272_6 + var_272_7 + arg_272_0 then
				var_272_5.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_272_12 = manager.ui.mainCamera.transform.position - var_272_5.position

				var_272_5.forward = Vector3.New(var_272_12.x, var_272_12.y, var_272_12.z)

				local var_272_13 = var_272_5.localEulerAngles

				var_272_13.z = 0
				var_272_13.x = 0
				var_272_5.localEulerAngles = var_272_13
			end

			local var_272_14 = arg_269_1.actors_["10145ui_story"]
			local var_272_15 = 0

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.characterEffect10145ui_story == nil then
				arg_269_1.var_.characterEffect10145ui_story = var_272_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_16 = 0.200000002980232

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_16 and not isNil(var_272_14) then
				local var_272_17 = (arg_269_1.time_ - var_272_15) / var_272_16

				if arg_269_1.var_.characterEffect10145ui_story and not isNil(var_272_14) then
					arg_269_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_15 + var_272_16 and arg_269_1.time_ < var_272_15 + var_272_16 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.characterEffect10145ui_story then
				arg_269_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_272_18 = arg_269_1.actors_["10143ui_story"]
			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 and not isNil(var_272_18) and arg_269_1.var_.characterEffect10143ui_story == nil then
				arg_269_1.var_.characterEffect10143ui_story = var_272_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_20 = 0.200000002980232

			if var_272_19 <= arg_269_1.time_ and arg_269_1.time_ < var_272_19 + var_272_20 and not isNil(var_272_18) then
				local var_272_21 = (arg_269_1.time_ - var_272_19) / var_272_20

				if arg_269_1.var_.characterEffect10143ui_story and not isNil(var_272_18) then
					local var_272_22 = Mathf.Lerp(0, 0.5, var_272_21)

					arg_269_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10143ui_story.fillRatio = var_272_22
				end
			end

			if arg_269_1.time_ >= var_272_19 + var_272_20 and arg_269_1.time_ < var_272_19 + var_272_20 + arg_272_0 and not isNil(var_272_18) and arg_269_1.var_.characterEffect10143ui_story then
				local var_272_23 = 0.5

				arg_269_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10143ui_story.fillRatio = var_272_23
			end

			local var_272_24 = 0

			if var_272_24 < arg_269_1.time_ and arg_269_1.time_ <= var_272_24 + arg_272_0 then
				arg_269_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_272_25 = 0

			if var_272_25 < arg_269_1.time_ and arg_269_1.time_ <= var_272_25 + arg_272_0 then
				arg_269_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_272_26 = 0
			local var_272_27 = 0.4

			if var_272_26 < arg_269_1.time_ and arg_269_1.time_ <= var_272_26 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_28 = arg_269_1:FormatText(StoryNameCfg[1308].name)

				arg_269_1.leftNameTxt_.text = var_272_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_29 = arg_269_1:GetWordFromCfg(421052066)
				local var_272_30 = arg_269_1:FormatText(var_272_29.content)

				arg_269_1.text_.text = var_272_30

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_31 = 16
				local var_272_32 = utf8.len(var_272_30)
				local var_272_33 = var_272_31 <= 0 and var_272_27 or var_272_27 * (var_272_32 / var_272_31)

				if var_272_33 > 0 and var_272_27 < var_272_33 then
					arg_269_1.talkMaxDuration = var_272_33

					if var_272_33 + var_272_26 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_33 + var_272_26
					end
				end

				arg_269_1.text_.text = var_272_30
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052066", "story_v_out_421052.awb") ~= 0 then
					local var_272_34 = manager.audio:GetVoiceLength("story_v_out_421052", "421052066", "story_v_out_421052.awb") / 1000

					if var_272_34 + var_272_26 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_34 + var_272_26
					end

					if var_272_29.prefab_name ~= "" and arg_269_1.actors_[var_272_29.prefab_name] ~= nil then
						local var_272_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_29.prefab_name].transform, "story_v_out_421052", "421052066", "story_v_out_421052.awb")

						arg_269_1:RecordAudio("421052066", var_272_35)
						arg_269_1:RecordAudio("421052066", var_272_35)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_421052", "421052066", "story_v_out_421052.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_421052", "421052066", "story_v_out_421052.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_36 = math.max(var_272_27, arg_269_1.talkMaxDuration)

			if var_272_26 <= arg_269_1.time_ and arg_269_1.time_ < var_272_26 + var_272_36 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_26) / var_272_36

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_26 + var_272_36 and arg_269_1.time_ < var_272_26 + var_272_36 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421052067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421052067
		arg_273_1.duration_ = 2

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421052068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10143ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10143ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(-0.72, -1.06, -6)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10143ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["10143ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10143ui_story == nil then
				arg_273_1.var_.characterEffect10143ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect10143ui_story and not isNil(var_276_9) then
					arg_273_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect10143ui_story then
				arg_273_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_276_13 = arg_273_1.actors_["10145ui_story"]
			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 and not isNil(var_276_13) and arg_273_1.var_.characterEffect10145ui_story == nil then
				arg_273_1.var_.characterEffect10145ui_story = var_276_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_15 = 0.200000002980232

			if var_276_14 <= arg_273_1.time_ and arg_273_1.time_ < var_276_14 + var_276_15 and not isNil(var_276_13) then
				local var_276_16 = (arg_273_1.time_ - var_276_14) / var_276_15

				if arg_273_1.var_.characterEffect10145ui_story and not isNil(var_276_13) then
					local var_276_17 = Mathf.Lerp(0, 0.5, var_276_16)

					arg_273_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10145ui_story.fillRatio = var_276_17
				end
			end

			if arg_273_1.time_ >= var_276_14 + var_276_15 and arg_273_1.time_ < var_276_14 + var_276_15 + arg_276_0 and not isNil(var_276_13) and arg_273_1.var_.characterEffect10145ui_story then
				local var_276_18 = 0.5

				arg_273_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10145ui_story.fillRatio = var_276_18
			end

			local var_276_19 = 0

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 then
				arg_273_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			local var_276_20 = 0

			if var_276_20 < arg_273_1.time_ and arg_273_1.time_ <= var_276_20 + arg_276_0 then
				arg_273_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_276_21 = 0
			local var_276_22 = 0.075

			if var_276_21 < arg_273_1.time_ and arg_273_1.time_ <= var_276_21 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_23 = arg_273_1:FormatText(StoryNameCfg[1307].name)

				arg_273_1.leftNameTxt_.text = var_276_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_24 = arg_273_1:GetWordFromCfg(421052067)
				local var_276_25 = arg_273_1:FormatText(var_276_24.content)

				arg_273_1.text_.text = var_276_25

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_26 = 3
				local var_276_27 = utf8.len(var_276_25)
				local var_276_28 = var_276_26 <= 0 and var_276_22 or var_276_22 * (var_276_27 / var_276_26)

				if var_276_28 > 0 and var_276_22 < var_276_28 then
					arg_273_1.talkMaxDuration = var_276_28

					if var_276_28 + var_276_21 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_28 + var_276_21
					end
				end

				arg_273_1.text_.text = var_276_25
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052067", "story_v_out_421052.awb") ~= 0 then
					local var_276_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052067", "story_v_out_421052.awb") / 1000

					if var_276_29 + var_276_21 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_29 + var_276_21
					end

					if var_276_24.prefab_name ~= "" and arg_273_1.actors_[var_276_24.prefab_name] ~= nil then
						local var_276_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_24.prefab_name].transform, "story_v_out_421052", "421052067", "story_v_out_421052.awb")

						arg_273_1:RecordAudio("421052067", var_276_30)
						arg_273_1:RecordAudio("421052067", var_276_30)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_421052", "421052067", "story_v_out_421052.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_421052", "421052067", "story_v_out_421052.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_31 = math.max(var_276_22, arg_273_1.talkMaxDuration)

			if var_276_21 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_31 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_21) / var_276_31

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_21 + var_276_31 and arg_273_1.time_ < var_276_21 + var_276_31 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play421052068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421052068
		arg_277_1.duration_ = 2.63

		local var_277_0 = {
			zh = 2.633,
			ja = 2.2
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
				arg_277_0:Play421052069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10145ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10145ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0.78, -1, -6.2)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10145ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["10145ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect10145ui_story == nil then
				arg_277_1.var_.characterEffect10145ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect10145ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect10145ui_story then
				arg_277_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_280_13 = arg_277_1.actors_["10143ui_story"]
			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 and not isNil(var_280_13) and arg_277_1.var_.characterEffect10143ui_story == nil then
				arg_277_1.var_.characterEffect10143ui_story = var_280_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_15 = 0.200000002980232

			if var_280_14 <= arg_277_1.time_ and arg_277_1.time_ < var_280_14 + var_280_15 and not isNil(var_280_13) then
				local var_280_16 = (arg_277_1.time_ - var_280_14) / var_280_15

				if arg_277_1.var_.characterEffect10143ui_story and not isNil(var_280_13) then
					local var_280_17 = Mathf.Lerp(0, 0.5, var_280_16)

					arg_277_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10143ui_story.fillRatio = var_280_17
				end
			end

			if arg_277_1.time_ >= var_280_14 + var_280_15 and arg_277_1.time_ < var_280_14 + var_280_15 + arg_280_0 and not isNil(var_280_13) and arg_277_1.var_.characterEffect10143ui_story then
				local var_280_18 = 0.5

				arg_277_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10143ui_story.fillRatio = var_280_18
			end

			local var_280_19 = 0

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 then
				arg_277_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_280_20 = 0

			if var_280_20 < arg_277_1.time_ and arg_277_1.time_ <= var_280_20 + arg_280_0 then
				arg_277_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_21 = 0
			local var_280_22 = 0.35

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_23 = arg_277_1:FormatText(StoryNameCfg[1308].name)

				arg_277_1.leftNameTxt_.text = var_280_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_24 = arg_277_1:GetWordFromCfg(421052068)
				local var_280_25 = arg_277_1:FormatText(var_280_24.content)

				arg_277_1.text_.text = var_280_25

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_26 = 14
				local var_280_27 = utf8.len(var_280_25)
				local var_280_28 = var_280_26 <= 0 and var_280_22 or var_280_22 * (var_280_27 / var_280_26)

				if var_280_28 > 0 and var_280_22 < var_280_28 then
					arg_277_1.talkMaxDuration = var_280_28

					if var_280_28 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_28 + var_280_21
					end
				end

				arg_277_1.text_.text = var_280_25
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052068", "story_v_out_421052.awb") ~= 0 then
					local var_280_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052068", "story_v_out_421052.awb") / 1000

					if var_280_29 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_29 + var_280_21
					end

					if var_280_24.prefab_name ~= "" and arg_277_1.actors_[var_280_24.prefab_name] ~= nil then
						local var_280_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_24.prefab_name].transform, "story_v_out_421052", "421052068", "story_v_out_421052.awb")

						arg_277_1:RecordAudio("421052068", var_280_30)
						arg_277_1:RecordAudio("421052068", var_280_30)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_421052", "421052068", "story_v_out_421052.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_421052", "421052068", "story_v_out_421052.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_31 = math.max(var_280_22, arg_277_1.talkMaxDuration)

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_31 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_21) / var_280_31

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_21 + var_280_31 and arg_277_1.time_ < var_280_21 + var_280_31 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play421052069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 421052069
		arg_281_1.duration_ = 9.3

		local var_281_0 = {
			zh = 5.1,
			ja = 9.3
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play421052070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10143ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10143ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(-0.72, -1.06, -6)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10143ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["10143ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect10143ui_story == nil then
				arg_281_1.var_.characterEffect10143ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect10143ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect10143ui_story then
				arg_281_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_284_13 = arg_281_1.actors_["10145ui_story"]
			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 and not isNil(var_284_13) and arg_281_1.var_.characterEffect10145ui_story == nil then
				arg_281_1.var_.characterEffect10145ui_story = var_284_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_15 = 0.200000002980232

			if var_284_14 <= arg_281_1.time_ and arg_281_1.time_ < var_284_14 + var_284_15 and not isNil(var_284_13) then
				local var_284_16 = (arg_281_1.time_ - var_284_14) / var_284_15

				if arg_281_1.var_.characterEffect10145ui_story and not isNil(var_284_13) then
					local var_284_17 = Mathf.Lerp(0, 0.5, var_284_16)

					arg_281_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10145ui_story.fillRatio = var_284_17
				end
			end

			if arg_281_1.time_ >= var_284_14 + var_284_15 and arg_281_1.time_ < var_284_14 + var_284_15 + arg_284_0 and not isNil(var_284_13) and arg_281_1.var_.characterEffect10145ui_story then
				local var_284_18 = 0.5

				arg_281_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10145ui_story.fillRatio = var_284_18
			end

			local var_284_19 = 0

			if var_284_19 < arg_281_1.time_ and arg_281_1.time_ <= var_284_19 + arg_284_0 then
				arg_281_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			local var_284_20 = 0

			if var_284_20 < arg_281_1.time_ and arg_281_1.time_ <= var_284_20 + arg_284_0 then
				arg_281_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_284_21 = 0
			local var_284_22 = 0.625

			if var_284_21 < arg_281_1.time_ and arg_281_1.time_ <= var_284_21 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_23 = arg_281_1:FormatText(StoryNameCfg[1307].name)

				arg_281_1.leftNameTxt_.text = var_284_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_24 = arg_281_1:GetWordFromCfg(421052069)
				local var_284_25 = arg_281_1:FormatText(var_284_24.content)

				arg_281_1.text_.text = var_284_25

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_26 = 25
				local var_284_27 = utf8.len(var_284_25)
				local var_284_28 = var_284_26 <= 0 and var_284_22 or var_284_22 * (var_284_27 / var_284_26)

				if var_284_28 > 0 and var_284_22 < var_284_28 then
					arg_281_1.talkMaxDuration = var_284_28

					if var_284_28 + var_284_21 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_28 + var_284_21
					end
				end

				arg_281_1.text_.text = var_284_25
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052069", "story_v_out_421052.awb") ~= 0 then
					local var_284_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052069", "story_v_out_421052.awb") / 1000

					if var_284_29 + var_284_21 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_29 + var_284_21
					end

					if var_284_24.prefab_name ~= "" and arg_281_1.actors_[var_284_24.prefab_name] ~= nil then
						local var_284_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_24.prefab_name].transform, "story_v_out_421052", "421052069", "story_v_out_421052.awb")

						arg_281_1:RecordAudio("421052069", var_284_30)
						arg_281_1:RecordAudio("421052069", var_284_30)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_421052", "421052069", "story_v_out_421052.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_421052", "421052069", "story_v_out_421052.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_31 = math.max(var_284_22, arg_281_1.talkMaxDuration)

			if var_284_21 <= arg_281_1.time_ and arg_281_1.time_ < var_284_21 + var_284_31 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_21) / var_284_31

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_21 + var_284_31 and arg_281_1.time_ < var_284_21 + var_284_31 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play421052070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421052070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play421052071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10143ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10143ui_story == nil then
				arg_285_1.var_.characterEffect10143ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect10143ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10143ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10143ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10143ui_story.fillRatio = var_288_5
			end

			local var_288_6 = 0
			local var_288_7 = 0.35

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_8

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

				local var_288_9 = arg_285_1:GetWordFromCfg(421052070)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 14
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
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play421052071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421052071
		arg_289_1.duration_ = 3.3

		local var_289_0 = {
			zh = 2.066,
			ja = 3.3
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play421052072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10145ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10145ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0.78, -1, -6.2)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10145ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["10145ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect10145ui_story == nil then
				arg_289_1.var_.characterEffect10145ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect10145ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect10145ui_story then
				arg_289_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_292_15 = 0
			local var_292_16 = 0.225

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[1308].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(421052071)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 9
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052071", "story_v_out_421052.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052071", "story_v_out_421052.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_421052", "421052071", "story_v_out_421052.awb")

						arg_289_1:RecordAudio("421052071", var_292_24)
						arg_289_1:RecordAudio("421052071", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421052", "421052071", "story_v_out_421052.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421052", "421052071", "story_v_out_421052.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play421052072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421052072
		arg_293_1.duration_ = 5

		local var_293_0 = {
			zh = 3.1,
			ja = 5
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
				arg_293_0:Play421052073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10145ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10145ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, 100, 0)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10145ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, 100, 0)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["10143ui_story"].transform
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1.var_.moveOldPos10143ui_story = var_296_9.localPosition
			end

			local var_296_11 = 0.001

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11
				local var_296_13 = Vector3.New(0, 100, 0)

				var_296_9.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10143ui_story, var_296_13, var_296_12)

				local var_296_14 = manager.ui.mainCamera.transform.position - var_296_9.position

				var_296_9.forward = Vector3.New(var_296_14.x, var_296_14.y, var_296_14.z)

				local var_296_15 = var_296_9.localEulerAngles

				var_296_15.z = 0
				var_296_15.x = 0
				var_296_9.localEulerAngles = var_296_15
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 then
				var_296_9.localPosition = Vector3.New(0, 100, 0)

				local var_296_16 = manager.ui.mainCamera.transform.position - var_296_9.position

				var_296_9.forward = Vector3.New(var_296_16.x, var_296_16.y, var_296_16.z)

				local var_296_17 = var_296_9.localEulerAngles

				var_296_17.z = 0
				var_296_17.x = 0
				var_296_9.localEulerAngles = var_296_17
			end

			local var_296_18 = arg_293_1.actors_["1047ui_story"].transform
			local var_296_19 = 0

			if var_296_19 < arg_293_1.time_ and arg_293_1.time_ <= var_296_19 + arg_296_0 then
				arg_293_1.var_.moveOldPos1047ui_story = var_296_18.localPosition
			end

			local var_296_20 = 0.001

			if var_296_19 <= arg_293_1.time_ and arg_293_1.time_ < var_296_19 + var_296_20 then
				local var_296_21 = (arg_293_1.time_ - var_296_19) / var_296_20
				local var_296_22 = Vector3.New(0, -1.13, -6.2)

				var_296_18.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1047ui_story, var_296_22, var_296_21)

				local var_296_23 = manager.ui.mainCamera.transform.position - var_296_18.position

				var_296_18.forward = Vector3.New(var_296_23.x, var_296_23.y, var_296_23.z)

				local var_296_24 = var_296_18.localEulerAngles

				var_296_24.z = 0
				var_296_24.x = 0
				var_296_18.localEulerAngles = var_296_24
			end

			if arg_293_1.time_ >= var_296_19 + var_296_20 and arg_293_1.time_ < var_296_19 + var_296_20 + arg_296_0 then
				var_296_18.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_296_25 = manager.ui.mainCamera.transform.position - var_296_18.position

				var_296_18.forward = Vector3.New(var_296_25.x, var_296_25.y, var_296_25.z)

				local var_296_26 = var_296_18.localEulerAngles

				var_296_26.z = 0
				var_296_26.x = 0
				var_296_18.localEulerAngles = var_296_26
			end

			local var_296_27 = arg_293_1.actors_["1047ui_story"]
			local var_296_28 = 0

			if var_296_28 < arg_293_1.time_ and arg_293_1.time_ <= var_296_28 + arg_296_0 and not isNil(var_296_27) and arg_293_1.var_.characterEffect1047ui_story == nil then
				arg_293_1.var_.characterEffect1047ui_story = var_296_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_29 = 0.200000002980232

			if var_296_28 <= arg_293_1.time_ and arg_293_1.time_ < var_296_28 + var_296_29 and not isNil(var_296_27) then
				local var_296_30 = (arg_293_1.time_ - var_296_28) / var_296_29

				if arg_293_1.var_.characterEffect1047ui_story and not isNil(var_296_27) then
					arg_293_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_28 + var_296_29 and arg_293_1.time_ < var_296_28 + var_296_29 + arg_296_0 and not isNil(var_296_27) and arg_293_1.var_.characterEffect1047ui_story then
				arg_293_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_296_31 = arg_293_1.actors_["10145ui_story"]
			local var_296_32 = 0

			if var_296_32 < arg_293_1.time_ and arg_293_1.time_ <= var_296_32 + arg_296_0 and not isNil(var_296_31) and arg_293_1.var_.characterEffect10145ui_story == nil then
				arg_293_1.var_.characterEffect10145ui_story = var_296_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_33 = 0.200000002980232

			if var_296_32 <= arg_293_1.time_ and arg_293_1.time_ < var_296_32 + var_296_33 and not isNil(var_296_31) then
				local var_296_34 = (arg_293_1.time_ - var_296_32) / var_296_33

				if arg_293_1.var_.characterEffect10145ui_story and not isNil(var_296_31) then
					local var_296_35 = Mathf.Lerp(0, 0.5, var_296_34)

					arg_293_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10145ui_story.fillRatio = var_296_35
				end
			end

			if arg_293_1.time_ >= var_296_32 + var_296_33 and arg_293_1.time_ < var_296_32 + var_296_33 + arg_296_0 and not isNil(var_296_31) and arg_293_1.var_.characterEffect10145ui_story then
				local var_296_36 = 0.5

				arg_293_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10145ui_story.fillRatio = var_296_36
			end

			local var_296_37 = 0

			if var_296_37 < arg_293_1.time_ and arg_293_1.time_ <= var_296_37 + arg_296_0 then
				arg_293_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_296_38 = 0

			if var_296_38 < arg_293_1.time_ and arg_293_1.time_ <= var_296_38 + arg_296_0 then
				arg_293_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_296_39 = 0
			local var_296_40 = 0.575

			if var_296_39 < arg_293_1.time_ and arg_293_1.time_ <= var_296_39 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_41 = arg_293_1:FormatText(StoryNameCfg[1296].name)

				arg_293_1.leftNameTxt_.text = var_296_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_42 = arg_293_1:GetWordFromCfg(421052072)
				local var_296_43 = arg_293_1:FormatText(var_296_42.content)

				arg_293_1.text_.text = var_296_43

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_44 = 23
				local var_296_45 = utf8.len(var_296_43)
				local var_296_46 = var_296_44 <= 0 and var_296_40 or var_296_40 * (var_296_45 / var_296_44)

				if var_296_46 > 0 and var_296_40 < var_296_46 then
					arg_293_1.talkMaxDuration = var_296_46

					if var_296_46 + var_296_39 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_46 + var_296_39
					end
				end

				arg_293_1.text_.text = var_296_43
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052072", "story_v_out_421052.awb") ~= 0 then
					local var_296_47 = manager.audio:GetVoiceLength("story_v_out_421052", "421052072", "story_v_out_421052.awb") / 1000

					if var_296_47 + var_296_39 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_47 + var_296_39
					end

					if var_296_42.prefab_name ~= "" and arg_293_1.actors_[var_296_42.prefab_name] ~= nil then
						local var_296_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_42.prefab_name].transform, "story_v_out_421052", "421052072", "story_v_out_421052.awb")

						arg_293_1:RecordAudio("421052072", var_296_48)
						arg_293_1:RecordAudio("421052072", var_296_48)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_421052", "421052072", "story_v_out_421052.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_421052", "421052072", "story_v_out_421052.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_49 = math.max(var_296_40, arg_293_1.talkMaxDuration)

			if var_296_39 <= arg_293_1.time_ and arg_293_1.time_ < var_296_39 + var_296_49 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_39) / var_296_49

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_39 + var_296_49 and arg_293_1.time_ < var_296_39 + var_296_49 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play421052073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421052073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421052074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1047ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1047ui_story == nil then
				arg_297_1.var_.characterEffect1047ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1047ui_story and not isNil(var_300_0) then
					local var_300_4 = Mathf.Lerp(0, 0.5, var_300_3)

					arg_297_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1047ui_story.fillRatio = var_300_4
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1047ui_story then
				local var_300_5 = 0.5

				arg_297_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1047ui_story.fillRatio = var_300_5
			end

			local var_300_6 = 0
			local var_300_7 = 0.95

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_8 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_9 = arg_297_1:GetWordFromCfg(421052073)
				local var_300_10 = arg_297_1:FormatText(var_300_9.content)

				arg_297_1.text_.text = var_300_10

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 38
				local var_300_12 = utf8.len(var_300_10)
				local var_300_13 = var_300_11 <= 0 and var_300_7 or var_300_7 * (var_300_12 / var_300_11)

				if var_300_13 > 0 and var_300_7 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_10
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play421052074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 421052074
		arg_301_1.duration_ = 14.1

		local var_301_0 = {
			zh = 10.3,
			ja = 14.1
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
				arg_301_0:Play421052075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1047ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1047ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, -1.13, -6.2)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1047ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1047ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1047ui_story == nil then
				arg_301_1.var_.characterEffect1047ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1047ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1047ui_story then
				arg_301_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_304_15 = 0
			local var_304_16 = 1.05

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[1296].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(421052074)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 42
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052074", "story_v_out_421052.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052074", "story_v_out_421052.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_out_421052", "421052074", "story_v_out_421052.awb")

						arg_301_1:RecordAudio("421052074", var_304_24)
						arg_301_1:RecordAudio("421052074", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_421052", "421052074", "story_v_out_421052.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_421052", "421052074", "story_v_out_421052.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play421052075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 421052075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play421052076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1047ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1047ui_story == nil then
				arg_305_1.var_.characterEffect1047ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1047ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1047ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1047ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1047ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.875

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(421052075)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 35
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play421052076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 421052076
		arg_309_1.duration_ = 6.73

		local var_309_0 = {
			zh = 6.6,
			ja = 6.733
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play421052077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1047ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos1047ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, -1.13, -6.2)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1047ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1047ui_story"]
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1047ui_story == nil then
				arg_309_1.var_.characterEffect1047ui_story = var_312_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_11 = 0.200000002980232

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 and not isNil(var_312_9) then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11

				if arg_309_1.var_.characterEffect1047ui_story and not isNil(var_312_9) then
					arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 and not isNil(var_312_9) and arg_309_1.var_.characterEffect1047ui_story then
				arg_309_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_312_13 = 0

			if var_312_13 < arg_309_1.time_ and arg_309_1.time_ <= var_312_13 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_312_14 = 0

			if var_312_14 < arg_309_1.time_ and arg_309_1.time_ <= var_312_14 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_312_15 = 0
			local var_312_16 = 0.8

			if var_312_15 < arg_309_1.time_ and arg_309_1.time_ <= var_312_15 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_17 = arg_309_1:FormatText(StoryNameCfg[1296].name)

				arg_309_1.leftNameTxt_.text = var_312_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_18 = arg_309_1:GetWordFromCfg(421052076)
				local var_312_19 = arg_309_1:FormatText(var_312_18.content)

				arg_309_1.text_.text = var_312_19

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_20 = 32
				local var_312_21 = utf8.len(var_312_19)
				local var_312_22 = var_312_20 <= 0 and var_312_16 or var_312_16 * (var_312_21 / var_312_20)

				if var_312_22 > 0 and var_312_16 < var_312_22 then
					arg_309_1.talkMaxDuration = var_312_22

					if var_312_22 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_22 + var_312_15
					end
				end

				arg_309_1.text_.text = var_312_19
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052076", "story_v_out_421052.awb") ~= 0 then
					local var_312_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052076", "story_v_out_421052.awb") / 1000

					if var_312_23 + var_312_15 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_15
					end

					if var_312_18.prefab_name ~= "" and arg_309_1.actors_[var_312_18.prefab_name] ~= nil then
						local var_312_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_18.prefab_name].transform, "story_v_out_421052", "421052076", "story_v_out_421052.awb")

						arg_309_1:RecordAudio("421052076", var_312_24)
						arg_309_1:RecordAudio("421052076", var_312_24)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_421052", "421052076", "story_v_out_421052.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_421052", "421052076", "story_v_out_421052.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_25 = math.max(var_312_16, arg_309_1.talkMaxDuration)

			if var_312_15 <= arg_309_1.time_ and arg_309_1.time_ < var_312_15 + var_312_25 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_15) / var_312_25

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_15 + var_312_25 and arg_309_1.time_ < var_312_15 + var_312_25 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play421052077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 421052077
		arg_313_1.duration_ = 6.23

		local var_313_0 = {
			zh = 4.566,
			ja = 6.233
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
				arg_313_0:Play421052078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10102ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos10102ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0.7, -0.985, -6.275)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10102ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1047ui_story"].transform
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.var_.moveOldPos1047ui_story = var_316_9.localPosition
			end

			local var_316_11 = 0.001

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11
				local var_316_13 = Vector3.New(-0.6, -1.13, -6.2)

				var_316_9.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1047ui_story, var_316_13, var_316_12)

				local var_316_14 = manager.ui.mainCamera.transform.position - var_316_9.position

				var_316_9.forward = Vector3.New(var_316_14.x, var_316_14.y, var_316_14.z)

				local var_316_15 = var_316_9.localEulerAngles

				var_316_15.z = 0
				var_316_15.x = 0
				var_316_9.localEulerAngles = var_316_15
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 then
				var_316_9.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_316_16 = manager.ui.mainCamera.transform.position - var_316_9.position

				var_316_9.forward = Vector3.New(var_316_16.x, var_316_16.y, var_316_16.z)

				local var_316_17 = var_316_9.localEulerAngles

				var_316_17.z = 0
				var_316_17.x = 0
				var_316_9.localEulerAngles = var_316_17
			end

			local var_316_18 = arg_313_1.actors_["10102ui_story"]
			local var_316_19 = 0

			if var_316_19 < arg_313_1.time_ and arg_313_1.time_ <= var_316_19 + arg_316_0 and not isNil(var_316_18) and arg_313_1.var_.characterEffect10102ui_story == nil then
				arg_313_1.var_.characterEffect10102ui_story = var_316_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_20 = 0.200000002980232

			if var_316_19 <= arg_313_1.time_ and arg_313_1.time_ < var_316_19 + var_316_20 and not isNil(var_316_18) then
				local var_316_21 = (arg_313_1.time_ - var_316_19) / var_316_20

				if arg_313_1.var_.characterEffect10102ui_story and not isNil(var_316_18) then
					arg_313_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_19 + var_316_20 and arg_313_1.time_ < var_316_19 + var_316_20 + arg_316_0 and not isNil(var_316_18) and arg_313_1.var_.characterEffect10102ui_story then
				arg_313_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_316_22 = arg_313_1.actors_["1047ui_story"]
			local var_316_23 = 0

			if var_316_23 < arg_313_1.time_ and arg_313_1.time_ <= var_316_23 + arg_316_0 and not isNil(var_316_22) and arg_313_1.var_.characterEffect1047ui_story == nil then
				arg_313_1.var_.characterEffect1047ui_story = var_316_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_24 = 0.200000002980232

			if var_316_23 <= arg_313_1.time_ and arg_313_1.time_ < var_316_23 + var_316_24 and not isNil(var_316_22) then
				local var_316_25 = (arg_313_1.time_ - var_316_23) / var_316_24

				if arg_313_1.var_.characterEffect1047ui_story and not isNil(var_316_22) then
					local var_316_26 = Mathf.Lerp(0, 0.5, var_316_25)

					arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1047ui_story.fillRatio = var_316_26
				end
			end

			if arg_313_1.time_ >= var_316_23 + var_316_24 and arg_313_1.time_ < var_316_23 + var_316_24 + arg_316_0 and not isNil(var_316_22) and arg_313_1.var_.characterEffect1047ui_story then
				local var_316_27 = 0.5

				arg_313_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1047ui_story.fillRatio = var_316_27
			end

			local var_316_28 = 0

			if var_316_28 < arg_313_1.time_ and arg_313_1.time_ <= var_316_28 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_316_29 = 0

			if var_316_29 < arg_313_1.time_ and arg_313_1.time_ <= var_316_29 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_30 = 0
			local var_316_31 = 0.5

			if var_316_30 < arg_313_1.time_ and arg_313_1.time_ <= var_316_30 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_32 = arg_313_1:FormatText(StoryNameCfg[6].name)

				arg_313_1.leftNameTxt_.text = var_316_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_33 = arg_313_1:GetWordFromCfg(421052077)
				local var_316_34 = arg_313_1:FormatText(var_316_33.content)

				arg_313_1.text_.text = var_316_34

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_35 = 20
				local var_316_36 = utf8.len(var_316_34)
				local var_316_37 = var_316_35 <= 0 and var_316_31 or var_316_31 * (var_316_36 / var_316_35)

				if var_316_37 > 0 and var_316_31 < var_316_37 then
					arg_313_1.talkMaxDuration = var_316_37

					if var_316_37 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_37 + var_316_30
					end
				end

				arg_313_1.text_.text = var_316_34
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052077", "story_v_out_421052.awb") ~= 0 then
					local var_316_38 = manager.audio:GetVoiceLength("story_v_out_421052", "421052077", "story_v_out_421052.awb") / 1000

					if var_316_38 + var_316_30 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_38 + var_316_30
					end

					if var_316_33.prefab_name ~= "" and arg_313_1.actors_[var_316_33.prefab_name] ~= nil then
						local var_316_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_33.prefab_name].transform, "story_v_out_421052", "421052077", "story_v_out_421052.awb")

						arg_313_1:RecordAudio("421052077", var_316_39)
						arg_313_1:RecordAudio("421052077", var_316_39)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_421052", "421052077", "story_v_out_421052.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_421052", "421052077", "story_v_out_421052.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_40 = math.max(var_316_31, arg_313_1.talkMaxDuration)

			if var_316_30 <= arg_313_1.time_ and arg_313_1.time_ < var_316_30 + var_316_40 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_30) / var_316_40

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_30 + var_316_40 and arg_313_1.time_ < var_316_30 + var_316_40 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play421052078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 421052078
		arg_317_1.duration_ = 8.23

		local var_317_0 = {
			zh = 6.2,
			ja = 8.233
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play421052079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1047ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1047ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1047ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1047ui_story"]
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1047ui_story == nil then
				arg_317_1.var_.characterEffect1047ui_story = var_320_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 and not isNil(var_320_9) then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11

				if arg_317_1.var_.characterEffect1047ui_story and not isNil(var_320_9) then
					arg_317_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1047ui_story then
				arg_317_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_320_13 = arg_317_1.actors_["10102ui_story"]
			local var_320_14 = 0

			if var_320_14 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 and not isNil(var_320_13) and arg_317_1.var_.characterEffect10102ui_story == nil then
				arg_317_1.var_.characterEffect10102ui_story = var_320_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_15 = 0.200000002980232

			if var_320_14 <= arg_317_1.time_ and arg_317_1.time_ < var_320_14 + var_320_15 and not isNil(var_320_13) then
				local var_320_16 = (arg_317_1.time_ - var_320_14) / var_320_15

				if arg_317_1.var_.characterEffect10102ui_story and not isNil(var_320_13) then
					local var_320_17 = Mathf.Lerp(0, 0.5, var_320_16)

					arg_317_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10102ui_story.fillRatio = var_320_17
				end
			end

			if arg_317_1.time_ >= var_320_14 + var_320_15 and arg_317_1.time_ < var_320_14 + var_320_15 + arg_320_0 and not isNil(var_320_13) and arg_317_1.var_.characterEffect10102ui_story then
				local var_320_18 = 0.5

				arg_317_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10102ui_story.fillRatio = var_320_18
			end

			local var_320_19 = 0

			if var_320_19 < arg_317_1.time_ and arg_317_1.time_ <= var_320_19 + arg_320_0 then
				arg_317_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			local var_320_20 = 0

			if var_320_20 < arg_317_1.time_ and arg_317_1.time_ <= var_320_20 + arg_320_0 then
				arg_317_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_21 = 0
			local var_320_22 = 0.7

			if var_320_21 < arg_317_1.time_ and arg_317_1.time_ <= var_320_21 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_23 = arg_317_1:FormatText(StoryNameCfg[1296].name)

				arg_317_1.leftNameTxt_.text = var_320_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_24 = arg_317_1:GetWordFromCfg(421052078)
				local var_320_25 = arg_317_1:FormatText(var_320_24.content)

				arg_317_1.text_.text = var_320_25

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_26 = 28
				local var_320_27 = utf8.len(var_320_25)
				local var_320_28 = var_320_26 <= 0 and var_320_22 or var_320_22 * (var_320_27 / var_320_26)

				if var_320_28 > 0 and var_320_22 < var_320_28 then
					arg_317_1.talkMaxDuration = var_320_28

					if var_320_28 + var_320_21 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_21
					end
				end

				arg_317_1.text_.text = var_320_25
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052078", "story_v_out_421052.awb") ~= 0 then
					local var_320_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052078", "story_v_out_421052.awb") / 1000

					if var_320_29 + var_320_21 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_29 + var_320_21
					end

					if var_320_24.prefab_name ~= "" and arg_317_1.actors_[var_320_24.prefab_name] ~= nil then
						local var_320_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_24.prefab_name].transform, "story_v_out_421052", "421052078", "story_v_out_421052.awb")

						arg_317_1:RecordAudio("421052078", var_320_30)
						arg_317_1:RecordAudio("421052078", var_320_30)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_421052", "421052078", "story_v_out_421052.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_421052", "421052078", "story_v_out_421052.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_31 = math.max(var_320_22, arg_317_1.talkMaxDuration)

			if var_320_21 <= arg_317_1.time_ and arg_317_1.time_ < var_320_21 + var_320_31 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_21) / var_320_31

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_21 + var_320_31 and arg_317_1.time_ < var_320_21 + var_320_31 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play421052079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421052079
		arg_321_1.duration_ = 2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play421052080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10143ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos10143ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0.78, -1.06, -6)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10143ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["10102ui_story"].transform
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 then
				arg_321_1.var_.moveOldPos10102ui_story = var_324_9.localPosition
			end

			local var_324_11 = 0.001

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11
				local var_324_13 = Vector3.New(0, 100, 0)

				var_324_9.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10102ui_story, var_324_13, var_324_12)

				local var_324_14 = manager.ui.mainCamera.transform.position - var_324_9.position

				var_324_9.forward = Vector3.New(var_324_14.x, var_324_14.y, var_324_14.z)

				local var_324_15 = var_324_9.localEulerAngles

				var_324_15.z = 0
				var_324_15.x = 0
				var_324_9.localEulerAngles = var_324_15
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 then
				var_324_9.localPosition = Vector3.New(0, 100, 0)

				local var_324_16 = manager.ui.mainCamera.transform.position - var_324_9.position

				var_324_9.forward = Vector3.New(var_324_16.x, var_324_16.y, var_324_16.z)

				local var_324_17 = var_324_9.localEulerAngles

				var_324_17.z = 0
				var_324_17.x = 0
				var_324_9.localEulerAngles = var_324_17
			end

			local var_324_18 = arg_321_1.actors_["10143ui_story"]
			local var_324_19 = 0

			if var_324_19 < arg_321_1.time_ and arg_321_1.time_ <= var_324_19 + arg_324_0 and not isNil(var_324_18) and arg_321_1.var_.characterEffect10143ui_story == nil then
				arg_321_1.var_.characterEffect10143ui_story = var_324_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_20 = 0.200000002980232

			if var_324_19 <= arg_321_1.time_ and arg_321_1.time_ < var_324_19 + var_324_20 and not isNil(var_324_18) then
				local var_324_21 = (arg_321_1.time_ - var_324_19) / var_324_20

				if arg_321_1.var_.characterEffect10143ui_story and not isNil(var_324_18) then
					arg_321_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_19 + var_324_20 and arg_321_1.time_ < var_324_19 + var_324_20 + arg_324_0 and not isNil(var_324_18) and arg_321_1.var_.characterEffect10143ui_story then
				arg_321_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_324_22 = arg_321_1.actors_["1047ui_story"]
			local var_324_23 = 0

			if var_324_23 < arg_321_1.time_ and arg_321_1.time_ <= var_324_23 + arg_324_0 and not isNil(var_324_22) and arg_321_1.var_.characterEffect1047ui_story == nil then
				arg_321_1.var_.characterEffect1047ui_story = var_324_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_24 = 0.200000002980232

			if var_324_23 <= arg_321_1.time_ and arg_321_1.time_ < var_324_23 + var_324_24 and not isNil(var_324_22) then
				local var_324_25 = (arg_321_1.time_ - var_324_23) / var_324_24

				if arg_321_1.var_.characterEffect1047ui_story and not isNil(var_324_22) then
					local var_324_26 = Mathf.Lerp(0, 0.5, var_324_25)

					arg_321_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1047ui_story.fillRatio = var_324_26
				end
			end

			if arg_321_1.time_ >= var_324_23 + var_324_24 and arg_321_1.time_ < var_324_23 + var_324_24 + arg_324_0 and not isNil(var_324_22) and arg_321_1.var_.characterEffect1047ui_story then
				local var_324_27 = 0.5

				arg_321_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1047ui_story.fillRatio = var_324_27
			end

			local var_324_28 = 0

			if var_324_28 < arg_321_1.time_ and arg_321_1.time_ <= var_324_28 + arg_324_0 then
				arg_321_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_324_29 = 0

			if var_324_29 < arg_321_1.time_ and arg_321_1.time_ <= var_324_29 + arg_324_0 then
				arg_321_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_324_30 = 0
			local var_324_31 = 0.075

			if var_324_30 < arg_321_1.time_ and arg_321_1.time_ <= var_324_30 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_32 = arg_321_1:FormatText(StoryNameCfg[1307].name)

				arg_321_1.leftNameTxt_.text = var_324_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_33 = arg_321_1:GetWordFromCfg(421052079)
				local var_324_34 = arg_321_1:FormatText(var_324_33.content)

				arg_321_1.text_.text = var_324_34

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_35 = 3
				local var_324_36 = utf8.len(var_324_34)
				local var_324_37 = var_324_35 <= 0 and var_324_31 or var_324_31 * (var_324_36 / var_324_35)

				if var_324_37 > 0 and var_324_31 < var_324_37 then
					arg_321_1.talkMaxDuration = var_324_37

					if var_324_37 + var_324_30 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_37 + var_324_30
					end
				end

				arg_321_1.text_.text = var_324_34
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052079", "story_v_out_421052.awb") ~= 0 then
					local var_324_38 = manager.audio:GetVoiceLength("story_v_out_421052", "421052079", "story_v_out_421052.awb") / 1000

					if var_324_38 + var_324_30 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_38 + var_324_30
					end

					if var_324_33.prefab_name ~= "" and arg_321_1.actors_[var_324_33.prefab_name] ~= nil then
						local var_324_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_33.prefab_name].transform, "story_v_out_421052", "421052079", "story_v_out_421052.awb")

						arg_321_1:RecordAudio("421052079", var_324_39)
						arg_321_1:RecordAudio("421052079", var_324_39)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_421052", "421052079", "story_v_out_421052.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_421052", "421052079", "story_v_out_421052.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_40 = math.max(var_324_31, arg_321_1.talkMaxDuration)

			if var_324_30 <= arg_321_1.time_ and arg_321_1.time_ < var_324_30 + var_324_40 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_30) / var_324_40

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_30 + var_324_40 and arg_321_1.time_ < var_324_30 + var_324_40 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421052080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421052080
		arg_325_1.duration_ = 19.73

		local var_325_0 = {
			zh = 10.933,
			ja = 19.733
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421052081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1047ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1047ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1047ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1047ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1047ui_story == nil then
				arg_325_1.var_.characterEffect1047ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1047ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1047ui_story then
				arg_325_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_328_13 = arg_325_1.actors_["10143ui_story"]
			local var_328_14 = 0

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 and not isNil(var_328_13) and arg_325_1.var_.characterEffect10143ui_story == nil then
				arg_325_1.var_.characterEffect10143ui_story = var_328_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_15 = 0.200000002980232

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_15 and not isNil(var_328_13) then
				local var_328_16 = (arg_325_1.time_ - var_328_14) / var_328_15

				if arg_325_1.var_.characterEffect10143ui_story and not isNil(var_328_13) then
					local var_328_17 = Mathf.Lerp(0, 0.5, var_328_16)

					arg_325_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10143ui_story.fillRatio = var_328_17
				end
			end

			if arg_325_1.time_ >= var_328_14 + var_328_15 and arg_325_1.time_ < var_328_14 + var_328_15 + arg_328_0 and not isNil(var_328_13) and arg_325_1.var_.characterEffect10143ui_story then
				local var_328_18 = 0.5

				arg_325_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10143ui_story.fillRatio = var_328_18
			end

			local var_328_19 = 0

			if var_328_19 < arg_325_1.time_ and arg_325_1.time_ <= var_328_19 + arg_328_0 then
				arg_325_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_328_20 = 0

			if var_328_20 < arg_325_1.time_ and arg_325_1.time_ <= var_328_20 + arg_328_0 then
				arg_325_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_328_21 = 0
			local var_328_22 = 1.1

			if var_328_21 < arg_325_1.time_ and arg_325_1.time_ <= var_328_21 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_23 = arg_325_1:FormatText(StoryNameCfg[1296].name)

				arg_325_1.leftNameTxt_.text = var_328_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_24 = arg_325_1:GetWordFromCfg(421052080)
				local var_328_25 = arg_325_1:FormatText(var_328_24.content)

				arg_325_1.text_.text = var_328_25

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_26 = 44
				local var_328_27 = utf8.len(var_328_25)
				local var_328_28 = var_328_26 <= 0 and var_328_22 or var_328_22 * (var_328_27 / var_328_26)

				if var_328_28 > 0 and var_328_22 < var_328_28 then
					arg_325_1.talkMaxDuration = var_328_28

					if var_328_28 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_28 + var_328_21
					end
				end

				arg_325_1.text_.text = var_328_25
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052080", "story_v_out_421052.awb") ~= 0 then
					local var_328_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052080", "story_v_out_421052.awb") / 1000

					if var_328_29 + var_328_21 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_29 + var_328_21
					end

					if var_328_24.prefab_name ~= "" and arg_325_1.actors_[var_328_24.prefab_name] ~= nil then
						local var_328_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_24.prefab_name].transform, "story_v_out_421052", "421052080", "story_v_out_421052.awb")

						arg_325_1:RecordAudio("421052080", var_328_30)
						arg_325_1:RecordAudio("421052080", var_328_30)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_421052", "421052080", "story_v_out_421052.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_421052", "421052080", "story_v_out_421052.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_31 = math.max(var_328_22, arg_325_1.talkMaxDuration)

			if var_328_21 <= arg_325_1.time_ and arg_325_1.time_ < var_328_21 + var_328_31 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_21) / var_328_31

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_21 + var_328_31 and arg_325_1.time_ < var_328_21 + var_328_31 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play421052081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421052081
		arg_329_1.duration_ = 11.7

		local var_329_0 = {
			zh = 9.733,
			ja = 11.7
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421052082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = "ST2401"

			if arg_329_1.bgs_[var_332_0] == nil then
				local var_332_1 = Object.Instantiate(arg_329_1.paintGo_)

				var_332_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_332_0)
				var_332_1.name = var_332_0
				var_332_1.transform.parent = arg_329_1.stage_.transform
				var_332_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.bgs_[var_332_0] = var_332_1
			end

			local var_332_2 = 2

			if var_332_2 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				local var_332_3 = manager.ui.mainCamera.transform.localPosition
				local var_332_4 = Vector3.New(0, 0, 10) + Vector3.New(var_332_3.x, var_332_3.y, 0)
				local var_332_5 = arg_329_1.bgs_.ST2401

				var_332_5.transform.localPosition = var_332_4
				var_332_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_332_6 = var_332_5:GetComponent("SpriteRenderer")

				if var_332_6 and var_332_6.sprite then
					local var_332_7 = (var_332_5.transform.localPosition - var_332_3).z
					local var_332_8 = manager.ui.mainCameraCom_
					local var_332_9 = 2 * var_332_7 * Mathf.Tan(var_332_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_332_10 = var_332_9 * var_332_8.aspect
					local var_332_11 = var_332_6.sprite.bounds.size.x
					local var_332_12 = var_332_6.sprite.bounds.size.y
					local var_332_13 = var_332_10 / var_332_11
					local var_332_14 = var_332_9 / var_332_12
					local var_332_15 = var_332_14 < var_332_13 and var_332_13 or var_332_14

					var_332_5.transform.localScale = Vector3.New(var_332_15, var_332_15, 0)
				end

				for iter_332_0, iter_332_1 in pairs(arg_329_1.bgs_) do
					if iter_332_0 ~= "ST2401" then
						iter_332_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_332_16 = 4

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_17 = 0.3

			if arg_329_1.time_ >= var_332_16 + var_332_17 and arg_329_1.time_ < var_332_16 + var_332_17 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end

			local var_332_18 = 0

			if var_332_18 < arg_329_1.time_ and arg_329_1.time_ <= var_332_18 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_19 = 2

			if var_332_18 <= arg_329_1.time_ and arg_329_1.time_ < var_332_18 + var_332_19 then
				local var_332_20 = (arg_329_1.time_ - var_332_18) / var_332_19
				local var_332_21 = Color.New(0, 0, 0)

				var_332_21.a = Mathf.Lerp(0, 1, var_332_20)
				arg_329_1.mask_.color = var_332_21
			end

			if arg_329_1.time_ >= var_332_18 + var_332_19 and arg_329_1.time_ < var_332_18 + var_332_19 + arg_332_0 then
				local var_332_22 = Color.New(0, 0, 0)

				var_332_22.a = 1
				arg_329_1.mask_.color = var_332_22
			end

			local var_332_23 = 2

			if var_332_23 < arg_329_1.time_ and arg_329_1.time_ <= var_332_23 + arg_332_0 then
				arg_329_1.mask_.enabled = true
				arg_329_1.mask_.raycastTarget = true

				arg_329_1:SetGaussion(false)
			end

			local var_332_24 = 2

			if var_332_23 <= arg_329_1.time_ and arg_329_1.time_ < var_332_23 + var_332_24 then
				local var_332_25 = (arg_329_1.time_ - var_332_23) / var_332_24
				local var_332_26 = Color.New(0, 0, 0)

				var_332_26.a = Mathf.Lerp(1, 0, var_332_25)
				arg_329_1.mask_.color = var_332_26
			end

			if arg_329_1.time_ >= var_332_23 + var_332_24 and arg_329_1.time_ < var_332_23 + var_332_24 + arg_332_0 then
				local var_332_27 = Color.New(0, 0, 0)
				local var_332_28 = 0

				arg_329_1.mask_.enabled = false
				var_332_27.a = var_332_28
				arg_329_1.mask_.color = var_332_27
			end

			local var_332_29 = arg_329_1.actors_["10143ui_story"].transform
			local var_332_30 = 2

			if var_332_30 < arg_329_1.time_ and arg_329_1.time_ <= var_332_30 + arg_332_0 then
				arg_329_1.var_.moveOldPos10143ui_story = var_332_29.localPosition
			end

			local var_332_31 = 0.001

			if var_332_30 <= arg_329_1.time_ and arg_329_1.time_ < var_332_30 + var_332_31 then
				local var_332_32 = (arg_329_1.time_ - var_332_30) / var_332_31
				local var_332_33 = Vector3.New(0, 100, 0)

				var_332_29.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10143ui_story, var_332_33, var_332_32)

				local var_332_34 = manager.ui.mainCamera.transform.position - var_332_29.position

				var_332_29.forward = Vector3.New(var_332_34.x, var_332_34.y, var_332_34.z)

				local var_332_35 = var_332_29.localEulerAngles

				var_332_35.z = 0
				var_332_35.x = 0
				var_332_29.localEulerAngles = var_332_35
			end

			if arg_329_1.time_ >= var_332_30 + var_332_31 and arg_329_1.time_ < var_332_30 + var_332_31 + arg_332_0 then
				var_332_29.localPosition = Vector3.New(0, 100, 0)

				local var_332_36 = manager.ui.mainCamera.transform.position - var_332_29.position

				var_332_29.forward = Vector3.New(var_332_36.x, var_332_36.y, var_332_36.z)

				local var_332_37 = var_332_29.localEulerAngles

				var_332_37.z = 0
				var_332_37.x = 0
				var_332_29.localEulerAngles = var_332_37
			end

			local var_332_38 = arg_329_1.actors_["1047ui_story"].transform
			local var_332_39 = 2

			if var_332_39 < arg_329_1.time_ and arg_329_1.time_ <= var_332_39 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = var_332_38.localPosition
			end

			local var_332_40 = 0.001

			if var_332_39 <= arg_329_1.time_ and arg_329_1.time_ < var_332_39 + var_332_40 then
				local var_332_41 = (arg_329_1.time_ - var_332_39) / var_332_40
				local var_332_42 = Vector3.New(0, 100, 0)

				var_332_38.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, var_332_42, var_332_41)

				local var_332_43 = manager.ui.mainCamera.transform.position - var_332_38.position

				var_332_38.forward = Vector3.New(var_332_43.x, var_332_43.y, var_332_43.z)

				local var_332_44 = var_332_38.localEulerAngles

				var_332_44.z = 0
				var_332_44.x = 0
				var_332_38.localEulerAngles = var_332_44
			end

			if arg_329_1.time_ >= var_332_39 + var_332_40 and arg_329_1.time_ < var_332_39 + var_332_40 + arg_332_0 then
				var_332_38.localPosition = Vector3.New(0, 100, 0)

				local var_332_45 = manager.ui.mainCamera.transform.position - var_332_38.position

				var_332_38.forward = Vector3.New(var_332_45.x, var_332_45.y, var_332_45.z)

				local var_332_46 = var_332_38.localEulerAngles

				var_332_46.z = 0
				var_332_46.x = 0
				var_332_38.localEulerAngles = var_332_46
			end

			local var_332_47 = arg_329_1.actors_["1047ui_story"].transform
			local var_332_48 = 3.8

			if var_332_48 < arg_329_1.time_ and arg_329_1.time_ <= var_332_48 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = var_332_47.localPosition
			end

			local var_332_49 = 0.001

			if var_332_48 <= arg_329_1.time_ and arg_329_1.time_ < var_332_48 + var_332_49 then
				local var_332_50 = (arg_329_1.time_ - var_332_48) / var_332_49
				local var_332_51 = Vector3.New(0, -1.13, -6.2)

				var_332_47.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, var_332_51, var_332_50)

				local var_332_52 = manager.ui.mainCamera.transform.position - var_332_47.position

				var_332_47.forward = Vector3.New(var_332_52.x, var_332_52.y, var_332_52.z)

				local var_332_53 = var_332_47.localEulerAngles

				var_332_53.z = 0
				var_332_53.x = 0
				var_332_47.localEulerAngles = var_332_53
			end

			if arg_329_1.time_ >= var_332_48 + var_332_49 and arg_329_1.time_ < var_332_48 + var_332_49 + arg_332_0 then
				var_332_47.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_332_54 = manager.ui.mainCamera.transform.position - var_332_47.position

				var_332_47.forward = Vector3.New(var_332_54.x, var_332_54.y, var_332_54.z)

				local var_332_55 = var_332_47.localEulerAngles

				var_332_55.z = 0
				var_332_55.x = 0
				var_332_47.localEulerAngles = var_332_55
			end

			local var_332_56 = 3.8

			if var_332_56 < arg_329_1.time_ and arg_329_1.time_ <= var_332_56 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_332_57 = 3.8

			if var_332_57 < arg_329_1.time_ and arg_329_1.time_ <= var_332_57 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_332_58 = arg_329_1.actors_["1047ui_story"]
			local var_332_59 = 3.8

			if var_332_59 < arg_329_1.time_ and arg_329_1.time_ <= var_332_59 + arg_332_0 and not isNil(var_332_58) and arg_329_1.var_.characterEffect1047ui_story == nil then
				arg_329_1.var_.characterEffect1047ui_story = var_332_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_60 = 0.200000002980232

			if var_332_59 <= arg_329_1.time_ and arg_329_1.time_ < var_332_59 + var_332_60 and not isNil(var_332_58) then
				local var_332_61 = (arg_329_1.time_ - var_332_59) / var_332_60

				if arg_329_1.var_.characterEffect1047ui_story and not isNil(var_332_58) then
					arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_59 + var_332_60 and arg_329_1.time_ < var_332_59 + var_332_60 + arg_332_0 and not isNil(var_332_58) and arg_329_1.var_.characterEffect1047ui_story then
				arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_332_62 = 0.1
			local var_332_63 = 1

			if var_332_62 < arg_329_1.time_ and arg_329_1.time_ <= var_332_62 + arg_332_0 then
				local var_332_64 = "stop"
				local var_332_65 = "effect"

				arg_329_1:AudioAction(var_332_64, var_332_65, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_332_66 = 1.6
			local var_332_67 = 1

			if var_332_66 < arg_329_1.time_ and arg_329_1.time_ <= var_332_66 + arg_332_0 then
				local var_332_68 = "play"
				local var_332_69 = "effect"

				arg_329_1:AudioAction(var_332_68, var_332_69, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_70 = 4
			local var_332_71 = 0.65

			if var_332_70 < arg_329_1.time_ and arg_329_1.time_ <= var_332_70 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_72 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_72:setOnUpdate(LuaHelper.FloatAction(function(arg_333_0)
					arg_329_1.dialogCg_.alpha = arg_333_0
				end))
				var_332_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_73 = arg_329_1:FormatText(StoryNameCfg[1296].name)

				arg_329_1.leftNameTxt_.text = var_332_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_74 = arg_329_1:GetWordFromCfg(421052081)
				local var_332_75 = arg_329_1:FormatText(var_332_74.content)

				arg_329_1.text_.text = var_332_75

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_76 = 26
				local var_332_77 = utf8.len(var_332_75)
				local var_332_78 = var_332_76 <= 0 and var_332_71 or var_332_71 * (var_332_77 / var_332_76)

				if var_332_78 > 0 and var_332_71 < var_332_78 then
					arg_329_1.talkMaxDuration = var_332_78
					var_332_70 = var_332_70 + 0.3

					if var_332_78 + var_332_70 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_78 + var_332_70
					end
				end

				arg_329_1.text_.text = var_332_75
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052081", "story_v_out_421052.awb") ~= 0 then
					local var_332_79 = manager.audio:GetVoiceLength("story_v_out_421052", "421052081", "story_v_out_421052.awb") / 1000

					if var_332_79 + var_332_70 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_79 + var_332_70
					end

					if var_332_74.prefab_name ~= "" and arg_329_1.actors_[var_332_74.prefab_name] ~= nil then
						local var_332_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_74.prefab_name].transform, "story_v_out_421052", "421052081", "story_v_out_421052.awb")

						arg_329_1:RecordAudio("421052081", var_332_80)
						arg_329_1:RecordAudio("421052081", var_332_80)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_421052", "421052081", "story_v_out_421052.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_421052", "421052081", "story_v_out_421052.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_81 = var_332_70 + 0.3
			local var_332_82 = math.max(var_332_71, arg_329_1.talkMaxDuration)

			if var_332_81 <= arg_329_1.time_ and arg_329_1.time_ < var_332_81 + var_332_82 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_81) / var_332_82

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_81 + var_332_82 and arg_329_1.time_ < var_332_81 + var_332_82 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play421052082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 421052082
		arg_335_1.duration_ = 9.9

		local var_335_0 = {
			zh = 8.266,
			ja = 9.9
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
				arg_335_0:Play421052083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10102ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos10102ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(0.7, -0.985, -6.275)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10102ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["1047ui_story"].transform
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 then
				arg_335_1.var_.moveOldPos1047ui_story = var_338_9.localPosition
			end

			local var_338_11 = 0.001

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11
				local var_338_13 = Vector3.New(-0.6, -1.13, -6.2)

				var_338_9.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1047ui_story, var_338_13, var_338_12)

				local var_338_14 = manager.ui.mainCamera.transform.position - var_338_9.position

				var_338_9.forward = Vector3.New(var_338_14.x, var_338_14.y, var_338_14.z)

				local var_338_15 = var_338_9.localEulerAngles

				var_338_15.z = 0
				var_338_15.x = 0
				var_338_9.localEulerAngles = var_338_15
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 then
				var_338_9.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_338_16 = manager.ui.mainCamera.transform.position - var_338_9.position

				var_338_9.forward = Vector3.New(var_338_16.x, var_338_16.y, var_338_16.z)

				local var_338_17 = var_338_9.localEulerAngles

				var_338_17.z = 0
				var_338_17.x = 0
				var_338_9.localEulerAngles = var_338_17
			end

			local var_338_18 = arg_335_1.actors_["10102ui_story"]
			local var_338_19 = 0

			if var_338_19 < arg_335_1.time_ and arg_335_1.time_ <= var_338_19 + arg_338_0 and not isNil(var_338_18) and arg_335_1.var_.characterEffect10102ui_story == nil then
				arg_335_1.var_.characterEffect10102ui_story = var_338_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_20 = 0.200000002980232

			if var_338_19 <= arg_335_1.time_ and arg_335_1.time_ < var_338_19 + var_338_20 and not isNil(var_338_18) then
				local var_338_21 = (arg_335_1.time_ - var_338_19) / var_338_20

				if arg_335_1.var_.characterEffect10102ui_story and not isNil(var_338_18) then
					arg_335_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_19 + var_338_20 and arg_335_1.time_ < var_338_19 + var_338_20 + arg_338_0 and not isNil(var_338_18) and arg_335_1.var_.characterEffect10102ui_story then
				arg_335_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_338_22 = arg_335_1.actors_["1047ui_story"]
			local var_338_23 = 0

			if var_338_23 < arg_335_1.time_ and arg_335_1.time_ <= var_338_23 + arg_338_0 and not isNil(var_338_22) and arg_335_1.var_.characterEffect1047ui_story == nil then
				arg_335_1.var_.characterEffect1047ui_story = var_338_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_24 = 0.200000002980232

			if var_338_23 <= arg_335_1.time_ and arg_335_1.time_ < var_338_23 + var_338_24 and not isNil(var_338_22) then
				local var_338_25 = (arg_335_1.time_ - var_338_23) / var_338_24

				if arg_335_1.var_.characterEffect1047ui_story and not isNil(var_338_22) then
					local var_338_26 = Mathf.Lerp(0, 0.5, var_338_25)

					arg_335_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1047ui_story.fillRatio = var_338_26
				end
			end

			if arg_335_1.time_ >= var_338_23 + var_338_24 and arg_335_1.time_ < var_338_23 + var_338_24 + arg_338_0 and not isNil(var_338_22) and arg_335_1.var_.characterEffect1047ui_story then
				local var_338_27 = 0.5

				arg_335_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1047ui_story.fillRatio = var_338_27
			end

			local var_338_28 = 0

			if var_338_28 < arg_335_1.time_ and arg_335_1.time_ <= var_338_28 + arg_338_0 then
				arg_335_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_338_29 = 0

			if var_338_29 < arg_335_1.time_ and arg_335_1.time_ <= var_338_29 + arg_338_0 then
				arg_335_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_338_30 = 0
			local var_338_31 = 1.2

			if var_338_30 < arg_335_1.time_ and arg_335_1.time_ <= var_338_30 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_32 = arg_335_1:FormatText(StoryNameCfg[6].name)

				arg_335_1.leftNameTxt_.text = var_338_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_33 = arg_335_1:GetWordFromCfg(421052082)
				local var_338_34 = arg_335_1:FormatText(var_338_33.content)

				arg_335_1.text_.text = var_338_34

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_35 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052082", "story_v_out_421052.awb") ~= 0 then
					local var_338_38 = manager.audio:GetVoiceLength("story_v_out_421052", "421052082", "story_v_out_421052.awb") / 1000

					if var_338_38 + var_338_30 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_38 + var_338_30
					end

					if var_338_33.prefab_name ~= "" and arg_335_1.actors_[var_338_33.prefab_name] ~= nil then
						local var_338_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_33.prefab_name].transform, "story_v_out_421052", "421052082", "story_v_out_421052.awb")

						arg_335_1:RecordAudio("421052082", var_338_39)
						arg_335_1:RecordAudio("421052082", var_338_39)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_421052", "421052082", "story_v_out_421052.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_421052", "421052082", "story_v_out_421052.awb")
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play421052083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 421052083
		arg_339_1.duration_ = 11.97

		local var_339_0 = {
			zh = 8.066,
			ja = 11.966
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
				arg_339_0:Play421052084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1047ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1047ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1047ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1047ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1047ui_story == nil then
				arg_339_1.var_.characterEffect1047ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1047ui_story and not isNil(var_342_9) then
					arg_339_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1047ui_story then
				arg_339_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_342_13 = arg_339_1.actors_["10102ui_story"]
			local var_342_14 = 0

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 and not isNil(var_342_13) and arg_339_1.var_.characterEffect10102ui_story == nil then
				arg_339_1.var_.characterEffect10102ui_story = var_342_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_15 = 0.200000002980232

			if var_342_14 <= arg_339_1.time_ and arg_339_1.time_ < var_342_14 + var_342_15 and not isNil(var_342_13) then
				local var_342_16 = (arg_339_1.time_ - var_342_14) / var_342_15

				if arg_339_1.var_.characterEffect10102ui_story and not isNil(var_342_13) then
					local var_342_17 = Mathf.Lerp(0, 0.5, var_342_16)

					arg_339_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_339_1.var_.characterEffect10102ui_story.fillRatio = var_342_17
				end
			end

			if arg_339_1.time_ >= var_342_14 + var_342_15 and arg_339_1.time_ < var_342_14 + var_342_15 + arg_342_0 and not isNil(var_342_13) and arg_339_1.var_.characterEffect10102ui_story then
				local var_342_18 = 0.5

				arg_339_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_339_1.var_.characterEffect10102ui_story.fillRatio = var_342_18
			end

			local var_342_19 = 0

			if var_342_19 < arg_339_1.time_ and arg_339_1.time_ <= var_342_19 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_342_20 = 0

			if var_342_20 < arg_339_1.time_ and arg_339_1.time_ <= var_342_20 + arg_342_0 then
				arg_339_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_342_21 = 0
			local var_342_22 = 0.925

			if var_342_21 < arg_339_1.time_ and arg_339_1.time_ <= var_342_21 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_23 = arg_339_1:FormatText(StoryNameCfg[1296].name)

				arg_339_1.leftNameTxt_.text = var_342_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_24 = arg_339_1:GetWordFromCfg(421052083)
				local var_342_25 = arg_339_1:FormatText(var_342_24.content)

				arg_339_1.text_.text = var_342_25

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_26 = 37
				local var_342_27 = utf8.len(var_342_25)
				local var_342_28 = var_342_26 <= 0 and var_342_22 or var_342_22 * (var_342_27 / var_342_26)

				if var_342_28 > 0 and var_342_22 < var_342_28 then
					arg_339_1.talkMaxDuration = var_342_28

					if var_342_28 + var_342_21 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_28 + var_342_21
					end
				end

				arg_339_1.text_.text = var_342_25
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052083", "story_v_out_421052.awb") ~= 0 then
					local var_342_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052083", "story_v_out_421052.awb") / 1000

					if var_342_29 + var_342_21 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_29 + var_342_21
					end

					if var_342_24.prefab_name ~= "" and arg_339_1.actors_[var_342_24.prefab_name] ~= nil then
						local var_342_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_24.prefab_name].transform, "story_v_out_421052", "421052083", "story_v_out_421052.awb")

						arg_339_1:RecordAudio("421052083", var_342_30)
						arg_339_1:RecordAudio("421052083", var_342_30)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_421052", "421052083", "story_v_out_421052.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_421052", "421052083", "story_v_out_421052.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_31 = math.max(var_342_22, arg_339_1.talkMaxDuration)

			if var_342_21 <= arg_339_1.time_ and arg_339_1.time_ < var_342_21 + var_342_31 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_21) / var_342_31

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_21 + var_342_31 and arg_339_1.time_ < var_342_21 + var_342_31 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421052084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 421052084
		arg_343_1.duration_ = 19.53

		local var_343_0 = {
			zh = 13,
			ja = 19.533
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
				arg_343_0:Play421052085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1047ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1047ui_story = var_346_0.localPosition
			end

			local var_346_2 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2
				local var_346_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1047ui_story, var_346_4, var_346_3)

				local var_346_5 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_5.x, var_346_5.y, var_346_5.z)

				local var_346_6 = var_346_0.localEulerAngles

				var_346_6.z = 0
				var_346_6.x = 0
				var_346_0.localEulerAngles = var_346_6
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_346_7 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_7.x, var_346_7.y, var_346_7.z)

				local var_346_8 = var_346_0.localEulerAngles

				var_346_8.z = 0
				var_346_8.x = 0
				var_346_0.localEulerAngles = var_346_8
			end

			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_346_10 = 0

			if var_346_10 < arg_343_1.time_ and arg_343_1.time_ <= var_346_10 + arg_346_0 then
				arg_343_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_346_11 = 0
			local var_346_12 = 1.6

			if var_346_11 < arg_343_1.time_ and arg_343_1.time_ <= var_346_11 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_13 = arg_343_1:FormatText(StoryNameCfg[1296].name)

				arg_343_1.leftNameTxt_.text = var_346_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_14 = arg_343_1:GetWordFromCfg(421052084)
				local var_346_15 = arg_343_1:FormatText(var_346_14.content)

				arg_343_1.text_.text = var_346_15

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_16 = 64
				local var_346_17 = utf8.len(var_346_15)
				local var_346_18 = var_346_16 <= 0 and var_346_12 or var_346_12 * (var_346_17 / var_346_16)

				if var_346_18 > 0 and var_346_12 < var_346_18 then
					arg_343_1.talkMaxDuration = var_346_18

					if var_346_18 + var_346_11 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_18 + var_346_11
					end
				end

				arg_343_1.text_.text = var_346_15
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052084", "story_v_out_421052.awb") ~= 0 then
					local var_346_19 = manager.audio:GetVoiceLength("story_v_out_421052", "421052084", "story_v_out_421052.awb") / 1000

					if var_346_19 + var_346_11 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_19 + var_346_11
					end

					if var_346_14.prefab_name ~= "" and arg_343_1.actors_[var_346_14.prefab_name] ~= nil then
						local var_346_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_14.prefab_name].transform, "story_v_out_421052", "421052084", "story_v_out_421052.awb")

						arg_343_1:RecordAudio("421052084", var_346_20)
						arg_343_1:RecordAudio("421052084", var_346_20)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_421052", "421052084", "story_v_out_421052.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_421052", "421052084", "story_v_out_421052.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_21 = math.max(var_346_12, arg_343_1.talkMaxDuration)

			if var_346_11 <= arg_343_1.time_ and arg_343_1.time_ < var_346_11 + var_346_21 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_11) / var_346_21

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_11 + var_346_21 and arg_343_1.time_ < var_346_11 + var_346_21 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421052085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 421052085
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play421052086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1047ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1047ui_story == nil then
				arg_347_1.var_.characterEffect1047ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1047ui_story and not isNil(var_350_0) then
					local var_350_4 = Mathf.Lerp(0, 0.5, var_350_3)

					arg_347_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1047ui_story.fillRatio = var_350_4
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.characterEffect1047ui_story then
				local var_350_5 = 0.5

				arg_347_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1047ui_story.fillRatio = var_350_5
			end

			local var_350_6 = 0
			local var_350_7 = 0.325

			if var_350_6 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_8 = arg_347_1:FormatText(StoryNameCfg[7].name)

				arg_347_1.leftNameTxt_.text = var_350_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_9 = arg_347_1:GetWordFromCfg(421052085)
				local var_350_10 = arg_347_1:FormatText(var_350_9.content)

				arg_347_1.text_.text = var_350_10

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 13
				local var_350_12 = utf8.len(var_350_10)
				local var_350_13 = var_350_11 <= 0 and var_350_7 or var_350_7 * (var_350_12 / var_350_11)

				if var_350_13 > 0 and var_350_7 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_10
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play421052086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 421052086
		arg_351_1.duration_ = 13.9

		local var_351_0 = {
			zh = 8.466,
			ja = 13.9
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
				arg_351_0:Play421052087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1047ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1047ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1047ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["1047ui_story"]
			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1047ui_story == nil then
				arg_351_1.var_.characterEffect1047ui_story = var_354_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_11 = 0.200000002980232

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_11 and not isNil(var_354_9) then
				local var_354_12 = (arg_351_1.time_ - var_354_10) / var_354_11

				if arg_351_1.var_.characterEffect1047ui_story and not isNil(var_354_9) then
					arg_351_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_11 and arg_351_1.time_ < var_354_10 + var_354_11 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1047ui_story then
				arg_351_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_354_13 = 0

			if var_354_13 < arg_351_1.time_ and arg_351_1.time_ <= var_354_13 + arg_354_0 then
				arg_351_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_354_14 = 0

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				arg_351_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_354_15 = 0
			local var_354_16 = 0.975

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_17 = arg_351_1:FormatText(StoryNameCfg[1296].name)

				arg_351_1.leftNameTxt_.text = var_354_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_18 = arg_351_1:GetWordFromCfg(421052086)
				local var_354_19 = arg_351_1:FormatText(var_354_18.content)

				arg_351_1.text_.text = var_354_19

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_20 = 39
				local var_354_21 = utf8.len(var_354_19)
				local var_354_22 = var_354_20 <= 0 and var_354_16 or var_354_16 * (var_354_21 / var_354_20)

				if var_354_22 > 0 and var_354_16 < var_354_22 then
					arg_351_1.talkMaxDuration = var_354_22

					if var_354_22 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_22 + var_354_15
					end
				end

				arg_351_1.text_.text = var_354_19
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052086", "story_v_out_421052.awb") ~= 0 then
					local var_354_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052086", "story_v_out_421052.awb") / 1000

					if var_354_23 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_23 + var_354_15
					end

					if var_354_18.prefab_name ~= "" and arg_351_1.actors_[var_354_18.prefab_name] ~= nil then
						local var_354_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_18.prefab_name].transform, "story_v_out_421052", "421052086", "story_v_out_421052.awb")

						arg_351_1:RecordAudio("421052086", var_354_24)
						arg_351_1:RecordAudio("421052086", var_354_24)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_421052", "421052086", "story_v_out_421052.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_421052", "421052086", "story_v_out_421052.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_25 = math.max(var_354_16, arg_351_1.talkMaxDuration)

			if var_354_15 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_25 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_15) / var_354_25

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_15 + var_354_25 and arg_351_1.time_ < var_354_15 + var_354_25 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play421052087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 421052087
		arg_355_1.duration_ = 3.9

		local var_355_0 = {
			zh = 3.7,
			ja = 3.9
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
				arg_355_0:Play421052088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10102ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10102ui_story = var_358_0.localPosition
			end

			local var_358_2 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2
				local var_358_4 = Vector3.New(0.7, -0.985, -6.275)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10102ui_story, var_358_4, var_358_3)

				local var_358_5 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_5.x, var_358_5.y, var_358_5.z)

				local var_358_6 = var_358_0.localEulerAngles

				var_358_6.z = 0
				var_358_6.x = 0
				var_358_0.localEulerAngles = var_358_6
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_358_7 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_7.x, var_358_7.y, var_358_7.z)

				local var_358_8 = var_358_0.localEulerAngles

				var_358_8.z = 0
				var_358_8.x = 0
				var_358_0.localEulerAngles = var_358_8
			end

			local var_358_9 = arg_355_1.actors_["10102ui_story"]
			local var_358_10 = 0

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect10102ui_story == nil then
				arg_355_1.var_.characterEffect10102ui_story = var_358_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_11 = 0.200000002980232

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_11 and not isNil(var_358_9) then
				local var_358_12 = (arg_355_1.time_ - var_358_10) / var_358_11

				if arg_355_1.var_.characterEffect10102ui_story and not isNil(var_358_9) then
					arg_355_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_10 + var_358_11 and arg_355_1.time_ < var_358_10 + var_358_11 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect10102ui_story then
				arg_355_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_358_13 = arg_355_1.actors_["1047ui_story"]
			local var_358_14 = 0

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 and not isNil(var_358_13) and arg_355_1.var_.characterEffect1047ui_story == nil then
				arg_355_1.var_.characterEffect1047ui_story = var_358_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_15 = 0.200000002980232

			if var_358_14 <= arg_355_1.time_ and arg_355_1.time_ < var_358_14 + var_358_15 and not isNil(var_358_13) then
				local var_358_16 = (arg_355_1.time_ - var_358_14) / var_358_15

				if arg_355_1.var_.characterEffect1047ui_story and not isNil(var_358_13) then
					local var_358_17 = Mathf.Lerp(0, 0.5, var_358_16)

					arg_355_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1047ui_story.fillRatio = var_358_17
				end
			end

			if arg_355_1.time_ >= var_358_14 + var_358_15 and arg_355_1.time_ < var_358_14 + var_358_15 + arg_358_0 and not isNil(var_358_13) and arg_355_1.var_.characterEffect1047ui_story then
				local var_358_18 = 0.5

				arg_355_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1047ui_story.fillRatio = var_358_18
			end

			local var_358_19 = 0

			if var_358_19 < arg_355_1.time_ and arg_355_1.time_ <= var_358_19 + arg_358_0 then
				arg_355_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_358_20 = 0

			if var_358_20 < arg_355_1.time_ and arg_355_1.time_ <= var_358_20 + arg_358_0 then
				arg_355_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_358_21 = 0
			local var_358_22 = 0.3

			if var_358_21 < arg_355_1.time_ and arg_355_1.time_ <= var_358_21 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_23 = arg_355_1:FormatText(StoryNameCfg[6].name)

				arg_355_1.leftNameTxt_.text = var_358_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_24 = arg_355_1:GetWordFromCfg(421052087)
				local var_358_25 = arg_355_1:FormatText(var_358_24.content)

				arg_355_1.text_.text = var_358_25

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_26 = 12
				local var_358_27 = utf8.len(var_358_25)
				local var_358_28 = var_358_26 <= 0 and var_358_22 or var_358_22 * (var_358_27 / var_358_26)

				if var_358_28 > 0 and var_358_22 < var_358_28 then
					arg_355_1.talkMaxDuration = var_358_28

					if var_358_28 + var_358_21 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_28 + var_358_21
					end
				end

				arg_355_1.text_.text = var_358_25
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052087", "story_v_out_421052.awb") ~= 0 then
					local var_358_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052087", "story_v_out_421052.awb") / 1000

					if var_358_29 + var_358_21 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_29 + var_358_21
					end

					if var_358_24.prefab_name ~= "" and arg_355_1.actors_[var_358_24.prefab_name] ~= nil then
						local var_358_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_24.prefab_name].transform, "story_v_out_421052", "421052087", "story_v_out_421052.awb")

						arg_355_1:RecordAudio("421052087", var_358_30)
						arg_355_1:RecordAudio("421052087", var_358_30)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_421052", "421052087", "story_v_out_421052.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_421052", "421052087", "story_v_out_421052.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_31 = math.max(var_358_22, arg_355_1.talkMaxDuration)

			if var_358_21 <= arg_355_1.time_ and arg_355_1.time_ < var_358_21 + var_358_31 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_21) / var_358_31

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_21 + var_358_31 and arg_355_1.time_ < var_358_21 + var_358_31 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421052088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 421052088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play421052089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10102ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect10102ui_story == nil then
				arg_359_1.var_.characterEffect10102ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect10102ui_story and not isNil(var_362_0) then
					local var_362_4 = Mathf.Lerp(0, 0.5, var_362_3)

					arg_359_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_359_1.var_.characterEffect10102ui_story.fillRatio = var_362_4
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect10102ui_story then
				local var_362_5 = 0.5

				arg_359_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_359_1.var_.characterEffect10102ui_story.fillRatio = var_362_5
			end

			local var_362_6 = 0
			local var_362_7 = 0.8

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_8 = arg_359_1:FormatText(StoryNameCfg[7].name)

				arg_359_1.leftNameTxt_.text = var_362_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_9 = arg_359_1:GetWordFromCfg(421052088)
				local var_362_10 = arg_359_1:FormatText(var_362_9.content)

				arg_359_1.text_.text = var_362_10

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_11 = 32
				local var_362_12 = utf8.len(var_362_10)
				local var_362_13 = var_362_11 <= 0 and var_362_7 or var_362_7 * (var_362_12 / var_362_11)

				if var_362_13 > 0 and var_362_7 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_10
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_14 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_14 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_14

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_14 and arg_359_1.time_ < var_362_6 + var_362_14 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play421052089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 421052089
		arg_363_1.duration_ = 3.37

		local var_363_0 = {
			zh = 3.366,
			ja = 3.2
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play421052090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1047ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos1047ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1047ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["1047ui_story"]
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect1047ui_story == nil then
				arg_363_1.var_.characterEffect1047ui_story = var_366_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_11 = 0.200000002980232

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 and not isNil(var_366_9) then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11

				if arg_363_1.var_.characterEffect1047ui_story and not isNil(var_366_9) then
					arg_363_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect1047ui_story then
				arg_363_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_366_13 = 0

			if var_366_13 < arg_363_1.time_ and arg_363_1.time_ <= var_366_13 + arg_366_0 then
				arg_363_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_366_14 = 0

			if var_366_14 < arg_363_1.time_ and arg_363_1.time_ <= var_366_14 + arg_366_0 then
				arg_363_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_366_15 = 0
			local var_366_16 = 0.525

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_17 = arg_363_1:FormatText(StoryNameCfg[1296].name)

				arg_363_1.leftNameTxt_.text = var_366_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(421052089)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 21
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_16 or var_366_16 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_16 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052089", "story_v_out_421052.awb") ~= 0 then
					local var_366_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052089", "story_v_out_421052.awb") / 1000

					if var_366_23 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_15
					end

					if var_366_18.prefab_name ~= "" and arg_363_1.actors_[var_366_18.prefab_name] ~= nil then
						local var_366_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_18.prefab_name].transform, "story_v_out_421052", "421052089", "story_v_out_421052.awb")

						arg_363_1:RecordAudio("421052089", var_366_24)
						arg_363_1:RecordAudio("421052089", var_366_24)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_421052", "421052089", "story_v_out_421052.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_421052", "421052089", "story_v_out_421052.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_25 and arg_363_1.time_ < var_366_15 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play421052090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 421052090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play421052091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1047ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1047ui_story == nil then
				arg_367_1.var_.characterEffect1047ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1047ui_story and not isNil(var_370_0) then
					local var_370_4 = Mathf.Lerp(0, 0.5, var_370_3)

					arg_367_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1047ui_story.fillRatio = var_370_4
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1047ui_story then
				local var_370_5 = 0.5

				arg_367_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1047ui_story.fillRatio = var_370_5
			end

			local var_370_6 = 0
			local var_370_7 = 0.55

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_8 = arg_367_1:GetWordFromCfg(421052090)
				local var_370_9 = arg_367_1:FormatText(var_370_8.content)

				arg_367_1.text_.text = var_370_9

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 22
				local var_370_11 = utf8.len(var_370_9)
				local var_370_12 = var_370_10 <= 0 and var_370_7 or var_370_7 * (var_370_11 / var_370_10)

				if var_370_12 > 0 and var_370_7 < var_370_12 then
					arg_367_1.talkMaxDuration = var_370_12

					if var_370_12 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_12 + var_370_6
					end
				end

				arg_367_1.text_.text = var_370_9
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_13 = math.max(var_370_7, arg_367_1.talkMaxDuration)

			if var_370_6 <= arg_367_1.time_ and arg_367_1.time_ < var_370_6 + var_370_13 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_6) / var_370_13

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_6 + var_370_13 and arg_367_1.time_ < var_370_6 + var_370_13 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play421052091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 421052091
		arg_371_1.duration_ = 11.97

		local var_371_0 = {
			zh = 7.733,
			ja = 11.966
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
				arg_371_0:Play421052092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1047ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1047ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1047ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1047ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1047ui_story == nil then
				arg_371_1.var_.characterEffect1047ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1047ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1047ui_story then
				arg_371_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_374_15 = 0
			local var_374_16 = 0.925

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[1296].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(421052091)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052091", "story_v_out_421052.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052091", "story_v_out_421052.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_421052", "421052091", "story_v_out_421052.awb")

						arg_371_1:RecordAudio("421052091", var_374_24)
						arg_371_1:RecordAudio("421052091", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_421052", "421052091", "story_v_out_421052.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_421052", "421052091", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
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
	Play421052092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 421052092
		arg_375_1.duration_ = 2.2

		local var_375_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play421052093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10102ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos10102ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0.7, -0.985, -6.275)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10102ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["10102ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect10102ui_story == nil then
				arg_375_1.var_.characterEffect10102ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect10102ui_story and not isNil(var_378_9) then
					arg_375_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect10102ui_story then
				arg_375_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_378_13 = arg_375_1.actors_["1047ui_story"]
			local var_378_14 = 0

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 and not isNil(var_378_13) and arg_375_1.var_.characterEffect1047ui_story == nil then
				arg_375_1.var_.characterEffect1047ui_story = var_378_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_15 = 0.200000002980232

			if var_378_14 <= arg_375_1.time_ and arg_375_1.time_ < var_378_14 + var_378_15 and not isNil(var_378_13) then
				local var_378_16 = (arg_375_1.time_ - var_378_14) / var_378_15

				if arg_375_1.var_.characterEffect1047ui_story and not isNil(var_378_13) then
					local var_378_17 = Mathf.Lerp(0, 0.5, var_378_16)

					arg_375_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1047ui_story.fillRatio = var_378_17
				end
			end

			if arg_375_1.time_ >= var_378_14 + var_378_15 and arg_375_1.time_ < var_378_14 + var_378_15 + arg_378_0 and not isNil(var_378_13) and arg_375_1.var_.characterEffect1047ui_story then
				local var_378_18 = 0.5

				arg_375_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1047ui_story.fillRatio = var_378_18
			end

			local var_378_19 = 0

			if var_378_19 < arg_375_1.time_ and arg_375_1.time_ <= var_378_19 + arg_378_0 then
				arg_375_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_378_20 = 0

			if var_378_20 < arg_375_1.time_ and arg_375_1.time_ <= var_378_20 + arg_378_0 then
				arg_375_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_378_21 = 0
			local var_378_22 = 0.175

			if var_378_21 < arg_375_1.time_ and arg_375_1.time_ <= var_378_21 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_23 = arg_375_1:FormatText(StoryNameCfg[6].name)

				arg_375_1.leftNameTxt_.text = var_378_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_24 = arg_375_1:GetWordFromCfg(421052092)
				local var_378_25 = arg_375_1:FormatText(var_378_24.content)

				arg_375_1.text_.text = var_378_25

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_26 = 7
				local var_378_27 = utf8.len(var_378_25)
				local var_378_28 = var_378_26 <= 0 and var_378_22 or var_378_22 * (var_378_27 / var_378_26)

				if var_378_28 > 0 and var_378_22 < var_378_28 then
					arg_375_1.talkMaxDuration = var_378_28

					if var_378_28 + var_378_21 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_28 + var_378_21
					end
				end

				arg_375_1.text_.text = var_378_25
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052092", "story_v_out_421052.awb") ~= 0 then
					local var_378_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052092", "story_v_out_421052.awb") / 1000

					if var_378_29 + var_378_21 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_29 + var_378_21
					end

					if var_378_24.prefab_name ~= "" and arg_375_1.actors_[var_378_24.prefab_name] ~= nil then
						local var_378_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_24.prefab_name].transform, "story_v_out_421052", "421052092", "story_v_out_421052.awb")

						arg_375_1:RecordAudio("421052092", var_378_30)
						arg_375_1:RecordAudio("421052092", var_378_30)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_421052", "421052092", "story_v_out_421052.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_421052", "421052092", "story_v_out_421052.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_31 = math.max(var_378_22, arg_375_1.talkMaxDuration)

			if var_378_21 <= arg_375_1.time_ and arg_375_1.time_ < var_378_21 + var_378_31 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_21) / var_378_31

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_21 + var_378_31 and arg_375_1.time_ < var_378_21 + var_378_31 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play421052093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 421052093
		arg_379_1.duration_ = 3.77

		local var_379_0 = {
			zh = 2.766,
			ja = 3.766
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
				arg_379_0:Play421052094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1047ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1047ui_story = var_382_0.localPosition
			end

			local var_382_2 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2
				local var_382_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1047ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = arg_379_1.actors_["1047ui_story"]
			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1047ui_story == nil then
				arg_379_1.var_.characterEffect1047ui_story = var_382_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_11 = 0.200000002980232

			if var_382_10 <= arg_379_1.time_ and arg_379_1.time_ < var_382_10 + var_382_11 and not isNil(var_382_9) then
				local var_382_12 = (arg_379_1.time_ - var_382_10) / var_382_11

				if arg_379_1.var_.characterEffect1047ui_story and not isNil(var_382_9) then
					arg_379_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_10 + var_382_11 and arg_379_1.time_ < var_382_10 + var_382_11 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1047ui_story then
				arg_379_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_382_13 = arg_379_1.actors_["10102ui_story"]
			local var_382_14 = 0

			if var_382_14 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 and not isNil(var_382_13) and arg_379_1.var_.characterEffect10102ui_story == nil then
				arg_379_1.var_.characterEffect10102ui_story = var_382_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_15 = 0.200000002980232

			if var_382_14 <= arg_379_1.time_ and arg_379_1.time_ < var_382_14 + var_382_15 and not isNil(var_382_13) then
				local var_382_16 = (arg_379_1.time_ - var_382_14) / var_382_15

				if arg_379_1.var_.characterEffect10102ui_story and not isNil(var_382_13) then
					local var_382_17 = Mathf.Lerp(0, 0.5, var_382_16)

					arg_379_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_379_1.var_.characterEffect10102ui_story.fillRatio = var_382_17
				end
			end

			if arg_379_1.time_ >= var_382_14 + var_382_15 and arg_379_1.time_ < var_382_14 + var_382_15 + arg_382_0 and not isNil(var_382_13) and arg_379_1.var_.characterEffect10102ui_story then
				local var_382_18 = 0.5

				arg_379_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_379_1.var_.characterEffect10102ui_story.fillRatio = var_382_18
			end

			local var_382_19 = 0

			if var_382_19 < arg_379_1.time_ and arg_379_1.time_ <= var_382_19 + arg_382_0 then
				arg_379_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_382_20 = 0

			if var_382_20 < arg_379_1.time_ and arg_379_1.time_ <= var_382_20 + arg_382_0 then
				arg_379_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_382_21 = 0
			local var_382_22 = 0.275

			if var_382_21 < arg_379_1.time_ and arg_379_1.time_ <= var_382_21 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_23 = arg_379_1:FormatText(StoryNameCfg[1296].name)

				arg_379_1.leftNameTxt_.text = var_382_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_24 = arg_379_1:GetWordFromCfg(421052093)
				local var_382_25 = arg_379_1:FormatText(var_382_24.content)

				arg_379_1.text_.text = var_382_25

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_26 = 11
				local var_382_27 = utf8.len(var_382_25)
				local var_382_28 = var_382_26 <= 0 and var_382_22 or var_382_22 * (var_382_27 / var_382_26)

				if var_382_28 > 0 and var_382_22 < var_382_28 then
					arg_379_1.talkMaxDuration = var_382_28

					if var_382_28 + var_382_21 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_28 + var_382_21
					end
				end

				arg_379_1.text_.text = var_382_25
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052093", "story_v_out_421052.awb") ~= 0 then
					local var_382_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052093", "story_v_out_421052.awb") / 1000

					if var_382_29 + var_382_21 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_29 + var_382_21
					end

					if var_382_24.prefab_name ~= "" and arg_379_1.actors_[var_382_24.prefab_name] ~= nil then
						local var_382_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_24.prefab_name].transform, "story_v_out_421052", "421052093", "story_v_out_421052.awb")

						arg_379_1:RecordAudio("421052093", var_382_30)
						arg_379_1:RecordAudio("421052093", var_382_30)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_421052", "421052093", "story_v_out_421052.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_421052", "421052093", "story_v_out_421052.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_31 = math.max(var_382_22, arg_379_1.talkMaxDuration)

			if var_382_21 <= arg_379_1.time_ and arg_379_1.time_ < var_382_21 + var_382_31 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_21) / var_382_31

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_21 + var_382_31 and arg_379_1.time_ < var_382_21 + var_382_31 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play421052094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 421052094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play421052095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1047ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1047ui_story == nil then
				arg_383_1.var_.characterEffect1047ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1047ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1047ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1047ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1047ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0
			local var_386_7 = 0.3

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_8 = arg_383_1:FormatText(StoryNameCfg[7].name)

				arg_383_1.leftNameTxt_.text = var_386_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_9 = arg_383_1:GetWordFromCfg(421052094)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 12
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_7 or var_386_7 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_7 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_14 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_14 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_14

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_14 and arg_383_1.time_ < var_386_6 + var_386_14 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play421052095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 421052095
		arg_387_1.duration_ = 9.93

		local var_387_0 = {
			zh = 6.966,
			ja = 9.933
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
				arg_387_0:Play421052096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1047ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1047ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1047ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["1047ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1047ui_story == nil then
				arg_387_1.var_.characterEffect1047ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect1047ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1047ui_story then
				arg_387_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_390_14 = 0

			if var_390_14 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_390_15 = 0
			local var_390_16 = 0.775

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[1296].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(421052095)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052095", "story_v_out_421052.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052095", "story_v_out_421052.awb") / 1000

					if var_390_23 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_15
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_out_421052", "421052095", "story_v_out_421052.awb")

						arg_387_1:RecordAudio("421052095", var_390_24)
						arg_387_1:RecordAudio("421052095", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_421052", "421052095", "story_v_out_421052.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_421052", "421052095", "story_v_out_421052.awb")
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
				actorName = "1047ui_story",
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
	Play421052096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 421052096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play421052097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1047ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1047ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0, 100, 0)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1047ui_story, var_394_4, var_394_3)

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

			local var_394_9 = arg_391_1.actors_["10102ui_story"].transform
			local var_394_10 = 0

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 then
				arg_391_1.var_.moveOldPos10102ui_story = var_394_9.localPosition
			end

			local var_394_11 = 0.001

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_11 then
				local var_394_12 = (arg_391_1.time_ - var_394_10) / var_394_11
				local var_394_13 = Vector3.New(0, 100, 0)

				var_394_9.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10102ui_story, var_394_13, var_394_12)

				local var_394_14 = manager.ui.mainCamera.transform.position - var_394_9.position

				var_394_9.forward = Vector3.New(var_394_14.x, var_394_14.y, var_394_14.z)

				local var_394_15 = var_394_9.localEulerAngles

				var_394_15.z = 0
				var_394_15.x = 0
				var_394_9.localEulerAngles = var_394_15
			end

			if arg_391_1.time_ >= var_394_10 + var_394_11 and arg_391_1.time_ < var_394_10 + var_394_11 + arg_394_0 then
				var_394_9.localPosition = Vector3.New(0, 100, 0)

				local var_394_16 = manager.ui.mainCamera.transform.position - var_394_9.position

				var_394_9.forward = Vector3.New(var_394_16.x, var_394_16.y, var_394_16.z)

				local var_394_17 = var_394_9.localEulerAngles

				var_394_17.z = 0
				var_394_17.x = 0
				var_394_9.localEulerAngles = var_394_17
			end

			local var_394_18 = 0
			local var_394_19 = 1.175

			if var_394_18 < arg_391_1.time_ and arg_391_1.time_ <= var_394_18 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_20 = arg_391_1:GetWordFromCfg(421052096)
				local var_394_21 = arg_391_1:FormatText(var_394_20.content)

				arg_391_1.text_.text = var_394_21

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_22 = 47
				local var_394_23 = utf8.len(var_394_21)
				local var_394_24 = var_394_22 <= 0 and var_394_19 or var_394_19 * (var_394_23 / var_394_22)

				if var_394_24 > 0 and var_394_19 < var_394_24 then
					arg_391_1.talkMaxDuration = var_394_24

					if var_394_24 + var_394_18 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_24 + var_394_18
					end
				end

				arg_391_1.text_.text = var_394_21
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_25 = math.max(var_394_19, arg_391_1.talkMaxDuration)

			if var_394_18 <= arg_391_1.time_ and arg_391_1.time_ < var_394_18 + var_394_25 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_18) / var_394_25

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_18 + var_394_25 and arg_391_1.time_ < var_394_18 + var_394_25 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play421052097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 421052097
		arg_395_1.duration_ = 8.6

		local var_395_0 = {
			zh = 7.9,
			ja = 8.6
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play421052098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 2

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				local var_398_1 = manager.ui.mainCamera.transform.localPosition
				local var_398_2 = Vector3.New(0, 0, 10) + Vector3.New(var_398_1.x, var_398_1.y, 0)
				local var_398_3 = arg_395_1.bgs_.B08b

				var_398_3.transform.localPosition = var_398_2
				var_398_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_398_4 = var_398_3:GetComponent("SpriteRenderer")

				if var_398_4 and var_398_4.sprite then
					local var_398_5 = (var_398_3.transform.localPosition - var_398_1).z
					local var_398_6 = manager.ui.mainCameraCom_
					local var_398_7 = 2 * var_398_5 * Mathf.Tan(var_398_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_398_8 = var_398_7 * var_398_6.aspect
					local var_398_9 = var_398_4.sprite.bounds.size.x
					local var_398_10 = var_398_4.sprite.bounds.size.y
					local var_398_11 = var_398_8 / var_398_9
					local var_398_12 = var_398_7 / var_398_10
					local var_398_13 = var_398_12 < var_398_11 and var_398_11 or var_398_12

					var_398_3.transform.localScale = Vector3.New(var_398_13, var_398_13, 0)
				end

				for iter_398_0, iter_398_1 in pairs(arg_395_1.bgs_) do
					if iter_398_0 ~= "B08b" then
						iter_398_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_398_14 = 4

			if var_398_14 < arg_395_1.time_ and arg_395_1.time_ <= var_398_14 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			local var_398_15 = 0.3

			if arg_395_1.time_ >= var_398_14 + var_398_15 and arg_395_1.time_ < var_398_14 + var_398_15 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end

			local var_398_16 = 0

			if var_398_16 < arg_395_1.time_ and arg_395_1.time_ <= var_398_16 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_17 = 2

			if var_398_16 <= arg_395_1.time_ and arg_395_1.time_ < var_398_16 + var_398_17 then
				local var_398_18 = (arg_395_1.time_ - var_398_16) / var_398_17
				local var_398_19 = Color.New(0, 0, 0)

				var_398_19.a = Mathf.Lerp(0, 1, var_398_18)
				arg_395_1.mask_.color = var_398_19
			end

			if arg_395_1.time_ >= var_398_16 + var_398_17 and arg_395_1.time_ < var_398_16 + var_398_17 + arg_398_0 then
				local var_398_20 = Color.New(0, 0, 0)

				var_398_20.a = 1
				arg_395_1.mask_.color = var_398_20
			end

			local var_398_21 = 2

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_22 = 2

			if var_398_21 <= arg_395_1.time_ and arg_395_1.time_ < var_398_21 + var_398_22 then
				local var_398_23 = (arg_395_1.time_ - var_398_21) / var_398_22
				local var_398_24 = Color.New(0, 0, 0)

				var_398_24.a = Mathf.Lerp(1, 0, var_398_23)
				arg_395_1.mask_.color = var_398_24
			end

			if arg_395_1.time_ >= var_398_21 + var_398_22 and arg_395_1.time_ < var_398_21 + var_398_22 + arg_398_0 then
				local var_398_25 = Color.New(0, 0, 0)
				local var_398_26 = 0

				arg_395_1.mask_.enabled = false
				var_398_25.a = var_398_26
				arg_395_1.mask_.color = var_398_25
			end

			local var_398_27 = arg_395_1.actors_["1047ui_story"].transform
			local var_398_28 = 3.83333333333333

			if var_398_28 < arg_395_1.time_ and arg_395_1.time_ <= var_398_28 + arg_398_0 then
				arg_395_1.var_.moveOldPos1047ui_story = var_398_27.localPosition
			end

			local var_398_29 = 0.001

			if var_398_28 <= arg_395_1.time_ and arg_395_1.time_ < var_398_28 + var_398_29 then
				local var_398_30 = (arg_395_1.time_ - var_398_28) / var_398_29
				local var_398_31 = Vector3.New(-0.6, -1.13, -6.2)

				var_398_27.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1047ui_story, var_398_31, var_398_30)

				local var_398_32 = manager.ui.mainCamera.transform.position - var_398_27.position

				var_398_27.forward = Vector3.New(var_398_32.x, var_398_32.y, var_398_32.z)

				local var_398_33 = var_398_27.localEulerAngles

				var_398_33.z = 0
				var_398_33.x = 0
				var_398_27.localEulerAngles = var_398_33
			end

			if arg_395_1.time_ >= var_398_28 + var_398_29 and arg_395_1.time_ < var_398_28 + var_398_29 + arg_398_0 then
				var_398_27.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_398_34 = manager.ui.mainCamera.transform.position - var_398_27.position

				var_398_27.forward = Vector3.New(var_398_34.x, var_398_34.y, var_398_34.z)

				local var_398_35 = var_398_27.localEulerAngles

				var_398_35.z = 0
				var_398_35.x = 0
				var_398_27.localEulerAngles = var_398_35
			end

			local var_398_36 = arg_395_1.actors_["1047ui_story"]
			local var_398_37 = 3.83333333333333

			if var_398_37 < arg_395_1.time_ and arg_395_1.time_ <= var_398_37 + arg_398_0 and not isNil(var_398_36) and arg_395_1.var_.characterEffect1047ui_story == nil then
				arg_395_1.var_.characterEffect1047ui_story = var_398_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_38 = 0.200000002980232

			if var_398_37 <= arg_395_1.time_ and arg_395_1.time_ < var_398_37 + var_398_38 and not isNil(var_398_36) then
				local var_398_39 = (arg_395_1.time_ - var_398_37) / var_398_38

				if arg_395_1.var_.characterEffect1047ui_story and not isNil(var_398_36) then
					arg_395_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_37 + var_398_38 and arg_395_1.time_ < var_398_37 + var_398_38 + arg_398_0 and not isNil(var_398_36) and arg_395_1.var_.characterEffect1047ui_story then
				arg_395_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_398_40 = 3.83333333333333

			if var_398_40 < arg_395_1.time_ and arg_395_1.time_ <= var_398_40 + arg_398_0 then
				arg_395_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_398_41 = 3.83333333333333

			if var_398_41 < arg_395_1.time_ and arg_395_1.time_ <= var_398_41 + arg_398_0 then
				arg_395_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_398_42 = 0.1
			local var_398_43 = 1

			if var_398_42 < arg_395_1.time_ and arg_395_1.time_ <= var_398_42 + arg_398_0 then
				local var_398_44 = "stop"
				local var_398_45 = "effect"

				arg_395_1:AudioAction(var_398_44, var_398_45, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			local var_398_46 = 1.56666666666667
			local var_398_47 = 1

			if var_398_46 < arg_395_1.time_ and arg_395_1.time_ <= var_398_46 + arg_398_0 then
				local var_398_48 = "play"
				local var_398_49 = "effect"

				arg_395_1:AudioAction(var_398_48, var_398_49, "se_story_140", "se_story_140_amb_lfe", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_50 = 4
			local var_398_51 = 0.425

			if var_398_50 < arg_395_1.time_ and arg_395_1.time_ <= var_398_50 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_52 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_52:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_53 = arg_395_1:FormatText(StoryNameCfg[1296].name)

				arg_395_1.leftNameTxt_.text = var_398_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_54 = arg_395_1:GetWordFromCfg(421052097)
				local var_398_55 = arg_395_1:FormatText(var_398_54.content)

				arg_395_1.text_.text = var_398_55

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_56 = 17
				local var_398_57 = utf8.len(var_398_55)
				local var_398_58 = var_398_56 <= 0 and var_398_51 or var_398_51 * (var_398_57 / var_398_56)

				if var_398_58 > 0 and var_398_51 < var_398_58 then
					arg_395_1.talkMaxDuration = var_398_58
					var_398_50 = var_398_50 + 0.3

					if var_398_58 + var_398_50 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_58 + var_398_50
					end
				end

				arg_395_1.text_.text = var_398_55
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052097", "story_v_out_421052.awb") ~= 0 then
					local var_398_59 = manager.audio:GetVoiceLength("story_v_out_421052", "421052097", "story_v_out_421052.awb") / 1000

					if var_398_59 + var_398_50 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_59 + var_398_50
					end

					if var_398_54.prefab_name ~= "" and arg_395_1.actors_[var_398_54.prefab_name] ~= nil then
						local var_398_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_54.prefab_name].transform, "story_v_out_421052", "421052097", "story_v_out_421052.awb")

						arg_395_1:RecordAudio("421052097", var_398_60)
						arg_395_1:RecordAudio("421052097", var_398_60)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_421052", "421052097", "story_v_out_421052.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_421052", "421052097", "story_v_out_421052.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_61 = var_398_50 + 0.3
			local var_398_62 = math.max(var_398_51, arg_395_1.talkMaxDuration)

			if var_398_61 <= arg_395_1.time_ and arg_395_1.time_ < var_398_61 + var_398_62 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_61) / var_398_62

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_61 + var_398_62 and arg_395_1.time_ < var_398_61 + var_398_62 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play421052098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 421052098
		arg_401_1.duration_ = 5.57

		local var_401_0 = {
			zh = 4.333,
			ja = 5.566
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play421052099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10145ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos10145ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0.78, -1, -6.2)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10145ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["10145ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect10145ui_story == nil then
				arg_401_1.var_.characterEffect10145ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect10145ui_story and not isNil(var_404_9) then
					arg_401_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect10145ui_story then
				arg_401_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_404_13 = arg_401_1.actors_["1047ui_story"]
			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 and not isNil(var_404_13) and arg_401_1.var_.characterEffect1047ui_story == nil then
				arg_401_1.var_.characterEffect1047ui_story = var_404_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_15 = 0.200000002980232

			if var_404_14 <= arg_401_1.time_ and arg_401_1.time_ < var_404_14 + var_404_15 and not isNil(var_404_13) then
				local var_404_16 = (arg_401_1.time_ - var_404_14) / var_404_15

				if arg_401_1.var_.characterEffect1047ui_story and not isNil(var_404_13) then
					local var_404_17 = Mathf.Lerp(0, 0.5, var_404_16)

					arg_401_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1047ui_story.fillRatio = var_404_17
				end
			end

			if arg_401_1.time_ >= var_404_14 + var_404_15 and arg_401_1.time_ < var_404_14 + var_404_15 + arg_404_0 and not isNil(var_404_13) and arg_401_1.var_.characterEffect1047ui_story then
				local var_404_18 = 0.5

				arg_401_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1047ui_story.fillRatio = var_404_18
			end

			local var_404_19 = 0

			if var_404_19 < arg_401_1.time_ and arg_401_1.time_ <= var_404_19 + arg_404_0 then
				arg_401_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_404_20 = 0

			if var_404_20 < arg_401_1.time_ and arg_401_1.time_ <= var_404_20 + arg_404_0 then
				arg_401_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_404_21 = 0
			local var_404_22 = 0.575

			if var_404_21 < arg_401_1.time_ and arg_401_1.time_ <= var_404_21 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_23 = arg_401_1:FormatText(StoryNameCfg[1308].name)

				arg_401_1.leftNameTxt_.text = var_404_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_24 = arg_401_1:GetWordFromCfg(421052098)
				local var_404_25 = arg_401_1:FormatText(var_404_24.content)

				arg_401_1.text_.text = var_404_25

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_26 = 23
				local var_404_27 = utf8.len(var_404_25)
				local var_404_28 = var_404_26 <= 0 and var_404_22 or var_404_22 * (var_404_27 / var_404_26)

				if var_404_28 > 0 and var_404_22 < var_404_28 then
					arg_401_1.talkMaxDuration = var_404_28

					if var_404_28 + var_404_21 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_28 + var_404_21
					end
				end

				arg_401_1.text_.text = var_404_25
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052098", "story_v_out_421052.awb") ~= 0 then
					local var_404_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052098", "story_v_out_421052.awb") / 1000

					if var_404_29 + var_404_21 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_29 + var_404_21
					end

					if var_404_24.prefab_name ~= "" and arg_401_1.actors_[var_404_24.prefab_name] ~= nil then
						local var_404_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_24.prefab_name].transform, "story_v_out_421052", "421052098", "story_v_out_421052.awb")

						arg_401_1:RecordAudio("421052098", var_404_30)
						arg_401_1:RecordAudio("421052098", var_404_30)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_421052", "421052098", "story_v_out_421052.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_421052", "421052098", "story_v_out_421052.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_31 = math.max(var_404_22, arg_401_1.talkMaxDuration)

			if var_404_21 <= arg_401_1.time_ and arg_401_1.time_ < var_404_21 + var_404_31 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_21) / var_404_31

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_21 + var_404_31 and arg_401_1.time_ < var_404_21 + var_404_31 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play421052099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 421052099
		arg_405_1.duration_ = 9.33

		local var_405_0 = {
			zh = 6.233,
			ja = 9.333
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play421052100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1047ui_story"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos1047ui_story = var_408_0.localPosition
			end

			local var_408_2 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2
				local var_408_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1047ui_story, var_408_4, var_408_3)

				local var_408_5 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_5.x, var_408_5.y, var_408_5.z)

				local var_408_6 = var_408_0.localEulerAngles

				var_408_6.z = 0
				var_408_6.x = 0
				var_408_0.localEulerAngles = var_408_6
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_408_7 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_7.x, var_408_7.y, var_408_7.z)

				local var_408_8 = var_408_0.localEulerAngles

				var_408_8.z = 0
				var_408_8.x = 0
				var_408_0.localEulerAngles = var_408_8
			end

			local var_408_9 = arg_405_1.actors_["1047ui_story"]
			local var_408_10 = 0

			if var_408_10 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect1047ui_story == nil then
				arg_405_1.var_.characterEffect1047ui_story = var_408_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_11 = 0.200000002980232

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_11 and not isNil(var_408_9) then
				local var_408_12 = (arg_405_1.time_ - var_408_10) / var_408_11

				if arg_405_1.var_.characterEffect1047ui_story and not isNil(var_408_9) then
					arg_405_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_10 + var_408_11 and arg_405_1.time_ < var_408_10 + var_408_11 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect1047ui_story then
				arg_405_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_408_13 = arg_405_1.actors_["10145ui_story"]
			local var_408_14 = 0

			if var_408_14 < arg_405_1.time_ and arg_405_1.time_ <= var_408_14 + arg_408_0 and not isNil(var_408_13) and arg_405_1.var_.characterEffect10145ui_story == nil then
				arg_405_1.var_.characterEffect10145ui_story = var_408_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_15 = 0.200000002980232

			if var_408_14 <= arg_405_1.time_ and arg_405_1.time_ < var_408_14 + var_408_15 and not isNil(var_408_13) then
				local var_408_16 = (arg_405_1.time_ - var_408_14) / var_408_15

				if arg_405_1.var_.characterEffect10145ui_story and not isNil(var_408_13) then
					local var_408_17 = Mathf.Lerp(0, 0.5, var_408_16)

					arg_405_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10145ui_story.fillRatio = var_408_17
				end
			end

			if arg_405_1.time_ >= var_408_14 + var_408_15 and arg_405_1.time_ < var_408_14 + var_408_15 + arg_408_0 and not isNil(var_408_13) and arg_405_1.var_.characterEffect10145ui_story then
				local var_408_18 = 0.5

				arg_405_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10145ui_story.fillRatio = var_408_18
			end

			local var_408_19 = 0

			if var_408_19 < arg_405_1.time_ and arg_405_1.time_ <= var_408_19 + arg_408_0 then
				arg_405_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_408_20 = 0

			if var_408_20 < arg_405_1.time_ and arg_405_1.time_ <= var_408_20 + arg_408_0 then
				arg_405_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_408_21 = 0
			local var_408_22 = 0.85

			if var_408_21 < arg_405_1.time_ and arg_405_1.time_ <= var_408_21 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_23 = arg_405_1:FormatText(StoryNameCfg[1296].name)

				arg_405_1.leftNameTxt_.text = var_408_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_24 = arg_405_1:GetWordFromCfg(421052099)
				local var_408_25 = arg_405_1:FormatText(var_408_24.content)

				arg_405_1.text_.text = var_408_25

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_26 = 34
				local var_408_27 = utf8.len(var_408_25)
				local var_408_28 = var_408_26 <= 0 and var_408_22 or var_408_22 * (var_408_27 / var_408_26)

				if var_408_28 > 0 and var_408_22 < var_408_28 then
					arg_405_1.talkMaxDuration = var_408_28

					if var_408_28 + var_408_21 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_28 + var_408_21
					end
				end

				arg_405_1.text_.text = var_408_25
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052099", "story_v_out_421052.awb") ~= 0 then
					local var_408_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052099", "story_v_out_421052.awb") / 1000

					if var_408_29 + var_408_21 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_29 + var_408_21
					end

					if var_408_24.prefab_name ~= "" and arg_405_1.actors_[var_408_24.prefab_name] ~= nil then
						local var_408_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_24.prefab_name].transform, "story_v_out_421052", "421052099", "story_v_out_421052.awb")

						arg_405_1:RecordAudio("421052099", var_408_30)
						arg_405_1:RecordAudio("421052099", var_408_30)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_421052", "421052099", "story_v_out_421052.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_421052", "421052099", "story_v_out_421052.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_31 = math.max(var_408_22, arg_405_1.talkMaxDuration)

			if var_408_21 <= arg_405_1.time_ and arg_405_1.time_ < var_408_21 + var_408_31 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_21) / var_408_31

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_21 + var_408_31 and arg_405_1.time_ < var_408_21 + var_408_31 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play421052100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 421052100
		arg_409_1.duration_ = 9.83

		local var_409_0 = {
			zh = 9.666,
			ja = 9.833
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play421052101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10145ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos10145ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0.78, -1, -6.2)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10145ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["10145ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect10145ui_story == nil then
				arg_409_1.var_.characterEffect10145ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect10145ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect10145ui_story then
				arg_409_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_412_13 = arg_409_1.actors_["1047ui_story"]
			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 and not isNil(var_412_13) and arg_409_1.var_.characterEffect1047ui_story == nil then
				arg_409_1.var_.characterEffect1047ui_story = var_412_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_15 = 0.200000002980232

			if var_412_14 <= arg_409_1.time_ and arg_409_1.time_ < var_412_14 + var_412_15 and not isNil(var_412_13) then
				local var_412_16 = (arg_409_1.time_ - var_412_14) / var_412_15

				if arg_409_1.var_.characterEffect1047ui_story and not isNil(var_412_13) then
					local var_412_17 = Mathf.Lerp(0, 0.5, var_412_16)

					arg_409_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1047ui_story.fillRatio = var_412_17
				end
			end

			if arg_409_1.time_ >= var_412_14 + var_412_15 and arg_409_1.time_ < var_412_14 + var_412_15 + arg_412_0 and not isNil(var_412_13) and arg_409_1.var_.characterEffect1047ui_story then
				local var_412_18 = 0.5

				arg_409_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1047ui_story.fillRatio = var_412_18
			end

			local var_412_19 = 0

			if var_412_19 < arg_409_1.time_ and arg_409_1.time_ <= var_412_19 + arg_412_0 then
				arg_409_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_412_20 = 0

			if var_412_20 < arg_409_1.time_ and arg_409_1.time_ <= var_412_20 + arg_412_0 then
				arg_409_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_412_21 = 0
			local var_412_22 = 1.225

			if var_412_21 < arg_409_1.time_ and arg_409_1.time_ <= var_412_21 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_23 = arg_409_1:FormatText(StoryNameCfg[1308].name)

				arg_409_1.leftNameTxt_.text = var_412_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_24 = arg_409_1:GetWordFromCfg(421052100)
				local var_412_25 = arg_409_1:FormatText(var_412_24.content)

				arg_409_1.text_.text = var_412_25

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_26 = 49
				local var_412_27 = utf8.len(var_412_25)
				local var_412_28 = var_412_26 <= 0 and var_412_22 or var_412_22 * (var_412_27 / var_412_26)

				if var_412_28 > 0 and var_412_22 < var_412_28 then
					arg_409_1.talkMaxDuration = var_412_28

					if var_412_28 + var_412_21 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_28 + var_412_21
					end
				end

				arg_409_1.text_.text = var_412_25
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052100", "story_v_out_421052.awb") ~= 0 then
					local var_412_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052100", "story_v_out_421052.awb") / 1000

					if var_412_29 + var_412_21 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_29 + var_412_21
					end

					if var_412_24.prefab_name ~= "" and arg_409_1.actors_[var_412_24.prefab_name] ~= nil then
						local var_412_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_24.prefab_name].transform, "story_v_out_421052", "421052100", "story_v_out_421052.awb")

						arg_409_1:RecordAudio("421052100", var_412_30)
						arg_409_1:RecordAudio("421052100", var_412_30)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_421052", "421052100", "story_v_out_421052.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_421052", "421052100", "story_v_out_421052.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_31 = math.max(var_412_22, arg_409_1.talkMaxDuration)

			if var_412_21 <= arg_409_1.time_ and arg_409_1.time_ < var_412_21 + var_412_31 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_21) / var_412_31

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_21 + var_412_31 and arg_409_1.time_ < var_412_21 + var_412_31 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play421052101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 421052101
		arg_413_1.duration_ = 8.5

		local var_413_0 = {
			zh = 6.666,
			ja = 8.5
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play421052102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.85

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[1308].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_3 = arg_413_1:GetWordFromCfg(421052101)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 34
				local var_416_6 = utf8.len(var_416_4)
				local var_416_7 = var_416_5 <= 0 and var_416_1 or var_416_1 * (var_416_6 / var_416_5)

				if var_416_7 > 0 and var_416_1 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052101", "story_v_out_421052.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_out_421052", "421052101", "story_v_out_421052.awb") / 1000

					if var_416_8 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_0
					end

					if var_416_3.prefab_name ~= "" and arg_413_1.actors_[var_416_3.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_3.prefab_name].transform, "story_v_out_421052", "421052101", "story_v_out_421052.awb")

						arg_413_1:RecordAudio("421052101", var_416_9)
						arg_413_1:RecordAudio("421052101", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_421052", "421052101", "story_v_out_421052.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_421052", "421052101", "story_v_out_421052.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_10 and arg_413_1.time_ < var_416_0 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play421052102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 421052102
		arg_417_1.duration_ = 5.07

		local var_417_0 = {
			zh = 3.1,
			ja = 5.066
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play421052103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1047ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1047ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1047ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["1047ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1047ui_story == nil then
				arg_417_1.var_.characterEffect1047ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect1047ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1047ui_story then
				arg_417_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_420_13 = arg_417_1.actors_["10145ui_story"]
			local var_420_14 = 0

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 and not isNil(var_420_13) and arg_417_1.var_.characterEffect10145ui_story == nil then
				arg_417_1.var_.characterEffect10145ui_story = var_420_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_15 = 0.200000002980232

			if var_420_14 <= arg_417_1.time_ and arg_417_1.time_ < var_420_14 + var_420_15 and not isNil(var_420_13) then
				local var_420_16 = (arg_417_1.time_ - var_420_14) / var_420_15

				if arg_417_1.var_.characterEffect10145ui_story and not isNil(var_420_13) then
					local var_420_17 = Mathf.Lerp(0, 0.5, var_420_16)

					arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10145ui_story.fillRatio = var_420_17
				end
			end

			if arg_417_1.time_ >= var_420_14 + var_420_15 and arg_417_1.time_ < var_420_14 + var_420_15 + arg_420_0 and not isNil(var_420_13) and arg_417_1.var_.characterEffect10145ui_story then
				local var_420_18 = 0.5

				arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10145ui_story.fillRatio = var_420_18
			end

			local var_420_19 = 0

			if var_420_19 < arg_417_1.time_ and arg_417_1.time_ <= var_420_19 + arg_420_0 then
				arg_417_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_420_20 = 0

			if var_420_20 < arg_417_1.time_ and arg_417_1.time_ <= var_420_20 + arg_420_0 then
				arg_417_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_420_21 = 0
			local var_420_22 = 0.375

			if var_420_21 < arg_417_1.time_ and arg_417_1.time_ <= var_420_21 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_23 = arg_417_1:FormatText(StoryNameCfg[1296].name)

				arg_417_1.leftNameTxt_.text = var_420_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_24 = arg_417_1:GetWordFromCfg(421052102)
				local var_420_25 = arg_417_1:FormatText(var_420_24.content)

				arg_417_1.text_.text = var_420_25

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_26 = 15
				local var_420_27 = utf8.len(var_420_25)
				local var_420_28 = var_420_26 <= 0 and var_420_22 or var_420_22 * (var_420_27 / var_420_26)

				if var_420_28 > 0 and var_420_22 < var_420_28 then
					arg_417_1.talkMaxDuration = var_420_28

					if var_420_28 + var_420_21 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_28 + var_420_21
					end
				end

				arg_417_1.text_.text = var_420_25
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052102", "story_v_out_421052.awb") ~= 0 then
					local var_420_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052102", "story_v_out_421052.awb") / 1000

					if var_420_29 + var_420_21 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_29 + var_420_21
					end

					if var_420_24.prefab_name ~= "" and arg_417_1.actors_[var_420_24.prefab_name] ~= nil then
						local var_420_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_24.prefab_name].transform, "story_v_out_421052", "421052102", "story_v_out_421052.awb")

						arg_417_1:RecordAudio("421052102", var_420_30)
						arg_417_1:RecordAudio("421052102", var_420_30)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_421052", "421052102", "story_v_out_421052.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_421052", "421052102", "story_v_out_421052.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_31 = math.max(var_420_22, arg_417_1.talkMaxDuration)

			if var_420_21 <= arg_417_1.time_ and arg_417_1.time_ < var_420_21 + var_420_31 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_21) / var_420_31

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_21 + var_420_31 and arg_417_1.time_ < var_420_21 + var_420_31 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play421052103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 421052103
		arg_421_1.duration_ = 2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play421052104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10145ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos10145ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0.78, -1, -6.2)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10145ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["10145ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect10145ui_story == nil then
				arg_421_1.var_.characterEffect10145ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 and not isNil(var_424_9) then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect10145ui_story and not isNil(var_424_9) then
					arg_421_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect10145ui_story then
				arg_421_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_424_13 = arg_421_1.actors_["1047ui_story"]
			local var_424_14 = 0

			if var_424_14 < arg_421_1.time_ and arg_421_1.time_ <= var_424_14 + arg_424_0 and not isNil(var_424_13) and arg_421_1.var_.characterEffect1047ui_story == nil then
				arg_421_1.var_.characterEffect1047ui_story = var_424_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_15 = 0.200000002980232

			if var_424_14 <= arg_421_1.time_ and arg_421_1.time_ < var_424_14 + var_424_15 and not isNil(var_424_13) then
				local var_424_16 = (arg_421_1.time_ - var_424_14) / var_424_15

				if arg_421_1.var_.characterEffect1047ui_story and not isNil(var_424_13) then
					local var_424_17 = Mathf.Lerp(0, 0.5, var_424_16)

					arg_421_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1047ui_story.fillRatio = var_424_17
				end
			end

			if arg_421_1.time_ >= var_424_14 + var_424_15 and arg_421_1.time_ < var_424_14 + var_424_15 + arg_424_0 and not isNil(var_424_13) and arg_421_1.var_.characterEffect1047ui_story then
				local var_424_18 = 0.5

				arg_421_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1047ui_story.fillRatio = var_424_18
			end

			local var_424_19 = 0

			if var_424_19 < arg_421_1.time_ and arg_421_1.time_ <= var_424_19 + arg_424_0 then
				arg_421_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			local var_424_20 = 0

			if var_424_20 < arg_421_1.time_ and arg_421_1.time_ <= var_424_20 + arg_424_0 then
				arg_421_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_424_21 = 0
			local var_424_22 = 0.05

			if var_424_21 < arg_421_1.time_ and arg_421_1.time_ <= var_424_21 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_23 = arg_421_1:FormatText(StoryNameCfg[1308].name)

				arg_421_1.leftNameTxt_.text = var_424_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_24 = arg_421_1:GetWordFromCfg(421052103)
				local var_424_25 = arg_421_1:FormatText(var_424_24.content)

				arg_421_1.text_.text = var_424_25

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_26 = 2
				local var_424_27 = utf8.len(var_424_25)
				local var_424_28 = var_424_26 <= 0 and var_424_22 or var_424_22 * (var_424_27 / var_424_26)

				if var_424_28 > 0 and var_424_22 < var_424_28 then
					arg_421_1.talkMaxDuration = var_424_28

					if var_424_28 + var_424_21 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_28 + var_424_21
					end
				end

				arg_421_1.text_.text = var_424_25
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052103", "story_v_out_421052.awb") ~= 0 then
					local var_424_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052103", "story_v_out_421052.awb") / 1000

					if var_424_29 + var_424_21 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_29 + var_424_21
					end

					if var_424_24.prefab_name ~= "" and arg_421_1.actors_[var_424_24.prefab_name] ~= nil then
						local var_424_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_24.prefab_name].transform, "story_v_out_421052", "421052103", "story_v_out_421052.awb")

						arg_421_1:RecordAudio("421052103", var_424_30)
						arg_421_1:RecordAudio("421052103", var_424_30)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_421052", "421052103", "story_v_out_421052.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_421052", "421052103", "story_v_out_421052.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_31 = math.max(var_424_22, arg_421_1.talkMaxDuration)

			if var_424_21 <= arg_421_1.time_ and arg_421_1.time_ < var_424_21 + var_424_31 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_21) / var_424_31

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_21 + var_424_31 and arg_421_1.time_ < var_424_21 + var_424_31 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play421052104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 421052104
		arg_425_1.duration_ = 14.07

		local var_425_0 = {
			zh = 8.766,
			ja = 14.066
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play421052105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1047ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1047ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1047ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["1047ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1047ui_story == nil then
				arg_425_1.var_.characterEffect1047ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect1047ui_story and not isNil(var_428_9) then
					arg_425_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1047ui_story then
				arg_425_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_428_13 = arg_425_1.actors_["10145ui_story"]
			local var_428_14 = 0

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 and not isNil(var_428_13) and arg_425_1.var_.characterEffect10145ui_story == nil then
				arg_425_1.var_.characterEffect10145ui_story = var_428_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_15 = 0.200000002980232

			if var_428_14 <= arg_425_1.time_ and arg_425_1.time_ < var_428_14 + var_428_15 and not isNil(var_428_13) then
				local var_428_16 = (arg_425_1.time_ - var_428_14) / var_428_15

				if arg_425_1.var_.characterEffect10145ui_story and not isNil(var_428_13) then
					local var_428_17 = Mathf.Lerp(0, 0.5, var_428_16)

					arg_425_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_425_1.var_.characterEffect10145ui_story.fillRatio = var_428_17
				end
			end

			if arg_425_1.time_ >= var_428_14 + var_428_15 and arg_425_1.time_ < var_428_14 + var_428_15 + arg_428_0 and not isNil(var_428_13) and arg_425_1.var_.characterEffect10145ui_story then
				local var_428_18 = 0.5

				arg_425_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_425_1.var_.characterEffect10145ui_story.fillRatio = var_428_18
			end

			local var_428_19 = 0

			if var_428_19 < arg_425_1.time_ and arg_425_1.time_ <= var_428_19 + arg_428_0 then
				arg_425_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_428_20 = 0

			if var_428_20 < arg_425_1.time_ and arg_425_1.time_ <= var_428_20 + arg_428_0 then
				arg_425_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_428_21 = 0
			local var_428_22 = 0.9

			if var_428_21 < arg_425_1.time_ and arg_425_1.time_ <= var_428_21 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_23 = arg_425_1:FormatText(StoryNameCfg[1296].name)

				arg_425_1.leftNameTxt_.text = var_428_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_24 = arg_425_1:GetWordFromCfg(421052104)
				local var_428_25 = arg_425_1:FormatText(var_428_24.content)

				arg_425_1.text_.text = var_428_25

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_26 = 36
				local var_428_27 = utf8.len(var_428_25)
				local var_428_28 = var_428_26 <= 0 and var_428_22 or var_428_22 * (var_428_27 / var_428_26)

				if var_428_28 > 0 and var_428_22 < var_428_28 then
					arg_425_1.talkMaxDuration = var_428_28

					if var_428_28 + var_428_21 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_28 + var_428_21
					end
				end

				arg_425_1.text_.text = var_428_25
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052104", "story_v_out_421052.awb") ~= 0 then
					local var_428_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052104", "story_v_out_421052.awb") / 1000

					if var_428_29 + var_428_21 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_29 + var_428_21
					end

					if var_428_24.prefab_name ~= "" and arg_425_1.actors_[var_428_24.prefab_name] ~= nil then
						local var_428_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_24.prefab_name].transform, "story_v_out_421052", "421052104", "story_v_out_421052.awb")

						arg_425_1:RecordAudio("421052104", var_428_30)
						arg_425_1:RecordAudio("421052104", var_428_30)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_421052", "421052104", "story_v_out_421052.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_421052", "421052104", "story_v_out_421052.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_31 = math.max(var_428_22, arg_425_1.talkMaxDuration)

			if var_428_21 <= arg_425_1.time_ and arg_425_1.time_ < var_428_21 + var_428_31 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_21) / var_428_31

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_21 + var_428_31 and arg_425_1.time_ < var_428_21 + var_428_31 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play421052105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 421052105
		arg_429_1.duration_ = 9.97

		local var_429_0 = {
			zh = 7.2,
			ja = 9.966
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play421052106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10145ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos10145ui_story = var_432_0.localPosition
			end

			local var_432_2 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2
				local var_432_4 = Vector3.New(0.78, -1, -6.2)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10145ui_story, var_432_4, var_432_3)

				local var_432_5 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_5.x, var_432_5.y, var_432_5.z)

				local var_432_6 = var_432_0.localEulerAngles

				var_432_6.z = 0
				var_432_6.x = 0
				var_432_0.localEulerAngles = var_432_6
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_432_7 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_7.x, var_432_7.y, var_432_7.z)

				local var_432_8 = var_432_0.localEulerAngles

				var_432_8.z = 0
				var_432_8.x = 0
				var_432_0.localEulerAngles = var_432_8
			end

			local var_432_9 = arg_429_1.actors_["10145ui_story"]
			local var_432_10 = 0

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect10145ui_story == nil then
				arg_429_1.var_.characterEffect10145ui_story = var_432_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_11 = 0.200000002980232

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_11 and not isNil(var_432_9) then
				local var_432_12 = (arg_429_1.time_ - var_432_10) / var_432_11

				if arg_429_1.var_.characterEffect10145ui_story and not isNil(var_432_9) then
					arg_429_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_10 + var_432_11 and arg_429_1.time_ < var_432_10 + var_432_11 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect10145ui_story then
				arg_429_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_432_13 = arg_429_1.actors_["1047ui_story"]
			local var_432_14 = 0

			if var_432_14 < arg_429_1.time_ and arg_429_1.time_ <= var_432_14 + arg_432_0 and not isNil(var_432_13) and arg_429_1.var_.characterEffect1047ui_story == nil then
				arg_429_1.var_.characterEffect1047ui_story = var_432_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_15 = 0.200000002980232

			if var_432_14 <= arg_429_1.time_ and arg_429_1.time_ < var_432_14 + var_432_15 and not isNil(var_432_13) then
				local var_432_16 = (arg_429_1.time_ - var_432_14) / var_432_15

				if arg_429_1.var_.characterEffect1047ui_story and not isNil(var_432_13) then
					local var_432_17 = Mathf.Lerp(0, 0.5, var_432_16)

					arg_429_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1047ui_story.fillRatio = var_432_17
				end
			end

			if arg_429_1.time_ >= var_432_14 + var_432_15 and arg_429_1.time_ < var_432_14 + var_432_15 + arg_432_0 and not isNil(var_432_13) and arg_429_1.var_.characterEffect1047ui_story then
				local var_432_18 = 0.5

				arg_429_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1047ui_story.fillRatio = var_432_18
			end

			local var_432_19 = 0

			if var_432_19 < arg_429_1.time_ and arg_429_1.time_ <= var_432_19 + arg_432_0 then
				arg_429_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			local var_432_20 = 0

			if var_432_20 < arg_429_1.time_ and arg_429_1.time_ <= var_432_20 + arg_432_0 then
				arg_429_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_432_21 = 0
			local var_432_22 = 0.75

			if var_432_21 < arg_429_1.time_ and arg_429_1.time_ <= var_432_21 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_23 = arg_429_1:FormatText(StoryNameCfg[1308].name)

				arg_429_1.leftNameTxt_.text = var_432_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_24 = arg_429_1:GetWordFromCfg(421052105)
				local var_432_25 = arg_429_1:FormatText(var_432_24.content)

				arg_429_1.text_.text = var_432_25

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_26 = 30
				local var_432_27 = utf8.len(var_432_25)
				local var_432_28 = var_432_26 <= 0 and var_432_22 or var_432_22 * (var_432_27 / var_432_26)

				if var_432_28 > 0 and var_432_22 < var_432_28 then
					arg_429_1.talkMaxDuration = var_432_28

					if var_432_28 + var_432_21 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_28 + var_432_21
					end
				end

				arg_429_1.text_.text = var_432_25
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052105", "story_v_out_421052.awb") ~= 0 then
					local var_432_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052105", "story_v_out_421052.awb") / 1000

					if var_432_29 + var_432_21 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_29 + var_432_21
					end

					if var_432_24.prefab_name ~= "" and arg_429_1.actors_[var_432_24.prefab_name] ~= nil then
						local var_432_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_24.prefab_name].transform, "story_v_out_421052", "421052105", "story_v_out_421052.awb")

						arg_429_1:RecordAudio("421052105", var_432_30)
						arg_429_1:RecordAudio("421052105", var_432_30)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_421052", "421052105", "story_v_out_421052.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_421052", "421052105", "story_v_out_421052.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_31 = math.max(var_432_22, arg_429_1.talkMaxDuration)

			if var_432_21 <= arg_429_1.time_ and arg_429_1.time_ < var_432_21 + var_432_31 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_21) / var_432_31

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_21 + var_432_31 and arg_429_1.time_ < var_432_21 + var_432_31 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play421052106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 421052106
		arg_433_1.duration_ = 6.4

		local var_433_0 = {
			zh = 3.233,
			ja = 6.4
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
				arg_433_0:Play421052107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1047ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1047ui_story = var_436_0.localPosition
			end

			local var_436_2 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2
				local var_436_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1047ui_story, var_436_4, var_436_3)

				local var_436_5 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_5.x, var_436_5.y, var_436_5.z)

				local var_436_6 = var_436_0.localEulerAngles

				var_436_6.z = 0
				var_436_6.x = 0
				var_436_0.localEulerAngles = var_436_6
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_436_7 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_7.x, var_436_7.y, var_436_7.z)

				local var_436_8 = var_436_0.localEulerAngles

				var_436_8.z = 0
				var_436_8.x = 0
				var_436_0.localEulerAngles = var_436_8
			end

			local var_436_9 = arg_433_1.actors_["1047ui_story"]
			local var_436_10 = 0

			if var_436_10 < arg_433_1.time_ and arg_433_1.time_ <= var_436_10 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect1047ui_story == nil then
				arg_433_1.var_.characterEffect1047ui_story = var_436_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_11 = 0.200000002980232

			if var_436_10 <= arg_433_1.time_ and arg_433_1.time_ < var_436_10 + var_436_11 and not isNil(var_436_9) then
				local var_436_12 = (arg_433_1.time_ - var_436_10) / var_436_11

				if arg_433_1.var_.characterEffect1047ui_story and not isNil(var_436_9) then
					arg_433_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_10 + var_436_11 and arg_433_1.time_ < var_436_10 + var_436_11 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect1047ui_story then
				arg_433_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_436_13 = arg_433_1.actors_["10145ui_story"]
			local var_436_14 = 0

			if var_436_14 < arg_433_1.time_ and arg_433_1.time_ <= var_436_14 + arg_436_0 and not isNil(var_436_13) and arg_433_1.var_.characterEffect10145ui_story == nil then
				arg_433_1.var_.characterEffect10145ui_story = var_436_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_15 = 0.200000002980232

			if var_436_14 <= arg_433_1.time_ and arg_433_1.time_ < var_436_14 + var_436_15 and not isNil(var_436_13) then
				local var_436_16 = (arg_433_1.time_ - var_436_14) / var_436_15

				if arg_433_1.var_.characterEffect10145ui_story and not isNil(var_436_13) then
					local var_436_17 = Mathf.Lerp(0, 0.5, var_436_16)

					arg_433_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_433_1.var_.characterEffect10145ui_story.fillRatio = var_436_17
				end
			end

			if arg_433_1.time_ >= var_436_14 + var_436_15 and arg_433_1.time_ < var_436_14 + var_436_15 + arg_436_0 and not isNil(var_436_13) and arg_433_1.var_.characterEffect10145ui_story then
				local var_436_18 = 0.5

				arg_433_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_433_1.var_.characterEffect10145ui_story.fillRatio = var_436_18
			end

			local var_436_19 = 0

			if var_436_19 < arg_433_1.time_ and arg_433_1.time_ <= var_436_19 + arg_436_0 then
				arg_433_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_436_20 = 0

			if var_436_20 < arg_433_1.time_ and arg_433_1.time_ <= var_436_20 + arg_436_0 then
				arg_433_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_436_21 = 0
			local var_436_22 = 0.3

			if var_436_21 < arg_433_1.time_ and arg_433_1.time_ <= var_436_21 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_23 = arg_433_1:FormatText(StoryNameCfg[1296].name)

				arg_433_1.leftNameTxt_.text = var_436_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_24 = arg_433_1:GetWordFromCfg(421052106)
				local var_436_25 = arg_433_1:FormatText(var_436_24.content)

				arg_433_1.text_.text = var_436_25

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_26 = 12
				local var_436_27 = utf8.len(var_436_25)
				local var_436_28 = var_436_26 <= 0 and var_436_22 or var_436_22 * (var_436_27 / var_436_26)

				if var_436_28 > 0 and var_436_22 < var_436_28 then
					arg_433_1.talkMaxDuration = var_436_28

					if var_436_28 + var_436_21 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_28 + var_436_21
					end
				end

				arg_433_1.text_.text = var_436_25
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052106", "story_v_out_421052.awb") ~= 0 then
					local var_436_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052106", "story_v_out_421052.awb") / 1000

					if var_436_29 + var_436_21 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_29 + var_436_21
					end

					if var_436_24.prefab_name ~= "" and arg_433_1.actors_[var_436_24.prefab_name] ~= nil then
						local var_436_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_24.prefab_name].transform, "story_v_out_421052", "421052106", "story_v_out_421052.awb")

						arg_433_1:RecordAudio("421052106", var_436_30)
						arg_433_1:RecordAudio("421052106", var_436_30)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_421052", "421052106", "story_v_out_421052.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_421052", "421052106", "story_v_out_421052.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_31 = math.max(var_436_22, arg_433_1.talkMaxDuration)

			if var_436_21 <= arg_433_1.time_ and arg_433_1.time_ < var_436_21 + var_436_31 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_21) / var_436_31

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_21 + var_436_31 and arg_433_1.time_ < var_436_21 + var_436_31 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play421052107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 421052107
		arg_437_1.duration_ = 7.67

		local var_437_0 = {
			zh = 4.966,
			ja = 7.666
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
				arg_437_0:Play421052108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["10145ui_story"].transform
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.moveOldPos10145ui_story = var_440_0.localPosition
			end

			local var_440_2 = 0.001

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2
				local var_440_4 = Vector3.New(0.78, -1, -6.2)

				var_440_0.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos10145ui_story, var_440_4, var_440_3)

				local var_440_5 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_5.x, var_440_5.y, var_440_5.z)

				local var_440_6 = var_440_0.localEulerAngles

				var_440_6.z = 0
				var_440_6.x = 0
				var_440_0.localEulerAngles = var_440_6
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_440_7 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_7.x, var_440_7.y, var_440_7.z)

				local var_440_8 = var_440_0.localEulerAngles

				var_440_8.z = 0
				var_440_8.x = 0
				var_440_0.localEulerAngles = var_440_8
			end

			local var_440_9 = arg_437_1.actors_["10145ui_story"]
			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect10145ui_story == nil then
				arg_437_1.var_.characterEffect10145ui_story = var_440_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_11 = 0.200000002980232

			if var_440_10 <= arg_437_1.time_ and arg_437_1.time_ < var_440_10 + var_440_11 and not isNil(var_440_9) then
				local var_440_12 = (arg_437_1.time_ - var_440_10) / var_440_11

				if arg_437_1.var_.characterEffect10145ui_story and not isNil(var_440_9) then
					arg_437_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_10 + var_440_11 and arg_437_1.time_ < var_440_10 + var_440_11 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect10145ui_story then
				arg_437_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_440_13 = arg_437_1.actors_["1047ui_story"]
			local var_440_14 = 0

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 and not isNil(var_440_13) and arg_437_1.var_.characterEffect1047ui_story == nil then
				arg_437_1.var_.characterEffect1047ui_story = var_440_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_15 = 0.200000002980232

			if var_440_14 <= arg_437_1.time_ and arg_437_1.time_ < var_440_14 + var_440_15 and not isNil(var_440_13) then
				local var_440_16 = (arg_437_1.time_ - var_440_14) / var_440_15

				if arg_437_1.var_.characterEffect1047ui_story and not isNil(var_440_13) then
					local var_440_17 = Mathf.Lerp(0, 0.5, var_440_16)

					arg_437_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1047ui_story.fillRatio = var_440_17
				end
			end

			if arg_437_1.time_ >= var_440_14 + var_440_15 and arg_437_1.time_ < var_440_14 + var_440_15 + arg_440_0 and not isNil(var_440_13) and arg_437_1.var_.characterEffect1047ui_story then
				local var_440_18 = 0.5

				arg_437_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1047ui_story.fillRatio = var_440_18
			end

			local var_440_19 = 0

			if var_440_19 < arg_437_1.time_ and arg_437_1.time_ <= var_440_19 + arg_440_0 then
				arg_437_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			local var_440_20 = 0

			if var_440_20 < arg_437_1.time_ and arg_437_1.time_ <= var_440_20 + arg_440_0 then
				arg_437_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_440_21 = 0
			local var_440_22 = 0.6

			if var_440_21 < arg_437_1.time_ and arg_437_1.time_ <= var_440_21 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_23 = arg_437_1:FormatText(StoryNameCfg[1308].name)

				arg_437_1.leftNameTxt_.text = var_440_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_24 = arg_437_1:GetWordFromCfg(421052107)
				local var_440_25 = arg_437_1:FormatText(var_440_24.content)

				arg_437_1.text_.text = var_440_25

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_26 = 24
				local var_440_27 = utf8.len(var_440_25)
				local var_440_28 = var_440_26 <= 0 and var_440_22 or var_440_22 * (var_440_27 / var_440_26)

				if var_440_28 > 0 and var_440_22 < var_440_28 then
					arg_437_1.talkMaxDuration = var_440_28

					if var_440_28 + var_440_21 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_28 + var_440_21
					end
				end

				arg_437_1.text_.text = var_440_25
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052107", "story_v_out_421052.awb") ~= 0 then
					local var_440_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052107", "story_v_out_421052.awb") / 1000

					if var_440_29 + var_440_21 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_29 + var_440_21
					end

					if var_440_24.prefab_name ~= "" and arg_437_1.actors_[var_440_24.prefab_name] ~= nil then
						local var_440_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_24.prefab_name].transform, "story_v_out_421052", "421052107", "story_v_out_421052.awb")

						arg_437_1:RecordAudio("421052107", var_440_30)
						arg_437_1:RecordAudio("421052107", var_440_30)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_421052", "421052107", "story_v_out_421052.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_421052", "421052107", "story_v_out_421052.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_31 = math.max(var_440_22, arg_437_1.talkMaxDuration)

			if var_440_21 <= arg_437_1.time_ and arg_437_1.time_ < var_440_21 + var_440_31 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_21) / var_440_31

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_21 + var_440_31 and arg_437_1.time_ < var_440_21 + var_440_31 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play421052108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 421052108
		arg_441_1.duration_ = 8.43

		local var_441_0 = {
			zh = 5.133,
			ja = 8.433
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play421052109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1047ui_story"].transform
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.var_.moveOldPos1047ui_story = var_444_0.localPosition
			end

			local var_444_2 = 0.001

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2
				local var_444_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_444_0.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1047ui_story, var_444_4, var_444_3)

				local var_444_5 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_5.x, var_444_5.y, var_444_5.z)

				local var_444_6 = var_444_0.localEulerAngles

				var_444_6.z = 0
				var_444_6.x = 0
				var_444_0.localEulerAngles = var_444_6
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 then
				var_444_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_444_7 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_7.x, var_444_7.y, var_444_7.z)

				local var_444_8 = var_444_0.localEulerAngles

				var_444_8.z = 0
				var_444_8.x = 0
				var_444_0.localEulerAngles = var_444_8
			end

			local var_444_9 = arg_441_1.actors_["1047ui_story"]
			local var_444_10 = 0

			if var_444_10 < arg_441_1.time_ and arg_441_1.time_ <= var_444_10 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect1047ui_story == nil then
				arg_441_1.var_.characterEffect1047ui_story = var_444_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_11 = 0.200000002980232

			if var_444_10 <= arg_441_1.time_ and arg_441_1.time_ < var_444_10 + var_444_11 and not isNil(var_444_9) then
				local var_444_12 = (arg_441_1.time_ - var_444_10) / var_444_11

				if arg_441_1.var_.characterEffect1047ui_story and not isNil(var_444_9) then
					arg_441_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_10 + var_444_11 and arg_441_1.time_ < var_444_10 + var_444_11 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect1047ui_story then
				arg_441_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_444_13 = arg_441_1.actors_["10145ui_story"]
			local var_444_14 = 0

			if var_444_14 < arg_441_1.time_ and arg_441_1.time_ <= var_444_14 + arg_444_0 and not isNil(var_444_13) and arg_441_1.var_.characterEffect10145ui_story == nil then
				arg_441_1.var_.characterEffect10145ui_story = var_444_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_15 = 0.200000002980232

			if var_444_14 <= arg_441_1.time_ and arg_441_1.time_ < var_444_14 + var_444_15 and not isNil(var_444_13) then
				local var_444_16 = (arg_441_1.time_ - var_444_14) / var_444_15

				if arg_441_1.var_.characterEffect10145ui_story and not isNil(var_444_13) then
					local var_444_17 = Mathf.Lerp(0, 0.5, var_444_16)

					arg_441_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_441_1.var_.characterEffect10145ui_story.fillRatio = var_444_17
				end
			end

			if arg_441_1.time_ >= var_444_14 + var_444_15 and arg_441_1.time_ < var_444_14 + var_444_15 + arg_444_0 and not isNil(var_444_13) and arg_441_1.var_.characterEffect10145ui_story then
				local var_444_18 = 0.5

				arg_441_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_441_1.var_.characterEffect10145ui_story.fillRatio = var_444_18
			end

			local var_444_19 = 0

			if var_444_19 < arg_441_1.time_ and arg_441_1.time_ <= var_444_19 + arg_444_0 then
				arg_441_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action463")
			end

			local var_444_20 = 0

			if var_444_20 < arg_441_1.time_ and arg_441_1.time_ <= var_444_20 + arg_444_0 then
				arg_441_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_444_21 = 0
			local var_444_22 = 0.6

			if var_444_21 < arg_441_1.time_ and arg_441_1.time_ <= var_444_21 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_23 = arg_441_1:FormatText(StoryNameCfg[1296].name)

				arg_441_1.leftNameTxt_.text = var_444_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_24 = arg_441_1:GetWordFromCfg(421052108)
				local var_444_25 = arg_441_1:FormatText(var_444_24.content)

				arg_441_1.text_.text = var_444_25

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_26 = 24
				local var_444_27 = utf8.len(var_444_25)
				local var_444_28 = var_444_26 <= 0 and var_444_22 or var_444_22 * (var_444_27 / var_444_26)

				if var_444_28 > 0 and var_444_22 < var_444_28 then
					arg_441_1.talkMaxDuration = var_444_28

					if var_444_28 + var_444_21 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_28 + var_444_21
					end
				end

				arg_441_1.text_.text = var_444_25
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052108", "story_v_out_421052.awb") ~= 0 then
					local var_444_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052108", "story_v_out_421052.awb") / 1000

					if var_444_29 + var_444_21 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_29 + var_444_21
					end

					if var_444_24.prefab_name ~= "" and arg_441_1.actors_[var_444_24.prefab_name] ~= nil then
						local var_444_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_24.prefab_name].transform, "story_v_out_421052", "421052108", "story_v_out_421052.awb")

						arg_441_1:RecordAudio("421052108", var_444_30)
						arg_441_1:RecordAudio("421052108", var_444_30)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_421052", "421052108", "story_v_out_421052.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_421052", "421052108", "story_v_out_421052.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_31 = math.max(var_444_22, arg_441_1.talkMaxDuration)

			if var_444_21 <= arg_441_1.time_ and arg_441_1.time_ < var_444_21 + var_444_31 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_21) / var_444_31

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_21 + var_444_31 and arg_441_1.time_ < var_444_21 + var_444_31 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play421052109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 421052109
		arg_445_1.duration_ = 16.5

		local var_445_0 = {
			zh = 13.333,
			ja = 16.5
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
				arg_445_0:Play421052110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["10145ui_story"].transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.var_.moveOldPos10145ui_story = var_448_0.localPosition
			end

			local var_448_2 = 0.001

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2
				local var_448_4 = Vector3.New(0.78, -1, -6.2)

				var_448_0.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10145ui_story, var_448_4, var_448_3)

				local var_448_5 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_5.x, var_448_5.y, var_448_5.z)

				local var_448_6 = var_448_0.localEulerAngles

				var_448_6.z = 0
				var_448_6.x = 0
				var_448_0.localEulerAngles = var_448_6
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 then
				var_448_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_448_7 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_7.x, var_448_7.y, var_448_7.z)

				local var_448_8 = var_448_0.localEulerAngles

				var_448_8.z = 0
				var_448_8.x = 0
				var_448_0.localEulerAngles = var_448_8
			end

			local var_448_9 = arg_445_1.actors_["10145ui_story"]
			local var_448_10 = 0

			if var_448_10 < arg_445_1.time_ and arg_445_1.time_ <= var_448_10 + arg_448_0 and not isNil(var_448_9) and arg_445_1.var_.characterEffect10145ui_story == nil then
				arg_445_1.var_.characterEffect10145ui_story = var_448_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_11 = 0.200000002980232

			if var_448_10 <= arg_445_1.time_ and arg_445_1.time_ < var_448_10 + var_448_11 and not isNil(var_448_9) then
				local var_448_12 = (arg_445_1.time_ - var_448_10) / var_448_11

				if arg_445_1.var_.characterEffect10145ui_story and not isNil(var_448_9) then
					arg_445_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_10 + var_448_11 and arg_445_1.time_ < var_448_10 + var_448_11 + arg_448_0 and not isNil(var_448_9) and arg_445_1.var_.characterEffect10145ui_story then
				arg_445_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_448_13 = arg_445_1.actors_["1047ui_story"]
			local var_448_14 = 0

			if var_448_14 < arg_445_1.time_ and arg_445_1.time_ <= var_448_14 + arg_448_0 and not isNil(var_448_13) and arg_445_1.var_.characterEffect1047ui_story == nil then
				arg_445_1.var_.characterEffect1047ui_story = var_448_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_15 = 0.200000002980232

			if var_448_14 <= arg_445_1.time_ and arg_445_1.time_ < var_448_14 + var_448_15 and not isNil(var_448_13) then
				local var_448_16 = (arg_445_1.time_ - var_448_14) / var_448_15

				if arg_445_1.var_.characterEffect1047ui_story and not isNil(var_448_13) then
					local var_448_17 = Mathf.Lerp(0, 0.5, var_448_16)

					arg_445_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1047ui_story.fillRatio = var_448_17
				end
			end

			if arg_445_1.time_ >= var_448_14 + var_448_15 and arg_445_1.time_ < var_448_14 + var_448_15 + arg_448_0 and not isNil(var_448_13) and arg_445_1.var_.characterEffect1047ui_story then
				local var_448_18 = 0.5

				arg_445_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1047ui_story.fillRatio = var_448_18
			end

			local var_448_19 = 0

			if var_448_19 < arg_445_1.time_ and arg_445_1.time_ <= var_448_19 + arg_448_0 then
				arg_445_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			local var_448_20 = 0

			if var_448_20 < arg_445_1.time_ and arg_445_1.time_ <= var_448_20 + arg_448_0 then
				arg_445_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_448_21 = 0
			local var_448_22 = 1.675

			if var_448_21 < arg_445_1.time_ and arg_445_1.time_ <= var_448_21 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_23 = arg_445_1:FormatText(StoryNameCfg[1308].name)

				arg_445_1.leftNameTxt_.text = var_448_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_24 = arg_445_1:GetWordFromCfg(421052109)
				local var_448_25 = arg_445_1:FormatText(var_448_24.content)

				arg_445_1.text_.text = var_448_25

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_26 = 67
				local var_448_27 = utf8.len(var_448_25)
				local var_448_28 = var_448_26 <= 0 and var_448_22 or var_448_22 * (var_448_27 / var_448_26)

				if var_448_28 > 0 and var_448_22 < var_448_28 then
					arg_445_1.talkMaxDuration = var_448_28

					if var_448_28 + var_448_21 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_28 + var_448_21
					end
				end

				arg_445_1.text_.text = var_448_25
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052109", "story_v_out_421052.awb") ~= 0 then
					local var_448_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052109", "story_v_out_421052.awb") / 1000

					if var_448_29 + var_448_21 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_29 + var_448_21
					end

					if var_448_24.prefab_name ~= "" and arg_445_1.actors_[var_448_24.prefab_name] ~= nil then
						local var_448_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_24.prefab_name].transform, "story_v_out_421052", "421052109", "story_v_out_421052.awb")

						arg_445_1:RecordAudio("421052109", var_448_30)
						arg_445_1:RecordAudio("421052109", var_448_30)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_421052", "421052109", "story_v_out_421052.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_421052", "421052109", "story_v_out_421052.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_31 = math.max(var_448_22, arg_445_1.talkMaxDuration)

			if var_448_21 <= arg_445_1.time_ and arg_445_1.time_ < var_448_21 + var_448_31 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_21) / var_448_31

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_21 + var_448_31 and arg_445_1.time_ < var_448_21 + var_448_31 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play421052110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 421052110
		arg_449_1.duration_ = 8.07

		local var_449_0 = {
			zh = 4.766,
			ja = 8.066
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
				arg_449_0:Play421052111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10145ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos10145ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0.78, -1, -6.2)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10145ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = 0

			if var_452_9 < arg_449_1.time_ and arg_449_1.time_ <= var_452_9 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_452_11 = 0
			local var_452_12 = 0.625

			if var_452_11 < arg_449_1.time_ and arg_449_1.time_ <= var_452_11 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_13 = arg_449_1:FormatText(StoryNameCfg[1308].name)

				arg_449_1.leftNameTxt_.text = var_452_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_14 = arg_449_1:GetWordFromCfg(421052110)
				local var_452_15 = arg_449_1:FormatText(var_452_14.content)

				arg_449_1.text_.text = var_452_15

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_16 = 25
				local var_452_17 = utf8.len(var_452_15)
				local var_452_18 = var_452_16 <= 0 and var_452_12 or var_452_12 * (var_452_17 / var_452_16)

				if var_452_18 > 0 and var_452_12 < var_452_18 then
					arg_449_1.talkMaxDuration = var_452_18

					if var_452_18 + var_452_11 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_18 + var_452_11
					end
				end

				arg_449_1.text_.text = var_452_15
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052110", "story_v_out_421052.awb") ~= 0 then
					local var_452_19 = manager.audio:GetVoiceLength("story_v_out_421052", "421052110", "story_v_out_421052.awb") / 1000

					if var_452_19 + var_452_11 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_19 + var_452_11
					end

					if var_452_14.prefab_name ~= "" and arg_449_1.actors_[var_452_14.prefab_name] ~= nil then
						local var_452_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_14.prefab_name].transform, "story_v_out_421052", "421052110", "story_v_out_421052.awb")

						arg_449_1:RecordAudio("421052110", var_452_20)
						arg_449_1:RecordAudio("421052110", var_452_20)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_421052", "421052110", "story_v_out_421052.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_421052", "421052110", "story_v_out_421052.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_21 = math.max(var_452_12, arg_449_1.talkMaxDuration)

			if var_452_11 <= arg_449_1.time_ and arg_449_1.time_ < var_452_11 + var_452_21 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_11) / var_452_21

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_11 + var_452_21 and arg_449_1.time_ < var_452_11 + var_452_21 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play421052111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 421052111
		arg_453_1.duration_ = 7.57

		local var_453_0 = {
			zh = 5.3,
			ja = 7.566
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
				arg_453_0:Play421052112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1047ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1047ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1047ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["1047ui_story"]
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1047ui_story == nil then
				arg_453_1.var_.characterEffect1047ui_story = var_456_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_11 = 0.200000002980232

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 and not isNil(var_456_9) then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11

				if arg_453_1.var_.characterEffect1047ui_story and not isNil(var_456_9) then
					arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1047ui_story then
				arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_456_13 = arg_453_1.actors_["10145ui_story"]
			local var_456_14 = 0

			if var_456_14 < arg_453_1.time_ and arg_453_1.time_ <= var_456_14 + arg_456_0 and not isNil(var_456_13) and arg_453_1.var_.characterEffect10145ui_story == nil then
				arg_453_1.var_.characterEffect10145ui_story = var_456_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_15 = 0.200000002980232

			if var_456_14 <= arg_453_1.time_ and arg_453_1.time_ < var_456_14 + var_456_15 and not isNil(var_456_13) then
				local var_456_16 = (arg_453_1.time_ - var_456_14) / var_456_15

				if arg_453_1.var_.characterEffect10145ui_story and not isNil(var_456_13) then
					local var_456_17 = Mathf.Lerp(0, 0.5, var_456_16)

					arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10145ui_story.fillRatio = var_456_17
				end
			end

			if arg_453_1.time_ >= var_456_14 + var_456_15 and arg_453_1.time_ < var_456_14 + var_456_15 + arg_456_0 and not isNil(var_456_13) and arg_453_1.var_.characterEffect10145ui_story then
				local var_456_18 = 0.5

				arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10145ui_story.fillRatio = var_456_18
			end

			local var_456_19 = 0

			if var_456_19 < arg_453_1.time_ and arg_453_1.time_ <= var_456_19 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			local var_456_20 = 0

			if var_456_20 < arg_453_1.time_ and arg_453_1.time_ <= var_456_20 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_456_21 = 0
			local var_456_22 = 0.525

			if var_456_21 < arg_453_1.time_ and arg_453_1.time_ <= var_456_21 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_23 = arg_453_1:FormatText(StoryNameCfg[1296].name)

				arg_453_1.leftNameTxt_.text = var_456_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_24 = arg_453_1:GetWordFromCfg(421052111)
				local var_456_25 = arg_453_1:FormatText(var_456_24.content)

				arg_453_1.text_.text = var_456_25

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_26 = 21
				local var_456_27 = utf8.len(var_456_25)
				local var_456_28 = var_456_26 <= 0 and var_456_22 or var_456_22 * (var_456_27 / var_456_26)

				if var_456_28 > 0 and var_456_22 < var_456_28 then
					arg_453_1.talkMaxDuration = var_456_28

					if var_456_28 + var_456_21 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_28 + var_456_21
					end
				end

				arg_453_1.text_.text = var_456_25
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052111", "story_v_out_421052.awb") ~= 0 then
					local var_456_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052111", "story_v_out_421052.awb") / 1000

					if var_456_29 + var_456_21 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_29 + var_456_21
					end

					if var_456_24.prefab_name ~= "" and arg_453_1.actors_[var_456_24.prefab_name] ~= nil then
						local var_456_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_24.prefab_name].transform, "story_v_out_421052", "421052111", "story_v_out_421052.awb")

						arg_453_1:RecordAudio("421052111", var_456_30)
						arg_453_1:RecordAudio("421052111", var_456_30)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_421052", "421052111", "story_v_out_421052.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_421052", "421052111", "story_v_out_421052.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_31 = math.max(var_456_22, arg_453_1.talkMaxDuration)

			if var_456_21 <= arg_453_1.time_ and arg_453_1.time_ < var_456_21 + var_456_31 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_21) / var_456_31

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_21 + var_456_31 and arg_453_1.time_ < var_456_21 + var_456_31 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play421052112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 421052112
		arg_457_1.duration_ = 8.2

		local var_457_0 = {
			zh = 5.133,
			ja = 8.2
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play421052113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["10145ui_story"].transform
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.var_.moveOldPos10145ui_story = var_460_0.localPosition
			end

			local var_460_2 = 0.001

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2
				local var_460_4 = Vector3.New(0.78, -1, -6.2)

				var_460_0.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10145ui_story, var_460_4, var_460_3)

				local var_460_5 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_5.x, var_460_5.y, var_460_5.z)

				local var_460_6 = var_460_0.localEulerAngles

				var_460_6.z = 0
				var_460_6.x = 0
				var_460_0.localEulerAngles = var_460_6
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 then
				var_460_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_460_7 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_7.x, var_460_7.y, var_460_7.z)

				local var_460_8 = var_460_0.localEulerAngles

				var_460_8.z = 0
				var_460_8.x = 0
				var_460_0.localEulerAngles = var_460_8
			end

			local var_460_9 = arg_457_1.actors_["10145ui_story"]
			local var_460_10 = 0

			if var_460_10 < arg_457_1.time_ and arg_457_1.time_ <= var_460_10 + arg_460_0 and not isNil(var_460_9) and arg_457_1.var_.characterEffect10145ui_story == nil then
				arg_457_1.var_.characterEffect10145ui_story = var_460_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_11 = 0.200000002980232

			if var_460_10 <= arg_457_1.time_ and arg_457_1.time_ < var_460_10 + var_460_11 and not isNil(var_460_9) then
				local var_460_12 = (arg_457_1.time_ - var_460_10) / var_460_11

				if arg_457_1.var_.characterEffect10145ui_story and not isNil(var_460_9) then
					arg_457_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= var_460_10 + var_460_11 and arg_457_1.time_ < var_460_10 + var_460_11 + arg_460_0 and not isNil(var_460_9) and arg_457_1.var_.characterEffect10145ui_story then
				arg_457_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_460_13 = arg_457_1.actors_["1047ui_story"]
			local var_460_14 = 0

			if var_460_14 < arg_457_1.time_ and arg_457_1.time_ <= var_460_14 + arg_460_0 and not isNil(var_460_13) and arg_457_1.var_.characterEffect1047ui_story == nil then
				arg_457_1.var_.characterEffect1047ui_story = var_460_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_15 = 0.200000002980232

			if var_460_14 <= arg_457_1.time_ and arg_457_1.time_ < var_460_14 + var_460_15 and not isNil(var_460_13) then
				local var_460_16 = (arg_457_1.time_ - var_460_14) / var_460_15

				if arg_457_1.var_.characterEffect1047ui_story and not isNil(var_460_13) then
					local var_460_17 = Mathf.Lerp(0, 0.5, var_460_16)

					arg_457_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1047ui_story.fillRatio = var_460_17
				end
			end

			if arg_457_1.time_ >= var_460_14 + var_460_15 and arg_457_1.time_ < var_460_14 + var_460_15 + arg_460_0 and not isNil(var_460_13) and arg_457_1.var_.characterEffect1047ui_story then
				local var_460_18 = 0.5

				arg_457_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1047ui_story.fillRatio = var_460_18
			end

			local var_460_19 = 0

			if var_460_19 < arg_457_1.time_ and arg_457_1.time_ <= var_460_19 + arg_460_0 then
				arg_457_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_460_20 = 0

			if var_460_20 < arg_457_1.time_ and arg_457_1.time_ <= var_460_20 + arg_460_0 then
				arg_457_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_460_21 = 0
			local var_460_22 = 0.475

			if var_460_21 < arg_457_1.time_ and arg_457_1.time_ <= var_460_21 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_23 = arg_457_1:FormatText(StoryNameCfg[1308].name)

				arg_457_1.leftNameTxt_.text = var_460_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_24 = arg_457_1:GetWordFromCfg(421052112)
				local var_460_25 = arg_457_1:FormatText(var_460_24.content)

				arg_457_1.text_.text = var_460_25

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_26 = 19
				local var_460_27 = utf8.len(var_460_25)
				local var_460_28 = var_460_26 <= 0 and var_460_22 or var_460_22 * (var_460_27 / var_460_26)

				if var_460_28 > 0 and var_460_22 < var_460_28 then
					arg_457_1.talkMaxDuration = var_460_28

					if var_460_28 + var_460_21 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_28 + var_460_21
					end
				end

				arg_457_1.text_.text = var_460_25
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052112", "story_v_out_421052.awb") ~= 0 then
					local var_460_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052112", "story_v_out_421052.awb") / 1000

					if var_460_29 + var_460_21 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_29 + var_460_21
					end

					if var_460_24.prefab_name ~= "" and arg_457_1.actors_[var_460_24.prefab_name] ~= nil then
						local var_460_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_24.prefab_name].transform, "story_v_out_421052", "421052112", "story_v_out_421052.awb")

						arg_457_1:RecordAudio("421052112", var_460_30)
						arg_457_1:RecordAudio("421052112", var_460_30)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_421052", "421052112", "story_v_out_421052.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_421052", "421052112", "story_v_out_421052.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_31 = math.max(var_460_22, arg_457_1.talkMaxDuration)

			if var_460_21 <= arg_457_1.time_ and arg_457_1.time_ < var_460_21 + var_460_31 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_21) / var_460_31

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_21 + var_460_31 and arg_457_1.time_ < var_460_21 + var_460_31 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play421052113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 421052113
		arg_461_1.duration_ = 5.13

		local var_461_0 = {
			zh = 3.1,
			ja = 5.133
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
				arg_461_0:Play421052114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1047ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1047ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1047ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["1047ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1047ui_story == nil then
				arg_461_1.var_.characterEffect1047ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect1047ui_story and not isNil(var_464_9) then
					arg_461_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1047ui_story then
				arg_461_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_464_13 = arg_461_1.actors_["10145ui_story"]
			local var_464_14 = 0

			if var_464_14 < arg_461_1.time_ and arg_461_1.time_ <= var_464_14 + arg_464_0 and not isNil(var_464_13) and arg_461_1.var_.characterEffect10145ui_story == nil then
				arg_461_1.var_.characterEffect10145ui_story = var_464_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_15 = 0.200000002980232

			if var_464_14 <= arg_461_1.time_ and arg_461_1.time_ < var_464_14 + var_464_15 and not isNil(var_464_13) then
				local var_464_16 = (arg_461_1.time_ - var_464_14) / var_464_15

				if arg_461_1.var_.characterEffect10145ui_story and not isNil(var_464_13) then
					local var_464_17 = Mathf.Lerp(0, 0.5, var_464_16)

					arg_461_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10145ui_story.fillRatio = var_464_17
				end
			end

			if arg_461_1.time_ >= var_464_14 + var_464_15 and arg_461_1.time_ < var_464_14 + var_464_15 + arg_464_0 and not isNil(var_464_13) and arg_461_1.var_.characterEffect10145ui_story then
				local var_464_18 = 0.5

				arg_461_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10145ui_story.fillRatio = var_464_18
			end

			local var_464_19 = 0

			if var_464_19 < arg_461_1.time_ and arg_461_1.time_ <= var_464_19 + arg_464_0 then
				arg_461_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_464_20 = 0

			if var_464_20 < arg_461_1.time_ and arg_461_1.time_ <= var_464_20 + arg_464_0 then
				arg_461_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_464_21 = 0
			local var_464_22 = 0.375

			if var_464_21 < arg_461_1.time_ and arg_461_1.time_ <= var_464_21 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_23 = arg_461_1:FormatText(StoryNameCfg[1296].name)

				arg_461_1.leftNameTxt_.text = var_464_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_24 = arg_461_1:GetWordFromCfg(421052113)
				local var_464_25 = arg_461_1:FormatText(var_464_24.content)

				arg_461_1.text_.text = var_464_25

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_26 = 15
				local var_464_27 = utf8.len(var_464_25)
				local var_464_28 = var_464_26 <= 0 and var_464_22 or var_464_22 * (var_464_27 / var_464_26)

				if var_464_28 > 0 and var_464_22 < var_464_28 then
					arg_461_1.talkMaxDuration = var_464_28

					if var_464_28 + var_464_21 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_28 + var_464_21
					end
				end

				arg_461_1.text_.text = var_464_25
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052113", "story_v_out_421052.awb") ~= 0 then
					local var_464_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052113", "story_v_out_421052.awb") / 1000

					if var_464_29 + var_464_21 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_29 + var_464_21
					end

					if var_464_24.prefab_name ~= "" and arg_461_1.actors_[var_464_24.prefab_name] ~= nil then
						local var_464_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_24.prefab_name].transform, "story_v_out_421052", "421052113", "story_v_out_421052.awb")

						arg_461_1:RecordAudio("421052113", var_464_30)
						arg_461_1:RecordAudio("421052113", var_464_30)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_421052", "421052113", "story_v_out_421052.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_421052", "421052113", "story_v_out_421052.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_31 = math.max(var_464_22, arg_461_1.talkMaxDuration)

			if var_464_21 <= arg_461_1.time_ and arg_461_1.time_ < var_464_21 + var_464_31 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_21) / var_464_31

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_21 + var_464_31 and arg_461_1.time_ < var_464_21 + var_464_31 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play421052114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 421052114
		arg_465_1.duration_ = 9.5

		local var_465_0 = {
			zh = 7.1,
			ja = 9.5
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
				arg_465_0:Play421052115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10145ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos10145ui_story = var_468_0.localPosition
			end

			local var_468_2 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2
				local var_468_4 = Vector3.New(0.78, -1, -6.2)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10145ui_story, var_468_4, var_468_3)

				local var_468_5 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_5.x, var_468_5.y, var_468_5.z)

				local var_468_6 = var_468_0.localEulerAngles

				var_468_6.z = 0
				var_468_6.x = 0
				var_468_0.localEulerAngles = var_468_6
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_468_7 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_7.x, var_468_7.y, var_468_7.z)

				local var_468_8 = var_468_0.localEulerAngles

				var_468_8.z = 0
				var_468_8.x = 0
				var_468_0.localEulerAngles = var_468_8
			end

			local var_468_9 = arg_465_1.actors_["10145ui_story"]
			local var_468_10 = 0

			if var_468_10 < arg_465_1.time_ and arg_465_1.time_ <= var_468_10 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect10145ui_story == nil then
				arg_465_1.var_.characterEffect10145ui_story = var_468_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_11 = 0.200000002980232

			if var_468_10 <= arg_465_1.time_ and arg_465_1.time_ < var_468_10 + var_468_11 and not isNil(var_468_9) then
				local var_468_12 = (arg_465_1.time_ - var_468_10) / var_468_11

				if arg_465_1.var_.characterEffect10145ui_story and not isNil(var_468_9) then
					arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_10 + var_468_11 and arg_465_1.time_ < var_468_10 + var_468_11 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect10145ui_story then
				arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_468_13 = arg_465_1.actors_["1047ui_story"]
			local var_468_14 = 0

			if var_468_14 < arg_465_1.time_ and arg_465_1.time_ <= var_468_14 + arg_468_0 and not isNil(var_468_13) and arg_465_1.var_.characterEffect1047ui_story == nil then
				arg_465_1.var_.characterEffect1047ui_story = var_468_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_15 = 0.200000002980232

			if var_468_14 <= arg_465_1.time_ and arg_465_1.time_ < var_468_14 + var_468_15 and not isNil(var_468_13) then
				local var_468_16 = (arg_465_1.time_ - var_468_14) / var_468_15

				if arg_465_1.var_.characterEffect1047ui_story and not isNil(var_468_13) then
					local var_468_17 = Mathf.Lerp(0, 0.5, var_468_16)

					arg_465_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1047ui_story.fillRatio = var_468_17
				end
			end

			if arg_465_1.time_ >= var_468_14 + var_468_15 and arg_465_1.time_ < var_468_14 + var_468_15 + arg_468_0 and not isNil(var_468_13) and arg_465_1.var_.characterEffect1047ui_story then
				local var_468_18 = 0.5

				arg_465_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1047ui_story.fillRatio = var_468_18
			end

			local var_468_19 = 0

			if var_468_19 < arg_465_1.time_ and arg_465_1.time_ <= var_468_19 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_468_20 = 0

			if var_468_20 < arg_465_1.time_ and arg_465_1.time_ <= var_468_20 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_468_21 = 0
			local var_468_22 = 0.8

			if var_468_21 < arg_465_1.time_ and arg_465_1.time_ <= var_468_21 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_23 = arg_465_1:FormatText(StoryNameCfg[1308].name)

				arg_465_1.leftNameTxt_.text = var_468_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_24 = arg_465_1:GetWordFromCfg(421052114)
				local var_468_25 = arg_465_1:FormatText(var_468_24.content)

				arg_465_1.text_.text = var_468_25

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_26 = 32
				local var_468_27 = utf8.len(var_468_25)
				local var_468_28 = var_468_26 <= 0 and var_468_22 or var_468_22 * (var_468_27 / var_468_26)

				if var_468_28 > 0 and var_468_22 < var_468_28 then
					arg_465_1.talkMaxDuration = var_468_28

					if var_468_28 + var_468_21 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_28 + var_468_21
					end
				end

				arg_465_1.text_.text = var_468_25
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052114", "story_v_out_421052.awb") ~= 0 then
					local var_468_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052114", "story_v_out_421052.awb") / 1000

					if var_468_29 + var_468_21 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_29 + var_468_21
					end

					if var_468_24.prefab_name ~= "" and arg_465_1.actors_[var_468_24.prefab_name] ~= nil then
						local var_468_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_24.prefab_name].transform, "story_v_out_421052", "421052114", "story_v_out_421052.awb")

						arg_465_1:RecordAudio("421052114", var_468_30)
						arg_465_1:RecordAudio("421052114", var_468_30)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_421052", "421052114", "story_v_out_421052.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_421052", "421052114", "story_v_out_421052.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_31 = math.max(var_468_22, arg_465_1.talkMaxDuration)

			if var_468_21 <= arg_465_1.time_ and arg_465_1.time_ < var_468_21 + var_468_31 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_21) / var_468_31

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_21 + var_468_31 and arg_465_1.time_ < var_468_21 + var_468_31 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play421052115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 421052115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play421052116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["10145ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos10145ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0, 100, 0)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10145ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0, 100, 0)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["1047ui_story"].transform
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 then
				arg_469_1.var_.moveOldPos1047ui_story = var_472_9.localPosition
			end

			local var_472_11 = 0.001

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11
				local var_472_13 = Vector3.New(0, 100, 0)

				var_472_9.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1047ui_story, var_472_13, var_472_12)

				local var_472_14 = manager.ui.mainCamera.transform.position - var_472_9.position

				var_472_9.forward = Vector3.New(var_472_14.x, var_472_14.y, var_472_14.z)

				local var_472_15 = var_472_9.localEulerAngles

				var_472_15.z = 0
				var_472_15.x = 0
				var_472_9.localEulerAngles = var_472_15
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 then
				var_472_9.localPosition = Vector3.New(0, 100, 0)

				local var_472_16 = manager.ui.mainCamera.transform.position - var_472_9.position

				var_472_9.forward = Vector3.New(var_472_16.x, var_472_16.y, var_472_16.z)

				local var_472_17 = var_472_9.localEulerAngles

				var_472_17.z = 0
				var_472_17.x = 0
				var_472_9.localEulerAngles = var_472_17
			end

			local var_472_18 = 0
			local var_472_19 = 1

			if var_472_18 < arg_469_1.time_ and arg_469_1.time_ <= var_472_18 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_20 = arg_469_1:GetWordFromCfg(421052115)
				local var_472_21 = arg_469_1:FormatText(var_472_20.content)

				arg_469_1.text_.text = var_472_21

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_22 = 40
				local var_472_23 = utf8.len(var_472_21)
				local var_472_24 = var_472_22 <= 0 and var_472_19 or var_472_19 * (var_472_23 / var_472_22)

				if var_472_24 > 0 and var_472_19 < var_472_24 then
					arg_469_1.talkMaxDuration = var_472_24

					if var_472_24 + var_472_18 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_24 + var_472_18
					end
				end

				arg_469_1.text_.text = var_472_21
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_25 = math.max(var_472_19, arg_469_1.talkMaxDuration)

			if var_472_18 <= arg_469_1.time_ and arg_469_1.time_ < var_472_18 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_18) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_18 + var_472_25 and arg_469_1.time_ < var_472_18 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play421052116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 421052116
		arg_473_1.duration_ = 6.17

		local var_473_0 = {
			zh = 6.166,
			ja = 5.7
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
				arg_473_0:Play421052117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["10145ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos10145ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, -1, -6.2)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10145ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["10145ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect10145ui_story == nil then
				arg_473_1.var_.characterEffect10145ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect10145ui_story and not isNil(var_476_9) then
					arg_473_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect10145ui_story then
				arg_473_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_476_13 = 0

			if var_476_13 < arg_473_1.time_ and arg_473_1.time_ <= var_476_13 + arg_476_0 then
				arg_473_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_476_14 = 0

			if var_476_14 < arg_473_1.time_ and arg_473_1.time_ <= var_476_14 + arg_476_0 then
				arg_473_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_476_15 = 0
			local var_476_16 = 0.65

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[1308].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_18 = arg_473_1:GetWordFromCfg(421052116)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 26
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052116", "story_v_out_421052.awb") ~= 0 then
					local var_476_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052116", "story_v_out_421052.awb") / 1000

					if var_476_23 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_23 + var_476_15
					end

					if var_476_18.prefab_name ~= "" and arg_473_1.actors_[var_476_18.prefab_name] ~= nil then
						local var_476_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_18.prefab_name].transform, "story_v_out_421052", "421052116", "story_v_out_421052.awb")

						arg_473_1:RecordAudio("421052116", var_476_24)
						arg_473_1:RecordAudio("421052116", var_476_24)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_421052", "421052116", "story_v_out_421052.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_421052", "421052116", "story_v_out_421052.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_25 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_25 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_25

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_25 and arg_473_1.time_ < var_476_15 + var_476_25 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play421052117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 421052117
		arg_477_1.duration_ = 9

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play421052118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 2

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				local var_480_1 = manager.ui.mainCamera.transform.localPosition
				local var_480_2 = Vector3.New(0, 0, 10) + Vector3.New(var_480_1.x, var_480_1.y, 0)
				local var_480_3 = arg_477_1.bgs_.B10a

				var_480_3.transform.localPosition = var_480_2
				var_480_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_4 = var_480_3:GetComponent("SpriteRenderer")

				if var_480_4 and var_480_4.sprite then
					local var_480_5 = (var_480_3.transform.localPosition - var_480_1).z
					local var_480_6 = manager.ui.mainCameraCom_
					local var_480_7 = 2 * var_480_5 * Mathf.Tan(var_480_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_480_8 = var_480_7 * var_480_6.aspect
					local var_480_9 = var_480_4.sprite.bounds.size.x
					local var_480_10 = var_480_4.sprite.bounds.size.y
					local var_480_11 = var_480_8 / var_480_9
					local var_480_12 = var_480_7 / var_480_10
					local var_480_13 = var_480_12 < var_480_11 and var_480_11 or var_480_12

					var_480_3.transform.localScale = Vector3.New(var_480_13, var_480_13, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "B10a" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_14 = 4

			if var_480_14 < arg_477_1.time_ and arg_477_1.time_ <= var_480_14 + arg_480_0 then
				arg_477_1.allBtn_.enabled = false
			end

			local var_480_15 = 0.0666666666666664

			if arg_477_1.time_ >= var_480_14 + var_480_15 and arg_477_1.time_ < var_480_14 + var_480_15 + arg_480_0 then
				arg_477_1.allBtn_.enabled = true
			end

			local var_480_16 = 0

			if var_480_16 < arg_477_1.time_ and arg_477_1.time_ <= var_480_16 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_17 = 2

			if var_480_16 <= arg_477_1.time_ and arg_477_1.time_ < var_480_16 + var_480_17 then
				local var_480_18 = (arg_477_1.time_ - var_480_16) / var_480_17
				local var_480_19 = Color.New(0, 0, 0)

				var_480_19.a = Mathf.Lerp(0, 1, var_480_18)
				arg_477_1.mask_.color = var_480_19
			end

			if arg_477_1.time_ >= var_480_16 + var_480_17 and arg_477_1.time_ < var_480_16 + var_480_17 + arg_480_0 then
				local var_480_20 = Color.New(0, 0, 0)

				var_480_20.a = 1
				arg_477_1.mask_.color = var_480_20
			end

			local var_480_21 = 2

			if var_480_21 < arg_477_1.time_ and arg_477_1.time_ <= var_480_21 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_22 = 2

			if var_480_21 <= arg_477_1.time_ and arg_477_1.time_ < var_480_21 + var_480_22 then
				local var_480_23 = (arg_477_1.time_ - var_480_21) / var_480_22
				local var_480_24 = Color.New(0, 0, 0)

				var_480_24.a = Mathf.Lerp(1, 0, var_480_23)
				arg_477_1.mask_.color = var_480_24
			end

			if arg_477_1.time_ >= var_480_21 + var_480_22 and arg_477_1.time_ < var_480_21 + var_480_22 + arg_480_0 then
				local var_480_25 = Color.New(0, 0, 0)
				local var_480_26 = 0

				arg_477_1.mask_.enabled = false
				var_480_25.a = var_480_26
				arg_477_1.mask_.color = var_480_25
			end

			local var_480_27 = arg_477_1.actors_["10145ui_story"].transform
			local var_480_28 = 2

			if var_480_28 < arg_477_1.time_ and arg_477_1.time_ <= var_480_28 + arg_480_0 then
				arg_477_1.var_.moveOldPos10145ui_story = var_480_27.localPosition
			end

			local var_480_29 = 0.001

			if var_480_28 <= arg_477_1.time_ and arg_477_1.time_ < var_480_28 + var_480_29 then
				local var_480_30 = (arg_477_1.time_ - var_480_28) / var_480_29
				local var_480_31 = Vector3.New(0, 100, 0)

				var_480_27.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10145ui_story, var_480_31, var_480_30)

				local var_480_32 = manager.ui.mainCamera.transform.position - var_480_27.position

				var_480_27.forward = Vector3.New(var_480_32.x, var_480_32.y, var_480_32.z)

				local var_480_33 = var_480_27.localEulerAngles

				var_480_33.z = 0
				var_480_33.x = 0
				var_480_27.localEulerAngles = var_480_33
			end

			if arg_477_1.time_ >= var_480_28 + var_480_29 and arg_477_1.time_ < var_480_28 + var_480_29 + arg_480_0 then
				var_480_27.localPosition = Vector3.New(0, 100, 0)

				local var_480_34 = manager.ui.mainCamera.transform.position - var_480_27.position

				var_480_27.forward = Vector3.New(var_480_34.x, var_480_34.y, var_480_34.z)

				local var_480_35 = var_480_27.localEulerAngles

				var_480_35.z = 0
				var_480_35.x = 0
				var_480_27.localEulerAngles = var_480_35
			end

			local var_480_36 = 0.1
			local var_480_37 = 1

			if var_480_36 < arg_477_1.time_ and arg_477_1.time_ <= var_480_36 + arg_480_0 then
				local var_480_38 = "stop"
				local var_480_39 = "effect"

				arg_477_1:AudioAction(var_480_38, var_480_39, "se_story_140", "se_story_140_amb_lfe", "")
			end

			local var_480_40 = 1.63333333333333
			local var_480_41 = 1

			if var_480_40 < arg_477_1.time_ and arg_477_1.time_ <= var_480_40 + arg_480_0 then
				local var_480_42 = "play"
				local var_480_43 = "effect"

				arg_477_1:AudioAction(var_480_42, var_480_43, "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_44 = 4
			local var_480_45 = 0.15

			if var_480_44 < arg_477_1.time_ and arg_477_1.time_ <= var_480_44 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_46 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_46:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_47 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_48 = arg_477_1:GetWordFromCfg(421052117)
				local var_480_49 = arg_477_1:FormatText(var_480_48.content)

				arg_477_1.text_.text = var_480_49

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_50 = 6
				local var_480_51 = utf8.len(var_480_49)
				local var_480_52 = var_480_50 <= 0 and var_480_45 or var_480_45 * (var_480_51 / var_480_50)

				if var_480_52 > 0 and var_480_45 < var_480_52 then
					arg_477_1.talkMaxDuration = var_480_52
					var_480_44 = var_480_44 + 0.3

					if var_480_52 + var_480_44 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_52 + var_480_44
					end
				end

				arg_477_1.text_.text = var_480_49
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_53 = var_480_44 + 0.3
			local var_480_54 = math.max(var_480_45, arg_477_1.talkMaxDuration)

			if var_480_53 <= arg_477_1.time_ and arg_477_1.time_ < var_480_53 + var_480_54 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_53) / var_480_54

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_53 + var_480_54 and arg_477_1.time_ < var_480_53 + var_480_54 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play421052118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 421052118
		arg_483_1.duration_ = 5.2

		local var_483_0 = {
			zh = 2.8,
			ja = 5.2
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play421052119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["10145ui_story"].transform
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.var_.moveOldPos10145ui_story = var_486_0.localPosition
			end

			local var_486_2 = 0.001

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2
				local var_486_4 = Vector3.New(0, -1, -6.2)

				var_486_0.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10145ui_story, var_486_4, var_486_3)

				local var_486_5 = manager.ui.mainCamera.transform.position - var_486_0.position

				var_486_0.forward = Vector3.New(var_486_5.x, var_486_5.y, var_486_5.z)

				local var_486_6 = var_486_0.localEulerAngles

				var_486_6.z = 0
				var_486_6.x = 0
				var_486_0.localEulerAngles = var_486_6
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 then
				var_486_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_486_7 = manager.ui.mainCamera.transform.position - var_486_0.position

				var_486_0.forward = Vector3.New(var_486_7.x, var_486_7.y, var_486_7.z)

				local var_486_8 = var_486_0.localEulerAngles

				var_486_8.z = 0
				var_486_8.x = 0
				var_486_0.localEulerAngles = var_486_8
			end

			local var_486_9 = arg_483_1.actors_["10145ui_story"]
			local var_486_10 = 0

			if var_486_10 < arg_483_1.time_ and arg_483_1.time_ <= var_486_10 + arg_486_0 and not isNil(var_486_9) and arg_483_1.var_.characterEffect10145ui_story == nil then
				arg_483_1.var_.characterEffect10145ui_story = var_486_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_11 = 0.200000002980232

			if var_486_10 <= arg_483_1.time_ and arg_483_1.time_ < var_486_10 + var_486_11 and not isNil(var_486_9) then
				local var_486_12 = (arg_483_1.time_ - var_486_10) / var_486_11

				if arg_483_1.var_.characterEffect10145ui_story and not isNil(var_486_9) then
					arg_483_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= var_486_10 + var_486_11 and arg_483_1.time_ < var_486_10 + var_486_11 + arg_486_0 and not isNil(var_486_9) and arg_483_1.var_.characterEffect10145ui_story then
				arg_483_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_486_13 = 0

			if var_486_13 < arg_483_1.time_ and arg_483_1.time_ <= var_486_13 + arg_486_0 then
				arg_483_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action8_1")
			end

			local var_486_14 = 0

			if var_486_14 < arg_483_1.time_ and arg_483_1.time_ <= var_486_14 + arg_486_0 then
				arg_483_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_486_15 = 0
			local var_486_16 = 0.325

			if var_486_15 < arg_483_1.time_ and arg_483_1.time_ <= var_486_15 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_17 = arg_483_1:FormatText(StoryNameCfg[1308].name)

				arg_483_1.leftNameTxt_.text = var_486_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_18 = arg_483_1:GetWordFromCfg(421052118)
				local var_486_19 = arg_483_1:FormatText(var_486_18.content)

				arg_483_1.text_.text = var_486_19

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_20 = 13
				local var_486_21 = utf8.len(var_486_19)
				local var_486_22 = var_486_20 <= 0 and var_486_16 or var_486_16 * (var_486_21 / var_486_20)

				if var_486_22 > 0 and var_486_16 < var_486_22 then
					arg_483_1.talkMaxDuration = var_486_22

					if var_486_22 + var_486_15 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_22 + var_486_15
					end
				end

				arg_483_1.text_.text = var_486_19
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052118", "story_v_out_421052.awb") ~= 0 then
					local var_486_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052118", "story_v_out_421052.awb") / 1000

					if var_486_23 + var_486_15 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_23 + var_486_15
					end

					if var_486_18.prefab_name ~= "" and arg_483_1.actors_[var_486_18.prefab_name] ~= nil then
						local var_486_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_18.prefab_name].transform, "story_v_out_421052", "421052118", "story_v_out_421052.awb")

						arg_483_1:RecordAudio("421052118", var_486_24)
						arg_483_1:RecordAudio("421052118", var_486_24)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_421052", "421052118", "story_v_out_421052.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_421052", "421052118", "story_v_out_421052.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_25 = math.max(var_486_16, arg_483_1.talkMaxDuration)

			if var_486_15 <= arg_483_1.time_ and arg_483_1.time_ < var_486_15 + var_486_25 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_15) / var_486_25

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_15 + var_486_25 and arg_483_1.time_ < var_486_15 + var_486_25 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play421052119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 421052119
		arg_487_1.duration_ = 4.17

		local var_487_0 = {
			zh = 3.733,
			ja = 4.166
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play421052120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["10102ui_story"].transform
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos10102ui_story = var_490_0.localPosition
			end

			local var_490_2 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2
				local var_490_4 = Vector3.New(0.7, -0.985, -6.275)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10102ui_story, var_490_4, var_490_3)

				local var_490_5 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_5.x, var_490_5.y, var_490_5.z)

				local var_490_6 = var_490_0.localEulerAngles

				var_490_6.z = 0
				var_490_6.x = 0
				var_490_0.localEulerAngles = var_490_6
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_490_7 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_7.x, var_490_7.y, var_490_7.z)

				local var_490_8 = var_490_0.localEulerAngles

				var_490_8.z = 0
				var_490_8.x = 0
				var_490_0.localEulerAngles = var_490_8
			end

			local var_490_9 = arg_487_1.actors_["10145ui_story"].transform
			local var_490_10 = 0

			if var_490_10 < arg_487_1.time_ and arg_487_1.time_ <= var_490_10 + arg_490_0 then
				arg_487_1.var_.moveOldPos10145ui_story = var_490_9.localPosition
			end

			local var_490_11 = 0.001

			if var_490_10 <= arg_487_1.time_ and arg_487_1.time_ < var_490_10 + var_490_11 then
				local var_490_12 = (arg_487_1.time_ - var_490_10) / var_490_11
				local var_490_13 = Vector3.New(-0.65, -1, -6.2)

				var_490_9.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10145ui_story, var_490_13, var_490_12)

				local var_490_14 = manager.ui.mainCamera.transform.position - var_490_9.position

				var_490_9.forward = Vector3.New(var_490_14.x, var_490_14.y, var_490_14.z)

				local var_490_15 = var_490_9.localEulerAngles

				var_490_15.z = 0
				var_490_15.x = 0
				var_490_9.localEulerAngles = var_490_15
			end

			if arg_487_1.time_ >= var_490_10 + var_490_11 and arg_487_1.time_ < var_490_10 + var_490_11 + arg_490_0 then
				var_490_9.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_490_16 = manager.ui.mainCamera.transform.position - var_490_9.position

				var_490_9.forward = Vector3.New(var_490_16.x, var_490_16.y, var_490_16.z)

				local var_490_17 = var_490_9.localEulerAngles

				var_490_17.z = 0
				var_490_17.x = 0
				var_490_9.localEulerAngles = var_490_17
			end

			local var_490_18 = arg_487_1.actors_["10102ui_story"]
			local var_490_19 = 0

			if var_490_19 < arg_487_1.time_ and arg_487_1.time_ <= var_490_19 + arg_490_0 and not isNil(var_490_18) and arg_487_1.var_.characterEffect10102ui_story == nil then
				arg_487_1.var_.characterEffect10102ui_story = var_490_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_20 = 0.200000002980232

			if var_490_19 <= arg_487_1.time_ and arg_487_1.time_ < var_490_19 + var_490_20 and not isNil(var_490_18) then
				local var_490_21 = (arg_487_1.time_ - var_490_19) / var_490_20

				if arg_487_1.var_.characterEffect10102ui_story and not isNil(var_490_18) then
					arg_487_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_19 + var_490_20 and arg_487_1.time_ < var_490_19 + var_490_20 + arg_490_0 and not isNil(var_490_18) and arg_487_1.var_.characterEffect10102ui_story then
				arg_487_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_490_22 = arg_487_1.actors_["10145ui_story"]
			local var_490_23 = 0

			if var_490_23 < arg_487_1.time_ and arg_487_1.time_ <= var_490_23 + arg_490_0 and not isNil(var_490_22) and arg_487_1.var_.characterEffect10145ui_story == nil then
				arg_487_1.var_.characterEffect10145ui_story = var_490_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_24 = 0.200000002980232

			if var_490_23 <= arg_487_1.time_ and arg_487_1.time_ < var_490_23 + var_490_24 and not isNil(var_490_22) then
				local var_490_25 = (arg_487_1.time_ - var_490_23) / var_490_24

				if arg_487_1.var_.characterEffect10145ui_story and not isNil(var_490_22) then
					local var_490_26 = Mathf.Lerp(0, 0.5, var_490_25)

					arg_487_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_487_1.var_.characterEffect10145ui_story.fillRatio = var_490_26
				end
			end

			if arg_487_1.time_ >= var_490_23 + var_490_24 and arg_487_1.time_ < var_490_23 + var_490_24 + arg_490_0 and not isNil(var_490_22) and arg_487_1.var_.characterEffect10145ui_story then
				local var_490_27 = 0.5

				arg_487_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_487_1.var_.characterEffect10145ui_story.fillRatio = var_490_27
			end

			local var_490_28 = 0

			if var_490_28 < arg_487_1.time_ and arg_487_1.time_ <= var_490_28 + arg_490_0 then
				arg_487_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_490_29 = 0

			if var_490_29 < arg_487_1.time_ and arg_487_1.time_ <= var_490_29 + arg_490_0 then
				arg_487_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_490_30 = 0
			local var_490_31 = 0.4

			if var_490_30 < arg_487_1.time_ and arg_487_1.time_ <= var_490_30 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_32 = arg_487_1:FormatText(StoryNameCfg[6].name)

				arg_487_1.leftNameTxt_.text = var_490_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_33 = arg_487_1:GetWordFromCfg(421052119)
				local var_490_34 = arg_487_1:FormatText(var_490_33.content)

				arg_487_1.text_.text = var_490_34

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_35 = 16
				local var_490_36 = utf8.len(var_490_34)
				local var_490_37 = var_490_35 <= 0 and var_490_31 or var_490_31 * (var_490_36 / var_490_35)

				if var_490_37 > 0 and var_490_31 < var_490_37 then
					arg_487_1.talkMaxDuration = var_490_37

					if var_490_37 + var_490_30 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_37 + var_490_30
					end
				end

				arg_487_1.text_.text = var_490_34
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052119", "story_v_out_421052.awb") ~= 0 then
					local var_490_38 = manager.audio:GetVoiceLength("story_v_out_421052", "421052119", "story_v_out_421052.awb") / 1000

					if var_490_38 + var_490_30 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_38 + var_490_30
					end

					if var_490_33.prefab_name ~= "" and arg_487_1.actors_[var_490_33.prefab_name] ~= nil then
						local var_490_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_33.prefab_name].transform, "story_v_out_421052", "421052119", "story_v_out_421052.awb")

						arg_487_1:RecordAudio("421052119", var_490_39)
						arg_487_1:RecordAudio("421052119", var_490_39)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_421052", "421052119", "story_v_out_421052.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_421052", "421052119", "story_v_out_421052.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_40 = math.max(var_490_31, arg_487_1.talkMaxDuration)

			if var_490_30 <= arg_487_1.time_ and arg_487_1.time_ < var_490_30 + var_490_40 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_30) / var_490_40

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_30 + var_490_40 and arg_487_1.time_ < var_490_30 + var_490_40 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421052120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 421052120
		arg_491_1.duration_ = 8.1

		local var_491_0 = {
			zh = 7.533,
			ja = 8.1
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play421052121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["10145ui_story"].transform
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.var_.moveOldPos10145ui_story = var_494_0.localPosition
			end

			local var_494_2 = 0.001

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2
				local var_494_4 = Vector3.New(-0.65, -1, -6.2)

				var_494_0.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10145ui_story, var_494_4, var_494_3)

				local var_494_5 = manager.ui.mainCamera.transform.position - var_494_0.position

				var_494_0.forward = Vector3.New(var_494_5.x, var_494_5.y, var_494_5.z)

				local var_494_6 = var_494_0.localEulerAngles

				var_494_6.z = 0
				var_494_6.x = 0
				var_494_0.localEulerAngles = var_494_6
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 then
				var_494_0.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_494_7 = manager.ui.mainCamera.transform.position - var_494_0.position

				var_494_0.forward = Vector3.New(var_494_7.x, var_494_7.y, var_494_7.z)

				local var_494_8 = var_494_0.localEulerAngles

				var_494_8.z = 0
				var_494_8.x = 0
				var_494_0.localEulerAngles = var_494_8
			end

			local var_494_9 = arg_491_1.actors_["10145ui_story"]
			local var_494_10 = 0

			if var_494_10 < arg_491_1.time_ and arg_491_1.time_ <= var_494_10 + arg_494_0 and not isNil(var_494_9) and arg_491_1.var_.characterEffect10145ui_story == nil then
				arg_491_1.var_.characterEffect10145ui_story = var_494_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_11 = 0.200000002980232

			if var_494_10 <= arg_491_1.time_ and arg_491_1.time_ < var_494_10 + var_494_11 and not isNil(var_494_9) then
				local var_494_12 = (arg_491_1.time_ - var_494_10) / var_494_11

				if arg_491_1.var_.characterEffect10145ui_story and not isNil(var_494_9) then
					arg_491_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= var_494_10 + var_494_11 and arg_491_1.time_ < var_494_10 + var_494_11 + arg_494_0 and not isNil(var_494_9) and arg_491_1.var_.characterEffect10145ui_story then
				arg_491_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_494_13 = arg_491_1.actors_["10102ui_story"]
			local var_494_14 = 0

			if var_494_14 < arg_491_1.time_ and arg_491_1.time_ <= var_494_14 + arg_494_0 and not isNil(var_494_13) and arg_491_1.var_.characterEffect10102ui_story == nil then
				arg_491_1.var_.characterEffect10102ui_story = var_494_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_15 = 0.200000002980232

			if var_494_14 <= arg_491_1.time_ and arg_491_1.time_ < var_494_14 + var_494_15 and not isNil(var_494_13) then
				local var_494_16 = (arg_491_1.time_ - var_494_14) / var_494_15

				if arg_491_1.var_.characterEffect10102ui_story and not isNil(var_494_13) then
					local var_494_17 = Mathf.Lerp(0, 0.5, var_494_16)

					arg_491_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_491_1.var_.characterEffect10102ui_story.fillRatio = var_494_17
				end
			end

			if arg_491_1.time_ >= var_494_14 + var_494_15 and arg_491_1.time_ < var_494_14 + var_494_15 + arg_494_0 and not isNil(var_494_13) and arg_491_1.var_.characterEffect10102ui_story then
				local var_494_18 = 0.5

				arg_491_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_491_1.var_.characterEffect10102ui_story.fillRatio = var_494_18
			end

			local var_494_19 = 0

			if var_494_19 < arg_491_1.time_ and arg_491_1.time_ <= var_494_19 + arg_494_0 then
				arg_491_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action8_2")
			end

			local var_494_20 = 0

			if var_494_20 < arg_491_1.time_ and arg_491_1.time_ <= var_494_20 + arg_494_0 then
				arg_491_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_494_21 = 0
			local var_494_22 = 0.8

			if var_494_21 < arg_491_1.time_ and arg_491_1.time_ <= var_494_21 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_23 = arg_491_1:FormatText(StoryNameCfg[1308].name)

				arg_491_1.leftNameTxt_.text = var_494_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_24 = arg_491_1:GetWordFromCfg(421052120)
				local var_494_25 = arg_491_1:FormatText(var_494_24.content)

				arg_491_1.text_.text = var_494_25

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_26 = 32
				local var_494_27 = utf8.len(var_494_25)
				local var_494_28 = var_494_26 <= 0 and var_494_22 or var_494_22 * (var_494_27 / var_494_26)

				if var_494_28 > 0 and var_494_22 < var_494_28 then
					arg_491_1.talkMaxDuration = var_494_28

					if var_494_28 + var_494_21 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_28 + var_494_21
					end
				end

				arg_491_1.text_.text = var_494_25
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052120", "story_v_out_421052.awb") ~= 0 then
					local var_494_29 = manager.audio:GetVoiceLength("story_v_out_421052", "421052120", "story_v_out_421052.awb") / 1000

					if var_494_29 + var_494_21 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_29 + var_494_21
					end

					if var_494_24.prefab_name ~= "" and arg_491_1.actors_[var_494_24.prefab_name] ~= nil then
						local var_494_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_24.prefab_name].transform, "story_v_out_421052", "421052120", "story_v_out_421052.awb")

						arg_491_1:RecordAudio("421052120", var_494_30)
						arg_491_1:RecordAudio("421052120", var_494_30)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_421052", "421052120", "story_v_out_421052.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_421052", "421052120", "story_v_out_421052.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_31 = math.max(var_494_22, arg_491_1.talkMaxDuration)

			if var_494_21 <= arg_491_1.time_ and arg_491_1.time_ < var_494_21 + var_494_31 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_21) / var_494_31

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_21 + var_494_31 and arg_491_1.time_ < var_494_21 + var_494_31 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421052121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 421052121
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play421052122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["10145ui_story"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect10145ui_story == nil then
				arg_495_1.var_.characterEffect10145ui_story = var_498_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.characterEffect10145ui_story and not isNil(var_498_0) then
					local var_498_4 = Mathf.Lerp(0, 0.5, var_498_3)

					arg_495_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10145ui_story.fillRatio = var_498_4
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect10145ui_story then
				local var_498_5 = 0.5

				arg_495_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10145ui_story.fillRatio = var_498_5
			end

			local var_498_6 = 0
			local var_498_7 = 0.225

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

				local var_498_9 = arg_495_1:GetWordFromCfg(421052121)
				local var_498_10 = arg_495_1:FormatText(var_498_9.content)

				arg_495_1.text_.text = var_498_10

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_11 = 9
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
	Play421052122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 421052122
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play421052123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["10145ui_story"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos10145ui_story = var_502_0.localPosition
			end

			local var_502_2 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2
				local var_502_4 = Vector3.New(0, 100, 0)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10145ui_story, var_502_4, var_502_3)

				local var_502_5 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_5.x, var_502_5.y, var_502_5.z)

				local var_502_6 = var_502_0.localEulerAngles

				var_502_6.z = 0
				var_502_6.x = 0
				var_502_0.localEulerAngles = var_502_6
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, 100, 0)

				local var_502_7 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_7.x, var_502_7.y, var_502_7.z)

				local var_502_8 = var_502_0.localEulerAngles

				var_502_8.z = 0
				var_502_8.x = 0
				var_502_0.localEulerAngles = var_502_8
			end

			local var_502_9 = arg_499_1.actors_["10102ui_story"].transform
			local var_502_10 = 0

			if var_502_10 < arg_499_1.time_ and arg_499_1.time_ <= var_502_10 + arg_502_0 then
				arg_499_1.var_.moveOldPos10102ui_story = var_502_9.localPosition
			end

			local var_502_11 = 0.001

			if var_502_10 <= arg_499_1.time_ and arg_499_1.time_ < var_502_10 + var_502_11 then
				local var_502_12 = (arg_499_1.time_ - var_502_10) / var_502_11
				local var_502_13 = Vector3.New(0, 100, 0)

				var_502_9.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10102ui_story, var_502_13, var_502_12)

				local var_502_14 = manager.ui.mainCamera.transform.position - var_502_9.position

				var_502_9.forward = Vector3.New(var_502_14.x, var_502_14.y, var_502_14.z)

				local var_502_15 = var_502_9.localEulerAngles

				var_502_15.z = 0
				var_502_15.x = 0
				var_502_9.localEulerAngles = var_502_15
			end

			if arg_499_1.time_ >= var_502_10 + var_502_11 and arg_499_1.time_ < var_502_10 + var_502_11 + arg_502_0 then
				var_502_9.localPosition = Vector3.New(0, 100, 0)

				local var_502_16 = manager.ui.mainCamera.transform.position - var_502_9.position

				var_502_9.forward = Vector3.New(var_502_16.x, var_502_16.y, var_502_16.z)

				local var_502_17 = var_502_9.localEulerAngles

				var_502_17.z = 0
				var_502_17.x = 0
				var_502_9.localEulerAngles = var_502_17
			end

			local var_502_18 = 0.1
			local var_502_19 = 1

			if var_502_18 < arg_499_1.time_ and arg_499_1.time_ <= var_502_18 + arg_502_0 then
				local var_502_20 = "play"
				local var_502_21 = "effect"

				arg_499_1:AudioAction(var_502_20, var_502_21, "se_story_143", "se_story_143_foley_bag", "")
			end

			local var_502_22 = 0
			local var_502_23 = 0.725

			if var_502_22 < arg_499_1.time_ and arg_499_1.time_ <= var_502_22 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_24 = arg_499_1:GetWordFromCfg(421052122)
				local var_502_25 = arg_499_1:FormatText(var_502_24.content)

				arg_499_1.text_.text = var_502_25

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_26 = 29
				local var_502_27 = utf8.len(var_502_25)
				local var_502_28 = var_502_26 <= 0 and var_502_23 or var_502_23 * (var_502_27 / var_502_26)

				if var_502_28 > 0 and var_502_23 < var_502_28 then
					arg_499_1.talkMaxDuration = var_502_28

					if var_502_28 + var_502_22 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_28 + var_502_22
					end
				end

				arg_499_1.text_.text = var_502_25
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_29 = math.max(var_502_23, arg_499_1.talkMaxDuration)

			if var_502_22 <= arg_499_1.time_ and arg_499_1.time_ < var_502_22 + var_502_29 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_22) / var_502_29

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_22 + var_502_29 and arg_499_1.time_ < var_502_22 + var_502_29 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play421052123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 421052123
		arg_503_1.duration_ = 4.57

		local var_503_0 = {
			zh = 3.8,
			ja = 4.566
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
				arg_503_0:Play421052124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["10145ui_story"].transform
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.var_.moveOldPos10145ui_story = var_506_0.localPosition
			end

			local var_506_2 = 0.001

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2
				local var_506_4 = Vector3.New(0, -1, -6.2)

				var_506_0.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10145ui_story, var_506_4, var_506_3)

				local var_506_5 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_5.x, var_506_5.y, var_506_5.z)

				local var_506_6 = var_506_0.localEulerAngles

				var_506_6.z = 0
				var_506_6.x = 0
				var_506_0.localEulerAngles = var_506_6
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 then
				var_506_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_506_7 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_7.x, var_506_7.y, var_506_7.z)

				local var_506_8 = var_506_0.localEulerAngles

				var_506_8.z = 0
				var_506_8.x = 0
				var_506_0.localEulerAngles = var_506_8
			end

			local var_506_9 = arg_503_1.actors_["10145ui_story"]
			local var_506_10 = 0

			if var_506_10 < arg_503_1.time_ and arg_503_1.time_ <= var_506_10 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect10145ui_story == nil then
				arg_503_1.var_.characterEffect10145ui_story = var_506_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_11 = 0.200000002980232

			if var_506_10 <= arg_503_1.time_ and arg_503_1.time_ < var_506_10 + var_506_11 and not isNil(var_506_9) then
				local var_506_12 = (arg_503_1.time_ - var_506_10) / var_506_11

				if arg_503_1.var_.characterEffect10145ui_story and not isNil(var_506_9) then
					arg_503_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_10 + var_506_11 and arg_503_1.time_ < var_506_10 + var_506_11 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect10145ui_story then
				arg_503_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_506_13 = 0

			if var_506_13 < arg_503_1.time_ and arg_503_1.time_ <= var_506_13 + arg_506_0 then
				arg_503_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			local var_506_14 = 0

			if var_506_14 < arg_503_1.time_ and arg_503_1.time_ <= var_506_14 + arg_506_0 then
				arg_503_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_506_15 = 0
			local var_506_16 = 0.35

			if var_506_15 < arg_503_1.time_ and arg_503_1.time_ <= var_506_15 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_17 = arg_503_1:FormatText(StoryNameCfg[1308].name)

				arg_503_1.leftNameTxt_.text = var_506_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_18 = arg_503_1:GetWordFromCfg(421052123)
				local var_506_19 = arg_503_1:FormatText(var_506_18.content)

				arg_503_1.text_.text = var_506_19

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_20 = 14
				local var_506_21 = utf8.len(var_506_19)
				local var_506_22 = var_506_20 <= 0 and var_506_16 or var_506_16 * (var_506_21 / var_506_20)

				if var_506_22 > 0 and var_506_16 < var_506_22 then
					arg_503_1.talkMaxDuration = var_506_22

					if var_506_22 + var_506_15 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_22 + var_506_15
					end
				end

				arg_503_1.text_.text = var_506_19
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052123", "story_v_out_421052.awb") ~= 0 then
					local var_506_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052123", "story_v_out_421052.awb") / 1000

					if var_506_23 + var_506_15 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_23 + var_506_15
					end

					if var_506_18.prefab_name ~= "" and arg_503_1.actors_[var_506_18.prefab_name] ~= nil then
						local var_506_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_18.prefab_name].transform, "story_v_out_421052", "421052123", "story_v_out_421052.awb")

						arg_503_1:RecordAudio("421052123", var_506_24)
						arg_503_1:RecordAudio("421052123", var_506_24)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_421052", "421052123", "story_v_out_421052.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_421052", "421052123", "story_v_out_421052.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_25 = math.max(var_506_16, arg_503_1.talkMaxDuration)

			if var_506_15 <= arg_503_1.time_ and arg_503_1.time_ < var_506_15 + var_506_25 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_15) / var_506_25

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_15 + var_506_25 and arg_503_1.time_ < var_506_15 + var_506_25 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play421052124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 421052124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play421052125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["10145ui_story"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect10145ui_story == nil then
				arg_507_1.var_.characterEffect10145ui_story = var_510_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.characterEffect10145ui_story and not isNil(var_510_0) then
					local var_510_4 = Mathf.Lerp(0, 0.5, var_510_3)

					arg_507_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_507_1.var_.characterEffect10145ui_story.fillRatio = var_510_4
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect10145ui_story then
				local var_510_5 = 0.5

				arg_507_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_507_1.var_.characterEffect10145ui_story.fillRatio = var_510_5
			end

			local var_510_6 = 0
			local var_510_7 = 0.975

			if var_510_6 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_8 = arg_507_1:FormatText(StoryNameCfg[7].name)

				arg_507_1.leftNameTxt_.text = var_510_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_9 = arg_507_1:GetWordFromCfg(421052124)
				local var_510_10 = arg_507_1:FormatText(var_510_9.content)

				arg_507_1.text_.text = var_510_10

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_11 = 39
				local var_510_12 = utf8.len(var_510_10)
				local var_510_13 = var_510_11 <= 0 and var_510_7 or var_510_7 * (var_510_12 / var_510_11)

				if var_510_13 > 0 and var_510_7 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_6
					end
				end

				arg_507_1.text_.text = var_510_10
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_14 = math.max(var_510_7, arg_507_1.talkMaxDuration)

			if var_510_6 <= arg_507_1.time_ and arg_507_1.time_ < var_510_6 + var_510_14 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_6) / var_510_14

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_6 + var_510_14 and arg_507_1.time_ < var_510_6 + var_510_14 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play421052125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 421052125
		arg_511_1.duration_ = 5.67

		local var_511_0 = {
			zh = 4,
			ja = 5.666
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
				arg_511_0:Play421052126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["10145ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos10145ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, -1, -6.2)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10145ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["10145ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect10145ui_story == nil then
				arg_511_1.var_.characterEffect10145ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 and not isNil(var_514_9) then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect10145ui_story and not isNil(var_514_9) then
					arg_511_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect10145ui_story then
				arg_511_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_514_13 = 0

			if var_514_13 < arg_511_1.time_ and arg_511_1.time_ <= var_514_13 + arg_514_0 then
				arg_511_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_2")
			end

			local var_514_14 = 0

			if var_514_14 < arg_511_1.time_ and arg_511_1.time_ <= var_514_14 + arg_514_0 then
				arg_511_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_514_15 = 0
			local var_514_16 = 0.7

			if var_514_15 < arg_511_1.time_ and arg_511_1.time_ <= var_514_15 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_17 = arg_511_1:FormatText(StoryNameCfg[1308].name)

				arg_511_1.leftNameTxt_.text = var_514_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_18 = arg_511_1:GetWordFromCfg(421052125)
				local var_514_19 = arg_511_1:FormatText(var_514_18.content)

				arg_511_1.text_.text = var_514_19

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_20 = 28
				local var_514_21 = utf8.len(var_514_19)
				local var_514_22 = var_514_20 <= 0 and var_514_16 or var_514_16 * (var_514_21 / var_514_20)

				if var_514_22 > 0 and var_514_16 < var_514_22 then
					arg_511_1.talkMaxDuration = var_514_22

					if var_514_22 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_22 + var_514_15
					end
				end

				arg_511_1.text_.text = var_514_19
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052125", "story_v_out_421052.awb") ~= 0 then
					local var_514_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052125", "story_v_out_421052.awb") / 1000

					if var_514_23 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_23 + var_514_15
					end

					if var_514_18.prefab_name ~= "" and arg_511_1.actors_[var_514_18.prefab_name] ~= nil then
						local var_514_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_18.prefab_name].transform, "story_v_out_421052", "421052125", "story_v_out_421052.awb")

						arg_511_1:RecordAudio("421052125", var_514_24)
						arg_511_1:RecordAudio("421052125", var_514_24)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_421052", "421052125", "story_v_out_421052.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_421052", "421052125", "story_v_out_421052.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_25 = math.max(var_514_16, arg_511_1.talkMaxDuration)

			if var_514_15 <= arg_511_1.time_ and arg_511_1.time_ < var_514_15 + var_514_25 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_15) / var_514_25

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_15 + var_514_25 and arg_511_1.time_ < var_514_15 + var_514_25 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play421052126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 421052126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play421052127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["10145ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos10145ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0, 100, 0)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10145ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0, 100, 0)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = 0
			local var_518_10 = 0.35

			if var_518_9 < arg_515_1.time_ and arg_515_1.time_ <= var_518_9 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_11 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_11

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

				local var_518_12 = arg_515_1:GetWordFromCfg(421052126)
				local var_518_13 = arg_515_1:FormatText(var_518_12.content)

				arg_515_1.text_.text = var_518_13

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_14 = 14
				local var_518_15 = utf8.len(var_518_13)
				local var_518_16 = var_518_14 <= 0 and var_518_10 or var_518_10 * (var_518_15 / var_518_14)

				if var_518_16 > 0 and var_518_10 < var_518_16 then
					arg_515_1.talkMaxDuration = var_518_16

					if var_518_16 + var_518_9 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_16 + var_518_9
					end
				end

				arg_515_1.text_.text = var_518_13
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_17 = math.max(var_518_10, arg_515_1.talkMaxDuration)

			if var_518_9 <= arg_515_1.time_ and arg_515_1.time_ < var_518_9 + var_518_17 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_9) / var_518_17

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_9 + var_518_17 and arg_515_1.time_ < var_518_9 + var_518_17 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play421052127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 421052127
		arg_519_1.duration_ = 2

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play421052128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["10102ui_story"].transform
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.var_.moveOldPos10102ui_story = var_522_0.localPosition
			end

			local var_522_2 = 0.001

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2
				local var_522_4 = Vector3.New(0, -0.985, -6.275)

				var_522_0.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10102ui_story, var_522_4, var_522_3)

				local var_522_5 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_5.x, var_522_5.y, var_522_5.z)

				local var_522_6 = var_522_0.localEulerAngles

				var_522_6.z = 0
				var_522_6.x = 0
				var_522_0.localEulerAngles = var_522_6
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 then
				var_522_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_522_7 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_7.x, var_522_7.y, var_522_7.z)

				local var_522_8 = var_522_0.localEulerAngles

				var_522_8.z = 0
				var_522_8.x = 0
				var_522_0.localEulerAngles = var_522_8
			end

			local var_522_9 = arg_519_1.actors_["10102ui_story"]
			local var_522_10 = 0

			if var_522_10 < arg_519_1.time_ and arg_519_1.time_ <= var_522_10 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect10102ui_story == nil then
				arg_519_1.var_.characterEffect10102ui_story = var_522_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_11 = 0.200000002980232

			if var_522_10 <= arg_519_1.time_ and arg_519_1.time_ < var_522_10 + var_522_11 and not isNil(var_522_9) then
				local var_522_12 = (arg_519_1.time_ - var_522_10) / var_522_11

				if arg_519_1.var_.characterEffect10102ui_story and not isNil(var_522_9) then
					arg_519_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_10 + var_522_11 and arg_519_1.time_ < var_522_10 + var_522_11 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect10102ui_story then
				arg_519_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_522_13 = 0

			if var_522_13 < arg_519_1.time_ and arg_519_1.time_ <= var_522_13 + arg_522_0 then
				arg_519_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_522_14 = 0

			if var_522_14 < arg_519_1.time_ and arg_519_1.time_ <= var_522_14 + arg_522_0 then
				arg_519_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_522_15 = 0
			local var_522_16 = 0.200000002980232

			if var_522_15 < arg_519_1.time_ and arg_519_1.time_ <= var_522_15 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_17 = arg_519_1:FormatText(StoryNameCfg[6].name)

				arg_519_1.leftNameTxt_.text = var_522_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_18 = arg_519_1:GetWordFromCfg(421052127)
				local var_522_19 = arg_519_1:FormatText(var_522_18.content)

				arg_519_1.text_.text = var_522_19

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_20 = 2
				local var_522_21 = utf8.len(var_522_19)
				local var_522_22 = var_522_20 <= 0 and var_522_16 or var_522_16 * (var_522_21 / var_522_20)

				if var_522_22 > 0 and var_522_16 < var_522_22 then
					arg_519_1.talkMaxDuration = var_522_22

					if var_522_22 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_22 + var_522_15
					end
				end

				arg_519_1.text_.text = var_522_19
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052127", "story_v_out_421052.awb") ~= 0 then
					local var_522_23 = manager.audio:GetVoiceLength("story_v_out_421052", "421052127", "story_v_out_421052.awb") / 1000

					if var_522_23 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_23 + var_522_15
					end

					if var_522_18.prefab_name ~= "" and arg_519_1.actors_[var_522_18.prefab_name] ~= nil then
						local var_522_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_18.prefab_name].transform, "story_v_out_421052", "421052127", "story_v_out_421052.awb")

						arg_519_1:RecordAudio("421052127", var_522_24)
						arg_519_1:RecordAudio("421052127", var_522_24)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_421052", "421052127", "story_v_out_421052.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_421052", "421052127", "story_v_out_421052.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_25 = math.max(var_522_16, arg_519_1.talkMaxDuration)

			if var_522_15 <= arg_519_1.time_ and arg_519_1.time_ < var_522_15 + var_522_25 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_15) / var_522_25

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_15 + var_522_25 and arg_519_1.time_ < var_522_15 + var_522_25 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play421052128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 421052128
		arg_523_1.duration_ = 4.77

		local var_523_0 = {
			zh = 4.333,
			ja = 4.766
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play421052129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["10102ui_story"].transform
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.var_.moveOldPos10102ui_story = var_526_0.localPosition
			end

			local var_526_2 = 0.001

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2
				local var_526_4 = Vector3.New(0, 100, 0)

				var_526_0.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10102ui_story, var_526_4, var_526_3)

				local var_526_5 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_5.x, var_526_5.y, var_526_5.z)

				local var_526_6 = var_526_0.localEulerAngles

				var_526_6.z = 0
				var_526_6.x = 0
				var_526_0.localEulerAngles = var_526_6
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 then
				var_526_0.localPosition = Vector3.New(0, 100, 0)

				local var_526_7 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_7.x, var_526_7.y, var_526_7.z)

				local var_526_8 = var_526_0.localEulerAngles

				var_526_8.z = 0
				var_526_8.x = 0
				var_526_0.localEulerAngles = var_526_8
			end

			local var_526_9 = arg_523_1.actors_["10145ui_story"].transform
			local var_526_10 = 0

			if var_526_10 < arg_523_1.time_ and arg_523_1.time_ <= var_526_10 + arg_526_0 then
				arg_523_1.var_.moveOldPos10145ui_story = var_526_9.localPosition
			end

			local var_526_11 = 0.001

			if var_526_10 <= arg_523_1.time_ and arg_523_1.time_ < var_526_10 + var_526_11 then
				local var_526_12 = (arg_523_1.time_ - var_526_10) / var_526_11
				local var_526_13 = Vector3.New(0, -1, -6.2)

				var_526_9.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10145ui_story, var_526_13, var_526_12)

				local var_526_14 = manager.ui.mainCamera.transform.position - var_526_9.position

				var_526_9.forward = Vector3.New(var_526_14.x, var_526_14.y, var_526_14.z)

				local var_526_15 = var_526_9.localEulerAngles

				var_526_15.z = 0
				var_526_15.x = 0
				var_526_9.localEulerAngles = var_526_15
			end

			if arg_523_1.time_ >= var_526_10 + var_526_11 and arg_523_1.time_ < var_526_10 + var_526_11 + arg_526_0 then
				var_526_9.localPosition = Vector3.New(0, -1, -6.2)

				local var_526_16 = manager.ui.mainCamera.transform.position - var_526_9.position

				var_526_9.forward = Vector3.New(var_526_16.x, var_526_16.y, var_526_16.z)

				local var_526_17 = var_526_9.localEulerAngles

				var_526_17.z = 0
				var_526_17.x = 0
				var_526_9.localEulerAngles = var_526_17
			end

			local var_526_18 = arg_523_1.actors_["10145ui_story"]
			local var_526_19 = 0

			if var_526_19 < arg_523_1.time_ and arg_523_1.time_ <= var_526_19 + arg_526_0 and not isNil(var_526_18) and arg_523_1.var_.characterEffect10145ui_story == nil then
				arg_523_1.var_.characterEffect10145ui_story = var_526_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_20 = 0.200000002980232

			if var_526_19 <= arg_523_1.time_ and arg_523_1.time_ < var_526_19 + var_526_20 and not isNil(var_526_18) then
				local var_526_21 = (arg_523_1.time_ - var_526_19) / var_526_20

				if arg_523_1.var_.characterEffect10145ui_story and not isNil(var_526_18) then
					arg_523_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= var_526_19 + var_526_20 and arg_523_1.time_ < var_526_19 + var_526_20 + arg_526_0 and not isNil(var_526_18) and arg_523_1.var_.characterEffect10145ui_story then
				arg_523_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_526_22 = arg_523_1.actors_["10102ui_story"]
			local var_526_23 = 0

			if var_526_23 < arg_523_1.time_ and arg_523_1.time_ <= var_526_23 + arg_526_0 and not isNil(var_526_22) and arg_523_1.var_.characterEffect10102ui_story == nil then
				arg_523_1.var_.characterEffect10102ui_story = var_526_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_24 = 0.200000002980232

			if var_526_23 <= arg_523_1.time_ and arg_523_1.time_ < var_526_23 + var_526_24 and not isNil(var_526_22) then
				local var_526_25 = (arg_523_1.time_ - var_526_23) / var_526_24

				if arg_523_1.var_.characterEffect10102ui_story and not isNil(var_526_22) then
					local var_526_26 = Mathf.Lerp(0, 0.5, var_526_25)

					arg_523_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_523_1.var_.characterEffect10102ui_story.fillRatio = var_526_26
				end
			end

			if arg_523_1.time_ >= var_526_23 + var_526_24 and arg_523_1.time_ < var_526_23 + var_526_24 + arg_526_0 and not isNil(var_526_22) and arg_523_1.var_.characterEffect10102ui_story then
				local var_526_27 = 0.5

				arg_523_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_523_1.var_.characterEffect10102ui_story.fillRatio = var_526_27
			end

			local var_526_28 = 0

			if var_526_28 < arg_523_1.time_ and arg_523_1.time_ <= var_526_28 + arg_526_0 then
				arg_523_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_526_29 = 0

			if var_526_29 < arg_523_1.time_ and arg_523_1.time_ <= var_526_29 + arg_526_0 then
				arg_523_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_526_30 = 0
			local var_526_31 = 0.45

			if var_526_30 < arg_523_1.time_ and arg_523_1.time_ <= var_526_30 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_32 = arg_523_1:FormatText(StoryNameCfg[1308].name)

				arg_523_1.leftNameTxt_.text = var_526_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_33 = arg_523_1:GetWordFromCfg(421052128)
				local var_526_34 = arg_523_1:FormatText(var_526_33.content)

				arg_523_1.text_.text = var_526_34

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_35 = 18
				local var_526_36 = utf8.len(var_526_34)
				local var_526_37 = var_526_35 <= 0 and var_526_31 or var_526_31 * (var_526_36 / var_526_35)

				if var_526_37 > 0 and var_526_31 < var_526_37 then
					arg_523_1.talkMaxDuration = var_526_37

					if var_526_37 + var_526_30 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_37 + var_526_30
					end
				end

				arg_523_1.text_.text = var_526_34
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421052", "421052128", "story_v_out_421052.awb") ~= 0 then
					local var_526_38 = manager.audio:GetVoiceLength("story_v_out_421052", "421052128", "story_v_out_421052.awb") / 1000

					if var_526_38 + var_526_30 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_38 + var_526_30
					end

					if var_526_33.prefab_name ~= "" and arg_523_1.actors_[var_526_33.prefab_name] ~= nil then
						local var_526_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_33.prefab_name].transform, "story_v_out_421052", "421052128", "story_v_out_421052.awb")

						arg_523_1:RecordAudio("421052128", var_526_39)
						arg_523_1:RecordAudio("421052128", var_526_39)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_421052", "421052128", "story_v_out_421052.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_421052", "421052128", "story_v_out_421052.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_40 = math.max(var_526_31, arg_523_1.talkMaxDuration)

			if var_526_30 <= arg_523_1.time_ and arg_523_1.time_ < var_526_30 + var_526_40 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_30) / var_526_40

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_30 + var_526_40 and arg_523_1.time_ < var_526_30 + var_526_40 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play421052129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 421052129
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
			local var_530_0 = arg_527_1.actors_["10145ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect10145ui_story == nil then
				arg_527_1.var_.characterEffect10145ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect10145ui_story and not isNil(var_530_0) then
					local var_530_4 = Mathf.Lerp(0, 0.5, var_530_3)

					arg_527_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_527_1.var_.characterEffect10145ui_story.fillRatio = var_530_4
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect10145ui_story then
				local var_530_5 = 0.5

				arg_527_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_527_1.var_.characterEffect10145ui_story.fillRatio = var_530_5
			end

			local var_530_6 = 0
			local var_530_7 = 0.4

			if var_530_6 < arg_527_1.time_ and arg_527_1.time_ <= var_530_6 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_8 = arg_527_1:FormatText(StoryNameCfg[7].name)

				arg_527_1.leftNameTxt_.text = var_530_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_9 = arg_527_1:GetWordFromCfg(421052129)
				local var_530_10 = arg_527_1:FormatText(var_530_9.content)

				arg_527_1.text_.text = var_530_10

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_11 = 16
				local var_530_12 = utf8.len(var_530_10)
				local var_530_13 = var_530_11 <= 0 and var_530_7 or var_530_7 * (var_530_12 / var_530_11)

				if var_530_13 > 0 and var_530_7 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_6 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_6
					end
				end

				arg_527_1.text_.text = var_530_10
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_14 = math.max(var_530_7, arg_527_1.talkMaxDuration)

			if var_530_6 <= arg_527_1.time_ and arg_527_1.time_ < var_530_6 + var_530_14 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_6) / var_530_14

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_6 + var_530_14 and arg_527_1.time_ < var_530_6 + var_530_14 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a",
		"TextureConfig/Background/B07b",
		"TextureConfig/Background/B08b",
		"TextureConfig/Background/ST2401"
	},
	voices = {
		"story_v_out_421052.awb"
	}
}
