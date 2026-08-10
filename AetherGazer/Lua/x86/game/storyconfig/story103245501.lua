return {
	Play324551001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324551001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324551002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J27g"

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
				local var_4_5 = arg_1_1.bgs_.J27g

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
					if iter_4_0 ~= "J27g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_150", "se_story_150_huatian", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

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
			local var_4_39 = 1.6

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

				local var_4_41 = arg_1_1:GetWordFromCfg(324551001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 64
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
	Play324551002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324551002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324551003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.975

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

				local var_11_2 = arg_8_1:GetWordFromCfg(324551002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 39
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
	Play324551003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324551003
		arg_12_1.duration_ = 2

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324551004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1071ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1071ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1071ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0, -1.05, -6.2)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1071ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1071ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1071ui_story == nil then
				arg_12_1.var_.characterEffect1071ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1071ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1071ui_story then
				arg_12_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_15_20 = 0
			local var_15_21 = 0.125

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[384].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(324551003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551003", "story_v_out_324551.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_out_324551", "324551003", "story_v_out_324551.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_out_324551", "324551003", "story_v_out_324551.awb")

						arg_12_1:RecordAudio("324551003", var_15_29)
						arg_12_1:RecordAudio("324551003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324551", "324551003", "story_v_out_324551.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324551", "324551003", "story_v_out_324551.awb")
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
				actorName = "1071ui_story",
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
	Play324551004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324551004
		arg_16_1.duration_ = 3

		local var_16_0 = {
			zh = 2.266,
			ja = 3
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
				arg_16_0:Play324551005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "6148ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["6148ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(-0.7, -0.985, -6)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14

				local var_19_15 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_15 then
					var_19_15:EnableDynamicBone(true)
				end
			end

			local var_19_16 = arg_16_1.actors_["1071ui_story"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos1071ui_story = var_19_16.localPosition
			end

			local var_19_18 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18
				local var_19_20 = Vector3.New(0, 100, 0)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1071ui_story, var_19_20, var_19_19)

				local var_19_21 = manager.ui.mainCamera.transform.position - var_19_16.position

				var_19_16.forward = Vector3.New(var_19_21.x, var_19_21.y, var_19_21.z)

				local var_19_22 = var_19_16.localEulerAngles

				var_19_22.z = 0
				var_19_22.x = 0
				var_19_16.localEulerAngles = var_19_22
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(0, 100, 0)

				local var_19_23 = manager.ui.mainCamera.transform.position - var_19_16.position

				var_19_16.forward = Vector3.New(var_19_23.x, var_19_23.y, var_19_23.z)

				local var_19_24 = var_19_16.localEulerAngles

				var_19_24.z = 0
				var_19_24.x = 0
				var_19_16.localEulerAngles = var_19_24
			end

			local var_19_25 = arg_16_1.actors_["6148ui_story"]
			local var_19_26 = 0

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 and not isNil(var_19_25) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_27 = 0.200000002980232

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_27 and not isNil(var_19_25) then
				local var_19_28 = (arg_16_1.time_ - var_19_26) / var_19_27

				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_25) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_26 + var_19_27 and arg_16_1.time_ < var_19_26 + var_19_27 + arg_19_0 and not isNil(var_19_25) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_19_29 = arg_16_1.actors_["1071ui_story"]
			local var_19_30 = 0

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 and not isNil(var_19_29) and arg_16_1.var_.characterEffect1071ui_story == nil then
				arg_16_1.var_.characterEffect1071ui_story = var_19_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_31 = 0.200000002980232

			if var_19_30 <= arg_16_1.time_ and arg_16_1.time_ < var_19_30 + var_19_31 and not isNil(var_19_29) then
				local var_19_32 = (arg_16_1.time_ - var_19_30) / var_19_31

				if arg_16_1.var_.characterEffect1071ui_story and not isNil(var_19_29) then
					local var_19_33 = Mathf.Lerp(0, 0.5, var_19_32)

					arg_16_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1071ui_story.fillRatio = var_19_33
				end
			end

			if arg_16_1.time_ >= var_19_30 + var_19_31 and arg_16_1.time_ < var_19_30 + var_19_31 + arg_19_0 and not isNil(var_19_29) and arg_16_1.var_.characterEffect1071ui_story then
				local var_19_34 = 0.5

				arg_16_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1071ui_story.fillRatio = var_19_34
			end

			local var_19_35 = 0

			if var_19_35 < arg_16_1.time_ and arg_16_1.time_ <= var_19_35 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_19_36 = 0

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_37 = 0
			local var_19_38 = 0.25

			if var_19_37 < arg_16_1.time_ and arg_16_1.time_ <= var_19_37 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_39 = arg_16_1:FormatText(StoryNameCfg[1488].name)

				arg_16_1.leftNameTxt_.text = var_19_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_40 = arg_16_1:GetWordFromCfg(324551004)
				local var_19_41 = arg_16_1:FormatText(var_19_40.content)

				arg_16_1.text_.text = var_19_41

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_42 = 10
				local var_19_43 = utf8.len(var_19_41)
				local var_19_44 = var_19_42 <= 0 and var_19_38 or var_19_38 * (var_19_43 / var_19_42)

				if var_19_44 > 0 and var_19_38 < var_19_44 then
					arg_16_1.talkMaxDuration = var_19_44

					if var_19_44 + var_19_37 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_44 + var_19_37
					end
				end

				arg_16_1.text_.text = var_19_41
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551004", "story_v_out_324551.awb") ~= 0 then
					local var_19_45 = manager.audio:GetVoiceLength("story_v_out_324551", "324551004", "story_v_out_324551.awb") / 1000

					if var_19_45 + var_19_37 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_45 + var_19_37
					end

					if var_19_40.prefab_name ~= "" and arg_16_1.actors_[var_19_40.prefab_name] ~= nil then
						local var_19_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_40.prefab_name].transform, "story_v_out_324551", "324551004", "story_v_out_324551.awb")

						arg_16_1:RecordAudio("324551004", var_19_46)
						arg_16_1:RecordAudio("324551004", var_19_46)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324551", "324551004", "story_v_out_324551.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324551", "324551004", "story_v_out_324551.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_47 = math.max(var_19_38, arg_16_1.talkMaxDuration)

			if var_19_37 <= arg_16_1.time_ and arg_16_1.time_ < var_19_37 + var_19_47 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_37) / var_19_47

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_37 + var_19_47 and arg_16_1.time_ < var_19_37 + var_19_47 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play324551005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324551005
		arg_20_1.duration_ = 5.37

		local var_20_0 = {
			zh = 3.6,
			ja = 5.366
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
				arg_20_0:Play324551006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1054ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["1054ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1054ui_story = var_23_5.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_6) / var_23_8
				local var_23_10 = Vector3.New(0.7, -0.985, -6)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1054ui_story, var_23_10, var_23_9)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_5.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_5.localEulerAngles = var_23_12
			end

			if arg_20_1.time_ >= var_23_6 + var_23_8 and arg_20_1.time_ < var_23_6 + var_23_8 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_23_13 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_13.x, var_23_13.y, var_23_13.z)

				local var_23_14 = var_23_5.localEulerAngles

				var_23_14.z = 0
				var_23_14.x = 0
				var_23_5.localEulerAngles = var_23_14

				local var_23_15 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_15 then
					var_23_15:EnableDynamicBone(true)
				end
			end

			local var_23_16 = arg_20_1.actors_["1054ui_story"]
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1054ui_story == nil then
				arg_20_1.var_.characterEffect1054ui_story = var_23_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_18 = 0.200000002980232

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_18 and not isNil(var_23_16) then
				local var_23_19 = (arg_20_1.time_ - var_23_17) / var_23_18

				if arg_20_1.var_.characterEffect1054ui_story and not isNil(var_23_16) then
					arg_20_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1054ui_story then
				arg_20_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_23_20 = arg_20_1.actors_["6148ui_story"]
			local var_23_21 = 0

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect6148ui_story == nil then
				arg_20_1.var_.characterEffect6148ui_story = var_23_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_22 = 0.200000002980232

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 and not isNil(var_23_20) then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22

				if arg_20_1.var_.characterEffect6148ui_story and not isNil(var_23_20) then
					local var_23_24 = Mathf.Lerp(0, 0.5, var_23_23)

					arg_20_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect6148ui_story.fillRatio = var_23_24
				end
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect6148ui_story then
				local var_23_25 = 0.5

				arg_20_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect6148ui_story.fillRatio = var_23_25
			end

			local var_23_26 = 0

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				arg_20_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_23_27 = 0

			if var_23_27 < arg_20_1.time_ and arg_20_1.time_ <= var_23_27 + arg_23_0 then
				arg_20_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_23_28 = 0
			local var_23_29 = 0.325

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_30 = arg_20_1:FormatText(StoryNameCfg[1487].name)

				arg_20_1.leftNameTxt_.text = var_23_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_31 = arg_20_1:GetWordFromCfg(324551005)
				local var_23_32 = arg_20_1:FormatText(var_23_31.content)

				arg_20_1.text_.text = var_23_32

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_33 = 13
				local var_23_34 = utf8.len(var_23_32)
				local var_23_35 = var_23_33 <= 0 and var_23_29 or var_23_29 * (var_23_34 / var_23_33)

				if var_23_35 > 0 and var_23_29 < var_23_35 then
					arg_20_1.talkMaxDuration = var_23_35

					if var_23_35 + var_23_28 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_35 + var_23_28
					end
				end

				arg_20_1.text_.text = var_23_32
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551005", "story_v_out_324551.awb") ~= 0 then
					local var_23_36 = manager.audio:GetVoiceLength("story_v_out_324551", "324551005", "story_v_out_324551.awb") / 1000

					if var_23_36 + var_23_28 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_36 + var_23_28
					end

					if var_23_31.prefab_name ~= "" and arg_20_1.actors_[var_23_31.prefab_name] ~= nil then
						local var_23_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_31.prefab_name].transform, "story_v_out_324551", "324551005", "story_v_out_324551.awb")

						arg_20_1:RecordAudio("324551005", var_23_37)
						arg_20_1:RecordAudio("324551005", var_23_37)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324551", "324551005", "story_v_out_324551.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324551", "324551005", "story_v_out_324551.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_38 = math.max(var_23_29, arg_20_1.talkMaxDuration)

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_38 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_28) / var_23_38

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_28 + var_23_38 and arg_20_1.time_ < var_23_28 + var_23_38 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324551006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324551006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324551007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["6148ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos6148ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6148ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["1054ui_story"].transform
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = var_27_11.localPosition

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(false)
				end
			end

			local var_27_14 = 0.001

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_14 then
				local var_27_15 = (arg_24_1.time_ - var_27_12) / var_27_14
				local var_27_16 = Vector3.New(0, 100, 0)

				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, var_27_16, var_27_15)

				local var_27_17 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_17.x, var_27_17.y, var_27_17.z)

				local var_27_18 = var_27_11.localEulerAngles

				var_27_18.z = 0
				var_27_18.x = 0
				var_27_11.localEulerAngles = var_27_18
			end

			if arg_24_1.time_ >= var_27_12 + var_27_14 and arg_24_1.time_ < var_27_12 + var_27_14 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(0, 100, 0)

				local var_27_19 = manager.ui.mainCamera.transform.position - var_27_11.position

				var_27_11.forward = Vector3.New(var_27_19.x, var_27_19.y, var_27_19.z)

				local var_27_20 = var_27_11.localEulerAngles

				var_27_20.z = 0
				var_27_20.x = 0
				var_27_11.localEulerAngles = var_27_20

				local var_27_21 = GameObjectTools.GetOrAddComponent(var_27_11.gameObject, typeof(DynamicBoneHelper))

				if var_27_21 then
					var_27_21:EnableDynamicBone(true)
				end
			end

			local var_27_22 = arg_24_1.actors_["1054ui_story"]
			local var_27_23 = 0

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 and not isNil(var_27_22) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_24 = 0.200000002980232

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 and not isNil(var_27_22) then
				local var_27_25 = (arg_24_1.time_ - var_27_23) / var_27_24

				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_22) then
					local var_27_26 = Mathf.Lerp(0, 0.5, var_27_25)

					arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1054ui_story.fillRatio = var_27_26
				end
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 and not isNil(var_27_22) and arg_24_1.var_.characterEffect1054ui_story then
				local var_27_27 = 0.5

				arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1054ui_story.fillRatio = var_27_27
			end

			local var_27_28 = 0
			local var_27_29 = 0.75

			if var_27_28 < arg_24_1.time_ and arg_24_1.time_ <= var_27_28 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_30 = arg_24_1:GetWordFromCfg(324551006)
				local var_27_31 = arg_24_1:FormatText(var_27_30.content)

				arg_24_1.text_.text = var_27_31

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_32 = 30
				local var_27_33 = utf8.len(var_27_31)
				local var_27_34 = var_27_32 <= 0 and var_27_29 or var_27_29 * (var_27_33 / var_27_32)

				if var_27_34 > 0 and var_27_29 < var_27_34 then
					arg_24_1.talkMaxDuration = var_27_34

					if var_27_34 + var_27_28 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_28
					end
				end

				arg_24_1.text_.text = var_27_31
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_35 = math.max(var_27_29, arg_24_1.talkMaxDuration)

			if var_27_28 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_35 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_28) / var_27_35

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_28 + var_27_35 and arg_24_1.time_ < var_27_28 + var_27_35 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324551007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324551007
		arg_28_1.duration_ = 3.1

		local var_28_0 = {
			zh = 2.2,
			ja = 3.1
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
				arg_28_0:Play324551008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1075ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1075ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1075ui_story = var_31_5.localPosition
			end

			local var_31_7 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7
				local var_31_9 = Vector3.New(0, -1.055, -6.16)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1075ui_story, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_5.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_5.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_31_12 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_12.x, var_31_12.y, var_31_12.z)

				local var_31_13 = var_31_5.localEulerAngles

				var_31_13.z = 0
				var_31_13.x = 0
				var_31_5.localEulerAngles = var_31_13
			end

			local var_31_14 = arg_28_1.actors_["1075ui_story"]
			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 and not isNil(var_31_14) and arg_28_1.var_.characterEffect1075ui_story == nil then
				arg_28_1.var_.characterEffect1075ui_story = var_31_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_16 = 0.200000002980232

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_16 and not isNil(var_31_14) then
				local var_31_17 = (arg_28_1.time_ - var_31_15) / var_31_16

				if arg_28_1.var_.characterEffect1075ui_story and not isNil(var_31_14) then
					arg_28_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_15 + var_31_16 and arg_28_1.time_ < var_31_15 + var_31_16 + arg_31_0 and not isNil(var_31_14) and arg_28_1.var_.characterEffect1075ui_story then
				arg_28_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_31_18 = 0

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_31_20 = 0
			local var_31_21 = 0.2

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_22 = arg_28_1:FormatText(StoryNameCfg[381].name)

				arg_28_1.leftNameTxt_.text = var_31_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_23 = arg_28_1:GetWordFromCfg(324551007)
				local var_31_24 = arg_28_1:FormatText(var_31_23.content)

				arg_28_1.text_.text = var_31_24

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_25 = 8
				local var_31_26 = utf8.len(var_31_24)
				local var_31_27 = var_31_25 <= 0 and var_31_21 or var_31_21 * (var_31_26 / var_31_25)

				if var_31_27 > 0 and var_31_21 < var_31_27 then
					arg_28_1.talkMaxDuration = var_31_27

					if var_31_27 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_27 + var_31_20
					end
				end

				arg_28_1.text_.text = var_31_24
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551007", "story_v_out_324551.awb") ~= 0 then
					local var_31_28 = manager.audio:GetVoiceLength("story_v_out_324551", "324551007", "story_v_out_324551.awb") / 1000

					if var_31_28 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_20
					end

					if var_31_23.prefab_name ~= "" and arg_28_1.actors_[var_31_23.prefab_name] ~= nil then
						local var_31_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_23.prefab_name].transform, "story_v_out_324551", "324551007", "story_v_out_324551.awb")

						arg_28_1:RecordAudio("324551007", var_31_29)
						arg_28_1:RecordAudio("324551007", var_31_29)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324551", "324551007", "story_v_out_324551.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324551", "324551007", "story_v_out_324551.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = math.max(var_31_21, arg_28_1.talkMaxDuration)

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_20) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_20 + var_31_30 and arg_28_1.time_ < var_31_20 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324551008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324551008
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324551009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["6148ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos6148ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0.7, -0.985, -6)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6148ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["1075ui_story"].transform
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.var_.moveOldPos1075ui_story = var_35_11.localPosition
			end

			local var_35_13 = 0.001

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_13 then
				local var_35_14 = (arg_32_1.time_ - var_35_12) / var_35_13
				local var_35_15 = Vector3.New(-0.7, -1.055, -6.16)

				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1075ui_story, var_35_15, var_35_14)

				local var_35_16 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_16.x, var_35_16.y, var_35_16.z)

				local var_35_17 = var_35_11.localEulerAngles

				var_35_17.z = 0
				var_35_17.x = 0
				var_35_11.localEulerAngles = var_35_17
			end

			if arg_32_1.time_ >= var_35_12 + var_35_13 and arg_32_1.time_ < var_35_12 + var_35_13 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_35_18 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_18.x, var_35_18.y, var_35_18.z)

				local var_35_19 = var_35_11.localEulerAngles

				var_35_19.z = 0
				var_35_19.x = 0
				var_35_11.localEulerAngles = var_35_19
			end

			local var_35_20 = arg_32_1.actors_["6148ui_story"]
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 and not isNil(var_35_20) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_22 = 0.200000002980232

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 and not isNil(var_35_20) then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22

				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_20) then
					arg_32_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 and not isNil(var_35_20) and arg_32_1.var_.characterEffect6148ui_story then
				arg_32_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_35_24 = arg_32_1.actors_["1075ui_story"]
			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 and not isNil(var_35_24) and arg_32_1.var_.characterEffect1075ui_story == nil then
				arg_32_1.var_.characterEffect1075ui_story = var_35_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_26 = 0.200000002980232

			if var_35_25 <= arg_32_1.time_ and arg_32_1.time_ < var_35_25 + var_35_26 and not isNil(var_35_24) then
				local var_35_27 = (arg_32_1.time_ - var_35_25) / var_35_26

				if arg_32_1.var_.characterEffect1075ui_story and not isNil(var_35_24) then
					local var_35_28 = Mathf.Lerp(0, 0.5, var_35_27)

					arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1075ui_story.fillRatio = var_35_28
				end
			end

			if arg_32_1.time_ >= var_35_25 + var_35_26 and arg_32_1.time_ < var_35_25 + var_35_26 + arg_35_0 and not isNil(var_35_24) and arg_32_1.var_.characterEffect1075ui_story then
				local var_35_29 = 0.5

				arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1075ui_story.fillRatio = var_35_29
			end

			local var_35_30 = 0

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 then
				arg_32_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			local var_35_31 = 0

			if var_35_31 < arg_32_1.time_ and arg_32_1.time_ <= var_35_31 + arg_35_0 then
				arg_32_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_35_32 = 0
			local var_35_33 = 0.225

			if var_35_32 < arg_32_1.time_ and arg_32_1.time_ <= var_35_32 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_34 = arg_32_1:FormatText(StoryNameCfg[1488].name)

				arg_32_1.leftNameTxt_.text = var_35_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_35 = arg_32_1:GetWordFromCfg(324551008)
				local var_35_36 = arg_32_1:FormatText(var_35_35.content)

				arg_32_1.text_.text = var_35_36

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_37 = 9
				local var_35_38 = utf8.len(var_35_36)
				local var_35_39 = var_35_37 <= 0 and var_35_33 or var_35_33 * (var_35_38 / var_35_37)

				if var_35_39 > 0 and var_35_33 < var_35_39 then
					arg_32_1.talkMaxDuration = var_35_39

					if var_35_39 + var_35_32 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_39 + var_35_32
					end
				end

				arg_32_1.text_.text = var_35_36
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551008", "story_v_out_324551.awb") ~= 0 then
					local var_35_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551008", "story_v_out_324551.awb") / 1000

					if var_35_40 + var_35_32 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_40 + var_35_32
					end

					if var_35_35.prefab_name ~= "" and arg_32_1.actors_[var_35_35.prefab_name] ~= nil then
						local var_35_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_35.prefab_name].transform, "story_v_out_324551", "324551008", "story_v_out_324551.awb")

						arg_32_1:RecordAudio("324551008", var_35_41)
						arg_32_1:RecordAudio("324551008", var_35_41)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324551", "324551008", "story_v_out_324551.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324551", "324551008", "story_v_out_324551.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_42 = math.max(var_35_33, arg_32_1.talkMaxDuration)

			if var_35_32 <= arg_32_1.time_ and arg_32_1.time_ < var_35_32 + var_35_42 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_32) / var_35_42

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_32 + var_35_42 and arg_32_1.time_ < var_35_32 + var_35_42 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324551009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324551009
		arg_36_1.duration_ = 3.7

		local var_36_0 = {
			zh = 3,
			ja = 3.7
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
				arg_36_0:Play324551010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1075ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1075ui_story == nil then
				arg_36_1.var_.characterEffect1075ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1075ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1075ui_story then
				arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["6148ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect6148ui_story == nil then
				arg_36_1.var_.characterEffect6148ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect6148ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_36_1.var_.characterEffect6148ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect6148ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_36_1.var_.characterEffect6148ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.575

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[381].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(324551009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551009", "story_v_out_324551.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_324551", "324551009", "story_v_out_324551.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_324551", "324551009", "story_v_out_324551.awb")

						arg_36_1:RecordAudio("324551009", var_39_21)
						arg_36_1:RecordAudio("324551009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324551", "324551009", "story_v_out_324551.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324551", "324551009", "story_v_out_324551.awb")
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
	Play324551010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324551010
		arg_40_1.duration_ = 5.73

		local var_40_0 = {
			zh = 4.733,
			ja = 5.733
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
				arg_40_0:Play324551011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["6148ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = var_43_0.localPosition

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end
			end

			local var_43_3 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_3 then
				local var_43_4 = (arg_40_1.time_ - var_43_1) / var_43_3
				local var_43_5 = Vector3.New(0.7, -0.985, -6)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, var_43_5, var_43_4)

				local var_43_6 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_6.x, var_43_6.y, var_43_6.z)

				local var_43_7 = var_43_0.localEulerAngles

				var_43_7.z = 0
				var_43_7.x = 0
				var_43_0.localEulerAngles = var_43_7
			end

			if arg_40_1.time_ >= var_43_1 + var_43_3 and arg_40_1.time_ < var_43_1 + var_43_3 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_43_8 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_8.x, var_43_8.y, var_43_8.z)

				local var_43_9 = var_43_0.localEulerAngles

				var_43_9.z = 0
				var_43_9.x = 0
				var_43_0.localEulerAngles = var_43_9

				local var_43_10 = GameObjectTools.GetOrAddComponent(var_43_0.gameObject, typeof(DynamicBoneHelper))

				if var_43_10 then
					var_43_10:EnableDynamicBone(true)
				end
			end

			local var_43_11 = arg_40_1.actors_["1054ui_story"].transform
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = var_43_11.localPosition

				local var_43_13 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_13 then
					var_43_13:EnableDynamicBone(false)
				end
			end

			local var_43_14 = 0.001

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_14 then
				local var_43_15 = (arg_40_1.time_ - var_43_12) / var_43_14
				local var_43_16 = Vector3.New(-0.7, -0.985, -6)

				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, var_43_16, var_43_15)

				local var_43_17 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_17.x, var_43_17.y, var_43_17.z)

				local var_43_18 = var_43_11.localEulerAngles

				var_43_18.z = 0
				var_43_18.x = 0
				var_43_11.localEulerAngles = var_43_18
			end

			if arg_40_1.time_ >= var_43_12 + var_43_14 and arg_40_1.time_ < var_43_12 + var_43_14 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_43_19 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_19.x, var_43_19.y, var_43_19.z)

				local var_43_20 = var_43_11.localEulerAngles

				var_43_20.z = 0
				var_43_20.x = 0
				var_43_11.localEulerAngles = var_43_20

				local var_43_21 = GameObjectTools.GetOrAddComponent(var_43_11.gameObject, typeof(DynamicBoneHelper))

				if var_43_21 then
					var_43_21:EnableDynamicBone(true)
				end
			end

			local var_43_22 = arg_40_1.actors_["1054ui_story"]
			local var_43_23 = 0

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 and not isNil(var_43_22) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_24 = 0.200000002980232

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_24 and not isNil(var_43_22) then
				local var_43_25 = (arg_40_1.time_ - var_43_23) / var_43_24

				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_22) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_23 + var_43_24 and arg_40_1.time_ < var_43_23 + var_43_24 + arg_43_0 and not isNil(var_43_22) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_43_26 = arg_40_1.actors_["1075ui_story"]
			local var_43_27 = 0

			if var_43_27 < arg_40_1.time_ and arg_40_1.time_ <= var_43_27 + arg_43_0 and not isNil(var_43_26) and arg_40_1.var_.characterEffect1075ui_story == nil then
				arg_40_1.var_.characterEffect1075ui_story = var_43_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_28 = 0.200000002980232

			if var_43_27 <= arg_40_1.time_ and arg_40_1.time_ < var_43_27 + var_43_28 and not isNil(var_43_26) then
				local var_43_29 = (arg_40_1.time_ - var_43_27) / var_43_28

				if arg_40_1.var_.characterEffect1075ui_story and not isNil(var_43_26) then
					local var_43_30 = Mathf.Lerp(0, 0.5, var_43_29)

					arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1075ui_story.fillRatio = var_43_30
				end
			end

			if arg_40_1.time_ >= var_43_27 + var_43_28 and arg_40_1.time_ < var_43_27 + var_43_28 + arg_43_0 and not isNil(var_43_26) and arg_40_1.var_.characterEffect1075ui_story then
				local var_43_31 = 0.5

				arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1075ui_story.fillRatio = var_43_31
			end

			local var_43_32 = 0

			if var_43_32 < arg_40_1.time_ and arg_40_1.time_ <= var_43_32 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action432")
			end

			local var_43_33 = 0

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_43_34 = arg_40_1.actors_["1075ui_story"].transform
			local var_43_35 = 0

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1.var_.moveOldPos1075ui_story = var_43_34.localPosition
			end

			local var_43_36 = 0.001

			if var_43_35 <= arg_40_1.time_ and arg_40_1.time_ < var_43_35 + var_43_36 then
				local var_43_37 = (arg_40_1.time_ - var_43_35) / var_43_36
				local var_43_38 = Vector3.New(0, 100, 0)

				var_43_34.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1075ui_story, var_43_38, var_43_37)

				local var_43_39 = manager.ui.mainCamera.transform.position - var_43_34.position

				var_43_34.forward = Vector3.New(var_43_39.x, var_43_39.y, var_43_39.z)

				local var_43_40 = var_43_34.localEulerAngles

				var_43_40.z = 0
				var_43_40.x = 0
				var_43_34.localEulerAngles = var_43_40
			end

			if arg_40_1.time_ >= var_43_35 + var_43_36 and arg_40_1.time_ < var_43_35 + var_43_36 + arg_43_0 then
				var_43_34.localPosition = Vector3.New(0, 100, 0)

				local var_43_41 = manager.ui.mainCamera.transform.position - var_43_34.position

				var_43_34.forward = Vector3.New(var_43_41.x, var_43_41.y, var_43_41.z)

				local var_43_42 = var_43_34.localEulerAngles

				var_43_42.z = 0
				var_43_42.x = 0
				var_43_34.localEulerAngles = var_43_42
			end

			local var_43_43 = 0
			local var_43_44 = 0.55

			if var_43_43 < arg_40_1.time_ and arg_40_1.time_ <= var_43_43 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_45 = arg_40_1:FormatText(StoryNameCfg[1487].name)

				arg_40_1.leftNameTxt_.text = var_43_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_46 = arg_40_1:GetWordFromCfg(324551010)
				local var_43_47 = arg_40_1:FormatText(var_43_46.content)

				arg_40_1.text_.text = var_43_47

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_48 = 22
				local var_43_49 = utf8.len(var_43_47)
				local var_43_50 = var_43_48 <= 0 and var_43_44 or var_43_44 * (var_43_49 / var_43_48)

				if var_43_50 > 0 and var_43_44 < var_43_50 then
					arg_40_1.talkMaxDuration = var_43_50

					if var_43_50 + var_43_43 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_50 + var_43_43
					end
				end

				arg_40_1.text_.text = var_43_47
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551010", "story_v_out_324551.awb") ~= 0 then
					local var_43_51 = manager.audio:GetVoiceLength("story_v_out_324551", "324551010", "story_v_out_324551.awb") / 1000

					if var_43_51 + var_43_43 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_51 + var_43_43
					end

					if var_43_46.prefab_name ~= "" and arg_40_1.actors_[var_43_46.prefab_name] ~= nil then
						local var_43_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_46.prefab_name].transform, "story_v_out_324551", "324551010", "story_v_out_324551.awb")

						arg_40_1:RecordAudio("324551010", var_43_52)
						arg_40_1:RecordAudio("324551010", var_43_52)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324551", "324551010", "story_v_out_324551.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324551", "324551010", "story_v_out_324551.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_53 = math.max(var_43_44, arg_40_1.talkMaxDuration)

			if var_43_43 <= arg_40_1.time_ and arg_40_1.time_ < var_43_43 + var_43_53 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_43) / var_43_53

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_43 + var_43_53 and arg_40_1.time_ < var_43_43 + var_43_53 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play324551011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324551011
		arg_44_1.duration_ = 4.7

		local var_44_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_44_0:Play324551012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["6148ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect6148ui_story == nil then
				arg_44_1.var_.characterEffect6148ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect6148ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect6148ui_story then
				arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1054ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1054ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1054ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1054ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_47_12 = 0
			local var_47_13 = 0.275

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[1488].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(324551011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 11
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551011", "story_v_out_324551.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_324551", "324551011", "story_v_out_324551.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_324551", "324551011", "story_v_out_324551.awb")

						arg_44_1:RecordAudio("324551011", var_47_21)
						arg_44_1:RecordAudio("324551011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324551", "324551011", "story_v_out_324551.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324551", "324551011", "story_v_out_324551.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324551012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324551012
		arg_48_1.duration_ = 7.27

		local var_48_0 = {
			zh = 4.7,
			ja = 7.266
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
				arg_48_0:Play324551013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.65

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[1488].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(324551012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551012", "story_v_out_324551.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_324551", "324551012", "story_v_out_324551.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_324551", "324551012", "story_v_out_324551.awb")

						arg_48_1:RecordAudio("324551012", var_51_9)
						arg_48_1:RecordAudio("324551012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324551", "324551012", "story_v_out_324551.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324551", "324551012", "story_v_out_324551.awb")
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
	Play324551013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324551013
		arg_52_1.duration_ = 4.87

		local var_52_0 = {
			zh = 4.533,
			ja = 4.866
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
				arg_52_0:Play324551014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1170ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["1170ui_story"]
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1170ui_story == nil then
				arg_52_1.var_.characterEffect1170ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.200000002980232

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 and not isNil(var_55_5) then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7

				if arg_52_1.var_.characterEffect1170ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1170ui_story then
				arg_52_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_55_9 = arg_52_1.actors_["6148ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect6148ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect6148ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = var_55_14
			end

			local var_55_15 = 0
			local var_55_16 = 0.45

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[318].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1170")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_18 = arg_52_1:GetWordFromCfg(324551013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 18
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551013", "story_v_out_324551.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_324551", "324551013", "story_v_out_324551.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_324551", "324551013", "story_v_out_324551.awb")

						arg_52_1:RecordAudio("324551013", var_55_24)
						arg_52_1:RecordAudio("324551013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324551", "324551013", "story_v_out_324551.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324551", "324551013", "story_v_out_324551.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324551014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324551014
		arg_56_1.duration_ = 5.5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324551015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["6148ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos6148ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos6148ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = arg_56_1.actors_["1170ui_story"]
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect1170ui_story == nil then
				arg_56_1.var_.characterEffect1170ui_story = var_59_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_13 = 0.200000002980232

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_13 and not isNil(var_59_11) then
				local var_59_14 = (arg_56_1.time_ - var_59_12) / var_59_13

				if arg_56_1.var_.characterEffect1170ui_story and not isNil(var_59_11) then
					local var_59_15 = Mathf.Lerp(0, 0.5, var_59_14)

					arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1170ui_story.fillRatio = var_59_15
				end
			end

			if arg_56_1.time_ >= var_59_12 + var_59_13 and arg_56_1.time_ < var_59_12 + var_59_13 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect1170ui_story then
				local var_59_16 = 0.5

				arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1170ui_story.fillRatio = var_59_16
			end

			local var_59_17 = arg_56_1.actors_["1054ui_story"].transform
			local var_59_18 = 0

			if var_59_18 < arg_56_1.time_ and arg_56_1.time_ <= var_59_18 + arg_59_0 then
				arg_56_1.var_.moveOldPos1054ui_story = var_59_17.localPosition

				local var_59_19 = GameObjectTools.GetOrAddComponent(var_59_17.gameObject, typeof(DynamicBoneHelper))

				if var_59_19 then
					var_59_19:EnableDynamicBone(false)
				end
			end

			local var_59_20 = 0.001

			if var_59_18 <= arg_56_1.time_ and arg_56_1.time_ < var_59_18 + var_59_20 then
				local var_59_21 = (arg_56_1.time_ - var_59_18) / var_59_20
				local var_59_22 = Vector3.New(0, 100, 0)

				var_59_17.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1054ui_story, var_59_22, var_59_21)

				local var_59_23 = manager.ui.mainCamera.transform.position - var_59_17.position

				var_59_17.forward = Vector3.New(var_59_23.x, var_59_23.y, var_59_23.z)

				local var_59_24 = var_59_17.localEulerAngles

				var_59_24.z = 0
				var_59_24.x = 0
				var_59_17.localEulerAngles = var_59_24
			end

			if arg_56_1.time_ >= var_59_18 + var_59_20 and arg_56_1.time_ < var_59_18 + var_59_20 + arg_59_0 then
				var_59_17.localPosition = Vector3.New(0, 100, 0)

				local var_59_25 = manager.ui.mainCamera.transform.position - var_59_17.position

				var_59_17.forward = Vector3.New(var_59_25.x, var_59_25.y, var_59_25.z)

				local var_59_26 = var_59_17.localEulerAngles

				var_59_26.z = 0
				var_59_26.x = 0
				var_59_17.localEulerAngles = var_59_26

				local var_59_27 = GameObjectTools.GetOrAddComponent(var_59_17.gameObject, typeof(DynamicBoneHelper))

				if var_59_27 then
					var_59_27:EnableDynamicBone(true)
				end
			end

			local var_59_28 = manager.ui.mainCamera.transform
			local var_59_29 = 0.7

			if var_59_29 < arg_56_1.time_ and arg_56_1.time_ <= var_59_29 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_28.localPosition
			end

			local var_59_30 = 0.3

			if var_59_29 <= arg_56_1.time_ and arg_56_1.time_ < var_59_29 + var_59_30 then
				local var_59_31 = (arg_56_1.time_ - var_59_29) / 0.066
				local var_59_32, var_59_33 = math.modf(var_59_31)

				var_59_28.localPosition = Vector3.New(var_59_33 * 0.13, var_59_33 * 0.13, var_59_33 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= var_59_29 + var_59_30 and arg_56_1.time_ < var_59_29 + var_59_30 + arg_59_0 then
				var_59_28.localPosition = arg_56_1.var_.shakeOldPos
			end

			local var_59_34 = manager.ui.mainCamera.transform
			local var_59_35 = 0

			if var_59_35 < arg_56_1.time_ and arg_56_1.time_ <= var_59_35 + arg_59_0 then
				local var_59_36 = arg_56_1.var_.effectjinwuluodi1
				local var_59_37
				local var_59_38 = var_59_34

				if not var_59_36 then
					var_59_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_59_38)
					var_59_36.name = "jinwuluodi1"
					arg_56_1.var_.effectjinwuluodi1 = var_59_36
				else
					var_59_36.transform:SetParent(var_59_38)
				end

				var_59_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_59_39 = 0

			if var_59_39 < arg_56_1.time_ and arg_56_1.time_ <= var_59_39 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			local var_59_40 = 1

			if arg_56_1.time_ >= var_59_39 + var_59_40 and arg_56_1.time_ < var_59_39 + var_59_40 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			local var_59_41 = 0.1
			local var_59_42 = 1

			if var_59_41 < arg_56_1.time_ and arg_56_1.time_ <= var_59_41 + arg_59_0 then
				local var_59_43 = "play"
				local var_59_44 = "effect"

				arg_56_1:AudioAction(var_59_43, var_59_44, "se_story_123_01", "se_story_123_01_wind", "")
			end

			local var_59_45 = 0.8
			local var_59_46 = 1

			if var_59_45 < arg_56_1.time_ and arg_56_1.time_ <= var_59_45 + arg_59_0 then
				local var_59_47 = "play"
				local var_59_48 = "effect"

				arg_56_1:AudioAction(var_59_47, var_59_48, "se_story_121_04", "se_story_121_04_jump", "")
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_49 = 0.5
			local var_59_50 = 0.775

			if var_59_49 < arg_56_1.time_ and arg_56_1.time_ <= var_59_49 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_51 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_51:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_52 = arg_56_1:GetWordFromCfg(324551014)
				local var_59_53 = arg_56_1:FormatText(var_59_52.content)

				arg_56_1.text_.text = var_59_53

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_54 = 31
				local var_59_55 = utf8.len(var_59_53)
				local var_59_56 = var_59_54 <= 0 and var_59_50 or var_59_50 * (var_59_55 / var_59_54)

				if var_59_56 > 0 and var_59_50 < var_59_56 then
					arg_56_1.talkMaxDuration = var_59_56
					var_59_49 = var_59_49 + 0.3

					if var_59_56 + var_59_49 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_56 + var_59_49
					end
				end

				arg_56_1.text_.text = var_59_53
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_57 = var_59_49 + 0.3
			local var_59_58 = math.max(var_59_50, arg_56_1.talkMaxDuration)

			if var_59_57 <= arg_56_1.time_ and arg_56_1.time_ < var_59_57 + var_59_58 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_57) / var_59_58

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_57 + var_59_58 and arg_56_1.time_ < var_59_57 + var_59_58 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play324551015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324551015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324551016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.55

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(324551015)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 62
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_7 and arg_62_1.time_ < var_65_0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324551016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324551016
		arg_66_1.duration_ = 4.4

		local var_66_0 = {
			zh = 2.666,
			ja = 4.4
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
				arg_66_0:Play324551017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1071ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1071ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, -1.05, -6.2)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1071ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1071ui_story"]
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1071ui_story == nil then
				arg_66_1.var_.characterEffect1071ui_story = var_69_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_11 = 0.200000002980232

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 and not isNil(var_69_9) then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11

				if arg_66_1.var_.characterEffect1071ui_story and not isNil(var_69_9) then
					arg_66_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1071ui_story then
				arg_66_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_69_13 = 0

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_69_15 = 0
			local var_69_16 = 0.325

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[384].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:GetWordFromCfg(324551016)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 13
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551016", "story_v_out_324551.awb") ~= 0 then
					local var_69_23 = manager.audio:GetVoiceLength("story_v_out_324551", "324551016", "story_v_out_324551.awb") / 1000

					if var_69_23 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_15
					end

					if var_69_18.prefab_name ~= "" and arg_66_1.actors_[var_69_18.prefab_name] ~= nil then
						local var_69_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_18.prefab_name].transform, "story_v_out_324551", "324551016", "story_v_out_324551.awb")

						arg_66_1:RecordAudio("324551016", var_69_24)
						arg_66_1:RecordAudio("324551016", var_69_24)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324551", "324551016", "story_v_out_324551.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324551", "324551016", "story_v_out_324551.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_25 and arg_66_1.time_ < var_69_15 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play324551017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324551017
		arg_70_1.duration_ = 8.37

		local var_70_0 = {
			zh = 4.2,
			ja = 8.366
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
				arg_70_0:Play324551018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1170ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1170ui_story = var_73_0.localPosition

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end
			end

			local var_73_3 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_3 then
				local var_73_4 = (arg_70_1.time_ - var_73_1) / var_73_3
				local var_73_5 = Vector3.New(0.03, -0.95, -6.08)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1170ui_story, var_73_5, var_73_4)

				local var_73_6 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_6.x, var_73_6.y, var_73_6.z)

				local var_73_7 = var_73_0.localEulerAngles

				var_73_7.z = 0
				var_73_7.x = 0
				var_73_0.localEulerAngles = var_73_7
			end

			if arg_70_1.time_ >= var_73_1 + var_73_3 and arg_70_1.time_ < var_73_1 + var_73_3 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_73_8 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_8.x, var_73_8.y, var_73_8.z)

				local var_73_9 = var_73_0.localEulerAngles

				var_73_9.z = 0
				var_73_9.x = 0
				var_73_0.localEulerAngles = var_73_9

				local var_73_10 = GameObjectTools.GetOrAddComponent(var_73_0.gameObject, typeof(DynamicBoneHelper))

				if var_73_10 then
					var_73_10:EnableDynamicBone(true)
				end
			end

			local var_73_11 = arg_70_1.actors_["1071ui_story"].transform
			local var_73_12 = 0

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.var_.moveOldPos1071ui_story = var_73_11.localPosition
			end

			local var_73_13 = 0.001

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_13 then
				local var_73_14 = (arg_70_1.time_ - var_73_12) / var_73_13
				local var_73_15 = Vector3.New(0, 100, 0)

				var_73_11.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1071ui_story, var_73_15, var_73_14)

				local var_73_16 = manager.ui.mainCamera.transform.position - var_73_11.position

				var_73_11.forward = Vector3.New(var_73_16.x, var_73_16.y, var_73_16.z)

				local var_73_17 = var_73_11.localEulerAngles

				var_73_17.z = 0
				var_73_17.x = 0
				var_73_11.localEulerAngles = var_73_17
			end

			if arg_70_1.time_ >= var_73_12 + var_73_13 and arg_70_1.time_ < var_73_12 + var_73_13 + arg_73_0 then
				var_73_11.localPosition = Vector3.New(0, 100, 0)

				local var_73_18 = manager.ui.mainCamera.transform.position - var_73_11.position

				var_73_11.forward = Vector3.New(var_73_18.x, var_73_18.y, var_73_18.z)

				local var_73_19 = var_73_11.localEulerAngles

				var_73_19.z = 0
				var_73_19.x = 0
				var_73_11.localEulerAngles = var_73_19
			end

			local var_73_20 = arg_70_1.actors_["1170ui_story"]
			local var_73_21 = 0

			if var_73_21 < arg_70_1.time_ and arg_70_1.time_ <= var_73_21 + arg_73_0 and not isNil(var_73_20) and arg_70_1.var_.characterEffect1170ui_story == nil then
				arg_70_1.var_.characterEffect1170ui_story = var_73_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_22 = 0.200000002980232

			if var_73_21 <= arg_70_1.time_ and arg_70_1.time_ < var_73_21 + var_73_22 and not isNil(var_73_20) then
				local var_73_23 = (arg_70_1.time_ - var_73_21) / var_73_22

				if arg_70_1.var_.characterEffect1170ui_story and not isNil(var_73_20) then
					arg_70_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_21 + var_73_22 and arg_70_1.time_ < var_73_21 + var_73_22 + arg_73_0 and not isNil(var_73_20) and arg_70_1.var_.characterEffect1170ui_story then
				arg_70_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_73_24 = arg_70_1.actors_["1071ui_story"]
			local var_73_25 = 0

			if var_73_25 < arg_70_1.time_ and arg_70_1.time_ <= var_73_25 + arg_73_0 and not isNil(var_73_24) and arg_70_1.var_.characterEffect1071ui_story == nil then
				arg_70_1.var_.characterEffect1071ui_story = var_73_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_26 = 0.200000002980232

			if var_73_25 <= arg_70_1.time_ and arg_70_1.time_ < var_73_25 + var_73_26 and not isNil(var_73_24) then
				local var_73_27 = (arg_70_1.time_ - var_73_25) / var_73_26

				if arg_70_1.var_.characterEffect1071ui_story and not isNil(var_73_24) then
					local var_73_28 = Mathf.Lerp(0, 0.5, var_73_27)

					arg_70_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1071ui_story.fillRatio = var_73_28
				end
			end

			if arg_70_1.time_ >= var_73_25 + var_73_26 and arg_70_1.time_ < var_73_25 + var_73_26 + arg_73_0 and not isNil(var_73_24) and arg_70_1.var_.characterEffect1071ui_story then
				local var_73_29 = 0.5

				arg_70_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1071ui_story.fillRatio = var_73_29
			end

			local var_73_30 = 0

			if var_73_30 < arg_70_1.time_ and arg_70_1.time_ <= var_73_30 + arg_73_0 then
				arg_70_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			local var_73_31 = 0

			if var_73_31 < arg_70_1.time_ and arg_70_1.time_ <= var_73_31 + arg_73_0 then
				arg_70_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_73_32 = 0
			local var_73_33 = 0.5

			if var_73_32 < arg_70_1.time_ and arg_70_1.time_ <= var_73_32 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_34 = arg_70_1:FormatText(StoryNameCfg[318].name)

				arg_70_1.leftNameTxt_.text = var_73_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_35 = arg_70_1:GetWordFromCfg(324551017)
				local var_73_36 = arg_70_1:FormatText(var_73_35.content)

				arg_70_1.text_.text = var_73_36

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_37 = 20
				local var_73_38 = utf8.len(var_73_36)
				local var_73_39 = var_73_37 <= 0 and var_73_33 or var_73_33 * (var_73_38 / var_73_37)

				if var_73_39 > 0 and var_73_33 < var_73_39 then
					arg_70_1.talkMaxDuration = var_73_39

					if var_73_39 + var_73_32 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_39 + var_73_32
					end
				end

				arg_70_1.text_.text = var_73_36
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551017", "story_v_out_324551.awb") ~= 0 then
					local var_73_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551017", "story_v_out_324551.awb") / 1000

					if var_73_40 + var_73_32 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_40 + var_73_32
					end

					if var_73_35.prefab_name ~= "" and arg_70_1.actors_[var_73_35.prefab_name] ~= nil then
						local var_73_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_35.prefab_name].transform, "story_v_out_324551", "324551017", "story_v_out_324551.awb")

						arg_70_1:RecordAudio("324551017", var_73_41)
						arg_70_1:RecordAudio("324551017", var_73_41)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324551", "324551017", "story_v_out_324551.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324551", "324551017", "story_v_out_324551.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_42 = math.max(var_73_33, arg_70_1.talkMaxDuration)

			if var_73_32 <= arg_70_1.time_ and arg_70_1.time_ < var_73_32 + var_73_42 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_32) / var_73_42

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_32 + var_73_42 and arg_70_1.time_ < var_73_32 + var_73_42 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play324551018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324551018
		arg_74_1.duration_ = 4.3

		local var_74_0 = {
			zh = 3.566,
			ja = 4.3
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
				arg_74_0:Play324551019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1075ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos1075ui_story = var_77_0.localPosition
			end

			local var_77_2 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2
				local var_77_4 = Vector3.New(0.7, -1.055, -6.16)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1075ui_story, var_77_4, var_77_3)

				local var_77_5 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_5.x, var_77_5.y, var_77_5.z)

				local var_77_6 = var_77_0.localEulerAngles

				var_77_6.z = 0
				var_77_6.x = 0
				var_77_0.localEulerAngles = var_77_6
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_77_7 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_7.x, var_77_7.y, var_77_7.z)

				local var_77_8 = var_77_0.localEulerAngles

				var_77_8.z = 0
				var_77_8.x = 0
				var_77_0.localEulerAngles = var_77_8
			end

			local var_77_9 = arg_74_1.actors_["1075ui_story"]
			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect1075ui_story == nil then
				arg_74_1.var_.characterEffect1075ui_story = var_77_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_11 = 0.200000002980232

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_11 and not isNil(var_77_9) then
				local var_77_12 = (arg_74_1.time_ - var_77_10) / var_77_11

				if arg_74_1.var_.characterEffect1075ui_story and not isNil(var_77_9) then
					arg_74_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_10 + var_77_11 and arg_74_1.time_ < var_77_10 + var_77_11 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect1075ui_story then
				arg_74_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_77_13 = arg_74_1.actors_["1170ui_story"]
			local var_77_14 = 0

			if var_77_14 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 and not isNil(var_77_13) and arg_74_1.var_.characterEffect1170ui_story == nil then
				arg_74_1.var_.characterEffect1170ui_story = var_77_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_15 = 0.200000002980232

			if var_77_14 <= arg_74_1.time_ and arg_74_1.time_ < var_77_14 + var_77_15 and not isNil(var_77_13) then
				local var_77_16 = (arg_74_1.time_ - var_77_14) / var_77_15

				if arg_74_1.var_.characterEffect1170ui_story and not isNil(var_77_13) then
					local var_77_17 = Mathf.Lerp(0, 0.5, var_77_16)

					arg_74_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1170ui_story.fillRatio = var_77_17
				end
			end

			if arg_74_1.time_ >= var_77_14 + var_77_15 and arg_74_1.time_ < var_77_14 + var_77_15 + arg_77_0 and not isNil(var_77_13) and arg_74_1.var_.characterEffect1170ui_story then
				local var_77_18 = 0.5

				arg_74_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1170ui_story.fillRatio = var_77_18
			end

			local var_77_19 = 0

			if var_77_19 < arg_74_1.time_ and arg_74_1.time_ <= var_77_19 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_77_20 = 0

			if var_77_20 < arg_74_1.time_ and arg_74_1.time_ <= var_77_20 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_77_21 = arg_74_1.actors_["1170ui_story"].transform
			local var_77_22 = 0

			if var_77_22 < arg_74_1.time_ and arg_74_1.time_ <= var_77_22 + arg_77_0 then
				arg_74_1.var_.moveOldPos1170ui_story = var_77_21.localPosition

				local var_77_23 = GameObjectTools.GetOrAddComponent(var_77_21.gameObject, typeof(DynamicBoneHelper))

				if var_77_23 then
					var_77_23:EnableDynamicBone(false)
				end
			end

			local var_77_24 = 0.001

			if var_77_22 <= arg_74_1.time_ and arg_74_1.time_ < var_77_22 + var_77_24 then
				local var_77_25 = (arg_74_1.time_ - var_77_22) / var_77_24
				local var_77_26 = Vector3.New(-0.68, -0.95, -6.08)

				var_77_21.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1170ui_story, var_77_26, var_77_25)

				local var_77_27 = manager.ui.mainCamera.transform.position - var_77_21.position

				var_77_21.forward = Vector3.New(var_77_27.x, var_77_27.y, var_77_27.z)

				local var_77_28 = var_77_21.localEulerAngles

				var_77_28.z = 0
				var_77_28.x = 0
				var_77_21.localEulerAngles = var_77_28
			end

			if arg_74_1.time_ >= var_77_22 + var_77_24 and arg_74_1.time_ < var_77_22 + var_77_24 + arg_77_0 then
				var_77_21.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_77_29 = manager.ui.mainCamera.transform.position - var_77_21.position

				var_77_21.forward = Vector3.New(var_77_29.x, var_77_29.y, var_77_29.z)

				local var_77_30 = var_77_21.localEulerAngles

				var_77_30.z = 0
				var_77_30.x = 0
				var_77_21.localEulerAngles = var_77_30

				local var_77_31 = GameObjectTools.GetOrAddComponent(var_77_21.gameObject, typeof(DynamicBoneHelper))

				if var_77_31 then
					var_77_31:EnableDynamicBone(true)
				end
			end

			local var_77_32 = 0
			local var_77_33 = 0.3

			if var_77_32 < arg_74_1.time_ and arg_74_1.time_ <= var_77_32 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_34 = arg_74_1:FormatText(StoryNameCfg[381].name)

				arg_74_1.leftNameTxt_.text = var_77_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_35 = arg_74_1:GetWordFromCfg(324551018)
				local var_77_36 = arg_74_1:FormatText(var_77_35.content)

				arg_74_1.text_.text = var_77_36

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_37 = 12
				local var_77_38 = utf8.len(var_77_36)
				local var_77_39 = var_77_37 <= 0 and var_77_33 or var_77_33 * (var_77_38 / var_77_37)

				if var_77_39 > 0 and var_77_33 < var_77_39 then
					arg_74_1.talkMaxDuration = var_77_39

					if var_77_39 + var_77_32 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_39 + var_77_32
					end
				end

				arg_74_1.text_.text = var_77_36
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551018", "story_v_out_324551.awb") ~= 0 then
					local var_77_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551018", "story_v_out_324551.awb") / 1000

					if var_77_40 + var_77_32 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_40 + var_77_32
					end

					if var_77_35.prefab_name ~= "" and arg_74_1.actors_[var_77_35.prefab_name] ~= nil then
						local var_77_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_35.prefab_name].transform, "story_v_out_324551", "324551018", "story_v_out_324551.awb")

						arg_74_1:RecordAudio("324551018", var_77_41)
						arg_74_1:RecordAudio("324551018", var_77_41)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_324551", "324551018", "story_v_out_324551.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_324551", "324551018", "story_v_out_324551.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_42 = math.max(var_77_33, arg_74_1.talkMaxDuration)

			if var_77_32 <= arg_74_1.time_ and arg_74_1.time_ < var_77_32 + var_77_42 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_32) / var_77_42

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_32 + var_77_42 and arg_74_1.time_ < var_77_32 + var_77_42 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play324551019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324551019
		arg_78_1.duration_ = 10.3

		local var_78_0 = {
			zh = 5.5,
			ja = 10.3
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
				arg_78_0:Play324551020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1170ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1170ui_story == nil then
				arg_78_1.var_.characterEffect1170ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1170ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1170ui_story then
				arg_78_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["1075ui_story"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect1075ui_story == nil then
				arg_78_1.var_.characterEffect1075ui_story = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.200000002980232

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect1075ui_story and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1075ui_story.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect1075ui_story then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1075ui_story.fillRatio = var_81_9
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action459")
			end

			local var_81_11 = 0
			local var_81_12 = 0.625

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_13 = arg_78_1:FormatText(StoryNameCfg[318].name)

				arg_78_1.leftNameTxt_.text = var_81_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_14 = arg_78_1:GetWordFromCfg(324551019)
				local var_81_15 = arg_78_1:FormatText(var_81_14.content)

				arg_78_1.text_.text = var_81_15

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_16 = 25
				local var_81_17 = utf8.len(var_81_15)
				local var_81_18 = var_81_16 <= 0 and var_81_12 or var_81_12 * (var_81_17 / var_81_16)

				if var_81_18 > 0 and var_81_12 < var_81_18 then
					arg_78_1.talkMaxDuration = var_81_18

					if var_81_18 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_18 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_15
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551019", "story_v_out_324551.awb") ~= 0 then
					local var_81_19 = manager.audio:GetVoiceLength("story_v_out_324551", "324551019", "story_v_out_324551.awb") / 1000

					if var_81_19 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_11
					end

					if var_81_14.prefab_name ~= "" and arg_78_1.actors_[var_81_14.prefab_name] ~= nil then
						local var_81_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_14.prefab_name].transform, "story_v_out_324551", "324551019", "story_v_out_324551.awb")

						arg_78_1:RecordAudio("324551019", var_81_20)
						arg_78_1:RecordAudio("324551019", var_81_20)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324551", "324551019", "story_v_out_324551.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324551", "324551019", "story_v_out_324551.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_21 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_21 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_21

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_21 and arg_78_1.time_ < var_81_11 + var_81_21 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324551020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324551020
		arg_82_1.duration_ = 6.93

		local var_82_0 = {
			zh = 5.366,
			ja = 6.933
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
				arg_82_0:Play324551021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1071ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1071ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0.7, -1.05, -6.2)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1071ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["1075ui_story"].transform
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.var_.moveOldPos1075ui_story = var_85_9.localPosition
			end

			local var_85_11 = 0.001

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11
				local var_85_13 = Vector3.New(0, 100, 0)

				var_85_9.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1075ui_story, var_85_13, var_85_12)

				local var_85_14 = manager.ui.mainCamera.transform.position - var_85_9.position

				var_85_9.forward = Vector3.New(var_85_14.x, var_85_14.y, var_85_14.z)

				local var_85_15 = var_85_9.localEulerAngles

				var_85_15.z = 0
				var_85_15.x = 0
				var_85_9.localEulerAngles = var_85_15
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 then
				var_85_9.localPosition = Vector3.New(0, 100, 0)

				local var_85_16 = manager.ui.mainCamera.transform.position - var_85_9.position

				var_85_9.forward = Vector3.New(var_85_16.x, var_85_16.y, var_85_16.z)

				local var_85_17 = var_85_9.localEulerAngles

				var_85_17.z = 0
				var_85_17.x = 0
				var_85_9.localEulerAngles = var_85_17
			end

			local var_85_18 = arg_82_1.actors_["1071ui_story"]
			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 and not isNil(var_85_18) and arg_82_1.var_.characterEffect1071ui_story == nil then
				arg_82_1.var_.characterEffect1071ui_story = var_85_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_20 = 0.200000002980232

			if var_85_19 <= arg_82_1.time_ and arg_82_1.time_ < var_85_19 + var_85_20 and not isNil(var_85_18) then
				local var_85_21 = (arg_82_1.time_ - var_85_19) / var_85_20

				if arg_82_1.var_.characterEffect1071ui_story and not isNil(var_85_18) then
					arg_82_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_19 + var_85_20 and arg_82_1.time_ < var_85_19 + var_85_20 + arg_85_0 and not isNil(var_85_18) and arg_82_1.var_.characterEffect1071ui_story then
				arg_82_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_85_22 = arg_82_1.actors_["1170ui_story"]
			local var_85_23 = 0

			if var_85_23 < arg_82_1.time_ and arg_82_1.time_ <= var_85_23 + arg_85_0 and not isNil(var_85_22) and arg_82_1.var_.characterEffect1170ui_story == nil then
				arg_82_1.var_.characterEffect1170ui_story = var_85_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_24 = 0.200000002980232

			if var_85_23 <= arg_82_1.time_ and arg_82_1.time_ < var_85_23 + var_85_24 and not isNil(var_85_22) then
				local var_85_25 = (arg_82_1.time_ - var_85_23) / var_85_24

				if arg_82_1.var_.characterEffect1170ui_story and not isNil(var_85_22) then
					local var_85_26 = Mathf.Lerp(0, 0.5, var_85_25)

					arg_82_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1170ui_story.fillRatio = var_85_26
				end
			end

			if arg_82_1.time_ >= var_85_23 + var_85_24 and arg_82_1.time_ < var_85_23 + var_85_24 + arg_85_0 and not isNil(var_85_22) and arg_82_1.var_.characterEffect1170ui_story then
				local var_85_27 = 0.5

				arg_82_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1170ui_story.fillRatio = var_85_27
			end

			local var_85_28 = 0

			if var_85_28 < arg_82_1.time_ and arg_82_1.time_ <= var_85_28 + arg_85_0 then
				arg_82_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_1")
			end

			local var_85_29 = 0
			local var_85_30 = 0.575

			if var_85_29 < arg_82_1.time_ and arg_82_1.time_ <= var_85_29 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_31 = arg_82_1:FormatText(StoryNameCfg[384].name)

				arg_82_1.leftNameTxt_.text = var_85_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_32 = arg_82_1:GetWordFromCfg(324551020)
				local var_85_33 = arg_82_1:FormatText(var_85_32.content)

				arg_82_1.text_.text = var_85_33

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_34 = 23
				local var_85_35 = utf8.len(var_85_33)
				local var_85_36 = var_85_34 <= 0 and var_85_30 or var_85_30 * (var_85_35 / var_85_34)

				if var_85_36 > 0 and var_85_30 < var_85_36 then
					arg_82_1.talkMaxDuration = var_85_36

					if var_85_36 + var_85_29 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_36 + var_85_29
					end
				end

				arg_82_1.text_.text = var_85_33
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551020", "story_v_out_324551.awb") ~= 0 then
					local var_85_37 = manager.audio:GetVoiceLength("story_v_out_324551", "324551020", "story_v_out_324551.awb") / 1000

					if var_85_37 + var_85_29 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_37 + var_85_29
					end

					if var_85_32.prefab_name ~= "" and arg_82_1.actors_[var_85_32.prefab_name] ~= nil then
						local var_85_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_32.prefab_name].transform, "story_v_out_324551", "324551020", "story_v_out_324551.awb")

						arg_82_1:RecordAudio("324551020", var_85_38)
						arg_82_1:RecordAudio("324551020", var_85_38)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_324551", "324551020", "story_v_out_324551.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_324551", "324551020", "story_v_out_324551.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_39 = math.max(var_85_30, arg_82_1.talkMaxDuration)

			if var_85_29 <= arg_82_1.time_ and arg_82_1.time_ < var_85_29 + var_85_39 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_29) / var_85_39

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_29 + var_85_39 and arg_82_1.time_ < var_85_29 + var_85_39 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play324551021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324551021
		arg_86_1.duration_ = 3.4

		local var_86_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_86_0:Play324551022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1071ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1071ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1071ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1054ui_story"].transform
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = var_89_9.localPosition

				local var_89_11 = GameObjectTools.GetOrAddComponent(var_89_9.gameObject, typeof(DynamicBoneHelper))

				if var_89_11 then
					var_89_11:EnableDynamicBone(false)
				end
			end

			local var_89_12 = 0.001

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_10) / var_89_12
				local var_89_14 = Vector3.New(0.7, -0.985, -6)

				var_89_9.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, var_89_14, var_89_13)

				local var_89_15 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_15.x, var_89_15.y, var_89_15.z)

				local var_89_16 = var_89_9.localEulerAngles

				var_89_16.z = 0
				var_89_16.x = 0
				var_89_9.localEulerAngles = var_89_16
			end

			if arg_86_1.time_ >= var_89_10 + var_89_12 and arg_86_1.time_ < var_89_10 + var_89_12 + arg_89_0 then
				var_89_9.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_89_17 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_17.x, var_89_17.y, var_89_17.z)

				local var_89_18 = var_89_9.localEulerAngles

				var_89_18.z = 0
				var_89_18.x = 0
				var_89_9.localEulerAngles = var_89_18

				local var_89_19 = GameObjectTools.GetOrAddComponent(var_89_9.gameObject, typeof(DynamicBoneHelper))

				if var_89_19 then
					var_89_19:EnableDynamicBone(true)
				end
			end

			local var_89_20 = arg_86_1.actors_["1054ui_story"]
			local var_89_21 = 0

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 and not isNil(var_89_20) and arg_86_1.var_.characterEffect1054ui_story == nil then
				arg_86_1.var_.characterEffect1054ui_story = var_89_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_22 = 0.200000002980232

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_22 and not isNil(var_89_20) then
				local var_89_23 = (arg_86_1.time_ - var_89_21) / var_89_22

				if arg_86_1.var_.characterEffect1054ui_story and not isNil(var_89_20) then
					arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_21 + var_89_22 and arg_86_1.time_ < var_89_21 + var_89_22 + arg_89_0 and not isNil(var_89_20) and arg_86_1.var_.characterEffect1054ui_story then
				arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_89_24 = arg_86_1.actors_["1071ui_story"]
			local var_89_25 = 0

			if var_89_25 < arg_86_1.time_ and arg_86_1.time_ <= var_89_25 + arg_89_0 and not isNil(var_89_24) and arg_86_1.var_.characterEffect1071ui_story == nil then
				arg_86_1.var_.characterEffect1071ui_story = var_89_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_26 = 0.200000002980232

			if var_89_25 <= arg_86_1.time_ and arg_86_1.time_ < var_89_25 + var_89_26 and not isNil(var_89_24) then
				local var_89_27 = (arg_86_1.time_ - var_89_25) / var_89_26

				if arg_86_1.var_.characterEffect1071ui_story and not isNil(var_89_24) then
					local var_89_28 = Mathf.Lerp(0, 0.5, var_89_27)

					arg_86_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1071ui_story.fillRatio = var_89_28
				end
			end

			if arg_86_1.time_ >= var_89_25 + var_89_26 and arg_86_1.time_ < var_89_25 + var_89_26 + arg_89_0 and not isNil(var_89_24) and arg_86_1.var_.characterEffect1071ui_story then
				local var_89_29 = 0.5

				arg_86_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1071ui_story.fillRatio = var_89_29
			end

			local var_89_30 = 0

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action8_1")
			end

			local var_89_31 = 0

			if var_89_31 < arg_86_1.time_ and arg_86_1.time_ <= var_89_31 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_89_32 = 0
			local var_89_33 = 0.275

			if var_89_32 < arg_86_1.time_ and arg_86_1.time_ <= var_89_32 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_34 = arg_86_1:FormatText(StoryNameCfg[1487].name)

				arg_86_1.leftNameTxt_.text = var_89_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_35 = arg_86_1:GetWordFromCfg(324551021)
				local var_89_36 = arg_86_1:FormatText(var_89_35.content)

				arg_86_1.text_.text = var_89_36

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_37 = 11
				local var_89_38 = utf8.len(var_89_36)
				local var_89_39 = var_89_37 <= 0 and var_89_33 or var_89_33 * (var_89_38 / var_89_37)

				if var_89_39 > 0 and var_89_33 < var_89_39 then
					arg_86_1.talkMaxDuration = var_89_39

					if var_89_39 + var_89_32 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_39 + var_89_32
					end
				end

				arg_86_1.text_.text = var_89_36
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551021", "story_v_out_324551.awb") ~= 0 then
					local var_89_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551021", "story_v_out_324551.awb") / 1000

					if var_89_40 + var_89_32 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_40 + var_89_32
					end

					if var_89_35.prefab_name ~= "" and arg_86_1.actors_[var_89_35.prefab_name] ~= nil then
						local var_89_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_35.prefab_name].transform, "story_v_out_324551", "324551021", "story_v_out_324551.awb")

						arg_86_1:RecordAudio("324551021", var_89_41)
						arg_86_1:RecordAudio("324551021", var_89_41)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_324551", "324551021", "story_v_out_324551.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_324551", "324551021", "story_v_out_324551.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_42 = math.max(var_89_33, arg_86_1.talkMaxDuration)

			if var_89_32 <= arg_86_1.time_ and arg_86_1.time_ < var_89_32 + var_89_42 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_32) / var_89_42

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_32 + var_89_42 and arg_86_1.time_ < var_89_32 + var_89_42 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324551022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324551022
		arg_90_1.duration_ = 2

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324551023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1170ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1170ui_story == nil then
				arg_90_1.var_.characterEffect1170ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1170ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1170ui_story then
				arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["1054ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1054ui_story == nil then
				arg_90_1.var_.characterEffect1054ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect1054ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1054ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1054ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1054ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action496")
			end

			local var_93_11 = 0

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_93_12 = 0
			local var_93_13 = 0.075

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[318].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:GetWordFromCfg(324551022)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551022", "story_v_out_324551.awb") ~= 0 then
					local var_93_20 = manager.audio:GetVoiceLength("story_v_out_324551", "324551022", "story_v_out_324551.awb") / 1000

					if var_93_20 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_12
					end

					if var_93_15.prefab_name ~= "" and arg_90_1.actors_[var_93_15.prefab_name] ~= nil then
						local var_93_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_15.prefab_name].transform, "story_v_out_324551", "324551022", "story_v_out_324551.awb")

						arg_90_1:RecordAudio("324551022", var_93_21)
						arg_90_1:RecordAudio("324551022", var_93_21)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324551", "324551022", "story_v_out_324551.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324551", "324551022", "story_v_out_324551.awb")
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
	Play324551023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324551023
		arg_94_1.duration_ = 9.5

		local var_94_0 = {
			zh = 7.033,
			ja = 9.5
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
				arg_94_0:Play324551024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["6148ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos6148ui_story = var_97_0.localPosition

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end
			end

			local var_97_3 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_3 then
				local var_97_4 = (arg_94_1.time_ - var_97_1) / var_97_3
				local var_97_5 = Vector3.New(0.7, -0.985, -6)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos6148ui_story, var_97_5, var_97_4)

				local var_97_6 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_6.x, var_97_6.y, var_97_6.z)

				local var_97_7 = var_97_0.localEulerAngles

				var_97_7.z = 0
				var_97_7.x = 0
				var_97_0.localEulerAngles = var_97_7
			end

			if arg_94_1.time_ >= var_97_1 + var_97_3 and arg_94_1.time_ < var_97_1 + var_97_3 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_97_8 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_8.x, var_97_8.y, var_97_8.z)

				local var_97_9 = var_97_0.localEulerAngles

				var_97_9.z = 0
				var_97_9.x = 0
				var_97_0.localEulerAngles = var_97_9

				local var_97_10 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_10 then
					var_97_10:EnableDynamicBone(true)
				end
			end

			local var_97_11 = arg_94_1.actors_["6148ui_story"]
			local var_97_12 = 0

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect6148ui_story == nil then
				arg_94_1.var_.characterEffect6148ui_story = var_97_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_13 = 0.200000002980232

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_13 and not isNil(var_97_11) then
				local var_97_14 = (arg_94_1.time_ - var_97_12) / var_97_13

				if arg_94_1.var_.characterEffect6148ui_story and not isNil(var_97_11) then
					arg_94_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_12 + var_97_13 and arg_94_1.time_ < var_97_12 + var_97_13 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect6148ui_story then
				arg_94_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_97_15 = arg_94_1.actors_["1170ui_story"]
			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 and not isNil(var_97_15) and arg_94_1.var_.characterEffect1170ui_story == nil then
				arg_94_1.var_.characterEffect1170ui_story = var_97_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_17 = 0.200000002980232

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_17 and not isNil(var_97_15) then
				local var_97_18 = (arg_94_1.time_ - var_97_16) / var_97_17

				if arg_94_1.var_.characterEffect1170ui_story and not isNil(var_97_15) then
					local var_97_19 = Mathf.Lerp(0, 0.5, var_97_18)

					arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1170ui_story.fillRatio = var_97_19
				end
			end

			if arg_94_1.time_ >= var_97_16 + var_97_17 and arg_94_1.time_ < var_97_16 + var_97_17 + arg_97_0 and not isNil(var_97_15) and arg_94_1.var_.characterEffect1170ui_story then
				local var_97_20 = 0.5

				arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1170ui_story.fillRatio = var_97_20
			end

			local var_97_21 = 0

			if var_97_21 < arg_94_1.time_ and arg_94_1.time_ <= var_97_21 + arg_97_0 then
				arg_94_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_97_22 = 0

			if var_97_22 < arg_94_1.time_ and arg_94_1.time_ <= var_97_22 + arg_97_0 then
				arg_94_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_97_23 = arg_94_1.actors_["1054ui_story"].transform
			local var_97_24 = 0

			if var_97_24 < arg_94_1.time_ and arg_94_1.time_ <= var_97_24 + arg_97_0 then
				arg_94_1.var_.moveOldPos1054ui_story = var_97_23.localPosition

				local var_97_25 = GameObjectTools.GetOrAddComponent(var_97_23.gameObject, typeof(DynamicBoneHelper))

				if var_97_25 then
					var_97_25:EnableDynamicBone(false)
				end
			end

			local var_97_26 = 0.001

			if var_97_24 <= arg_94_1.time_ and arg_94_1.time_ < var_97_24 + var_97_26 then
				local var_97_27 = (arg_94_1.time_ - var_97_24) / var_97_26
				local var_97_28 = Vector3.New(0, 100, 0)

				var_97_23.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1054ui_story, var_97_28, var_97_27)

				local var_97_29 = manager.ui.mainCamera.transform.position - var_97_23.position

				var_97_23.forward = Vector3.New(var_97_29.x, var_97_29.y, var_97_29.z)

				local var_97_30 = var_97_23.localEulerAngles

				var_97_30.z = 0
				var_97_30.x = 0
				var_97_23.localEulerAngles = var_97_30
			end

			if arg_94_1.time_ >= var_97_24 + var_97_26 and arg_94_1.time_ < var_97_24 + var_97_26 + arg_97_0 then
				var_97_23.localPosition = Vector3.New(0, 100, 0)

				local var_97_31 = manager.ui.mainCamera.transform.position - var_97_23.position

				var_97_23.forward = Vector3.New(var_97_31.x, var_97_31.y, var_97_31.z)

				local var_97_32 = var_97_23.localEulerAngles

				var_97_32.z = 0
				var_97_32.x = 0
				var_97_23.localEulerAngles = var_97_32

				local var_97_33 = GameObjectTools.GetOrAddComponent(var_97_23.gameObject, typeof(DynamicBoneHelper))

				if var_97_33 then
					var_97_33:EnableDynamicBone(true)
				end
			end

			local var_97_34 = 0
			local var_97_35 = 0.825

			if var_97_34 < arg_94_1.time_ and arg_94_1.time_ <= var_97_34 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_36 = arg_94_1:FormatText(StoryNameCfg[1488].name)

				arg_94_1.leftNameTxt_.text = var_97_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_37 = arg_94_1:GetWordFromCfg(324551023)
				local var_97_38 = arg_94_1:FormatText(var_97_37.content)

				arg_94_1.text_.text = var_97_38

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_39 = 33
				local var_97_40 = utf8.len(var_97_38)
				local var_97_41 = var_97_39 <= 0 and var_97_35 or var_97_35 * (var_97_40 / var_97_39)

				if var_97_41 > 0 and var_97_35 < var_97_41 then
					arg_94_1.talkMaxDuration = var_97_41

					if var_97_41 + var_97_34 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_41 + var_97_34
					end
				end

				arg_94_1.text_.text = var_97_38
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551023", "story_v_out_324551.awb") ~= 0 then
					local var_97_42 = manager.audio:GetVoiceLength("story_v_out_324551", "324551023", "story_v_out_324551.awb") / 1000

					if var_97_42 + var_97_34 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_42 + var_97_34
					end

					if var_97_37.prefab_name ~= "" and arg_94_1.actors_[var_97_37.prefab_name] ~= nil then
						local var_97_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_37.prefab_name].transform, "story_v_out_324551", "324551023", "story_v_out_324551.awb")

						arg_94_1:RecordAudio("324551023", var_97_43)
						arg_94_1:RecordAudio("324551023", var_97_43)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324551", "324551023", "story_v_out_324551.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324551", "324551023", "story_v_out_324551.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_44 = math.max(var_97_35, arg_94_1.talkMaxDuration)

			if var_97_34 <= arg_94_1.time_ and arg_94_1.time_ < var_97_34 + var_97_44 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_34) / var_97_44

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_34 + var_97_44 and arg_94_1.time_ < var_97_34 + var_97_44 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324551024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324551024
		arg_98_1.duration_ = 4.33

		local var_98_0 = {
			zh = 3.866,
			ja = 4.333
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
				arg_98_0:Play324551025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["6148ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos6148ui_story = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos6148ui_story, var_101_5, var_101_4)

				local var_101_6 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_6.x, var_101_6.y, var_101_6.z)

				local var_101_7 = var_101_0.localEulerAngles

				var_101_7.z = 0
				var_101_7.x = 0
				var_101_0.localEulerAngles = var_101_7
			end

			if arg_98_1.time_ >= var_101_1 + var_101_3 and arg_98_1.time_ < var_101_1 + var_101_3 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_8 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_8.x, var_101_8.y, var_101_8.z)

				local var_101_9 = var_101_0.localEulerAngles

				var_101_9.z = 0
				var_101_9.x = 0
				var_101_0.localEulerAngles = var_101_9

				local var_101_10 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_10 then
					var_101_10:EnableDynamicBone(true)
				end
			end

			local var_101_11 = arg_98_1.actors_["1071ui_story"].transform
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.var_.moveOldPos1071ui_story = var_101_11.localPosition
			end

			local var_101_13 = 0.001

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13
				local var_101_15 = Vector3.New(0.7, -1.05, -6.2)

				var_101_11.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1071ui_story, var_101_15, var_101_14)

				local var_101_16 = manager.ui.mainCamera.transform.position - var_101_11.position

				var_101_11.forward = Vector3.New(var_101_16.x, var_101_16.y, var_101_16.z)

				local var_101_17 = var_101_11.localEulerAngles

				var_101_17.z = 0
				var_101_17.x = 0
				var_101_11.localEulerAngles = var_101_17
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 then
				var_101_11.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_101_18 = manager.ui.mainCamera.transform.position - var_101_11.position

				var_101_11.forward = Vector3.New(var_101_18.x, var_101_18.y, var_101_18.z)

				local var_101_19 = var_101_11.localEulerAngles

				var_101_19.z = 0
				var_101_19.x = 0
				var_101_11.localEulerAngles = var_101_19
			end

			local var_101_20 = arg_98_1.actors_["1071ui_story"]
			local var_101_21 = 0

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 and not isNil(var_101_20) and arg_98_1.var_.characterEffect1071ui_story == nil then
				arg_98_1.var_.characterEffect1071ui_story = var_101_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_22 = 0.200000002980232

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_22 and not isNil(var_101_20) then
				local var_101_23 = (arg_98_1.time_ - var_101_21) / var_101_22

				if arg_98_1.var_.characterEffect1071ui_story and not isNil(var_101_20) then
					arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_21 + var_101_22 and arg_98_1.time_ < var_101_21 + var_101_22 + arg_101_0 and not isNil(var_101_20) and arg_98_1.var_.characterEffect1071ui_story then
				arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_101_24 = arg_98_1.actors_["6148ui_story"]
			local var_101_25 = 0

			if var_101_25 < arg_98_1.time_ and arg_98_1.time_ <= var_101_25 + arg_101_0 and not isNil(var_101_24) and arg_98_1.var_.characterEffect6148ui_story == nil then
				arg_98_1.var_.characterEffect6148ui_story = var_101_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_26 = 0.200000002980232

			if var_101_25 <= arg_98_1.time_ and arg_98_1.time_ < var_101_25 + var_101_26 and not isNil(var_101_24) then
				local var_101_27 = (arg_98_1.time_ - var_101_25) / var_101_26

				if arg_98_1.var_.characterEffect6148ui_story and not isNil(var_101_24) then
					local var_101_28 = Mathf.Lerp(0, 0.5, var_101_27)

					arg_98_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_98_1.var_.characterEffect6148ui_story.fillRatio = var_101_28
				end
			end

			if arg_98_1.time_ >= var_101_25 + var_101_26 and arg_98_1.time_ < var_101_25 + var_101_26 + arg_101_0 and not isNil(var_101_24) and arg_98_1.var_.characterEffect6148ui_story then
				local var_101_29 = 0.5

				arg_98_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_98_1.var_.characterEffect6148ui_story.fillRatio = var_101_29
			end

			local var_101_30 = 0

			if var_101_30 < arg_98_1.time_ and arg_98_1.time_ <= var_101_30 + arg_101_0 then
				arg_98_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_2")
			end

			local var_101_31 = 0
			local var_101_32 = 0.4

			if var_101_31 < arg_98_1.time_ and arg_98_1.time_ <= var_101_31 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_33 = arg_98_1:FormatText(StoryNameCfg[384].name)

				arg_98_1.leftNameTxt_.text = var_101_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_34 = arg_98_1:GetWordFromCfg(324551024)
				local var_101_35 = arg_98_1:FormatText(var_101_34.content)

				arg_98_1.text_.text = var_101_35

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_36 = 16
				local var_101_37 = utf8.len(var_101_35)
				local var_101_38 = var_101_36 <= 0 and var_101_32 or var_101_32 * (var_101_37 / var_101_36)

				if var_101_38 > 0 and var_101_32 < var_101_38 then
					arg_98_1.talkMaxDuration = var_101_38

					if var_101_38 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_38 + var_101_31
					end
				end

				arg_98_1.text_.text = var_101_35
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551024", "story_v_out_324551.awb") ~= 0 then
					local var_101_39 = manager.audio:GetVoiceLength("story_v_out_324551", "324551024", "story_v_out_324551.awb") / 1000

					if var_101_39 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_39 + var_101_31
					end

					if var_101_34.prefab_name ~= "" and arg_98_1.actors_[var_101_34.prefab_name] ~= nil then
						local var_101_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_34.prefab_name].transform, "story_v_out_324551", "324551024", "story_v_out_324551.awb")

						arg_98_1:RecordAudio("324551024", var_101_40)
						arg_98_1:RecordAudio("324551024", var_101_40)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324551", "324551024", "story_v_out_324551.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324551", "324551024", "story_v_out_324551.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_41 = math.max(var_101_32, arg_98_1.talkMaxDuration)

			if var_101_31 <= arg_98_1.time_ and arg_98_1.time_ < var_101_31 + var_101_41 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_31) / var_101_41

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_31 + var_101_41 and arg_98_1.time_ < var_101_31 + var_101_41 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play324551025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324551025
		arg_102_1.duration_ = 7.47

		local var_102_0 = {
			zh = 4.533,
			ja = 7.466
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
				arg_102_0:Play324551026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1071ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1071ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, 100, 0)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1071ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, 100, 0)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1170ui_story"].transform
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.var_.moveOldPos1170ui_story = var_105_9.localPosition

				local var_105_11 = GameObjectTools.GetOrAddComponent(var_105_9.gameObject, typeof(DynamicBoneHelper))

				if var_105_11 then
					var_105_11:EnableDynamicBone(false)
				end
			end

			local var_105_12 = 0.001

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_12 then
				local var_105_13 = (arg_102_1.time_ - var_105_10) / var_105_12
				local var_105_14 = Vector3.New(0.03, -0.95, -6.08)

				var_105_9.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1170ui_story, var_105_14, var_105_13)

				local var_105_15 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_15.x, var_105_15.y, var_105_15.z)

				local var_105_16 = var_105_9.localEulerAngles

				var_105_16.z = 0
				var_105_16.x = 0
				var_105_9.localEulerAngles = var_105_16
			end

			if arg_102_1.time_ >= var_105_10 + var_105_12 and arg_102_1.time_ < var_105_10 + var_105_12 + arg_105_0 then
				var_105_9.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_105_17 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_17.x, var_105_17.y, var_105_17.z)

				local var_105_18 = var_105_9.localEulerAngles

				var_105_18.z = 0
				var_105_18.x = 0
				var_105_9.localEulerAngles = var_105_18

				local var_105_19 = GameObjectTools.GetOrAddComponent(var_105_9.gameObject, typeof(DynamicBoneHelper))

				if var_105_19 then
					var_105_19:EnableDynamicBone(true)
				end
			end

			local var_105_20 = arg_102_1.actors_["1170ui_story"]
			local var_105_21 = 0

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 and not isNil(var_105_20) and arg_102_1.var_.characterEffect1170ui_story == nil then
				arg_102_1.var_.characterEffect1170ui_story = var_105_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_22 = 0.200000002980232

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_22 and not isNil(var_105_20) then
				local var_105_23 = (arg_102_1.time_ - var_105_21) / var_105_22

				if arg_102_1.var_.characterEffect1170ui_story and not isNil(var_105_20) then
					arg_102_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_21 + var_105_22 and arg_102_1.time_ < var_105_21 + var_105_22 + arg_105_0 and not isNil(var_105_20) and arg_102_1.var_.characterEffect1170ui_story then
				arg_102_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_105_24 = arg_102_1.actors_["1071ui_story"]
			local var_105_25 = 0

			if var_105_25 < arg_102_1.time_ and arg_102_1.time_ <= var_105_25 + arg_105_0 and not isNil(var_105_24) and arg_102_1.var_.characterEffect1071ui_story == nil then
				arg_102_1.var_.characterEffect1071ui_story = var_105_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_26 = 0.200000002980232

			if var_105_25 <= arg_102_1.time_ and arg_102_1.time_ < var_105_25 + var_105_26 and not isNil(var_105_24) then
				local var_105_27 = (arg_102_1.time_ - var_105_25) / var_105_26

				if arg_102_1.var_.characterEffect1071ui_story and not isNil(var_105_24) then
					local var_105_28 = Mathf.Lerp(0, 0.5, var_105_27)

					arg_102_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1071ui_story.fillRatio = var_105_28
				end
			end

			if arg_102_1.time_ >= var_105_25 + var_105_26 and arg_102_1.time_ < var_105_25 + var_105_26 + arg_105_0 and not isNil(var_105_24) and arg_102_1.var_.characterEffect1071ui_story then
				local var_105_29 = 0.5

				arg_102_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1071ui_story.fillRatio = var_105_29
			end

			local var_105_30 = 0

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 then
				arg_102_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action6_2")
			end

			local var_105_31 = 0

			if var_105_31 < arg_102_1.time_ and arg_102_1.time_ <= var_105_31 + arg_105_0 then
				arg_102_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_105_32 = 0
			local var_105_33 = 0.525

			if var_105_32 < arg_102_1.time_ and arg_102_1.time_ <= var_105_32 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_34 = arg_102_1:FormatText(StoryNameCfg[318].name)

				arg_102_1.leftNameTxt_.text = var_105_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_35 = arg_102_1:GetWordFromCfg(324551025)
				local var_105_36 = arg_102_1:FormatText(var_105_35.content)

				arg_102_1.text_.text = var_105_36

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_37 = 21
				local var_105_38 = utf8.len(var_105_36)
				local var_105_39 = var_105_37 <= 0 and var_105_33 or var_105_33 * (var_105_38 / var_105_37)

				if var_105_39 > 0 and var_105_33 < var_105_39 then
					arg_102_1.talkMaxDuration = var_105_39

					if var_105_39 + var_105_32 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_39 + var_105_32
					end
				end

				arg_102_1.text_.text = var_105_36
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551025", "story_v_out_324551.awb") ~= 0 then
					local var_105_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551025", "story_v_out_324551.awb") / 1000

					if var_105_40 + var_105_32 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_40 + var_105_32
					end

					if var_105_35.prefab_name ~= "" and arg_102_1.actors_[var_105_35.prefab_name] ~= nil then
						local var_105_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_35.prefab_name].transform, "story_v_out_324551", "324551025", "story_v_out_324551.awb")

						arg_102_1:RecordAudio("324551025", var_105_41)
						arg_102_1:RecordAudio("324551025", var_105_41)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324551", "324551025", "story_v_out_324551.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324551", "324551025", "story_v_out_324551.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_42 = math.max(var_105_33, arg_102_1.talkMaxDuration)

			if var_105_32 <= arg_102_1.time_ and arg_102_1.time_ < var_105_32 + var_105_42 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_32) / var_105_42

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_32 + var_105_42 and arg_102_1.time_ < var_105_32 + var_105_42 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play324551026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324551026
		arg_106_1.duration_ = 11.07

		local var_106_0 = {
			zh = 10.166,
			ja = 11.066
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
				arg_106_0:Play324551027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1170ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1170ui_story = var_109_0.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_3 then
				local var_109_4 = (arg_106_1.time_ - var_109_1) / var_109_3
				local var_109_5 = Vector3.New(-0.68, -0.95, -6.08)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1170ui_story, var_109_5, var_109_4)

				local var_109_6 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_6.x, var_109_6.y, var_109_6.z)

				local var_109_7 = var_109_0.localEulerAngles

				var_109_7.z = 0
				var_109_7.x = 0
				var_109_0.localEulerAngles = var_109_7
			end

			if arg_106_1.time_ >= var_109_1 + var_109_3 and arg_106_1.time_ < var_109_1 + var_109_3 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_109_8 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_8.x, var_109_8.y, var_109_8.z)

				local var_109_9 = var_109_0.localEulerAngles

				var_109_9.z = 0
				var_109_9.x = 0
				var_109_0.localEulerAngles = var_109_9

				local var_109_10 = GameObjectTools.GetOrAddComponent(var_109_0.gameObject, typeof(DynamicBoneHelper))

				if var_109_10 then
					var_109_10:EnableDynamicBone(true)
				end
			end

			local var_109_11 = arg_106_1.actors_["1075ui_story"]
			local var_109_12 = 0

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 and not isNil(var_109_11) and arg_106_1.var_.characterEffect1075ui_story == nil then
				arg_106_1.var_.characterEffect1075ui_story = var_109_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_13 = 0.200000002980232

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_13 and not isNil(var_109_11) then
				local var_109_14 = (arg_106_1.time_ - var_109_12) / var_109_13

				if arg_106_1.var_.characterEffect1075ui_story and not isNil(var_109_11) then
					arg_106_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_12 + var_109_13 and arg_106_1.time_ < var_109_12 + var_109_13 + arg_109_0 and not isNil(var_109_11) and arg_106_1.var_.characterEffect1075ui_story then
				arg_106_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_109_15 = arg_106_1.actors_["1170ui_story"]
			local var_109_16 = 0

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 and not isNil(var_109_15) and arg_106_1.var_.characterEffect1170ui_story == nil then
				arg_106_1.var_.characterEffect1170ui_story = var_109_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_17 = 0.200000002980232

			if var_109_16 <= arg_106_1.time_ and arg_106_1.time_ < var_109_16 + var_109_17 and not isNil(var_109_15) then
				local var_109_18 = (arg_106_1.time_ - var_109_16) / var_109_17

				if arg_106_1.var_.characterEffect1170ui_story and not isNil(var_109_15) then
					local var_109_19 = Mathf.Lerp(0, 0.5, var_109_18)

					arg_106_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1170ui_story.fillRatio = var_109_19
				end
			end

			if arg_106_1.time_ >= var_109_16 + var_109_17 and arg_106_1.time_ < var_109_16 + var_109_17 + arg_109_0 and not isNil(var_109_15) and arg_106_1.var_.characterEffect1170ui_story then
				local var_109_20 = 0.5

				arg_106_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1170ui_story.fillRatio = var_109_20
			end

			local var_109_21 = 0

			if var_109_21 < arg_106_1.time_ and arg_106_1.time_ <= var_109_21 + arg_109_0 then
				arg_106_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_109_22 = 0

			if var_109_22 < arg_106_1.time_ and arg_106_1.time_ <= var_109_22 + arg_109_0 then
				arg_106_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_23 = arg_106_1.actors_["1075ui_story"].transform
			local var_109_24 = 0

			if var_109_24 < arg_106_1.time_ and arg_106_1.time_ <= var_109_24 + arg_109_0 then
				arg_106_1.var_.moveOldPos1075ui_story = var_109_23.localPosition
			end

			local var_109_25 = 0.001

			if var_109_24 <= arg_106_1.time_ and arg_106_1.time_ < var_109_24 + var_109_25 then
				local var_109_26 = (arg_106_1.time_ - var_109_24) / var_109_25
				local var_109_27 = Vector3.New(0.7, -1.055, -6.16)

				var_109_23.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1075ui_story, var_109_27, var_109_26)

				local var_109_28 = manager.ui.mainCamera.transform.position - var_109_23.position

				var_109_23.forward = Vector3.New(var_109_28.x, var_109_28.y, var_109_28.z)

				local var_109_29 = var_109_23.localEulerAngles

				var_109_29.z = 0
				var_109_29.x = 0
				var_109_23.localEulerAngles = var_109_29
			end

			if arg_106_1.time_ >= var_109_24 + var_109_25 and arg_106_1.time_ < var_109_24 + var_109_25 + arg_109_0 then
				var_109_23.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_109_30 = manager.ui.mainCamera.transform.position - var_109_23.position

				var_109_23.forward = Vector3.New(var_109_30.x, var_109_30.y, var_109_30.z)

				local var_109_31 = var_109_23.localEulerAngles

				var_109_31.z = 0
				var_109_31.x = 0
				var_109_23.localEulerAngles = var_109_31
			end

			local var_109_32 = 0
			local var_109_33 = 1.025

			if var_109_32 < arg_106_1.time_ and arg_106_1.time_ <= var_109_32 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_34 = arg_106_1:FormatText(StoryNameCfg[381].name)

				arg_106_1.leftNameTxt_.text = var_109_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_35 = arg_106_1:GetWordFromCfg(324551026)
				local var_109_36 = arg_106_1:FormatText(var_109_35.content)

				arg_106_1.text_.text = var_109_36

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_37 = 41
				local var_109_38 = utf8.len(var_109_36)
				local var_109_39 = var_109_37 <= 0 and var_109_33 or var_109_33 * (var_109_38 / var_109_37)

				if var_109_39 > 0 and var_109_33 < var_109_39 then
					arg_106_1.talkMaxDuration = var_109_39

					if var_109_39 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_39 + var_109_32
					end
				end

				arg_106_1.text_.text = var_109_36
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551026", "story_v_out_324551.awb") ~= 0 then
					local var_109_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551026", "story_v_out_324551.awb") / 1000

					if var_109_40 + var_109_32 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_40 + var_109_32
					end

					if var_109_35.prefab_name ~= "" and arg_106_1.actors_[var_109_35.prefab_name] ~= nil then
						local var_109_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_35.prefab_name].transform, "story_v_out_324551", "324551026", "story_v_out_324551.awb")

						arg_106_1:RecordAudio("324551026", var_109_41)
						arg_106_1:RecordAudio("324551026", var_109_41)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324551", "324551026", "story_v_out_324551.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324551", "324551026", "story_v_out_324551.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_42 = math.max(var_109_33, arg_106_1.talkMaxDuration)

			if var_109_32 <= arg_106_1.time_ and arg_106_1.time_ < var_109_32 + var_109_42 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_32) / var_109_42

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_32 + var_109_42 and arg_106_1.time_ < var_109_32 + var_109_42 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play324551027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324551027
		arg_110_1.duration_ = 5.83

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324551028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "ST2007"

			if arg_110_1.bgs_[var_113_0] == nil then
				local var_113_1 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_0)
				var_113_1.name = var_113_0
				var_113_1.transform.parent = arg_110_1.stage_.transform
				var_113_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_0] = var_113_1
			end

			local var_113_2 = 2

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				local var_113_3 = manager.ui.mainCamera.transform.localPosition
				local var_113_4 = Vector3.New(0, 0, 10) + Vector3.New(var_113_3.x, var_113_3.y, 0)
				local var_113_5 = arg_110_1.bgs_.ST2007

				var_113_5.transform.localPosition = var_113_4
				var_113_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_6 = var_113_5:GetComponent("SpriteRenderer")

				if var_113_6 and var_113_6.sprite then
					local var_113_7 = (var_113_5.transform.localPosition - var_113_3).z
					local var_113_8 = manager.ui.mainCameraCom_
					local var_113_9 = 2 * var_113_7 * Mathf.Tan(var_113_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_10 = var_113_9 * var_113_8.aspect
					local var_113_11 = var_113_6.sprite.bounds.size.x
					local var_113_12 = var_113_6.sprite.bounds.size.y
					local var_113_13 = var_113_10 / var_113_11
					local var_113_14 = var_113_9 / var_113_12
					local var_113_15 = var_113_14 < var_113_13 and var_113_13 or var_113_14

					var_113_5.transform.localScale = Vector3.New(var_113_15, var_113_15, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST2007" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			local var_113_17 = 0.3

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_18 = 0

			if var_113_18 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_19 = 2

			if var_113_18 <= arg_110_1.time_ and arg_110_1.time_ < var_113_18 + var_113_19 then
				local var_113_20 = (arg_110_1.time_ - var_113_18) / var_113_19
				local var_113_21 = Color.New(0, 0, 0)

				var_113_21.a = Mathf.Lerp(0, 1, var_113_20)
				arg_110_1.mask_.color = var_113_21
			end

			if arg_110_1.time_ >= var_113_18 + var_113_19 and arg_110_1.time_ < var_113_18 + var_113_19 + arg_113_0 then
				local var_113_22 = Color.New(0, 0, 0)

				var_113_22.a = 1
				arg_110_1.mask_.color = var_113_22
			end

			local var_113_23 = 2

			if var_113_23 < arg_110_1.time_ and arg_110_1.time_ <= var_113_23 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_24 = 2

			if var_113_23 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 then
				local var_113_25 = (arg_110_1.time_ - var_113_23) / var_113_24
				local var_113_26 = Color.New(0, 0, 0)

				var_113_26.a = Mathf.Lerp(1, 0, var_113_25)
				arg_110_1.mask_.color = var_113_26
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				local var_113_27 = Color.New(0, 0, 0)
				local var_113_28 = 0

				arg_110_1.mask_.enabled = false
				var_113_27.a = var_113_28
				arg_110_1.mask_.color = var_113_27
			end

			local var_113_29 = arg_110_1.actors_["1054ui_story"].transform
			local var_113_30 = 3.8

			if var_113_30 < arg_110_1.time_ and arg_110_1.time_ <= var_113_30 + arg_113_0 then
				arg_110_1.var_.moveOldPos1054ui_story = var_113_29.localPosition

				local var_113_31 = GameObjectTools.GetOrAddComponent(var_113_29.gameObject, typeof(DynamicBoneHelper))

				if var_113_31 then
					var_113_31:EnableDynamicBone(false)
				end
			end

			local var_113_32 = 0.001

			if var_113_30 <= arg_110_1.time_ and arg_110_1.time_ < var_113_30 + var_113_32 then
				local var_113_33 = (arg_110_1.time_ - var_113_30) / var_113_32
				local var_113_34 = Vector3.New(0, -0.985, -6)

				var_113_29.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1054ui_story, var_113_34, var_113_33)

				local var_113_35 = manager.ui.mainCamera.transform.position - var_113_29.position

				var_113_29.forward = Vector3.New(var_113_35.x, var_113_35.y, var_113_35.z)

				local var_113_36 = var_113_29.localEulerAngles

				var_113_36.z = 0
				var_113_36.x = 0
				var_113_29.localEulerAngles = var_113_36
			end

			if arg_110_1.time_ >= var_113_30 + var_113_32 and arg_110_1.time_ < var_113_30 + var_113_32 + arg_113_0 then
				var_113_29.localPosition = Vector3.New(0, -0.985, -6)

				local var_113_37 = manager.ui.mainCamera.transform.position - var_113_29.position

				var_113_29.forward = Vector3.New(var_113_37.x, var_113_37.y, var_113_37.z)

				local var_113_38 = var_113_29.localEulerAngles

				var_113_38.z = 0
				var_113_38.x = 0
				var_113_29.localEulerAngles = var_113_38

				local var_113_39 = GameObjectTools.GetOrAddComponent(var_113_29.gameObject, typeof(DynamicBoneHelper))

				if var_113_39 then
					var_113_39:EnableDynamicBone(true)
				end
			end

			local var_113_40 = arg_110_1.actors_["1075ui_story"].transform
			local var_113_41 = 1.96599999815226

			if var_113_41 < arg_110_1.time_ and arg_110_1.time_ <= var_113_41 + arg_113_0 then
				arg_110_1.var_.moveOldPos1075ui_story = var_113_40.localPosition
			end

			local var_113_42 = 0.001

			if var_113_41 <= arg_110_1.time_ and arg_110_1.time_ < var_113_41 + var_113_42 then
				local var_113_43 = (arg_110_1.time_ - var_113_41) / var_113_42
				local var_113_44 = Vector3.New(0, 100, 0)

				var_113_40.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1075ui_story, var_113_44, var_113_43)

				local var_113_45 = manager.ui.mainCamera.transform.position - var_113_40.position

				var_113_40.forward = Vector3.New(var_113_45.x, var_113_45.y, var_113_45.z)

				local var_113_46 = var_113_40.localEulerAngles

				var_113_46.z = 0
				var_113_46.x = 0
				var_113_40.localEulerAngles = var_113_46
			end

			if arg_110_1.time_ >= var_113_41 + var_113_42 and arg_110_1.time_ < var_113_41 + var_113_42 + arg_113_0 then
				var_113_40.localPosition = Vector3.New(0, 100, 0)

				local var_113_47 = manager.ui.mainCamera.transform.position - var_113_40.position

				var_113_40.forward = Vector3.New(var_113_47.x, var_113_47.y, var_113_47.z)

				local var_113_48 = var_113_40.localEulerAngles

				var_113_48.z = 0
				var_113_48.x = 0
				var_113_40.localEulerAngles = var_113_48
			end

			local var_113_49 = arg_110_1.actors_["1054ui_story"]
			local var_113_50 = 3.83400000184774

			if var_113_50 < arg_110_1.time_ and arg_110_1.time_ <= var_113_50 + arg_113_0 and not isNil(var_113_49) and arg_110_1.var_.characterEffect1054ui_story == nil then
				arg_110_1.var_.characterEffect1054ui_story = var_113_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_51 = 0.200000002980232

			if var_113_50 <= arg_110_1.time_ and arg_110_1.time_ < var_113_50 + var_113_51 and not isNil(var_113_49) then
				local var_113_52 = (arg_110_1.time_ - var_113_50) / var_113_51

				if arg_110_1.var_.characterEffect1054ui_story and not isNil(var_113_49) then
					arg_110_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_50 + var_113_51 and arg_110_1.time_ < var_113_50 + var_113_51 + arg_113_0 and not isNil(var_113_49) and arg_110_1.var_.characterEffect1054ui_story then
				arg_110_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_113_53 = arg_110_1.actors_["1075ui_story"]
			local var_113_54 = 3.83400000184774

			if var_113_54 < arg_110_1.time_ and arg_110_1.time_ <= var_113_54 + arg_113_0 and not isNil(var_113_53) and arg_110_1.var_.characterEffect1075ui_story == nil then
				arg_110_1.var_.characterEffect1075ui_story = var_113_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_55 = 0.200000002980232

			if var_113_54 <= arg_110_1.time_ and arg_110_1.time_ < var_113_54 + var_113_55 and not isNil(var_113_53) then
				local var_113_56 = (arg_110_1.time_ - var_113_54) / var_113_55

				if arg_110_1.var_.characterEffect1075ui_story and not isNil(var_113_53) then
					local var_113_57 = Mathf.Lerp(0, 0.5, var_113_56)

					arg_110_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1075ui_story.fillRatio = var_113_57
				end
			end

			if arg_110_1.time_ >= var_113_54 + var_113_55 and arg_110_1.time_ < var_113_54 + var_113_55 + arg_113_0 and not isNil(var_113_53) and arg_110_1.var_.characterEffect1075ui_story then
				local var_113_58 = 0.5

				arg_110_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1075ui_story.fillRatio = var_113_58
			end

			local var_113_59 = 3.83400000184774

			if var_113_59 < arg_110_1.time_ and arg_110_1.time_ <= var_113_59 + arg_113_0 then
				arg_110_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_113_60 = 3.83400000184774

			if var_113_60 < arg_110_1.time_ and arg_110_1.time_ <= var_113_60 + arg_113_0 then
				arg_110_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_113_61 = arg_110_1.actors_["1170ui_story"].transform
			local var_113_62 = 1.96599999815226

			if var_113_62 < arg_110_1.time_ and arg_110_1.time_ <= var_113_62 + arg_113_0 then
				arg_110_1.var_.moveOldPos1170ui_story = var_113_61.localPosition

				local var_113_63 = GameObjectTools.GetOrAddComponent(var_113_61.gameObject, typeof(DynamicBoneHelper))

				if var_113_63 then
					var_113_63:EnableDynamicBone(false)
				end
			end

			local var_113_64 = 0.001

			if var_113_62 <= arg_110_1.time_ and arg_110_1.time_ < var_113_62 + var_113_64 then
				local var_113_65 = (arg_110_1.time_ - var_113_62) / var_113_64
				local var_113_66 = Vector3.New(0, 100, 0)

				var_113_61.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1170ui_story, var_113_66, var_113_65)

				local var_113_67 = manager.ui.mainCamera.transform.position - var_113_61.position

				var_113_61.forward = Vector3.New(var_113_67.x, var_113_67.y, var_113_67.z)

				local var_113_68 = var_113_61.localEulerAngles

				var_113_68.z = 0
				var_113_68.x = 0
				var_113_61.localEulerAngles = var_113_68
			end

			if arg_110_1.time_ >= var_113_62 + var_113_64 and arg_110_1.time_ < var_113_62 + var_113_64 + arg_113_0 then
				var_113_61.localPosition = Vector3.New(0, 100, 0)

				local var_113_69 = manager.ui.mainCamera.transform.position - var_113_61.position

				var_113_61.forward = Vector3.New(var_113_69.x, var_113_69.y, var_113_69.z)

				local var_113_70 = var_113_61.localEulerAngles

				var_113_70.z = 0
				var_113_70.x = 0
				var_113_61.localEulerAngles = var_113_70

				local var_113_71 = GameObjectTools.GetOrAddComponent(var_113_61.gameObject, typeof(DynamicBoneHelper))

				if var_113_71 then
					var_113_71:EnableDynamicBone(true)
				end
			end

			local var_113_72 = 1.2
			local var_113_73 = 1

			if var_113_72 < arg_110_1.time_ and arg_110_1.time_ <= var_113_72 + arg_113_0 then
				local var_113_74 = "play"
				local var_113_75 = "effect"

				arg_110_1:AudioAction(var_113_74, var_113_75, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_113_76 = 0.1
			local var_113_77 = 1

			if var_113_76 < arg_110_1.time_ and arg_110_1.time_ <= var_113_76 + arg_113_0 then
				local var_113_78 = "stop"
				local var_113_79 = "effect"

				arg_110_1:AudioAction(var_113_78, var_113_79, "se_story_150", "se_story_150_huatian", "")
			end

			local var_113_80 = 0
			local var_113_81 = 1

			if var_113_80 < arg_110_1.time_ and arg_110_1.time_ <= var_113_80 + arg_113_0 then
				local var_113_82 = "play"
				local var_113_83 = "effect"

				arg_110_1:AudioAction(var_113_82, var_113_83, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_113_84 = 1
			local var_113_85 = 1

			if var_113_84 < arg_110_1.time_ and arg_110_1.time_ <= var_113_84 + arg_113_0 then
				local var_113_86 = "play"
				local var_113_87 = "music"

				arg_110_1:AudioAction(var_113_86, var_113_87, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_113_88 = ""
				local var_113_89 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if var_113_89 ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_89 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_89

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_89
						arg_110_1.bgmTxt2_.text = var_113_89
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_90 = 3.874999999999
			local var_113_91 = 0.125

			if var_113_90 < arg_110_1.time_ and arg_110_1.time_ <= var_113_90 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_92 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_92:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_110_1.dialogCg_.alpha = arg_115_0
				end))
				var_113_92:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_92:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_93 = arg_110_1:FormatText(StoryNameCfg[1487].name)

				arg_110_1.leftNameTxt_.text = var_113_93

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_94 = arg_110_1:GetWordFromCfg(324551027)
				local var_113_95 = arg_110_1:FormatText(var_113_94.content)

				arg_110_1.text_.text = var_113_95

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_96 = 5
				local var_113_97 = utf8.len(var_113_95)
				local var_113_98 = var_113_96 <= 0 and var_113_91 or var_113_91 * (var_113_97 / var_113_96)

				if var_113_98 > 0 and var_113_91 < var_113_98 then
					arg_110_1.talkMaxDuration = var_113_98
					var_113_90 = var_113_90 + 0.3

					if var_113_98 + var_113_90 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_98 + var_113_90
					end
				end

				arg_110_1.text_.text = var_113_95
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551027", "story_v_out_324551.awb") ~= 0 then
					local var_113_99 = manager.audio:GetVoiceLength("story_v_out_324551", "324551027", "story_v_out_324551.awb") / 1000

					if var_113_99 + var_113_90 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_99 + var_113_90
					end

					if var_113_94.prefab_name ~= "" and arg_110_1.actors_[var_113_94.prefab_name] ~= nil then
						local var_113_100 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_94.prefab_name].transform, "story_v_out_324551", "324551027", "story_v_out_324551.awb")

						arg_110_1:RecordAudio("324551027", var_113_100)
						arg_110_1:RecordAudio("324551027", var_113_100)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324551", "324551027", "story_v_out_324551.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324551", "324551027", "story_v_out_324551.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_101 = var_113_90 + 0.3
			local var_113_102 = math.max(var_113_91, arg_110_1.talkMaxDuration)

			if var_113_101 <= arg_110_1.time_ and arg_110_1.time_ < var_113_101 + var_113_102 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_101) / var_113_102

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_101 + var_113_102 and arg_110_1.time_ < var_113_101 + var_113_102 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play324551028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 324551028
		arg_117_1.duration_ = 2

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play324551029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1054ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1054ui_story = var_120_0.localPosition

				local var_120_2 = GameObjectTools.GetOrAddComponent(var_120_0.gameObject, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(false)
				end
			end

			local var_120_3 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_3 then
				local var_120_4 = (arg_117_1.time_ - var_120_1) / var_120_3
				local var_120_5 = Vector3.New(-0.7, -0.985, -6)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1054ui_story, var_120_5, var_120_4)

				local var_120_6 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_6.x, var_120_6.y, var_120_6.z)

				local var_120_7 = var_120_0.localEulerAngles

				var_120_7.z = 0
				var_120_7.x = 0
				var_120_0.localEulerAngles = var_120_7
			end

			if arg_117_1.time_ >= var_120_1 + var_120_3 and arg_117_1.time_ < var_120_1 + var_120_3 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_120_8 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_8.x, var_120_8.y, var_120_8.z)

				local var_120_9 = var_120_0.localEulerAngles

				var_120_9.z = 0
				var_120_9.x = 0
				var_120_0.localEulerAngles = var_120_9

				local var_120_10 = GameObjectTools.GetOrAddComponent(var_120_0.gameObject, typeof(DynamicBoneHelper))

				if var_120_10 then
					var_120_10:EnableDynamicBone(true)
				end
			end

			local var_120_11 = arg_117_1.actors_["6148ui_story"].transform
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.var_.moveOldPos6148ui_story = var_120_11.localPosition

				local var_120_13 = GameObjectTools.GetOrAddComponent(var_120_11.gameObject, typeof(DynamicBoneHelper))

				if var_120_13 then
					var_120_13:EnableDynamicBone(false)
				end
			end

			local var_120_14 = 0.001

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_14 then
				local var_120_15 = (arg_117_1.time_ - var_120_12) / var_120_14
				local var_120_16 = Vector3.New(0.7, -0.985, -6)

				var_120_11.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos6148ui_story, var_120_16, var_120_15)

				local var_120_17 = manager.ui.mainCamera.transform.position - var_120_11.position

				var_120_11.forward = Vector3.New(var_120_17.x, var_120_17.y, var_120_17.z)

				local var_120_18 = var_120_11.localEulerAngles

				var_120_18.z = 0
				var_120_18.x = 0
				var_120_11.localEulerAngles = var_120_18
			end

			if arg_117_1.time_ >= var_120_12 + var_120_14 and arg_117_1.time_ < var_120_12 + var_120_14 + arg_120_0 then
				var_120_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_120_19 = manager.ui.mainCamera.transform.position - var_120_11.position

				var_120_11.forward = Vector3.New(var_120_19.x, var_120_19.y, var_120_19.z)

				local var_120_20 = var_120_11.localEulerAngles

				var_120_20.z = 0
				var_120_20.x = 0
				var_120_11.localEulerAngles = var_120_20

				local var_120_21 = GameObjectTools.GetOrAddComponent(var_120_11.gameObject, typeof(DynamicBoneHelper))

				if var_120_21 then
					var_120_21:EnableDynamicBone(true)
				end
			end

			local var_120_22 = arg_117_1.actors_["6148ui_story"]
			local var_120_23 = 0

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.characterEffect6148ui_story == nil then
				arg_117_1.var_.characterEffect6148ui_story = var_120_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_24 = 0.200000002980232

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_24 and not isNil(var_120_22) then
				local var_120_25 = (arg_117_1.time_ - var_120_23) / var_120_24

				if arg_117_1.var_.characterEffect6148ui_story and not isNil(var_120_22) then
					arg_117_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_23 + var_120_24 and arg_117_1.time_ < var_120_23 + var_120_24 + arg_120_0 and not isNil(var_120_22) and arg_117_1.var_.characterEffect6148ui_story then
				arg_117_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_120_26 = arg_117_1.actors_["1054ui_story"]
			local var_120_27 = 0

			if var_120_27 < arg_117_1.time_ and arg_117_1.time_ <= var_120_27 + arg_120_0 and not isNil(var_120_26) and arg_117_1.var_.characterEffect1054ui_story == nil then
				arg_117_1.var_.characterEffect1054ui_story = var_120_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_28 = 0.200000002980232

			if var_120_27 <= arg_117_1.time_ and arg_117_1.time_ < var_120_27 + var_120_28 and not isNil(var_120_26) then
				local var_120_29 = (arg_117_1.time_ - var_120_27) / var_120_28

				if arg_117_1.var_.characterEffect1054ui_story and not isNil(var_120_26) then
					local var_120_30 = Mathf.Lerp(0, 0.5, var_120_29)

					arg_117_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1054ui_story.fillRatio = var_120_30
				end
			end

			if arg_117_1.time_ >= var_120_27 + var_120_28 and arg_117_1.time_ < var_120_27 + var_120_28 + arg_120_0 and not isNil(var_120_26) and arg_117_1.var_.characterEffect1054ui_story then
				local var_120_31 = 0.5

				arg_117_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1054ui_story.fillRatio = var_120_31
			end

			local var_120_32 = 0

			if var_120_32 < arg_117_1.time_ and arg_117_1.time_ <= var_120_32 + arg_120_0 then
				arg_117_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_120_33 = 0

			if var_120_33 < arg_117_1.time_ and arg_117_1.time_ <= var_120_33 + arg_120_0 then
				arg_117_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_34 = 0
			local var_120_35 = 0.2

			if var_120_34 < arg_117_1.time_ and arg_117_1.time_ <= var_120_34 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_36 = arg_117_1:FormatText(StoryNameCfg[1488].name)

				arg_117_1.leftNameTxt_.text = var_120_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_37 = arg_117_1:GetWordFromCfg(324551028)
				local var_120_38 = arg_117_1:FormatText(var_120_37.content)

				arg_117_1.text_.text = var_120_38

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_39 = 8
				local var_120_40 = utf8.len(var_120_38)
				local var_120_41 = var_120_39 <= 0 and var_120_35 or var_120_35 * (var_120_40 / var_120_39)

				if var_120_41 > 0 and var_120_35 < var_120_41 then
					arg_117_1.talkMaxDuration = var_120_41

					if var_120_41 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_41 + var_120_34
					end
				end

				arg_117_1.text_.text = var_120_38
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551028", "story_v_out_324551.awb") ~= 0 then
					local var_120_42 = manager.audio:GetVoiceLength("story_v_out_324551", "324551028", "story_v_out_324551.awb") / 1000

					if var_120_42 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_42 + var_120_34
					end

					if var_120_37.prefab_name ~= "" and arg_117_1.actors_[var_120_37.prefab_name] ~= nil then
						local var_120_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_37.prefab_name].transform, "story_v_out_324551", "324551028", "story_v_out_324551.awb")

						arg_117_1:RecordAudio("324551028", var_120_43)
						arg_117_1:RecordAudio("324551028", var_120_43)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_324551", "324551028", "story_v_out_324551.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_324551", "324551028", "story_v_out_324551.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_44 = math.max(var_120_35, arg_117_1.talkMaxDuration)

			if var_120_34 <= arg_117_1.time_ and arg_117_1.time_ < var_120_34 + var_120_44 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_34) / var_120_44

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_34 + var_120_44 and arg_117_1.time_ < var_120_34 + var_120_44 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play324551029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 324551029
		arg_121_1.duration_ = 5.43

		local var_121_0 = {
			zh = 4.633,
			ja = 5.433
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
				arg_121_0:Play324551030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1054ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1054ui_story = var_124_0.localPosition

				local var_124_2 = GameObjectTools.GetOrAddComponent(var_124_0.gameObject, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(false)
				end
			end

			local var_124_3 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_3 then
				local var_124_4 = (arg_121_1.time_ - var_124_1) / var_124_3
				local var_124_5 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1054ui_story, var_124_5, var_124_4)

				local var_124_6 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_6.x, var_124_6.y, var_124_6.z)

				local var_124_7 = var_124_0.localEulerAngles

				var_124_7.z = 0
				var_124_7.x = 0
				var_124_0.localEulerAngles = var_124_7
			end

			if arg_121_1.time_ >= var_124_1 + var_124_3 and arg_121_1.time_ < var_124_1 + var_124_3 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_8 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_8.x, var_124_8.y, var_124_8.z)

				local var_124_9 = var_124_0.localEulerAngles

				var_124_9.z = 0
				var_124_9.x = 0
				var_124_0.localEulerAngles = var_124_9

				local var_124_10 = GameObjectTools.GetOrAddComponent(var_124_0.gameObject, typeof(DynamicBoneHelper))

				if var_124_10 then
					var_124_10:EnableDynamicBone(true)
				end
			end

			local var_124_11 = arg_121_1.actors_["6148ui_story"].transform
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.var_.moveOldPos6148ui_story = var_124_11.localPosition

				local var_124_13 = GameObjectTools.GetOrAddComponent(var_124_11.gameObject, typeof(DynamicBoneHelper))

				if var_124_13 then
					var_124_13:EnableDynamicBone(false)
				end
			end

			local var_124_14 = 0.001

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_14 then
				local var_124_15 = (arg_121_1.time_ - var_124_12) / var_124_14
				local var_124_16 = Vector3.New(0, 100, 0)

				var_124_11.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos6148ui_story, var_124_16, var_124_15)

				local var_124_17 = manager.ui.mainCamera.transform.position - var_124_11.position

				var_124_11.forward = Vector3.New(var_124_17.x, var_124_17.y, var_124_17.z)

				local var_124_18 = var_124_11.localEulerAngles

				var_124_18.z = 0
				var_124_18.x = 0
				var_124_11.localEulerAngles = var_124_18
			end

			if arg_121_1.time_ >= var_124_12 + var_124_14 and arg_121_1.time_ < var_124_12 + var_124_14 + arg_124_0 then
				var_124_11.localPosition = Vector3.New(0, 100, 0)

				local var_124_19 = manager.ui.mainCamera.transform.position - var_124_11.position

				var_124_11.forward = Vector3.New(var_124_19.x, var_124_19.y, var_124_19.z)

				local var_124_20 = var_124_11.localEulerAngles

				var_124_20.z = 0
				var_124_20.x = 0
				var_124_11.localEulerAngles = var_124_20

				local var_124_21 = GameObjectTools.GetOrAddComponent(var_124_11.gameObject, typeof(DynamicBoneHelper))

				if var_124_21 then
					var_124_21:EnableDynamicBone(true)
				end
			end

			local var_124_22 = arg_121_1.actors_["1170ui_story"].transform
			local var_124_23 = 0

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.var_.moveOldPos1170ui_story = var_124_22.localPosition

				local var_124_24 = GameObjectTools.GetOrAddComponent(var_124_22.gameObject, typeof(DynamicBoneHelper))

				if var_124_24 then
					var_124_24:EnableDynamicBone(false)
				end
			end

			local var_124_25 = 0.001

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_25 then
				local var_124_26 = (arg_121_1.time_ - var_124_23) / var_124_25
				local var_124_27 = Vector3.New(0.03, -0.95, -6.08)

				var_124_22.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1170ui_story, var_124_27, var_124_26)

				local var_124_28 = manager.ui.mainCamera.transform.position - var_124_22.position

				var_124_22.forward = Vector3.New(var_124_28.x, var_124_28.y, var_124_28.z)

				local var_124_29 = var_124_22.localEulerAngles

				var_124_29.z = 0
				var_124_29.x = 0
				var_124_22.localEulerAngles = var_124_29
			end

			if arg_121_1.time_ >= var_124_23 + var_124_25 and arg_121_1.time_ < var_124_23 + var_124_25 + arg_124_0 then
				var_124_22.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_124_30 = manager.ui.mainCamera.transform.position - var_124_22.position

				var_124_22.forward = Vector3.New(var_124_30.x, var_124_30.y, var_124_30.z)

				local var_124_31 = var_124_22.localEulerAngles

				var_124_31.z = 0
				var_124_31.x = 0
				var_124_22.localEulerAngles = var_124_31

				local var_124_32 = GameObjectTools.GetOrAddComponent(var_124_22.gameObject, typeof(DynamicBoneHelper))

				if var_124_32 then
					var_124_32:EnableDynamicBone(true)
				end
			end

			local var_124_33 = arg_121_1.actors_["1170ui_story"]
			local var_124_34 = 0

			if var_124_34 < arg_121_1.time_ and arg_121_1.time_ <= var_124_34 + arg_124_0 and not isNil(var_124_33) and arg_121_1.var_.characterEffect1170ui_story == nil then
				arg_121_1.var_.characterEffect1170ui_story = var_124_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_35 = 0.200000002980232

			if var_124_34 <= arg_121_1.time_ and arg_121_1.time_ < var_124_34 + var_124_35 and not isNil(var_124_33) then
				local var_124_36 = (arg_121_1.time_ - var_124_34) / var_124_35

				if arg_121_1.var_.characterEffect1170ui_story and not isNil(var_124_33) then
					arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_34 + var_124_35 and arg_121_1.time_ < var_124_34 + var_124_35 + arg_124_0 and not isNil(var_124_33) and arg_121_1.var_.characterEffect1170ui_story then
				arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_124_37 = arg_121_1.actors_["6148ui_story"]
			local var_124_38 = 0

			if var_124_38 < arg_121_1.time_ and arg_121_1.time_ <= var_124_38 + arg_124_0 and not isNil(var_124_37) and arg_121_1.var_.characterEffect6148ui_story == nil then
				arg_121_1.var_.characterEffect6148ui_story = var_124_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_39 = 0.200000002980232

			if var_124_38 <= arg_121_1.time_ and arg_121_1.time_ < var_124_38 + var_124_39 and not isNil(var_124_37) then
				local var_124_40 = (arg_121_1.time_ - var_124_38) / var_124_39

				if arg_121_1.var_.characterEffect6148ui_story and not isNil(var_124_37) then
					local var_124_41 = Mathf.Lerp(0, 0.5, var_124_40)

					arg_121_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_121_1.var_.characterEffect6148ui_story.fillRatio = var_124_41
				end
			end

			if arg_121_1.time_ >= var_124_38 + var_124_39 and arg_121_1.time_ < var_124_38 + var_124_39 + arg_124_0 and not isNil(var_124_37) and arg_121_1.var_.characterEffect6148ui_story then
				local var_124_42 = 0.5

				arg_121_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_121_1.var_.characterEffect6148ui_story.fillRatio = var_124_42
			end

			local var_124_43 = 0

			if var_124_43 < arg_121_1.time_ and arg_121_1.time_ <= var_124_43 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_124_44 = 0

			if var_124_44 < arg_121_1.time_ and arg_121_1.time_ <= var_124_44 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_1")
			end

			local var_124_45 = 0
			local var_124_46 = 0.45

			if var_124_45 < arg_121_1.time_ and arg_121_1.time_ <= var_124_45 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_47 = arg_121_1:FormatText(StoryNameCfg[318].name)

				arg_121_1.leftNameTxt_.text = var_124_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_48 = arg_121_1:GetWordFromCfg(324551029)
				local var_124_49 = arg_121_1:FormatText(var_124_48.content)

				arg_121_1.text_.text = var_124_49

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_50 = 18
				local var_124_51 = utf8.len(var_124_49)
				local var_124_52 = var_124_50 <= 0 and var_124_46 or var_124_46 * (var_124_51 / var_124_50)

				if var_124_52 > 0 and var_124_46 < var_124_52 then
					arg_121_1.talkMaxDuration = var_124_52

					if var_124_52 + var_124_45 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_52 + var_124_45
					end
				end

				arg_121_1.text_.text = var_124_49
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551029", "story_v_out_324551.awb") ~= 0 then
					local var_124_53 = manager.audio:GetVoiceLength("story_v_out_324551", "324551029", "story_v_out_324551.awb") / 1000

					if var_124_53 + var_124_45 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_53 + var_124_45
					end

					if var_124_48.prefab_name ~= "" and arg_121_1.actors_[var_124_48.prefab_name] ~= nil then
						local var_124_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_48.prefab_name].transform, "story_v_out_324551", "324551029", "story_v_out_324551.awb")

						arg_121_1:RecordAudio("324551029", var_124_54)
						arg_121_1:RecordAudio("324551029", var_124_54)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_324551", "324551029", "story_v_out_324551.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_324551", "324551029", "story_v_out_324551.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_55 = math.max(var_124_46, arg_121_1.talkMaxDuration)

			if var_124_45 <= arg_121_1.time_ and arg_121_1.time_ < var_124_45 + var_124_55 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_45) / var_124_55

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_45 + var_124_55 and arg_121_1.time_ < var_124_45 + var_124_55 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play324551030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 324551030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play324551031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1170ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1170ui_story = var_128_0.localPosition

				local var_128_2 = GameObjectTools.GetOrAddComponent(var_128_0.gameObject, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(false)
				end
			end

			local var_128_3 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_3 then
				local var_128_4 = (arg_125_1.time_ - var_128_1) / var_128_3
				local var_128_5 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1170ui_story, var_128_5, var_128_4)

				local var_128_6 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_6.x, var_128_6.y, var_128_6.z)

				local var_128_7 = var_128_0.localEulerAngles

				var_128_7.z = 0
				var_128_7.x = 0
				var_128_0.localEulerAngles = var_128_7
			end

			if arg_125_1.time_ >= var_128_1 + var_128_3 and arg_125_1.time_ < var_128_1 + var_128_3 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_8 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_8.x, var_128_8.y, var_128_8.z)

				local var_128_9 = var_128_0.localEulerAngles

				var_128_9.z = 0
				var_128_9.x = 0
				var_128_0.localEulerAngles = var_128_9

				local var_128_10 = GameObjectTools.GetOrAddComponent(var_128_0.gameObject, typeof(DynamicBoneHelper))

				if var_128_10 then
					var_128_10:EnableDynamicBone(true)
				end
			end

			local var_128_11 = arg_125_1.actors_["1170ui_story"]
			local var_128_12 = 0

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 and not isNil(var_128_11) and arg_125_1.var_.characterEffect1170ui_story == nil then
				arg_125_1.var_.characterEffect1170ui_story = var_128_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_13 = 0.200000002980232

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_13 and not isNil(var_128_11) then
				local var_128_14 = (arg_125_1.time_ - var_128_12) / var_128_13

				if arg_125_1.var_.characterEffect1170ui_story and not isNil(var_128_11) then
					local var_128_15 = Mathf.Lerp(0, 0.5, var_128_14)

					arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1170ui_story.fillRatio = var_128_15
				end
			end

			if arg_125_1.time_ >= var_128_12 + var_128_13 and arg_125_1.time_ < var_128_12 + var_128_13 + arg_128_0 and not isNil(var_128_11) and arg_125_1.var_.characterEffect1170ui_story then
				local var_128_16 = 0.5

				arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1170ui_story.fillRatio = var_128_16
			end

			local var_128_17 = 0
			local var_128_18 = 0.975

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_19 = arg_125_1:GetWordFromCfg(324551030)
				local var_128_20 = arg_125_1:FormatText(var_128_19.content)

				arg_125_1.text_.text = var_128_20

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_21 = 39
				local var_128_22 = utf8.len(var_128_20)
				local var_128_23 = var_128_21 <= 0 and var_128_18 or var_128_18 * (var_128_22 / var_128_21)

				if var_128_23 > 0 and var_128_18 < var_128_23 then
					arg_125_1.talkMaxDuration = var_128_23

					if var_128_23 + var_128_17 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_17
					end
				end

				arg_125_1.text_.text = var_128_20
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_24 = math.max(var_128_18, arg_125_1.talkMaxDuration)

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_17) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_17 + var_128_24 and arg_125_1.time_ < var_128_17 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play324551031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 324551031
		arg_129_1.duration_ = 7.37

		local var_129_0 = {
			zh = 4.366,
			ja = 7.366
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
				arg_129_0:Play324551032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1071ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1071ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1071ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1071ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1071ui_story == nil then
				arg_129_1.var_.characterEffect1071ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1071ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1071ui_story then
				arg_129_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_132_14 = 0
			local var_132_15 = 0.6

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_16 = arg_129_1:FormatText(StoryNameCfg[384].name)

				arg_129_1.leftNameTxt_.text = var_132_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_17 = arg_129_1:GetWordFromCfg(324551031)
				local var_132_18 = arg_129_1:FormatText(var_132_17.content)

				arg_129_1.text_.text = var_132_18

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_19 = 24
				local var_132_20 = utf8.len(var_132_18)
				local var_132_21 = var_132_19 <= 0 and var_132_15 or var_132_15 * (var_132_20 / var_132_19)

				if var_132_21 > 0 and var_132_15 < var_132_21 then
					arg_129_1.talkMaxDuration = var_132_21

					if var_132_21 + var_132_14 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_21 + var_132_14
					end
				end

				arg_129_1.text_.text = var_132_18
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551031", "story_v_out_324551.awb") ~= 0 then
					local var_132_22 = manager.audio:GetVoiceLength("story_v_out_324551", "324551031", "story_v_out_324551.awb") / 1000

					if var_132_22 + var_132_14 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_14
					end

					if var_132_17.prefab_name ~= "" and arg_129_1.actors_[var_132_17.prefab_name] ~= nil then
						local var_132_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_17.prefab_name].transform, "story_v_out_324551", "324551031", "story_v_out_324551.awb")

						arg_129_1:RecordAudio("324551031", var_132_23)
						arg_129_1:RecordAudio("324551031", var_132_23)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_324551", "324551031", "story_v_out_324551.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_324551", "324551031", "story_v_out_324551.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_24 = math.max(var_132_15, arg_129_1.talkMaxDuration)

			if var_132_14 <= arg_129_1.time_ and arg_129_1.time_ < var_132_14 + var_132_24 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_14) / var_132_24

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_14 + var_132_24 and arg_129_1.time_ < var_132_14 + var_132_24 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play324551032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 324551032
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_133_0:Play324551033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1170ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1170ui_story = var_136_0.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Vector3.New(0.74, -0.95, -6.08)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1170ui_story, var_136_5, var_136_4)

				local var_136_6 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_6.x, var_136_6.y, var_136_6.z)

				local var_136_7 = var_136_0.localEulerAngles

				var_136_7.z = 0
				var_136_7.x = 0
				var_136_0.localEulerAngles = var_136_7
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0.74, -0.95, -6.08)

				local var_136_8 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_8.x, var_136_8.y, var_136_8.z)

				local var_136_9 = var_136_0.localEulerAngles

				var_136_9.z = 0
				var_136_9.x = 0
				var_136_0.localEulerAngles = var_136_9

				local var_136_10 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_10 then
					var_136_10:EnableDynamicBone(true)
				end
			end

			local var_136_11 = arg_133_1.actors_["1170ui_story"]
			local var_136_12 = 0

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1170ui_story == nil then
				arg_133_1.var_.characterEffect1170ui_story = var_136_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_13 = 0.200000002980232

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 and not isNil(var_136_11) then
				local var_136_14 = (arg_133_1.time_ - var_136_12) / var_136_13

				if arg_133_1.var_.characterEffect1170ui_story and not isNil(var_136_11) then
					arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1170ui_story then
				arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_136_15 = arg_133_1.actors_["1071ui_story"]
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.characterEffect1071ui_story == nil then
				arg_133_1.var_.characterEffect1071ui_story = var_136_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_17 = 0.200000002980232

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 and not isNil(var_136_15) then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17

				if arg_133_1.var_.characterEffect1071ui_story and not isNil(var_136_15) then
					local var_136_19 = Mathf.Lerp(0, 0.5, var_136_18)

					arg_133_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1071ui_story.fillRatio = var_136_19
				end
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.characterEffect1071ui_story then
				local var_136_20 = 0.5

				arg_133_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1071ui_story.fillRatio = var_136_20
			end

			local var_136_21 = 0

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			local var_136_22 = 0

			if var_136_22 < arg_133_1.time_ and arg_133_1.time_ <= var_136_22 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_136_23 = 0
			local var_136_24 = 0.2

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_25 = arg_133_1:FormatText(StoryNameCfg[318].name)

				arg_133_1.leftNameTxt_.text = var_136_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_26 = arg_133_1:GetWordFromCfg(324551032)
				local var_136_27 = arg_133_1:FormatText(var_136_26.content)

				arg_133_1.text_.text = var_136_27

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_28 = 8
				local var_136_29 = utf8.len(var_136_27)
				local var_136_30 = var_136_28 <= 0 and var_136_24 or var_136_24 * (var_136_29 / var_136_28)

				if var_136_30 > 0 and var_136_24 < var_136_30 then
					arg_133_1.talkMaxDuration = var_136_30

					if var_136_30 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_30 + var_136_23
					end
				end

				arg_133_1.text_.text = var_136_27
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551032", "story_v_out_324551.awb") ~= 0 then
					local var_136_31 = manager.audio:GetVoiceLength("story_v_out_324551", "324551032", "story_v_out_324551.awb") / 1000

					if var_136_31 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_23
					end

					if var_136_26.prefab_name ~= "" and arg_133_1.actors_[var_136_26.prefab_name] ~= nil then
						local var_136_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_26.prefab_name].transform, "story_v_out_324551", "324551032", "story_v_out_324551.awb")

						arg_133_1:RecordAudio("324551032", var_136_32)
						arg_133_1:RecordAudio("324551032", var_136_32)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_324551", "324551032", "story_v_out_324551.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_324551", "324551032", "story_v_out_324551.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_33 = math.max(var_136_24, arg_133_1.talkMaxDuration)

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_33 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_23) / var_136_33

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_23 + var_136_33 and arg_133_1.time_ < var_136_23 + var_136_33 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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
	Play324551033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 324551033
		arg_137_1.duration_ = 6.53

		local var_137_0 = {
			zh = 4.9,
			ja = 6.533
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
				arg_137_0:Play324551034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1170ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1170ui_story = var_140_0.localPosition

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0.gameObject, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end
			end

			local var_140_3 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_3 then
				local var_140_4 = (arg_137_1.time_ - var_140_1) / var_140_3
				local var_140_5 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1170ui_story, var_140_5, var_140_4)

				local var_140_6 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_6.x, var_140_6.y, var_140_6.z)

				local var_140_7 = var_140_0.localEulerAngles

				var_140_7.z = 0
				var_140_7.x = 0
				var_140_0.localEulerAngles = var_140_7
			end

			if arg_137_1.time_ >= var_140_1 + var_140_3 and arg_137_1.time_ < var_140_1 + var_140_3 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_8 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_8.x, var_140_8.y, var_140_8.z)

				local var_140_9 = var_140_0.localEulerAngles

				var_140_9.z = 0
				var_140_9.x = 0
				var_140_0.localEulerAngles = var_140_9

				local var_140_10 = GameObjectTools.GetOrAddComponent(var_140_0.gameObject, typeof(DynamicBoneHelper))

				if var_140_10 then
					var_140_10:EnableDynamicBone(true)
				end
			end

			local var_140_11 = arg_137_1.actors_["1075ui_story"].transform
			local var_140_12 = 0

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.var_.moveOldPos1075ui_story = var_140_11.localPosition
			end

			local var_140_13 = 0.001

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_13 then
				local var_140_14 = (arg_137_1.time_ - var_140_12) / var_140_13
				local var_140_15 = Vector3.New(0.7, -1.055, -6.16)

				var_140_11.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1075ui_story, var_140_15, var_140_14)

				local var_140_16 = manager.ui.mainCamera.transform.position - var_140_11.position

				var_140_11.forward = Vector3.New(var_140_16.x, var_140_16.y, var_140_16.z)

				local var_140_17 = var_140_11.localEulerAngles

				var_140_17.z = 0
				var_140_17.x = 0
				var_140_11.localEulerAngles = var_140_17
			end

			if arg_137_1.time_ >= var_140_12 + var_140_13 and arg_137_1.time_ < var_140_12 + var_140_13 + arg_140_0 then
				var_140_11.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_140_18 = manager.ui.mainCamera.transform.position - var_140_11.position

				var_140_11.forward = Vector3.New(var_140_18.x, var_140_18.y, var_140_18.z)

				local var_140_19 = var_140_11.localEulerAngles

				var_140_19.z = 0
				var_140_19.x = 0
				var_140_11.localEulerAngles = var_140_19
			end

			local var_140_20 = arg_137_1.actors_["1075ui_story"]
			local var_140_21 = 0

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 and not isNil(var_140_20) and arg_137_1.var_.characterEffect1075ui_story == nil then
				arg_137_1.var_.characterEffect1075ui_story = var_140_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_22 = 0.200000002980232

			if var_140_21 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_22 and not isNil(var_140_20) then
				local var_140_23 = (arg_137_1.time_ - var_140_21) / var_140_22

				if arg_137_1.var_.characterEffect1075ui_story and not isNil(var_140_20) then
					arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_21 + var_140_22 and arg_137_1.time_ < var_140_21 + var_140_22 + arg_140_0 and not isNil(var_140_20) and arg_137_1.var_.characterEffect1075ui_story then
				arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_140_24 = arg_137_1.actors_["1170ui_story"]
			local var_140_25 = 0

			if var_140_25 < arg_137_1.time_ and arg_137_1.time_ <= var_140_25 + arg_140_0 and not isNil(var_140_24) and arg_137_1.var_.characterEffect1170ui_story == nil then
				arg_137_1.var_.characterEffect1170ui_story = var_140_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_26 = 0.200000002980232

			if var_140_25 <= arg_137_1.time_ and arg_137_1.time_ < var_140_25 + var_140_26 and not isNil(var_140_24) then
				local var_140_27 = (arg_137_1.time_ - var_140_25) / var_140_26

				if arg_137_1.var_.characterEffect1170ui_story and not isNil(var_140_24) then
					local var_140_28 = Mathf.Lerp(0, 0.5, var_140_27)

					arg_137_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1170ui_story.fillRatio = var_140_28
				end
			end

			if arg_137_1.time_ >= var_140_25 + var_140_26 and arg_137_1.time_ < var_140_25 + var_140_26 + arg_140_0 and not isNil(var_140_24) and arg_137_1.var_.characterEffect1170ui_story then
				local var_140_29 = 0.5

				arg_137_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1170ui_story.fillRatio = var_140_29
			end

			local var_140_30 = 0

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_140_31 = 0

			if var_140_31 < arg_137_1.time_ and arg_137_1.time_ <= var_140_31 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_140_32 = 0
			local var_140_33 = 0.525

			if var_140_32 < arg_137_1.time_ and arg_137_1.time_ <= var_140_32 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_34 = arg_137_1:FormatText(StoryNameCfg[381].name)

				arg_137_1.leftNameTxt_.text = var_140_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_35 = arg_137_1:GetWordFromCfg(324551033)
				local var_140_36 = arg_137_1:FormatText(var_140_35.content)

				arg_137_1.text_.text = var_140_36

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_37 = 21
				local var_140_38 = utf8.len(var_140_36)
				local var_140_39 = var_140_37 <= 0 and var_140_33 or var_140_33 * (var_140_38 / var_140_37)

				if var_140_39 > 0 and var_140_33 < var_140_39 then
					arg_137_1.talkMaxDuration = var_140_39

					if var_140_39 + var_140_32 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_39 + var_140_32
					end
				end

				arg_137_1.text_.text = var_140_36
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551033", "story_v_out_324551.awb") ~= 0 then
					local var_140_40 = manager.audio:GetVoiceLength("story_v_out_324551", "324551033", "story_v_out_324551.awb") / 1000

					if var_140_40 + var_140_32 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_40 + var_140_32
					end

					if var_140_35.prefab_name ~= "" and arg_137_1.actors_[var_140_35.prefab_name] ~= nil then
						local var_140_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_35.prefab_name].transform, "story_v_out_324551", "324551033", "story_v_out_324551.awb")

						arg_137_1:RecordAudio("324551033", var_140_41)
						arg_137_1:RecordAudio("324551033", var_140_41)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_324551", "324551033", "story_v_out_324551.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_324551", "324551033", "story_v_out_324551.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_42 = math.max(var_140_33, arg_137_1.talkMaxDuration)

			if var_140_32 <= arg_137_1.time_ and arg_137_1.time_ < var_140_32 + var_140_42 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_32) / var_140_42

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_32 + var_140_42 and arg_137_1.time_ < var_140_32 + var_140_42 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play324551034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 324551034
		arg_141_1.duration_ = 9.4

		local var_141_0 = {
			zh = 7.866,
			ja = 9.4
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
				arg_141_0:Play324551035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1071ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1071ui_story == nil then
				arg_141_1.var_.characterEffect1071ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1071ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1071ui_story then
				arg_141_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["1075ui_story"]
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1075ui_story == nil then
				arg_141_1.var_.characterEffect1075ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 and not isNil(var_144_4) then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6

				if arg_141_1.var_.characterEffect1075ui_story and not isNil(var_144_4) then
					local var_144_8 = Mathf.Lerp(0, 0.5, var_144_7)

					arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1075ui_story.fillRatio = var_144_8
				end
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1075ui_story then
				local var_144_9 = 0.5

				arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1075ui_story.fillRatio = var_144_9
			end

			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			local var_144_11 = 0

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_12 = 0
			local var_144_13 = 0.9

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[384].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(324551034)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 36
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551034", "story_v_out_324551.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_324551", "324551034", "story_v_out_324551.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_324551", "324551034", "story_v_out_324551.awb")

						arg_141_1:RecordAudio("324551034", var_144_21)
						arg_141_1:RecordAudio("324551034", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_324551", "324551034", "story_v_out_324551.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_324551", "324551034", "story_v_out_324551.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play324551035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 324551035
		arg_145_1.duration_ = 11.8

		local var_145_0 = {
			zh = 8.6,
			ja = 11.8
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
			arg_145_1.auto_ = false
		end

		function arg_145_1.playNext_(arg_147_0)
			arg_145_1.onStoryFinished_()
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.7

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[384].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(324551035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551035", "story_v_out_324551.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_324551", "324551035", "story_v_out_324551.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_324551", "324551035", "story_v_out_324551.awb")

						arg_145_1:RecordAudio("324551035", var_148_9)
						arg_145_1:RecordAudio("324551035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_324551", "324551035", "story_v_out_324551.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_324551", "324551035", "story_v_out_324551.awb")
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
	assets = {
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324551.awb"
	}
}
