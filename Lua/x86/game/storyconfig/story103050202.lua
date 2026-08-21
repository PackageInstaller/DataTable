return {
	Play305022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305022001
		arg_1_1.duration_ = 6.53

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play305022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B10d"

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
				local var_4_5 = arg_1_1.bgs_.B10d

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
					if iter_4_0 ~= "B10d" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.53333333333333
			local var_4_39 = 1.65

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(305022001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 66
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305022002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305022002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305022003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.775

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(305022002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 71
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305022003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305022003
		arg_12_1.duration_ = 7.6

		local var_12_0 = {
			zh = 5.566,
			ja = 7.6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305022004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3008ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["3008ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(-1.04, -1.51, -4.3)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-1.04, -1.51, -4.3)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["3008ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect3008ui_story then
				arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_15_20 = 0
			local var_15_21 = 0.6

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[20].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(305022003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 24
				local var_15_26 = utf8.len(var_15_24)
				local var_15_27 = var_15_25 <= 0 and var_15_21 or var_15_21 * (var_15_26 / var_15_25)

				if var_15_27 > 0 and var_15_21 < var_15_27 then
					arg_12_1.talkMaxDuration = var_15_27

					if var_15_27 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_27 + var_15_20
					end
				end

				arg_12_1.text_.text = var_15_24
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022003", "story_v_out_305022.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_out_305022", "305022003", "story_v_out_305022.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_out_305022", "305022003", "story_v_out_305022.awb")

						arg_12_1:RecordAudio("305022003", var_15_29)
						arg_12_1:RecordAudio("305022003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_305022", "305022003", "story_v_out_305022.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_305022", "305022003", "story_v_out_305022.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_30 = math.max(var_15_21, arg_12_1.talkMaxDuration)

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_30 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_20) / var_15_30

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_20 + var_15_30 and arg_12_1.time_ < var_15_20 + var_15_30 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play305022004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 305022004
		arg_16_1.duration_ = 7.03

		local var_16_0 = {
			zh = 4.5,
			ja = 7.033
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
				arg_16_0:Play305022005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.675

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[20].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(305022004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022004", "story_v_out_305022.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_305022", "305022004", "story_v_out_305022.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_305022", "305022004", "story_v_out_305022.awb")

						arg_16_1:RecordAudio("305022004", var_19_9)
						arg_16_1:RecordAudio("305022004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_305022", "305022004", "story_v_out_305022.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_305022", "305022004", "story_v_out_305022.awb")
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
	Play305022005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 305022005
		arg_20_1.duration_ = 10.97

		local var_20_0 = {
			zh = 7.8,
			ja = 10.966
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
				arg_20_0:Play305022006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "4010ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["4010ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos4010ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(0.7, -1.59, -5.2)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4010ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = arg_20_1.actors_["4010ui_story"]
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect4010ui_story == nil then
				arg_20_1.var_.characterEffect4010ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_16 = 0.200000002980232

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 and not isNil(var_23_14) then
				local var_23_17 = (arg_20_1.time_ - var_23_15) / var_23_16

				if arg_20_1.var_.characterEffect4010ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect4010ui_story then
				arg_20_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_23_18 = arg_20_1.actors_["3008ui_story"]
			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 and not isNil(var_23_18) and arg_20_1.var_.characterEffect3008ui_story == nil then
				arg_20_1.var_.characterEffect3008ui_story = var_23_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_20 = 0.200000002980232

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 and not isNil(var_23_18) then
				local var_23_21 = (arg_20_1.time_ - var_23_19) / var_23_20

				if arg_20_1.var_.characterEffect3008ui_story and not isNil(var_23_18) then
					local var_23_22 = Mathf.Lerp(0, 0.5, var_23_21)

					arg_20_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_20_1.var_.characterEffect3008ui_story.fillRatio = var_23_22
				end
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 and not isNil(var_23_18) and arg_20_1.var_.characterEffect3008ui_story then
				local var_23_23 = 0.5

				arg_20_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_20_1.var_.characterEffect3008ui_story.fillRatio = var_23_23
			end

			local var_23_24 = 0

			if var_23_24 < arg_20_1.time_ and arg_20_1.time_ <= var_23_24 + arg_23_0 then
				arg_20_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_1")
			end

			local var_23_25 = 0

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_26 = 0
			local var_23_27 = 0.7

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_28 = arg_20_1:FormatText(StoryNameCfg[42].name)

				arg_20_1.leftNameTxt_.text = var_23_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_29 = arg_20_1:GetWordFromCfg(305022005)
				local var_23_30 = arg_20_1:FormatText(var_23_29.content)

				arg_20_1.text_.text = var_23_30

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_31 = 28
				local var_23_32 = utf8.len(var_23_30)
				local var_23_33 = var_23_31 <= 0 and var_23_27 or var_23_27 * (var_23_32 / var_23_31)

				if var_23_33 > 0 and var_23_27 < var_23_33 then
					arg_20_1.talkMaxDuration = var_23_33

					if var_23_33 + var_23_26 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_33 + var_23_26
					end
				end

				arg_20_1.text_.text = var_23_30
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022005", "story_v_out_305022.awb") ~= 0 then
					local var_23_34 = manager.audio:GetVoiceLength("story_v_out_305022", "305022005", "story_v_out_305022.awb") / 1000

					if var_23_34 + var_23_26 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_34 + var_23_26
					end

					if var_23_29.prefab_name ~= "" and arg_20_1.actors_[var_23_29.prefab_name] ~= nil then
						local var_23_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_29.prefab_name].transform, "story_v_out_305022", "305022005", "story_v_out_305022.awb")

						arg_20_1:RecordAudio("305022005", var_23_35)
						arg_20_1:RecordAudio("305022005", var_23_35)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_305022", "305022005", "story_v_out_305022.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_305022", "305022005", "story_v_out_305022.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_36 = math.max(var_23_27, arg_20_1.talkMaxDuration)

			if var_23_26 <= arg_20_1.time_ and arg_20_1.time_ < var_23_26 + var_23_36 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_26) / var_23_36

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_26 + var_23_36 and arg_20_1.time_ < var_23_26 + var_23_36 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play305022006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 305022006
		arg_24_1.duration_ = 5.27

		local var_24_0 = {
			zh = 4.6,
			ja = 5.266
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
				arg_24_0:Play305022007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["3008ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["4010ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect4010ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_24_1.var_.characterEffect4010ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect4010ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_24_1.var_.characterEffect4010ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_12 = 0
			local var_27_13 = 0.475

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[20].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_15 = arg_24_1:GetWordFromCfg(305022006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 19
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_13 or var_27_13 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_13 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022006", "story_v_out_305022.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022006", "story_v_out_305022.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_305022", "305022006", "story_v_out_305022.awb")

						arg_24_1:RecordAudio("305022006", var_27_21)
						arg_24_1:RecordAudio("305022006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_305022", "305022006", "story_v_out_305022.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_305022", "305022006", "story_v_out_305022.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_22 and arg_24_1.time_ < var_27_12 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play305022007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305022007
		arg_28_1.duration_ = 6.2

		local var_28_0 = {
			zh = 3.3,
			ja = 6.2
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
				arg_28_0:Play305022008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["4010ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["3008ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3008ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_2")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_12 = 0
			local var_31_13 = 0.3

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[42].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(305022007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 12
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022007", "story_v_out_305022.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022007", "story_v_out_305022.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_305022", "305022007", "story_v_out_305022.awb")

						arg_28_1:RecordAudio("305022007", var_31_21)
						arg_28_1:RecordAudio("305022007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_305022", "305022007", "story_v_out_305022.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_305022", "305022007", "story_v_out_305022.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play305022008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305022008
		arg_32_1.duration_ = 11.27

		local var_32_0 = {
			zh = 8.3,
			ja = 11.266
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
				arg_32_0:Play305022009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3008ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story then
				arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["4010ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect4010ui_story == nil then
				arg_32_1.var_.characterEffect4010ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect4010ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_32_1.var_.characterEffect4010ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect4010ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_32_1.var_.characterEffect4010ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 1.025

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[20].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(305022008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 41
				local var_35_18 = utf8.len(var_35_16)
				local var_35_19 = var_35_17 <= 0 and var_35_13 or var_35_13 * (var_35_18 / var_35_17)

				if var_35_19 > 0 and var_35_13 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022008", "story_v_out_305022.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022008", "story_v_out_305022.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_305022", "305022008", "story_v_out_305022.awb")

						arg_32_1:RecordAudio("305022008", var_35_21)
						arg_32_1:RecordAudio("305022008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_305022", "305022008", "story_v_out_305022.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_305022", "305022008", "story_v_out_305022.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_22 and arg_32_1.time_ < var_35_12 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play305022009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305022009
		arg_36_1.duration_ = 7.1

		local var_36_0 = {
			zh = 5.9,
			ja = 7.1
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
				arg_36_0:Play305022010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["4010ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect4010ui_story == nil then
				arg_36_1.var_.characterEffect4010ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect4010ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect4010ui_story then
				arg_36_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["3008ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_36_1.var_.characterEffect3008ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect3008ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_36_1.var_.characterEffect3008ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.7

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[42].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(305022009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 28
				local var_39_18 = utf8.len(var_39_16)
				local var_39_19 = var_39_17 <= 0 and var_39_13 or var_39_13 * (var_39_18 / var_39_17)

				if var_39_19 > 0 and var_39_13 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_16
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022009", "story_v_out_305022.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022009", "story_v_out_305022.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_305022", "305022009", "story_v_out_305022.awb")

						arg_36_1:RecordAudio("305022009", var_39_21)
						arg_36_1:RecordAudio("305022009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_305022", "305022009", "story_v_out_305022.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_305022", "305022009", "story_v_out_305022.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_22 and arg_36_1.time_ < var_39_12 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play305022010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305022010
		arg_40_1.duration_ = 5.47

		local var_40_0 = {
			zh = 3.5,
			ja = 5.466
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
				arg_40_0:Play305022011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4010ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos4010ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4010ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["3008ui_story"].transform
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.var_.moveOldPos3008ui_story = var_43_9.localPosition
			end

			local var_43_11 = 0.001

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11
				local var_43_13 = Vector3.New(0, 100, 0)

				var_43_9.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3008ui_story, var_43_13, var_43_12)

				local var_43_14 = manager.ui.mainCamera.transform.position - var_43_9.position

				var_43_9.forward = Vector3.New(var_43_14.x, var_43_14.y, var_43_14.z)

				local var_43_15 = var_43_9.localEulerAngles

				var_43_15.z = 0
				var_43_15.x = 0
				var_43_9.localEulerAngles = var_43_15
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 then
				var_43_9.localPosition = Vector3.New(0, 100, 0)

				local var_43_16 = manager.ui.mainCamera.transform.position - var_43_9.position

				var_43_9.forward = Vector3.New(var_43_16.x, var_43_16.y, var_43_16.z)

				local var_43_17 = var_43_9.localEulerAngles

				var_43_17.z = 0
				var_43_17.x = 0
				var_43_9.localEulerAngles = var_43_17
			end

			local var_43_18 = "1035ui_story"

			if arg_40_1.actors_[var_43_18] == nil then
				local var_43_19 = Asset.Load("Char/" .. "1035ui_story")

				if not isNil(var_43_19) then
					local var_43_20 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_40_1.stage_.transform)

					var_43_20.name = var_43_18
					var_43_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_18] = var_43_20

					local var_43_21 = var_43_20:GetComponentInChildren(typeof(CharacterEffect))

					var_43_21.enabled = true

					local var_43_22 = GameObjectTools.GetOrAddComponent(var_43_20, typeof(DynamicBoneHelper))

					if var_43_22 then
						var_43_22:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_21.transform, false)

					arg_40_1.var_[var_43_18 .. "Animator"] = var_43_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_18 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_18 .. "LipSync"] = var_43_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_23 = arg_40_1.actors_["1035ui_story"]
			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 and not isNil(var_43_23) and arg_40_1.var_.characterEffect1035ui_story == nil then
				arg_40_1.var_.characterEffect1035ui_story = var_43_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_25 = 0.200000002980232

			if var_43_24 <= arg_40_1.time_ and arg_40_1.time_ < var_43_24 + var_43_25 and not isNil(var_43_23) then
				local var_43_26 = (arg_40_1.time_ - var_43_24) / var_43_25

				if arg_40_1.var_.characterEffect1035ui_story and not isNil(var_43_23) then
					arg_40_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_24 + var_43_25 and arg_40_1.time_ < var_43_24 + var_43_25 + arg_43_0 and not isNil(var_43_23) and arg_40_1.var_.characterEffect1035ui_story then
				arg_40_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_43_27 = arg_40_1.actors_["4010ui_story"]
			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 and not isNil(var_43_27) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = var_43_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_29 = 0.200000002980232

			if var_43_28 <= arg_40_1.time_ and arg_40_1.time_ < var_43_28 + var_43_29 and not isNil(var_43_27) then
				local var_43_30 = (arg_40_1.time_ - var_43_28) / var_43_29

				if arg_40_1.var_.characterEffect4010ui_story and not isNil(var_43_27) then
					local var_43_31 = Mathf.Lerp(0, 0.5, var_43_30)

					arg_40_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_40_1.var_.characterEffect4010ui_story.fillRatio = var_43_31
				end
			end

			if arg_40_1.time_ >= var_43_28 + var_43_29 and arg_40_1.time_ < var_43_28 + var_43_29 + arg_43_0 and not isNil(var_43_27) and arg_40_1.var_.characterEffect4010ui_story then
				local var_43_32 = 0.5

				arg_40_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_40_1.var_.characterEffect4010ui_story.fillRatio = var_43_32
			end

			local var_43_33 = 0
			local var_43_34 = 0.375

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_35 = arg_40_1:FormatText(StoryNameCfg[21].name)

				arg_40_1.leftNameTxt_.text = var_43_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_36 = arg_40_1:GetWordFromCfg(305022010)
				local var_43_37 = arg_40_1:FormatText(var_43_36.content)

				arg_40_1.text_.text = var_43_37

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_38 = 15
				local var_43_39 = utf8.len(var_43_37)
				local var_43_40 = var_43_38 <= 0 and var_43_34 or var_43_34 * (var_43_39 / var_43_38)

				if var_43_40 > 0 and var_43_34 < var_43_40 then
					arg_40_1.talkMaxDuration = var_43_40

					if var_43_40 + var_43_33 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_40 + var_43_33
					end
				end

				arg_40_1.text_.text = var_43_37
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022010", "story_v_out_305022.awb") ~= 0 then
					local var_43_41 = manager.audio:GetVoiceLength("story_v_out_305022", "305022010", "story_v_out_305022.awb") / 1000

					if var_43_41 + var_43_33 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_41 + var_43_33
					end

					if var_43_36.prefab_name ~= "" and arg_40_1.actors_[var_43_36.prefab_name] ~= nil then
						local var_43_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_36.prefab_name].transform, "story_v_out_305022", "305022010", "story_v_out_305022.awb")

						arg_40_1:RecordAudio("305022010", var_43_42)
						arg_40_1:RecordAudio("305022010", var_43_42)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_305022", "305022010", "story_v_out_305022.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_305022", "305022010", "story_v_out_305022.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_43 = math.max(var_43_34, arg_40_1.talkMaxDuration)

			if var_43_33 <= arg_40_1.time_ and arg_40_1.time_ < var_43_33 + var_43_43 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_33) / var_43_43

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_33 + var_43_43 and arg_40_1.time_ < var_43_33 + var_43_43 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305022011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 305022011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play305022012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1035ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1035ui_story == nil then
				arg_44_1.var_.characterEffect1035ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1035ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1035ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1035ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1035ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 1.875

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(305022011)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 63
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_7 or var_47_7 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_7 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_13 and arg_44_1.time_ < var_47_6 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play305022012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 305022012
		arg_48_1.duration_ = 10.37

		local var_48_0 = {
			zh = 5.8,
			ja = 10.366
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
				arg_48_0:Play305022013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["4010ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect4010ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_4 = 0
			local var_51_5 = 0.75

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_6 = arg_48_1:FormatText(StoryNameCfg[42].name)

				arg_48_1.leftNameTxt_.text = var_51_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_7 = arg_48_1:GetWordFromCfg(305022012)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 30
				local var_51_10 = utf8.len(var_51_8)
				local var_51_11 = var_51_9 <= 0 and var_51_5 or var_51_5 * (var_51_10 / var_51_9)

				if var_51_11 > 0 and var_51_5 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022012", "story_v_out_305022.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_305022", "305022012", "story_v_out_305022.awb") / 1000

					if var_51_12 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_4
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_out_305022", "305022012", "story_v_out_305022.awb")

						arg_48_1:RecordAudio("305022012", var_51_13)
						arg_48_1:RecordAudio("305022012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_305022", "305022012", "story_v_out_305022.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_305022", "305022012", "story_v_out_305022.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_14 and arg_48_1.time_ < var_51_4 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play305022013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305022013
		arg_52_1.duration_ = 7.7

		local var_52_0 = {
			zh = 5.533,
			ja = 7.7
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
				arg_52_0:Play305022014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1035ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1035ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, -1.05, -5.6)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1035ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -1.05, -5.6)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1035ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1035ui_story == nil then
				arg_52_1.var_.characterEffect1035ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1035ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1035ui_story then
				arg_52_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_55_13 = arg_52_1.actors_["4010ui_story"]
			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 and not isNil(var_55_13) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_15 = 0.200000002980232

			if var_55_14 <= arg_52_1.time_ and arg_52_1.time_ < var_55_14 + var_55_15 and not isNil(var_55_13) then
				local var_55_16 = (arg_52_1.time_ - var_55_14) / var_55_15

				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_13) then
					local var_55_17 = Mathf.Lerp(0, 0.5, var_55_16)

					arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_52_1.var_.characterEffect4010ui_story.fillRatio = var_55_17
				end
			end

			if arg_52_1.time_ >= var_55_14 + var_55_15 and arg_52_1.time_ < var_55_14 + var_55_15 + arg_55_0 and not isNil(var_55_13) and arg_52_1.var_.characterEffect4010ui_story then
				local var_55_18 = 0.5

				arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_52_1.var_.characterEffect4010ui_story.fillRatio = var_55_18
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_1")
			end

			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_21 = 0
			local var_55_22 = 0.675

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_23 = arg_52_1:FormatText(StoryNameCfg[21].name)

				arg_52_1.leftNameTxt_.text = var_55_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_24 = arg_52_1:GetWordFromCfg(305022013)
				local var_55_25 = arg_52_1:FormatText(var_55_24.content)

				arg_52_1.text_.text = var_55_25

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_26 = 27
				local var_55_27 = utf8.len(var_55_25)
				local var_55_28 = var_55_26 <= 0 and var_55_22 or var_55_22 * (var_55_27 / var_55_26)

				if var_55_28 > 0 and var_55_22 < var_55_28 then
					arg_52_1.talkMaxDuration = var_55_28

					if var_55_28 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_21
					end
				end

				arg_52_1.text_.text = var_55_25
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022013", "story_v_out_305022.awb") ~= 0 then
					local var_55_29 = manager.audio:GetVoiceLength("story_v_out_305022", "305022013", "story_v_out_305022.awb") / 1000

					if var_55_29 + var_55_21 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_29 + var_55_21
					end

					if var_55_24.prefab_name ~= "" and arg_52_1.actors_[var_55_24.prefab_name] ~= nil then
						local var_55_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_24.prefab_name].transform, "story_v_out_305022", "305022013", "story_v_out_305022.awb")

						arg_52_1:RecordAudio("305022013", var_55_30)
						arg_52_1:RecordAudio("305022013", var_55_30)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_305022", "305022013", "story_v_out_305022.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_305022", "305022013", "story_v_out_305022.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_31 = math.max(var_55_22, arg_52_1.talkMaxDuration)

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_31 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_21) / var_55_31

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_21 + var_55_31 and arg_52_1.time_ < var_55_21 + var_55_31 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play305022014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 305022014
		arg_56_1.duration_ = 12.33

		local var_56_0 = {
			zh = 7,
			ja = 12.333
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
				arg_56_0:Play305022015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.15

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[21].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(305022014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 46
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022014", "story_v_out_305022.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_305022", "305022014", "story_v_out_305022.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_305022", "305022014", "story_v_out_305022.awb")

						arg_56_1:RecordAudio("305022014", var_59_9)
						arg_56_1:RecordAudio("305022014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_305022", "305022014", "story_v_out_305022.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_305022", "305022014", "story_v_out_305022.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play305022015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 305022015
		arg_60_1.duration_ = 7

		local var_60_0 = {
			zh = 5.266,
			ja = 7
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
				arg_60_0:Play305022016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1035ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1035ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(-0.7, -1.05, -5.6)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1035ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(-0.7, -1.05, -5.6)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["3008ui_story"].transform
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.var_.moveOldPos3008ui_story = var_63_9.localPosition
			end

			local var_63_11 = 0.001

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11
				local var_63_13 = Vector3.New(0.7, -1.51, -4.3)

				var_63_9.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos3008ui_story, var_63_13, var_63_12)

				local var_63_14 = manager.ui.mainCamera.transform.position - var_63_9.position

				var_63_9.forward = Vector3.New(var_63_14.x, var_63_14.y, var_63_14.z)

				local var_63_15 = var_63_9.localEulerAngles

				var_63_15.z = 0
				var_63_15.x = 0
				var_63_9.localEulerAngles = var_63_15
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 then
				var_63_9.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_63_16 = manager.ui.mainCamera.transform.position - var_63_9.position

				var_63_9.forward = Vector3.New(var_63_16.x, var_63_16.y, var_63_16.z)

				local var_63_17 = var_63_9.localEulerAngles

				var_63_17.z = 0
				var_63_17.x = 0
				var_63_9.localEulerAngles = var_63_17
			end

			local var_63_18 = arg_60_1.actors_["3008ui_story"]
			local var_63_19 = 0

			if var_63_19 < arg_60_1.time_ and arg_60_1.time_ <= var_63_19 + arg_63_0 and not isNil(var_63_18) and arg_60_1.var_.characterEffect3008ui_story == nil then
				arg_60_1.var_.characterEffect3008ui_story = var_63_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_20 = 0.200000002980232

			if var_63_19 <= arg_60_1.time_ and arg_60_1.time_ < var_63_19 + var_63_20 and not isNil(var_63_18) then
				local var_63_21 = (arg_60_1.time_ - var_63_19) / var_63_20

				if arg_60_1.var_.characterEffect3008ui_story and not isNil(var_63_18) then
					arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_19 + var_63_20 and arg_60_1.time_ < var_63_19 + var_63_20 + arg_63_0 and not isNil(var_63_18) and arg_60_1.var_.characterEffect3008ui_story then
				arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_63_22 = arg_60_1.actors_["1035ui_story"]
			local var_63_23 = 0

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 and not isNil(var_63_22) and arg_60_1.var_.characterEffect1035ui_story == nil then
				arg_60_1.var_.characterEffect1035ui_story = var_63_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_24 = 0.200000002980232

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 and not isNil(var_63_22) then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24

				if arg_60_1.var_.characterEffect1035ui_story and not isNil(var_63_22) then
					local var_63_26 = Mathf.Lerp(0, 0.5, var_63_25)

					arg_60_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1035ui_story.fillRatio = var_63_26
				end
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 and not isNil(var_63_22) and arg_60_1.var_.characterEffect1035ui_story then
				local var_63_27 = 0.5

				arg_60_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1035ui_story.fillRatio = var_63_27
			end

			local var_63_28 = 0

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_63_29 = 0

			if var_63_29 < arg_60_1.time_ and arg_60_1.time_ <= var_63_29 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_30 = 0
			local var_63_31 = 0.7

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_32 = arg_60_1:FormatText(StoryNameCfg[20].name)

				arg_60_1.leftNameTxt_.text = var_63_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_33 = arg_60_1:GetWordFromCfg(305022015)
				local var_63_34 = arg_60_1:FormatText(var_63_33.content)

				arg_60_1.text_.text = var_63_34

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_35 = 28
				local var_63_36 = utf8.len(var_63_34)
				local var_63_37 = var_63_35 <= 0 and var_63_31 or var_63_31 * (var_63_36 / var_63_35)

				if var_63_37 > 0 and var_63_31 < var_63_37 then
					arg_60_1.talkMaxDuration = var_63_37

					if var_63_37 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_37 + var_63_30
					end
				end

				arg_60_1.text_.text = var_63_34
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022015", "story_v_out_305022.awb") ~= 0 then
					local var_63_38 = manager.audio:GetVoiceLength("story_v_out_305022", "305022015", "story_v_out_305022.awb") / 1000

					if var_63_38 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_38 + var_63_30
					end

					if var_63_33.prefab_name ~= "" and arg_60_1.actors_[var_63_33.prefab_name] ~= nil then
						local var_63_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_33.prefab_name].transform, "story_v_out_305022", "305022015", "story_v_out_305022.awb")

						arg_60_1:RecordAudio("305022015", var_63_39)
						arg_60_1:RecordAudio("305022015", var_63_39)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_305022", "305022015", "story_v_out_305022.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_305022", "305022015", "story_v_out_305022.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_40 = math.max(var_63_31, arg_60_1.talkMaxDuration)

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_40 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_30) / var_63_40

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_30 + var_63_40 and arg_60_1.time_ < var_63_30 + var_63_40 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play305022016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 305022016
		arg_64_1.duration_ = 3.67

		local var_64_0 = {
			zh = 2.766,
			ja = 3.666
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
				arg_64_0:Play305022017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1035ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1035ui_story == nil then
				arg_64_1.var_.characterEffect1035ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1035ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1035ui_story then
				arg_64_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["3008ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect3008ui_story == nil then
				arg_64_1.var_.characterEffect3008ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect3008ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_64_1.var_.characterEffect3008ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect3008ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_64_1.var_.characterEffect3008ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action443")
			end

			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_12 = 0
			local var_67_13 = 0.225

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_14 = arg_64_1:FormatText(StoryNameCfg[21].name)

				arg_64_1.leftNameTxt_.text = var_67_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_15 = arg_64_1:GetWordFromCfg(305022016)
				local var_67_16 = arg_64_1:FormatText(var_67_15.content)

				arg_64_1.text_.text = var_67_16

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 9
				local var_67_18 = utf8.len(var_67_16)
				local var_67_19 = var_67_17 <= 0 and var_67_13 or var_67_13 * (var_67_18 / var_67_17)

				if var_67_19 > 0 and var_67_13 < var_67_19 then
					arg_64_1.talkMaxDuration = var_67_19

					if var_67_19 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_16
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022016", "story_v_out_305022.awb") ~= 0 then
					local var_67_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022016", "story_v_out_305022.awb") / 1000

					if var_67_20 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_20 + var_67_12
					end

					if var_67_15.prefab_name ~= "" and arg_64_1.actors_[var_67_15.prefab_name] ~= nil then
						local var_67_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_15.prefab_name].transform, "story_v_out_305022", "305022016", "story_v_out_305022.awb")

						arg_64_1:RecordAudio("305022016", var_67_21)
						arg_64_1:RecordAudio("305022016", var_67_21)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_305022", "305022016", "story_v_out_305022.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_305022", "305022016", "story_v_out_305022.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_22 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_22 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_22

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_22 and arg_64_1.time_ < var_67_12 + var_67_22 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play305022017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 305022017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play305022018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1035ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1035ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1035ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["3008ui_story"].transform
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.var_.moveOldPos3008ui_story = var_71_9.localPosition
			end

			local var_71_11 = 0.001

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11
				local var_71_13 = Vector3.New(0, 100, 0)

				var_71_9.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3008ui_story, var_71_13, var_71_12)

				local var_71_14 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_14.x, var_71_14.y, var_71_14.z)

				local var_71_15 = var_71_9.localEulerAngles

				var_71_15.z = 0
				var_71_15.x = 0
				var_71_9.localEulerAngles = var_71_15
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 then
				var_71_9.localPosition = Vector3.New(0, 100, 0)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_9.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_9.localEulerAngles = var_71_17
			end

			local var_71_18 = arg_68_1.actors_["1035ui_story"]
			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 and not isNil(var_71_18) and arg_68_1.var_.characterEffect1035ui_story == nil then
				arg_68_1.var_.characterEffect1035ui_story = var_71_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_20 = 0.200000002980232

			if var_71_19 <= arg_68_1.time_ and arg_68_1.time_ < var_71_19 + var_71_20 and not isNil(var_71_18) then
				local var_71_21 = (arg_68_1.time_ - var_71_19) / var_71_20

				if arg_68_1.var_.characterEffect1035ui_story and not isNil(var_71_18) then
					local var_71_22 = Mathf.Lerp(0, 0.5, var_71_21)

					arg_68_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1035ui_story.fillRatio = var_71_22
				end
			end

			if arg_68_1.time_ >= var_71_19 + var_71_20 and arg_68_1.time_ < var_71_19 + var_71_20 + arg_71_0 and not isNil(var_71_18) and arg_68_1.var_.characterEffect1035ui_story then
				local var_71_23 = 0.5

				arg_68_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1035ui_story.fillRatio = var_71_23
			end

			local var_71_24 = 0
			local var_71_25 = 1.475

			if var_71_24 < arg_68_1.time_ and arg_68_1.time_ <= var_71_24 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_26 = arg_68_1:GetWordFromCfg(305022017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 59
				local var_71_29 = utf8.len(var_71_27)
				local var_71_30 = var_71_28 <= 0 and var_71_25 or var_71_25 * (var_71_29 / var_71_28)

				if var_71_30 > 0 and var_71_25 < var_71_30 then
					arg_68_1.talkMaxDuration = var_71_30

					if var_71_30 + var_71_24 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_24
					end
				end

				arg_68_1.text_.text = var_71_27
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_31 = math.max(var_71_25, arg_68_1.talkMaxDuration)

			if var_71_24 <= arg_68_1.time_ and arg_68_1.time_ < var_71_24 + var_71_31 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_24) / var_71_31

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_24 + var_71_31 and arg_68_1.time_ < var_71_24 + var_71_31 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play305022018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 305022018
		arg_72_1.duration_ = 11.7

		local var_72_0 = {
			zh = 6.166,
			ja = 11.7
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play305022019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["4010ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect4010ui_story == nil then
				arg_72_1.var_.characterEffect4010ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect4010ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect4010ui_story then
				arg_72_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_75_4 = 0
			local var_75_5 = 0.65

			if var_75_4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_6 = arg_72_1:FormatText(StoryNameCfg[42].name)

				arg_72_1.leftNameTxt_.text = var_75_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_7 = arg_72_1:GetWordFromCfg(305022018)
				local var_75_8 = arg_72_1:FormatText(var_75_7.content)

				arg_72_1.text_.text = var_75_8

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 26
				local var_75_10 = utf8.len(var_75_8)
				local var_75_11 = var_75_9 <= 0 and var_75_5 or var_75_5 * (var_75_10 / var_75_9)

				if var_75_11 > 0 and var_75_5 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_8
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022018", "story_v_out_305022.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_305022", "305022018", "story_v_out_305022.awb") / 1000

					if var_75_12 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_4
					end

					if var_75_7.prefab_name ~= "" and arg_72_1.actors_[var_75_7.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_7.prefab_name].transform, "story_v_out_305022", "305022018", "story_v_out_305022.awb")

						arg_72_1:RecordAudio("305022018", var_75_13)
						arg_72_1:RecordAudio("305022018", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_305022", "305022018", "story_v_out_305022.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_305022", "305022018", "story_v_out_305022.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_14 and arg_72_1.time_ < var_75_4 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play305022019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 305022019
		arg_76_1.duration_ = 7.87

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play305022020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "B07a"

			if arg_76_1.bgs_[var_79_0] == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			local var_79_2 = 1.63333333333333

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				local var_79_3 = manager.ui.mainCamera.transform.localPosition
				local var_79_4 = Vector3.New(0, 0, 10) + Vector3.New(var_79_3.x, var_79_3.y, 0)
				local var_79_5 = arg_76_1.bgs_.B07a

				var_79_5.transform.localPosition = var_79_4
				var_79_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_6 = var_79_5:GetComponent("SpriteRenderer")

				if var_79_6 and var_79_6.sprite then
					local var_79_7 = (var_79_5.transform.localPosition - var_79_3).z
					local var_79_8 = manager.ui.mainCameraCom_
					local var_79_9 = 2 * var_79_7 * Mathf.Tan(var_79_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_10 = var_79_9 * var_79_8.aspect
					local var_79_11 = var_79_6.sprite.bounds.size.x
					local var_79_12 = var_79_6.sprite.bounds.size.y
					local var_79_13 = var_79_10 / var_79_11
					local var_79_14 = var_79_9 / var_79_12
					local var_79_15 = var_79_14 < var_79_13 and var_79_13 or var_79_14

					var_79_5.transform.localScale = Vector3.New(var_79_15, var_79_15, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "B07a" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_17 = 0.3

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_18 = 0

			if var_79_18 < arg_76_1.time_ and arg_76_1.time_ <= var_79_18 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_19 = 1.63333333333333

			if var_79_18 <= arg_76_1.time_ and arg_76_1.time_ < var_79_18 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_18) / var_79_19
				local var_79_21 = Color.New(0, 0, 0)

				var_79_21.a = Mathf.Lerp(0, 1, var_79_20)
				arg_76_1.mask_.color = var_79_21
			end

			if arg_76_1.time_ >= var_79_18 + var_79_19 and arg_76_1.time_ < var_79_18 + var_79_19 + arg_79_0 then
				local var_79_22 = Color.New(0, 0, 0)

				var_79_22.a = 1
				arg_76_1.mask_.color = var_79_22
			end

			local var_79_23 = 1.63333333333333

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_24 = 1.63333333333333

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_24 then
				local var_79_25 = (arg_76_1.time_ - var_79_23) / var_79_24
				local var_79_26 = Color.New(0, 0, 0)

				var_79_26.a = Mathf.Lerp(1, 0, var_79_25)
				arg_76_1.mask_.color = var_79_26
			end

			if arg_76_1.time_ >= var_79_23 + var_79_24 and arg_76_1.time_ < var_79_23 + var_79_24 + arg_79_0 then
				local var_79_27 = Color.New(0, 0, 0)
				local var_79_28 = 0

				arg_76_1.mask_.enabled = false
				var_79_27.a = var_79_28
				arg_76_1.mask_.color = var_79_27
			end

			local var_79_29 = arg_76_1.actors_["4010ui_story"]
			local var_79_30 = 0

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 and not isNil(var_79_29) and arg_76_1.var_.characterEffect4010ui_story == nil then
				arg_76_1.var_.characterEffect4010ui_story = var_79_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_31 = 0.200000002980232

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_31 and not isNil(var_79_29) then
				local var_79_32 = (arg_76_1.time_ - var_79_30) / var_79_31

				if arg_76_1.var_.characterEffect4010ui_story and not isNil(var_79_29) then
					local var_79_33 = Mathf.Lerp(0, 0.5, var_79_32)

					arg_76_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_76_1.var_.characterEffect4010ui_story.fillRatio = var_79_33
				end
			end

			if arg_76_1.time_ >= var_79_30 + var_79_31 and arg_76_1.time_ < var_79_30 + var_79_31 + arg_79_0 and not isNil(var_79_29) and arg_76_1.var_.characterEffect4010ui_story then
				local var_79_34 = 0.5

				arg_76_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_76_1.var_.characterEffect4010ui_story.fillRatio = var_79_34
			end

			local var_79_35 = 1.2
			local var_79_36 = 1

			if var_79_35 < arg_76_1.time_ and arg_76_1.time_ <= var_79_35 + arg_79_0 then
				local var_79_37 = "play"
				local var_79_38 = "effect"

				arg_76_1:AudioAction(var_79_37, var_79_38, "se_story_152", "se_story_152_amb_lift", "")
			end

			local var_79_39 = 0.2
			local var_79_40 = 1

			if var_79_39 < arg_76_1.time_ and arg_76_1.time_ <= var_79_39 + arg_79_0 then
				local var_79_41 = "stop"
				local var_79_42 = "effect"

				arg_76_1:AudioAction(var_79_41, var_79_42, "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_43 = 2.86666666666667
			local var_79_44 = 1.425

			if var_79_43 < arg_76_1.time_ and arg_76_1.time_ <= var_79_43 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_45 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_45:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_46 = arg_76_1:GetWordFromCfg(305022019)
				local var_79_47 = arg_76_1:FormatText(var_79_46.content)

				arg_76_1.text_.text = var_79_47

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_48 = 57
				local var_79_49 = utf8.len(var_79_47)
				local var_79_50 = var_79_48 <= 0 and var_79_44 or var_79_44 * (var_79_49 / var_79_48)

				if var_79_50 > 0 and var_79_44 < var_79_50 then
					arg_76_1.talkMaxDuration = var_79_50
					var_79_43 = var_79_43 + 0.3

					if var_79_50 + var_79_43 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_50 + var_79_43
					end
				end

				arg_76_1.text_.text = var_79_47
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_51 = var_79_43 + 0.3
			local var_79_52 = math.max(var_79_44, arg_76_1.talkMaxDuration)

			if var_79_51 <= arg_76_1.time_ and arg_76_1.time_ < var_79_51 + var_79_52 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_51) / var_79_52

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_51 + var_79_52 and arg_76_1.time_ < var_79_51 + var_79_52 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play305022020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 305022020
		arg_82_1.duration_ = 4.8

		local var_82_0 = {
			zh = 4.8,
			ja = 1.999999999999
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
				arg_82_0:Play305022021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "1084ui_story"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_82_1.stage_.transform)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentInChildren(typeof(CharacterEffect))

					var_85_3.enabled = true

					local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_2, typeof(DynamicBoneHelper))

					if var_85_4 then
						var_85_4:EnableDynamicBone(false)
					end

					arg_82_1:ShowWeapon(var_85_3.transform, false)

					arg_82_1.var_[var_85_0 .. "Animator"] = var_85_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_82_1.var_[var_85_0 .. "Animator"].applyRootMotion = true
					arg_82_1.var_[var_85_0 .. "LipSync"] = var_85_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_85_5 = arg_82_1.actors_["1084ui_story"].transform
			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.var_.moveOldPos1084ui_story = var_85_5.localPosition
			end

			local var_85_7 = 0.001

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 then
				local var_85_8 = (arg_82_1.time_ - var_85_6) / var_85_7
				local var_85_9 = Vector3.New(-0.7, -0.97, -6)

				var_85_5.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1084ui_story, var_85_9, var_85_8)

				local var_85_10 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_10.x, var_85_10.y, var_85_10.z)

				local var_85_11 = var_85_5.localEulerAngles

				var_85_11.z = 0
				var_85_11.x = 0
				var_85_5.localEulerAngles = var_85_11
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 then
				var_85_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_85_12 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_12.x, var_85_12.y, var_85_12.z)

				local var_85_13 = var_85_5.localEulerAngles

				var_85_13.z = 0
				var_85_13.x = 0
				var_85_5.localEulerAngles = var_85_13
			end

			local var_85_14 = arg_82_1.actors_["1084ui_story"]
			local var_85_15 = 0

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 and not isNil(var_85_14) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_16 = 0.200000002980232

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_16 and not isNil(var_85_14) then
				local var_85_17 = (arg_82_1.time_ - var_85_15) / var_85_16

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_14) then
					arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_15 + var_85_16 and arg_82_1.time_ < var_85_15 + var_85_16 + arg_85_0 and not isNil(var_85_14) and arg_82_1.var_.characterEffect1084ui_story then
				arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_85_18 = 0

			if var_85_18 < arg_82_1.time_ and arg_82_1.time_ <= var_85_18 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_20 = 0
			local var_85_21 = 0.525

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_22 = arg_82_1:FormatText(StoryNameCfg[6].name)

				arg_82_1.leftNameTxt_.text = var_85_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_23 = arg_82_1:GetWordFromCfg(305022020)
				local var_85_24 = arg_82_1:FormatText(var_85_23.content)

				arg_82_1.text_.text = var_85_24

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_25 = 21
				local var_85_26 = utf8.len(var_85_24)
				local var_85_27 = var_85_25 <= 0 and var_85_21 or var_85_21 * (var_85_26 / var_85_25)

				if var_85_27 > 0 and var_85_21 < var_85_27 then
					arg_82_1.talkMaxDuration = var_85_27

					if var_85_27 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_27 + var_85_20
					end
				end

				arg_82_1.text_.text = var_85_24
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022020", "story_v_out_305022.awb") ~= 0 then
					local var_85_28 = manager.audio:GetVoiceLength("story_v_out_305022", "305022020", "story_v_out_305022.awb") / 1000

					if var_85_28 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_28 + var_85_20
					end

					if var_85_23.prefab_name ~= "" and arg_82_1.actors_[var_85_23.prefab_name] ~= nil then
						local var_85_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_23.prefab_name].transform, "story_v_out_305022", "305022020", "story_v_out_305022.awb")

						arg_82_1:RecordAudio("305022020", var_85_29)
						arg_82_1:RecordAudio("305022020", var_85_29)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_305022", "305022020", "story_v_out_305022.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_305022", "305022020", "story_v_out_305022.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_30 = math.max(var_85_21, arg_82_1.talkMaxDuration)

			if var_85_20 <= arg_82_1.time_ and arg_82_1.time_ < var_85_20 + var_85_30 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_20) / var_85_30

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_20 + var_85_30 and arg_82_1.time_ < var_85_20 + var_85_30 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play305022021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 305022021
		arg_86_1.duration_ = 13.97

		local var_86_0 = {
			zh = 6.7,
			ja = 13.966
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play305022022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "1011ui_story"

			if arg_86_1.actors_[var_89_0] == nil then
				local var_89_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_89_1) then
					local var_89_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_86_1.stage_.transform)

					var_89_2.name = var_89_0
					var_89_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_86_1.actors_[var_89_0] = var_89_2

					local var_89_3 = var_89_2:GetComponentInChildren(typeof(CharacterEffect))

					var_89_3.enabled = true

					local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_2, typeof(DynamicBoneHelper))

					if var_89_4 then
						var_89_4:EnableDynamicBone(false)
					end

					arg_86_1:ShowWeapon(var_89_3.transform, false)

					arg_86_1.var_[var_89_0 .. "Animator"] = var_89_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_86_1.var_[var_89_0 .. "Animator"].applyRootMotion = true
					arg_86_1.var_[var_89_0 .. "LipSync"] = var_89_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_89_5 = arg_86_1.actors_["1011ui_story"].transform
			local var_89_6 = 0

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.var_.moveOldPos1011ui_story = var_89_5.localPosition
			end

			local var_89_7 = 0.001

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_7 then
				local var_89_8 = (arg_86_1.time_ - var_89_6) / var_89_7
				local var_89_9 = Vector3.New(0.7, -0.71, -6)

				var_89_5.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1011ui_story, var_89_9, var_89_8)

				local var_89_10 = manager.ui.mainCamera.transform.position - var_89_5.position

				var_89_5.forward = Vector3.New(var_89_10.x, var_89_10.y, var_89_10.z)

				local var_89_11 = var_89_5.localEulerAngles

				var_89_11.z = 0
				var_89_11.x = 0
				var_89_5.localEulerAngles = var_89_11
			end

			if arg_86_1.time_ >= var_89_6 + var_89_7 and arg_86_1.time_ < var_89_6 + var_89_7 + arg_89_0 then
				var_89_5.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_89_12 = manager.ui.mainCamera.transform.position - var_89_5.position

				var_89_5.forward = Vector3.New(var_89_12.x, var_89_12.y, var_89_12.z)

				local var_89_13 = var_89_5.localEulerAngles

				var_89_13.z = 0
				var_89_13.x = 0
				var_89_5.localEulerAngles = var_89_13
			end

			local var_89_14 = arg_86_1.actors_["1011ui_story"]
			local var_89_15 = 0

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 and not isNil(var_89_14) and arg_86_1.var_.characterEffect1011ui_story == nil then
				arg_86_1.var_.characterEffect1011ui_story = var_89_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_16 = 0.200000002980232

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_16 and not isNil(var_89_14) then
				local var_89_17 = (arg_86_1.time_ - var_89_15) / var_89_16

				if arg_86_1.var_.characterEffect1011ui_story and not isNil(var_89_14) then
					arg_86_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_15 + var_89_16 and arg_86_1.time_ < var_89_15 + var_89_16 + arg_89_0 and not isNil(var_89_14) and arg_86_1.var_.characterEffect1011ui_story then
				arg_86_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_89_18 = arg_86_1.actors_["1084ui_story"]
			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_20 = 0.200000002980232

			if var_89_19 <= arg_86_1.time_ and arg_86_1.time_ < var_89_19 + var_89_20 and not isNil(var_89_18) then
				local var_89_21 = (arg_86_1.time_ - var_89_19) / var_89_20

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_18) then
					local var_89_22 = Mathf.Lerp(0, 0.5, var_89_21)

					arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_22
				end
			end

			if arg_86_1.time_ >= var_89_19 + var_89_20 and arg_86_1.time_ < var_89_19 + var_89_20 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect1084ui_story then
				local var_89_23 = 0.5

				arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_23
			end

			local var_89_24 = 0

			if var_89_24 < arg_86_1.time_ and arg_86_1.time_ <= var_89_24 + arg_89_0 then
				arg_86_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_89_25 = 0

			if var_89_25 < arg_86_1.time_ and arg_86_1.time_ <= var_89_25 + arg_89_0 then
				arg_86_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_26 = 0
			local var_89_27 = 0.7

			if var_89_26 < arg_86_1.time_ and arg_86_1.time_ <= var_89_26 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_28 = arg_86_1:FormatText(StoryNameCfg[37].name)

				arg_86_1.leftNameTxt_.text = var_89_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_29 = arg_86_1:GetWordFromCfg(305022021)
				local var_89_30 = arg_86_1:FormatText(var_89_29.content)

				arg_86_1.text_.text = var_89_30

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_31 = 28
				local var_89_32 = utf8.len(var_89_30)
				local var_89_33 = var_89_31 <= 0 and var_89_27 or var_89_27 * (var_89_32 / var_89_31)

				if var_89_33 > 0 and var_89_27 < var_89_33 then
					arg_86_1.talkMaxDuration = var_89_33

					if var_89_33 + var_89_26 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_33 + var_89_26
					end
				end

				arg_86_1.text_.text = var_89_30
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022021", "story_v_out_305022.awb") ~= 0 then
					local var_89_34 = manager.audio:GetVoiceLength("story_v_out_305022", "305022021", "story_v_out_305022.awb") / 1000

					if var_89_34 + var_89_26 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_34 + var_89_26
					end

					if var_89_29.prefab_name ~= "" and arg_86_1.actors_[var_89_29.prefab_name] ~= nil then
						local var_89_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_29.prefab_name].transform, "story_v_out_305022", "305022021", "story_v_out_305022.awb")

						arg_86_1:RecordAudio("305022021", var_89_35)
						arg_86_1:RecordAudio("305022021", var_89_35)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_305022", "305022021", "story_v_out_305022.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_305022", "305022021", "story_v_out_305022.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_36 = math.max(var_89_27, arg_86_1.talkMaxDuration)

			if var_89_26 <= arg_86_1.time_ and arg_86_1.time_ < var_89_26 + var_89_36 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_26) / var_89_36

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_26 + var_89_36 and arg_86_1.time_ < var_89_26 + var_89_36 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play305022022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 305022022
		arg_90_1.duration_ = 3.97

		local var_90_0 = {
			zh = 3.966,
			ja = 1.999999999999
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
				arg_90_0:Play305022023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1084ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["1011ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1011ui_story == nil then
				arg_90_1.var_.characterEffect1011ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect1011ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1011ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1011ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1011ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action465")
			end

			local var_93_11 = 0

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_12 = 0
			local var_93_13 = 0.45

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[6].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:GetWordFromCfg(305022022)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 18
				local var_93_18 = utf8.len(var_93_16)
				local var_93_19 = var_93_17 <= 0 and var_93_13 or var_93_13 * (var_93_18 / var_93_17)

				if var_93_19 > 0 and var_93_13 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_16
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022022", "story_v_out_305022.awb") ~= 0 then
					local var_93_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022022", "story_v_out_305022.awb") / 1000

					if var_93_20 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_12
					end

					if var_93_15.prefab_name ~= "" and arg_90_1.actors_[var_93_15.prefab_name] ~= nil then
						local var_93_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_15.prefab_name].transform, "story_v_out_305022", "305022022", "story_v_out_305022.awb")

						arg_90_1:RecordAudio("305022022", var_93_21)
						arg_90_1:RecordAudio("305022022", var_93_21)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_305022", "305022022", "story_v_out_305022.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_305022", "305022022", "story_v_out_305022.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_12) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_22 and arg_90_1.time_ < var_93_12 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play305022023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 305022023
		arg_94_1.duration_ = 7.43

		local var_94_0 = {
			zh = 5.733,
			ja = 7.433
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
				arg_94_0:Play305022024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "1019ui_story"

			if arg_94_1.actors_[var_97_0] == nil then
				local var_97_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_97_1) then
					local var_97_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_94_1.stage_.transform)

					var_97_2.name = var_97_0
					var_97_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_94_1.actors_[var_97_0] = var_97_2

					local var_97_3 = var_97_2:GetComponentInChildren(typeof(CharacterEffect))

					var_97_3.enabled = true

					local var_97_4 = GameObjectTools.GetOrAddComponent(var_97_2, typeof(DynamicBoneHelper))

					if var_97_4 then
						var_97_4:EnableDynamicBone(false)
					end

					arg_94_1:ShowWeapon(var_97_3.transform, false)

					arg_94_1.var_[var_97_0 .. "Animator"] = var_97_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_94_1.var_[var_97_0 .. "Animator"].applyRootMotion = true
					arg_94_1.var_[var_97_0 .. "LipSync"] = var_97_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_97_5 = arg_94_1.actors_["1019ui_story"].transform
			local var_97_6 = 0

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.var_.moveOldPos1019ui_story = var_97_5.localPosition
			end

			local var_97_7 = 0.001

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_7 then
				local var_97_8 = (arg_94_1.time_ - var_97_6) / var_97_7
				local var_97_9 = Vector3.New(0.7, -1.08, -5.9)

				var_97_5.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1019ui_story, var_97_9, var_97_8)

				local var_97_10 = manager.ui.mainCamera.transform.position - var_97_5.position

				var_97_5.forward = Vector3.New(var_97_10.x, var_97_10.y, var_97_10.z)

				local var_97_11 = var_97_5.localEulerAngles

				var_97_11.z = 0
				var_97_11.x = 0
				var_97_5.localEulerAngles = var_97_11
			end

			if arg_94_1.time_ >= var_97_6 + var_97_7 and arg_94_1.time_ < var_97_6 + var_97_7 + arg_97_0 then
				var_97_5.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_97_12 = manager.ui.mainCamera.transform.position - var_97_5.position

				var_97_5.forward = Vector3.New(var_97_12.x, var_97_12.y, var_97_12.z)

				local var_97_13 = var_97_5.localEulerAngles

				var_97_13.z = 0
				var_97_13.x = 0
				var_97_5.localEulerAngles = var_97_13
			end

			local var_97_14 = arg_94_1.actors_["1011ui_story"].transform
			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.var_.moveOldPos1011ui_story = var_97_14.localPosition
			end

			local var_97_16 = 0.001

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_16 then
				local var_97_17 = (arg_94_1.time_ - var_97_15) / var_97_16
				local var_97_18 = Vector3.New(0, 100, 0)

				var_97_14.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1011ui_story, var_97_18, var_97_17)

				local var_97_19 = manager.ui.mainCamera.transform.position - var_97_14.position

				var_97_14.forward = Vector3.New(var_97_19.x, var_97_19.y, var_97_19.z)

				local var_97_20 = var_97_14.localEulerAngles

				var_97_20.z = 0
				var_97_20.x = 0
				var_97_14.localEulerAngles = var_97_20
			end

			if arg_94_1.time_ >= var_97_15 + var_97_16 and arg_94_1.time_ < var_97_15 + var_97_16 + arg_97_0 then
				var_97_14.localPosition = Vector3.New(0, 100, 0)

				local var_97_21 = manager.ui.mainCamera.transform.position - var_97_14.position

				var_97_14.forward = Vector3.New(var_97_21.x, var_97_21.y, var_97_21.z)

				local var_97_22 = var_97_14.localEulerAngles

				var_97_22.z = 0
				var_97_22.x = 0
				var_97_14.localEulerAngles = var_97_22
			end

			local var_97_23 = arg_94_1.actors_["1019ui_story"]
			local var_97_24 = 0

			if var_97_24 < arg_94_1.time_ and arg_94_1.time_ <= var_97_24 + arg_97_0 and not isNil(var_97_23) and arg_94_1.var_.characterEffect1019ui_story == nil then
				arg_94_1.var_.characterEffect1019ui_story = var_97_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_25 = 0.200000002980232

			if var_97_24 <= arg_94_1.time_ and arg_94_1.time_ < var_97_24 + var_97_25 and not isNil(var_97_23) then
				local var_97_26 = (arg_94_1.time_ - var_97_24) / var_97_25

				if arg_94_1.var_.characterEffect1019ui_story and not isNil(var_97_23) then
					arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_24 + var_97_25 and arg_94_1.time_ < var_97_24 + var_97_25 + arg_97_0 and not isNil(var_97_23) and arg_94_1.var_.characterEffect1019ui_story then
				arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_97_27 = arg_94_1.actors_["1084ui_story"]
			local var_97_28 = 0

			if var_97_28 < arg_94_1.time_ and arg_94_1.time_ <= var_97_28 + arg_97_0 and not isNil(var_97_27) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_29 = 0.200000002980232

			if var_97_28 <= arg_94_1.time_ and arg_94_1.time_ < var_97_28 + var_97_29 and not isNil(var_97_27) then
				local var_97_30 = (arg_94_1.time_ - var_97_28) / var_97_29

				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_27) then
					local var_97_31 = Mathf.Lerp(0, 0.5, var_97_30)

					arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1084ui_story.fillRatio = var_97_31
				end
			end

			if arg_94_1.time_ >= var_97_28 + var_97_29 and arg_94_1.time_ < var_97_28 + var_97_29 + arg_97_0 and not isNil(var_97_27) and arg_94_1.var_.characterEffect1084ui_story then
				local var_97_32 = 0.5

				arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1084ui_story.fillRatio = var_97_32
			end

			local var_97_33 = 0

			if var_97_33 < arg_94_1.time_ and arg_94_1.time_ <= var_97_33 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_97_34 = 0

			if var_97_34 < arg_94_1.time_ and arg_94_1.time_ <= var_97_34 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_97_35 = 0
			local var_97_36 = 0.675

			if var_97_35 < arg_94_1.time_ and arg_94_1.time_ <= var_97_35 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_37 = arg_94_1:FormatText(StoryNameCfg[13].name)

				arg_94_1.leftNameTxt_.text = var_97_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_38 = arg_94_1:GetWordFromCfg(305022023)
				local var_97_39 = arg_94_1:FormatText(var_97_38.content)

				arg_94_1.text_.text = var_97_39

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_40 = 27
				local var_97_41 = utf8.len(var_97_39)
				local var_97_42 = var_97_40 <= 0 and var_97_36 or var_97_36 * (var_97_41 / var_97_40)

				if var_97_42 > 0 and var_97_36 < var_97_42 then
					arg_94_1.talkMaxDuration = var_97_42

					if var_97_42 + var_97_35 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_42 + var_97_35
					end
				end

				arg_94_1.text_.text = var_97_39
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022023", "story_v_out_305022.awb") ~= 0 then
					local var_97_43 = manager.audio:GetVoiceLength("story_v_out_305022", "305022023", "story_v_out_305022.awb") / 1000

					if var_97_43 + var_97_35 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_43 + var_97_35
					end

					if var_97_38.prefab_name ~= "" and arg_94_1.actors_[var_97_38.prefab_name] ~= nil then
						local var_97_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_38.prefab_name].transform, "story_v_out_305022", "305022023", "story_v_out_305022.awb")

						arg_94_1:RecordAudio("305022023", var_97_44)
						arg_94_1:RecordAudio("305022023", var_97_44)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_305022", "305022023", "story_v_out_305022.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_305022", "305022023", "story_v_out_305022.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_45 = math.max(var_97_36, arg_94_1.talkMaxDuration)

			if var_97_35 <= arg_94_1.time_ and arg_94_1.time_ < var_97_35 + var_97_45 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_35) / var_97_45

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_35 + var_97_45 and arg_94_1.time_ < var_97_35 + var_97_45 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play305022024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 305022024
		arg_98_1.duration_ = 5.53

		local var_98_0 = {
			zh = 5.533,
			ja = 1.999999999999
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
				arg_98_0:Play305022025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1084ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1019ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1019ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_101_11 = 0

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_101_12 = 0
			local var_101_13 = 0.575

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_14 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_15 = arg_98_1:GetWordFromCfg(305022024)
				local var_101_16 = arg_98_1:FormatText(var_101_15.content)

				arg_98_1.text_.text = var_101_16

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_17 = 23
				local var_101_18 = utf8.len(var_101_16)
				local var_101_19 = var_101_17 <= 0 and var_101_13 or var_101_13 * (var_101_18 / var_101_17)

				if var_101_19 > 0 and var_101_13 < var_101_19 then
					arg_98_1.talkMaxDuration = var_101_19

					if var_101_19 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_12
					end
				end

				arg_98_1.text_.text = var_101_16
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022024", "story_v_out_305022.awb") ~= 0 then
					local var_101_20 = manager.audio:GetVoiceLength("story_v_out_305022", "305022024", "story_v_out_305022.awb") / 1000

					if var_101_20 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_20 + var_101_12
					end

					if var_101_15.prefab_name ~= "" and arg_98_1.actors_[var_101_15.prefab_name] ~= nil then
						local var_101_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_15.prefab_name].transform, "story_v_out_305022", "305022024", "story_v_out_305022.awb")

						arg_98_1:RecordAudio("305022024", var_101_21)
						arg_98_1:RecordAudio("305022024", var_101_21)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_305022", "305022024", "story_v_out_305022.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_305022", "305022024", "story_v_out_305022.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_13, arg_98_1.talkMaxDuration)

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_12) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_12 + var_101_22 and arg_98_1.time_ < var_101_12 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play305022025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 305022025
		arg_102_1.duration_ = 7.93

		local var_102_0 = {
			zh = 6.166,
			ja = 7.933
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play305022026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1019ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1019ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1019ui_story then
				arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1084ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1084ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1084ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1084ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_105_11 = 0
			local var_105_12 = 0.9

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_13 = arg_102_1:FormatText(StoryNameCfg[13].name)

				arg_102_1.leftNameTxt_.text = var_105_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_14 = arg_102_1:GetWordFromCfg(305022025)
				local var_105_15 = arg_102_1:FormatText(var_105_14.content)

				arg_102_1.text_.text = var_105_15

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_16 = 36
				local var_105_17 = utf8.len(var_105_15)
				local var_105_18 = var_105_16 <= 0 and var_105_12 or var_105_12 * (var_105_17 / var_105_16)

				if var_105_18 > 0 and var_105_12 < var_105_18 then
					arg_102_1.talkMaxDuration = var_105_18

					if var_105_18 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_18 + var_105_11
					end
				end

				arg_102_1.text_.text = var_105_15
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022025", "story_v_out_305022.awb") ~= 0 then
					local var_105_19 = manager.audio:GetVoiceLength("story_v_out_305022", "305022025", "story_v_out_305022.awb") / 1000

					if var_105_19 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_11
					end

					if var_105_14.prefab_name ~= "" and arg_102_1.actors_[var_105_14.prefab_name] ~= nil then
						local var_105_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_14.prefab_name].transform, "story_v_out_305022", "305022025", "story_v_out_305022.awb")

						arg_102_1:RecordAudio("305022025", var_105_20)
						arg_102_1:RecordAudio("305022025", var_105_20)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_305022", "305022025", "story_v_out_305022.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_305022", "305022025", "story_v_out_305022.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_21 = math.max(var_105_12, arg_102_1.talkMaxDuration)

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_21 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_11) / var_105_21

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_11 + var_105_21 and arg_102_1.time_ < var_105_11 + var_105_21 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play305022026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 305022026
		arg_106_1.duration_ = 4.7

		local var_106_0 = {
			zh = 2.333,
			ja = 4.7
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
				arg_106_0:Play305022027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.2
			local var_109_1 = 1

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				local var_109_2 = "play"
				local var_109_3 = "effect"

				arg_106_1:AudioAction(var_109_2, var_109_3, "se_story_152", "se_story_152_lift_door_close", "")
			end

			local var_109_4 = 0
			local var_109_5 = 0.175

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_6 = arg_106_1:FormatText(StoryNameCfg[13].name)

				arg_106_1.leftNameTxt_.text = var_109_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(305022026)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022026", "story_v_out_305022.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_305022", "305022026", "story_v_out_305022.awb") / 1000

					if var_109_12 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_4
					end

					if var_109_7.prefab_name ~= "" and arg_106_1.actors_[var_109_7.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_7.prefab_name].transform, "story_v_out_305022", "305022026", "story_v_out_305022.awb")

						arg_106_1:RecordAudio("305022026", var_109_13)
						arg_106_1:RecordAudio("305022026", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_305022", "305022026", "story_v_out_305022.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_305022", "305022026", "story_v_out_305022.awb")
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
	Play305022027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 305022027
		arg_110_1.duration_ = 5.9

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play305022028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1084ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1084ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0, 100, 0)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1084ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, 100, 0)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = arg_110_1.actors_["1019ui_story"].transform
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_9.localPosition
			end

			local var_113_11 = 0.001

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11
				local var_113_13 = Vector3.New(0, 100, 0)

				var_113_9.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, var_113_13, var_113_12)

				local var_113_14 = manager.ui.mainCamera.transform.position - var_113_9.position

				var_113_9.forward = Vector3.New(var_113_14.x, var_113_14.y, var_113_14.z)

				local var_113_15 = var_113_9.localEulerAngles

				var_113_15.z = 0
				var_113_15.x = 0
				var_113_9.localEulerAngles = var_113_15
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 then
				var_113_9.localPosition = Vector3.New(0, 100, 0)

				local var_113_16 = manager.ui.mainCamera.transform.position - var_113_9.position

				var_113_9.forward = Vector3.New(var_113_16.x, var_113_16.y, var_113_16.z)

				local var_113_17 = var_113_9.localEulerAngles

				var_113_17.z = 0
				var_113_17.x = 0
				var_113_9.localEulerAngles = var_113_17
			end

			local var_113_18 = 0

			if var_113_18 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_19 = 1.0333333303531

			if arg_110_1.time_ >= var_113_18 + var_113_19 and arg_110_1.time_ < var_113_18 + var_113_19 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_20 = 0.2
			local var_113_21 = 1

			if var_113_20 < arg_110_1.time_ and arg_110_1.time_ <= var_113_20 + arg_113_0 then
				local var_113_22 = "play"
				local var_113_23 = "effect"

				arg_110_1:AudioAction(var_113_22, var_113_23, "se_story_152", "se_story_152_lift_move", "")
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_24 = 0.9
			local var_113_25 = 1.125

			if var_113_24 < arg_110_1.time_ and arg_110_1.time_ <= var_113_24 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_26 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_26:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_27 = arg_110_1:GetWordFromCfg(305022027)
				local var_113_28 = arg_110_1:FormatText(var_113_27.content)

				arg_110_1.text_.text = var_113_28

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_29 = 45
				local var_113_30 = utf8.len(var_113_28)
				local var_113_31 = var_113_29 <= 0 and var_113_25 or var_113_25 * (var_113_30 / var_113_29)

				if var_113_31 > 0 and var_113_25 < var_113_31 then
					arg_110_1.talkMaxDuration = var_113_31
					var_113_24 = var_113_24 + 0.3

					if var_113_31 + var_113_24 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_31 + var_113_24
					end
				end

				arg_110_1.text_.text = var_113_28
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_32 = var_113_24 + 0.3
			local var_113_33 = math.max(var_113_25, arg_110_1.talkMaxDuration)

			if var_113_32 <= arg_110_1.time_ and arg_110_1.time_ < var_113_32 + var_113_33 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_32) / var_113_33

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_32 + var_113_33 and arg_110_1.time_ < var_113_32 + var_113_33 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 4,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play305022028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 305022028
		arg_116_1.duration_ = 4.43

		local var_116_0 = {
			zh = 4.433,
			ja = 1.999999999999
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play305022029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1084ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1084ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(-0.7, -0.97, -6)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1084ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1084ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_119_15 = 0
			local var_119_16 = 0.5

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(305022028)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 20
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022028", "story_v_out_305022.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_305022", "305022028", "story_v_out_305022.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_305022", "305022028", "story_v_out_305022.awb")

						arg_116_1:RecordAudio("305022028", var_119_24)
						arg_116_1:RecordAudio("305022028", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_305022", "305022028", "story_v_out_305022.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_305022", "305022028", "story_v_out_305022.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play305022029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 305022029
		arg_120_1.duration_ = 5.8

		local var_120_0 = {
			zh = 3.4,
			ja = 5.8
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play305022030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1019ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0.7, -1.08, -5.9)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1019ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1019ui_story then
				arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_123_13 = arg_120_1.actors_["1084ui_story"]
			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 and not isNil(var_123_13) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = var_123_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_15 = 0.200000002980232

			if var_123_14 <= arg_120_1.time_ and arg_120_1.time_ < var_123_14 + var_123_15 and not isNil(var_123_13) then
				local var_123_16 = (arg_120_1.time_ - var_123_14) / var_123_15

				if arg_120_1.var_.characterEffect1084ui_story and not isNil(var_123_13) then
					local var_123_17 = Mathf.Lerp(0, 0.5, var_123_16)

					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_17
				end
			end

			if arg_120_1.time_ >= var_123_14 + var_123_15 and arg_120_1.time_ < var_123_14 + var_123_15 + arg_123_0 and not isNil(var_123_13) and arg_120_1.var_.characterEffect1084ui_story then
				local var_123_18 = 0.5

				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_18
			end

			local var_123_19 = 0

			if var_123_19 < arg_120_1.time_ and arg_120_1.time_ <= var_123_19 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			local var_123_20 = 0

			if var_123_20 < arg_120_1.time_ and arg_120_1.time_ <= var_123_20 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_21 = 0
			local var_123_22 = 0.35

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_23 = arg_120_1:FormatText(StoryNameCfg[13].name)

				arg_120_1.leftNameTxt_.text = var_123_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_24 = arg_120_1:GetWordFromCfg(305022029)
				local var_123_25 = arg_120_1:FormatText(var_123_24.content)

				arg_120_1.text_.text = var_123_25

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_26 = 14
				local var_123_27 = utf8.len(var_123_25)
				local var_123_28 = var_123_26 <= 0 and var_123_22 or var_123_22 * (var_123_27 / var_123_26)

				if var_123_28 > 0 and var_123_22 < var_123_28 then
					arg_120_1.talkMaxDuration = var_123_28

					if var_123_28 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_28 + var_123_21
					end
				end

				arg_120_1.text_.text = var_123_25
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022029", "story_v_out_305022.awb") ~= 0 then
					local var_123_29 = manager.audio:GetVoiceLength("story_v_out_305022", "305022029", "story_v_out_305022.awb") / 1000

					if var_123_29 + var_123_21 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_29 + var_123_21
					end

					if var_123_24.prefab_name ~= "" and arg_120_1.actors_[var_123_24.prefab_name] ~= nil then
						local var_123_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_24.prefab_name].transform, "story_v_out_305022", "305022029", "story_v_out_305022.awb")

						arg_120_1:RecordAudio("305022029", var_123_30)
						arg_120_1:RecordAudio("305022029", var_123_30)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_305022", "305022029", "story_v_out_305022.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_305022", "305022029", "story_v_out_305022.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_31 = math.max(var_123_22, arg_120_1.talkMaxDuration)

			if var_123_21 <= arg_120_1.time_ and arg_120_1.time_ < var_123_21 + var_123_31 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_21) / var_123_31

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_21 + var_123_31 and arg_120_1.time_ < var_123_21 + var_123_31 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play305022030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 305022030
		arg_124_1.duration_ = 8.6

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play305022031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = "S0406"

			if arg_124_1.bgs_[var_127_0] == nil then
				local var_127_1 = Object.Instantiate(arg_124_1.paintGo_)

				var_127_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_127_0)
				var_127_1.name = var_127_0
				var_127_1.transform.parent = arg_124_1.stage_.transform
				var_127_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.bgs_[var_127_0] = var_127_1
			end

			local var_127_2 = 1.96666666666667

			if var_127_2 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				local var_127_3 = manager.ui.mainCamera.transform.localPosition
				local var_127_4 = Vector3.New(0, 0, 10) + Vector3.New(var_127_3.x, var_127_3.y, 0)
				local var_127_5 = arg_124_1.bgs_.S0406

				var_127_5.transform.localPosition = var_127_4
				var_127_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_6 = var_127_5:GetComponent("SpriteRenderer")

				if var_127_6 and var_127_6.sprite then
					local var_127_7 = (var_127_5.transform.localPosition - var_127_3).z
					local var_127_8 = manager.ui.mainCameraCom_
					local var_127_9 = 2 * var_127_7 * Mathf.Tan(var_127_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_127_10 = var_127_9 * var_127_8.aspect
					local var_127_11 = var_127_6.sprite.bounds.size.x
					local var_127_12 = var_127_6.sprite.bounds.size.y
					local var_127_13 = var_127_10 / var_127_11
					local var_127_14 = var_127_9 / var_127_12
					local var_127_15 = var_127_14 < var_127_13 and var_127_13 or var_127_14

					var_127_5.transform.localScale = Vector3.New(var_127_15, var_127_15, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "S0406" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_16 = 1.999999999999

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_17 = 0.3

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_18 = 0

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_19 = 2

			if var_127_18 <= arg_124_1.time_ and arg_124_1.time_ < var_127_18 + var_127_19 then
				local var_127_20 = (arg_124_1.time_ - var_127_18) / var_127_19
				local var_127_21 = Color.New(0, 0, 0)

				var_127_21.a = Mathf.Lerp(0, 1, var_127_20)
				arg_124_1.mask_.color = var_127_21
			end

			if arg_124_1.time_ >= var_127_18 + var_127_19 and arg_124_1.time_ < var_127_18 + var_127_19 + arg_127_0 then
				local var_127_22 = Color.New(0, 0, 0)

				var_127_22.a = 1
				arg_124_1.mask_.color = var_127_22
			end

			local var_127_23 = 1.999999999999

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_24 = 1.16666666666767

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_24 then
				local var_127_25 = (arg_124_1.time_ - var_127_23) / var_127_24
				local var_127_26 = Color.New(0, 0, 0)

				var_127_26.a = Mathf.Lerp(1, 0, var_127_25)
				arg_124_1.mask_.color = var_127_26
			end

			if arg_124_1.time_ >= var_127_23 + var_127_24 and arg_124_1.time_ < var_127_23 + var_127_24 + arg_127_0 then
				local var_127_27 = Color.New(0, 0, 0)
				local var_127_28 = 0

				arg_124_1.mask_.enabled = false
				var_127_27.a = var_127_28
				arg_124_1.mask_.color = var_127_27
			end

			local var_127_29 = arg_124_1.actors_["1084ui_story"].transform
			local var_127_30 = 1.999999999999

			if var_127_30 < arg_124_1.time_ and arg_124_1.time_ <= var_127_30 + arg_127_0 then
				arg_124_1.var_.moveOldPos1084ui_story = var_127_29.localPosition
			end

			local var_127_31 = 0.001

			if var_127_30 <= arg_124_1.time_ and arg_124_1.time_ < var_127_30 + var_127_31 then
				local var_127_32 = (arg_124_1.time_ - var_127_30) / var_127_31
				local var_127_33 = Vector3.New(0, 100, 0)

				var_127_29.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1084ui_story, var_127_33, var_127_32)

				local var_127_34 = manager.ui.mainCamera.transform.position - var_127_29.position

				var_127_29.forward = Vector3.New(var_127_34.x, var_127_34.y, var_127_34.z)

				local var_127_35 = var_127_29.localEulerAngles

				var_127_35.z = 0
				var_127_35.x = 0
				var_127_29.localEulerAngles = var_127_35
			end

			if arg_124_1.time_ >= var_127_30 + var_127_31 and arg_124_1.time_ < var_127_30 + var_127_31 + arg_127_0 then
				var_127_29.localPosition = Vector3.New(0, 100, 0)

				local var_127_36 = manager.ui.mainCamera.transform.position - var_127_29.position

				var_127_29.forward = Vector3.New(var_127_36.x, var_127_36.y, var_127_36.z)

				local var_127_37 = var_127_29.localEulerAngles

				var_127_37.z = 0
				var_127_37.x = 0
				var_127_29.localEulerAngles = var_127_37
			end

			local var_127_38 = arg_124_1.actors_["1019ui_story"].transform
			local var_127_39 = 1.999999999999

			if var_127_39 < arg_124_1.time_ and arg_124_1.time_ <= var_127_39 + arg_127_0 then
				arg_124_1.var_.moveOldPos1019ui_story = var_127_38.localPosition
			end

			local var_127_40 = 0.001

			if var_127_39 <= arg_124_1.time_ and arg_124_1.time_ < var_127_39 + var_127_40 then
				local var_127_41 = (arg_124_1.time_ - var_127_39) / var_127_40
				local var_127_42 = Vector3.New(0, 100, 0)

				var_127_38.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1019ui_story, var_127_42, var_127_41)

				local var_127_43 = manager.ui.mainCamera.transform.position - var_127_38.position

				var_127_38.forward = Vector3.New(var_127_43.x, var_127_43.y, var_127_43.z)

				local var_127_44 = var_127_38.localEulerAngles

				var_127_44.z = 0
				var_127_44.x = 0
				var_127_38.localEulerAngles = var_127_44
			end

			if arg_124_1.time_ >= var_127_39 + var_127_40 and arg_124_1.time_ < var_127_39 + var_127_40 + arg_127_0 then
				var_127_38.localPosition = Vector3.New(0, 100, 0)

				local var_127_45 = manager.ui.mainCamera.transform.position - var_127_38.position

				var_127_38.forward = Vector3.New(var_127_45.x, var_127_45.y, var_127_45.z)

				local var_127_46 = var_127_38.localEulerAngles

				var_127_46.z = 0
				var_127_46.x = 0
				var_127_38.localEulerAngles = var_127_46
			end

			local var_127_47 = arg_124_1.actors_["1019ui_story"]
			local var_127_48 = 1.999999999999

			if var_127_48 < arg_124_1.time_ and arg_124_1.time_ <= var_127_48 + arg_127_0 and not isNil(var_127_47) and arg_124_1.var_.characterEffect1019ui_story == nil then
				arg_124_1.var_.characterEffect1019ui_story = var_127_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_49 = 0.200000002980232

			if var_127_48 <= arg_124_1.time_ and arg_124_1.time_ < var_127_48 + var_127_49 and not isNil(var_127_47) then
				local var_127_50 = (arg_124_1.time_ - var_127_48) / var_127_49

				if arg_124_1.var_.characterEffect1019ui_story and not isNil(var_127_47) then
					local var_127_51 = Mathf.Lerp(0, 0.5, var_127_50)

					arg_124_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1019ui_story.fillRatio = var_127_51
				end
			end

			if arg_124_1.time_ >= var_127_48 + var_127_49 and arg_124_1.time_ < var_127_48 + var_127_49 + arg_127_0 and not isNil(var_127_47) and arg_124_1.var_.characterEffect1019ui_story then
				local var_127_52 = 0.5

				arg_124_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1019ui_story.fillRatio = var_127_52
			end

			local var_127_53 = arg_124_1.bgs_.S0406.transform
			local var_127_54 = 2

			if var_127_54 < arg_124_1.time_ and arg_124_1.time_ <= var_127_54 + arg_127_0 then
				arg_124_1.var_.moveOldPosS0406 = var_127_53.localPosition
			end

			local var_127_55 = 2

			if var_127_54 <= arg_124_1.time_ and arg_124_1.time_ < var_127_54 + var_127_55 then
				local var_127_56 = (arg_124_1.time_ - var_127_54) / var_127_55
				local var_127_57 = Vector3.New(0, 1.09, 9)

				var_127_53.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPosS0406, var_127_57, var_127_56)
			end

			if arg_124_1.time_ >= var_127_54 + var_127_55 and arg_124_1.time_ < var_127_54 + var_127_55 + arg_127_0 then
				var_127_53.localPosition = Vector3.New(0, 1.09, 9)
			end

			local var_127_58 = 2.86666666666667

			if var_127_58 < arg_124_1.time_ and arg_124_1.time_ <= var_127_58 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_59 = 1

			if arg_124_1.time_ >= var_127_58 + var_127_59 and arg_124_1.time_ < var_127_58 + var_127_59 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_60 = 1.4
			local var_127_61 = 1

			if var_127_60 < arg_124_1.time_ and arg_124_1.time_ <= var_127_60 + arg_127_0 then
				local var_127_62 = "play"
				local var_127_63 = "effect"

				arg_124_1:AudioAction(var_127_62, var_127_63, "se_story_16", "se_story_16_door02", "")
			end

			local var_127_64 = 1.2
			local var_127_65 = 1

			if var_127_64 < arg_124_1.time_ and arg_124_1.time_ <= var_127_64 + arg_127_0 then
				local var_127_66 = "play"
				local var_127_67 = "effect"

				arg_124_1:AudioAction(var_127_66, var_127_67, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_127_68 = 0.2
			local var_127_69 = 1

			if var_127_68 < arg_124_1.time_ and arg_124_1.time_ <= var_127_68 + arg_127_0 then
				local var_127_70 = "stop"
				local var_127_71 = "effect"

				arg_124_1:AudioAction(var_127_70, var_127_71, "se_story_143", "se_story_143_amb_lift", "")
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_72 = 3.6
			local var_127_73 = 1.55

			if var_127_72 < arg_124_1.time_ and arg_124_1.time_ <= var_127_72 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_74 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_74:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_75 = arg_124_1:GetWordFromCfg(305022030)
				local var_127_76 = arg_124_1:FormatText(var_127_75.content)

				arg_124_1.text_.text = var_127_76

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_77 = 62
				local var_127_78 = utf8.len(var_127_76)
				local var_127_79 = var_127_77 <= 0 and var_127_73 or var_127_73 * (var_127_78 / var_127_77)

				if var_127_79 > 0 and var_127_73 < var_127_79 then
					arg_124_1.talkMaxDuration = var_127_79
					var_127_72 = var_127_72 + 0.3

					if var_127_79 + var_127_72 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_79 + var_127_72
					end
				end

				arg_124_1.text_.text = var_127_76
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_80 = var_127_72 + 0.3
			local var_127_81 = math.max(var_127_73, arg_124_1.talkMaxDuration)

			if var_127_80 <= arg_124_1.time_ and arg_124_1.time_ < var_127_80 + var_127_81 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_80) / var_127_81

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_80 + var_127_81 and arg_124_1.time_ < var_127_80 + var_127_81 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 6.23),
					endPos = Vector3.New(0, 1.09, 9),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play305022031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 305022031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play305022032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.925

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(305022031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 37
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play305022032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 305022032
		arg_134_1.duration_ = 4.4

		local var_134_0 = {
			zh = 4.4,
			ja = 1.333
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
				arg_134_0:Play305022033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1084ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_137_4 = 0
			local var_137_5 = 0.375

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_6 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_7 = arg_134_1:GetWordFromCfg(305022032)
				local var_137_8 = arg_134_1:FormatText(var_137_7.content)

				arg_134_1.text_.text = var_137_8

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022032", "story_v_out_305022.awb") ~= 0 then
					local var_137_12 = manager.audio:GetVoiceLength("story_v_out_305022", "305022032", "story_v_out_305022.awb") / 1000

					if var_137_12 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_12 + var_137_4
					end

					if var_137_7.prefab_name ~= "" and arg_134_1.actors_[var_137_7.prefab_name] ~= nil then
						local var_137_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_7.prefab_name].transform, "story_v_out_305022", "305022032", "story_v_out_305022.awb")

						arg_134_1:RecordAudio("305022032", var_137_13)
						arg_134_1:RecordAudio("305022032", var_137_13)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_305022", "305022032", "story_v_out_305022.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_305022", "305022032", "story_v_out_305022.awb")
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
	Play305022033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 305022033
		arg_138_1.duration_ = 11.17

		local var_138_0 = {
			zh = 6.133,
			ja = 11.166
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
				arg_138_0:Play305022034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1011ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1011ui_story == nil then
				arg_138_1.var_.characterEffect1011ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1011ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1011ui_story then
				arg_138_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1084ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.200000002980232

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1084ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_9
			end

			local var_141_10 = 0
			local var_141_11 = 0.7

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_12 = arg_138_1:FormatText(StoryNameCfg[37].name)

				arg_138_1.leftNameTxt_.text = var_141_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011_split_5")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_13 = arg_138_1:GetWordFromCfg(305022033)
				local var_141_14 = arg_138_1:FormatText(var_141_13.content)

				arg_138_1.text_.text = var_141_14

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_15 = 28
				local var_141_16 = utf8.len(var_141_14)
				local var_141_17 = var_141_15 <= 0 and var_141_11 or var_141_11 * (var_141_16 / var_141_15)

				if var_141_17 > 0 and var_141_11 < var_141_17 then
					arg_138_1.talkMaxDuration = var_141_17

					if var_141_17 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_10
					end
				end

				arg_138_1.text_.text = var_141_14
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022033", "story_v_out_305022.awb") ~= 0 then
					local var_141_18 = manager.audio:GetVoiceLength("story_v_out_305022", "305022033", "story_v_out_305022.awb") / 1000

					if var_141_18 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_18 + var_141_10
					end

					if var_141_13.prefab_name ~= "" and arg_138_1.actors_[var_141_13.prefab_name] ~= nil then
						local var_141_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_13.prefab_name].transform, "story_v_out_305022", "305022033", "story_v_out_305022.awb")

						arg_138_1:RecordAudio("305022033", var_141_19)
						arg_138_1:RecordAudio("305022033", var_141_19)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_305022", "305022033", "story_v_out_305022.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_305022", "305022033", "story_v_out_305022.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_20 = math.max(var_141_11, arg_138_1.talkMaxDuration)

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_20 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_10) / var_141_20

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_10 + var_141_20 and arg_138_1.time_ < var_141_10 + var_141_20 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play305022034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 305022034
		arg_142_1.duration_ = 5.4

		local var_142_0 = {
			zh = 4.4,
			ja = 5.4
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
				arg_142_0:Play305022035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.375

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[37].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011_split_5")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(305022034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022034", "story_v_out_305022.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_305022", "305022034", "story_v_out_305022.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_305022", "305022034", "story_v_out_305022.awb")

						arg_142_1:RecordAudio("305022034", var_145_9)
						arg_142_1:RecordAudio("305022034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_305022", "305022034", "story_v_out_305022.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_305022", "305022034", "story_v_out_305022.awb")
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
	Play305022035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 305022035
		arg_146_1.duration_ = 10.73

		local var_146_0 = {
			zh = 10.733,
			ja = 8.1
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
				arg_146_0:Play305022036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1011ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1011ui_story == nil then
				arg_146_1.var_.characterEffect1011ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1011ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1011ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1011ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1011ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 0.675

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[49].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_9 = arg_146_1:GetWordFromCfg(305022035)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 27
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022035", "story_v_out_305022.awb") ~= 0 then
					local var_149_14 = manager.audio:GetVoiceLength("story_v_out_305022", "305022035", "story_v_out_305022.awb") / 1000

					if var_149_14 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_6
					end

					if var_149_9.prefab_name ~= "" and arg_146_1.actors_[var_149_9.prefab_name] ~= nil then
						local var_149_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_9.prefab_name].transform, "story_v_out_305022", "305022035", "story_v_out_305022.awb")

						arg_146_1:RecordAudio("305022035", var_149_15)
						arg_146_1:RecordAudio("305022035", var_149_15)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_305022", "305022035", "story_v_out_305022.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_305022", "305022035", "story_v_out_305022.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_16 and arg_146_1.time_ < var_149_6 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play305022036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 305022036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play305022037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 1.325

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(305022036)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 53
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play305022037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 305022037
		arg_154_1.duration_ = 7.47

		local var_154_0 = {
			zh = 7.466,
			ja = 7.4
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
				arg_154_0:Play305022038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.675

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[49].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:GetWordFromCfg(305022037)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022037", "story_v_out_305022.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_305022", "305022037", "story_v_out_305022.awb") / 1000

					if var_157_8 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_0
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_305022", "305022037", "story_v_out_305022.awb")

						arg_154_1:RecordAudio("305022037", var_157_9)
						arg_154_1:RecordAudio("305022037", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_305022", "305022037", "story_v_out_305022.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_305022", "305022037", "story_v_out_305022.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_10 and arg_154_1.time_ < var_157_0 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play305022038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 305022038
		arg_158_1.duration_ = 8.23

		local var_158_0 = {
			zh = 7.133,
			ja = 8.233
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
			arg_158_1.auto_ = false
		end

		function arg_158_1.playNext_(arg_160_0)
			arg_158_1.onStoryFinished_()
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.45

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[49].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:GetWordFromCfg(305022038)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_305022", "305022038", "story_v_out_305022.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_305022", "305022038", "story_v_out_305022.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_305022", "305022038", "story_v_out_305022.awb")

						arg_158_1:RecordAudio("305022038", var_161_9)
						arg_158_1:RecordAudio("305022038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_305022", "305022038", "story_v_out_305022.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_305022", "305022038", "story_v_out_305022.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10d",
		"TextureConfig/Background/B07a",
		"TextureConfig/Background/S0406"
	},
	voices = {
		"story_v_out_305022.awb"
	}
}
