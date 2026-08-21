return {
	Play1108408001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108408001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108408002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H02"

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
				local var_4_5 = arg_1_1.bgs_.H02

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
					if iter_4_0 ~= "H02" then
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

			local var_4_24 = 1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

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

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_34 = 0.2
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_133", "se_story_133_sea", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.275

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

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(1108408001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 11
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
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_38 + 0.3
			local var_4_48 = math.max(var_4_39, arg_1_1.talkMaxDuration)

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
	Play1108408002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108408002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108408003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.1

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

				local var_11_2 = arg_8_1:GetWordFromCfg(1108408002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 44
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
	Play1108408003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108408003
		arg_12_1.duration_ = 5.97

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108408004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1084ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0, -0.97, -6)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1084ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_15_20 = 0
			local var_15_21 = 0.5

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(1108408003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb")

						arg_12_1:RecordAudio("1108408003", var_15_29)
						arg_12_1:RecordAudio("1108408003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408003", "story_v_side_new_1108408.awb")
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
				actorName = "1084ui_story",
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
	Play1108408004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108408004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108408005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1084ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_14
			end

			local var_19_15 = 0
			local var_19_16 = 1.25

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(1108408004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 50
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_16 or var_19_16 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_16 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_22 and arg_16_1.time_ < var_19_15 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play1108408005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108408005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108408006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.75

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(1108408005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 30
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
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1108408006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108408006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108408007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.3

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(1108408006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 52
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108408007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108408007
		arg_28_1.duration_ = 14.27

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1108408008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1084ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0, -0.97, -6)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1084ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_9) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_31_15 = 0
			local var_31_16 = 1.15

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(1108408007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 46
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb")

						arg_28_1:RecordAudio("1108408007", var_31_24)
						arg_28_1:RecordAudio("1108408007", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408007", "story_v_side_new_1108408.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play1108408008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108408008
		arg_32_1.duration_ = 10.97

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1108408009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.025

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(1108408008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb")

						arg_32_1:RecordAudio("1108408008", var_35_9)
						arg_32_1:RecordAudio("1108408008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408008", "story_v_side_new_1108408.awb")
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
	Play1108408009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108408009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108408010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1084ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.6

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(1108408009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 24
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1108408010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108408010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108408011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_4, var_43_3)

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

			local var_43_9 = 0
			local var_43_10 = 1.025

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_11 = arg_40_1:GetWordFromCfg(1108408010)
				local var_43_12 = arg_40_1:FormatText(var_43_11.content)

				arg_40_1.text_.text = var_43_12

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 41
				local var_43_14 = utf8.len(var_43_12)
				local var_43_15 = var_43_13 <= 0 and var_43_10 or var_43_10 * (var_43_14 / var_43_13)

				if var_43_15 > 0 and var_43_10 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_9 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_9
					end
				end

				arg_40_1.text_.text = var_43_12
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_10, arg_40_1.talkMaxDuration)

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_9) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_9 + var_43_16 and arg_40_1.time_ < var_43_9 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play1108408011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1108408011
		arg_44_1.duration_ = 3.4

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1108408012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -0.97, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1084ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 0.15

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(1108408011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 6
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb")

						arg_44_1:RecordAudio("1108408011", var_47_24)
						arg_44_1:RecordAudio("1108408011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408011", "story_v_side_new_1108408.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play1108408012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108408012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108408013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1084ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_9) then
					local var_51_13 = Mathf.Lerp(0, 0.5, var_51_12)

					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_13
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1084ui_story then
				local var_51_14 = 0.5

				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = var_51_14
			end

			local var_51_15 = 0
			local var_51_16 = 1.325

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_17 = arg_48_1:GetWordFromCfg(1108408012)
				local var_51_18 = arg_48_1:FormatText(var_51_17.content)

				arg_48_1.text_.text = var_51_18

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 53
				local var_51_20 = utf8.len(var_51_18)
				local var_51_21 = var_51_19 <= 0 and var_51_16 or var_51_16 * (var_51_20 / var_51_19)

				if var_51_21 > 0 and var_51_16 < var_51_21 then
					arg_48_1.talkMaxDuration = var_51_21

					if var_51_21 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_21 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_18
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_22 and arg_48_1.time_ < var_51_15 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play1108408013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108408013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108408014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1.55

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(1108408013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 62
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108408014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108408014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108408015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1.125

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(1108408014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 45
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108408015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108408015
		arg_60_1.duration_ = 3.77

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108408016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -0.97, -6)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["1084ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_63_15 = 0
			local var_63_16 = 0.35

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(1108408015)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 14
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb")

						arg_60_1:RecordAudio("1108408015", var_63_24)
						arg_60_1:RecordAudio("1108408015", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408015", "story_v_side_new_1108408.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play1108408016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108408016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108408017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1084ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.4

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(1108408016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 16
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108408017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108408017
		arg_68_1.duration_ = 2.3

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108408018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_71_6 = 0
			local var_71_7 = 0.175

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_9 = arg_68_1:GetWordFromCfg(1108408017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 7
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb")

						arg_68_1:RecordAudio("1108408017", var_71_15)
						arg_68_1:RecordAudio("1108408017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408017", "story_v_side_new_1108408.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_16 and arg_68_1.time_ < var_71_6 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1108408018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108408018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108408019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.475

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(1108408018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 19
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108408019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108408019
		arg_76_1.duration_ = 2.3

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108408020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1084ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_6 = 0
			local var_79_7 = 0.25

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[6].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_9 = arg_76_1:GetWordFromCfg(1108408019)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 10
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb") / 1000

					if var_79_14 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_6
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb")

						arg_76_1:RecordAudio("1108408019", var_79_15)
						arg_76_1:RecordAudio("1108408019", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408019", "story_v_side_new_1108408.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_16 and arg_76_1.time_ < var_79_6 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108408020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108408020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108408021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1084ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1084ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_9) then
					local var_83_13 = Mathf.Lerp(0, 0.5, var_83_12)

					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_13
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1084ui_story then
				local var_83_14 = 0.5

				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_14
			end

			local var_83_15 = 0
			local var_83_16 = 0.95

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_17 = arg_80_1:GetWordFromCfg(1108408020)
				local var_83_18 = arg_80_1:FormatText(var_83_17.content)

				arg_80_1.text_.text = var_83_18

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_19 = 38
				local var_83_20 = utf8.len(var_83_18)
				local var_83_21 = var_83_19 <= 0 and var_83_16 or var_83_16 * (var_83_20 / var_83_19)

				if var_83_21 > 0 and var_83_16 < var_83_21 then
					arg_80_1.talkMaxDuration = var_83_21

					if var_83_21 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_21 + var_83_15
					end
				end

				arg_80_1.text_.text = var_83_18
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_16, arg_80_1.talkMaxDuration)

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_15) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_15 + var_83_22 and arg_80_1.time_ < var_83_15 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play1108408021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108408021
		arg_84_1.duration_ = 11.37

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108408022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, -0.97, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["1084ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_87_15 = 0
			local var_87_16 = 1

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(1108408021)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 40
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb")

						arg_84_1:RecordAudio("1108408021", var_87_24)
						arg_84_1:RecordAudio("1108408021", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408021", "story_v_side_new_1108408.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play1108408022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108408022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108408023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1084ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.75

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(1108408022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 30
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108408023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108408023
		arg_92_1.duration_ = 2.2

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108408024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1084ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_4 = 0

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_95_6 = 0
			local var_95_7 = 0.225

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[6].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:GetWordFromCfg(1108408023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 9
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb")

						arg_92_1:RecordAudio("1108408023", var_95_15)
						arg_92_1:RecordAudio("1108408023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408023", "story_v_side_new_1108408.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_16 and arg_92_1.time_ < var_95_6 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108408024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108408024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1108408025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1084ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1084ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, 100, 0)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1084ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, 100, 0)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1084ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1084ui_story and not isNil(var_99_9) then
					local var_99_13 = Mathf.Lerp(0, 0.5, var_99_12)

					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_13
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1084ui_story then
				local var_99_14 = 0.5

				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = var_99_14
			end

			local var_99_15 = manager.ui.mainCamera.transform
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				local var_99_17 = arg_96_1.var_.effectxiyangluoxia
				local var_99_18
				local var_99_19 = var_99_15

				if not var_99_17 then
					var_99_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_guangban2"), var_99_19)
					var_99_17.name = "xiyangluoxia"
					arg_96_1.var_.effectxiyangluoxia = var_99_17
				else
					var_99_17.transform:SetParent(var_99_19)
				end

				var_99_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_99_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_99_20 = 1.7777777777777777
				local var_99_21 = Screen.width / Screen.height
				local var_99_22 = var_99_21 / var_99_20
				local var_99_23 = Mathf.Max(var_99_20 / var_99_21, 1)
				local var_99_24 = Mathf.Max(var_99_22, var_99_23)

				var_99_17.transform.localScale = Vector3.New(var_99_17.transform.localScale.x * var_99_24, var_99_17.transform.localScale.y * var_99_24, var_99_17.transform.localScale.z * var_99_24)
			end

			local var_99_25 = 0
			local var_99_26 = 1.15

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_27 = arg_96_1:GetWordFromCfg(1108408024)
				local var_99_28 = arg_96_1:FormatText(var_99_27.content)

				arg_96_1.text_.text = var_99_28

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_29 = 46
				local var_99_30 = utf8.len(var_99_28)
				local var_99_31 = var_99_29 <= 0 and var_99_26 or var_99_26 * (var_99_30 / var_99_29)

				if var_99_31 > 0 and var_99_26 < var_99_31 then
					arg_96_1.talkMaxDuration = var_99_31

					if var_99_31 + var_99_25 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_31 + var_99_25
					end
				end

				arg_96_1.text_.text = var_99_28
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_32 = math.max(var_99_26, arg_96_1.talkMaxDuration)

			if var_99_25 <= arg_96_1.time_ and arg_96_1.time_ < var_99_25 + var_99_32 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_25) / var_99_32

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_25 + var_99_32 and arg_96_1.time_ < var_99_25 + var_99_32 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play1108408025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108408025
		arg_100_1.duration_ = 5.7

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108408026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1084ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1084ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(0, -0.97, -6)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1084ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = arg_100_1.actors_["1084ui_story"]
			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = var_103_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_11 = 0.200000002980232

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_11 and not isNil(var_103_9) then
				local var_103_12 = (arg_100_1.time_ - var_103_10) / var_103_11

				if arg_100_1.var_.characterEffect1084ui_story and not isNil(var_103_9) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_10 + var_103_11 and arg_100_1.time_ < var_103_10 + var_103_11 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_103_13 = 0

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_103_15 = 0
			local var_103_16 = 0.85

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(1108408025)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 34
				local var_103_21 = utf8.len(var_103_19)
				local var_103_22 = var_103_20 <= 0 and var_103_16 or var_103_16 * (var_103_21 / var_103_20)

				if var_103_22 > 0 and var_103_16 < var_103_22 then
					arg_100_1.talkMaxDuration = var_103_22

					if var_103_22 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb") ~= 0 then
					local var_103_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb") / 1000

					if var_103_23 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_15
					end

					if var_103_18.prefab_name ~= "" and arg_100_1.actors_[var_103_18.prefab_name] ~= nil then
						local var_103_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_18.prefab_name].transform, "story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb")

						arg_100_1:RecordAudio("1108408025", var_103_24)
						arg_100_1:RecordAudio("1108408025", var_103_24)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408025", "story_v_side_new_1108408.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_25 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_25 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_25

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_25 and arg_100_1.time_ < var_103_15 + var_103_25 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play1108408026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1108408026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1108408027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1084ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1084ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 1.45

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(1108408026)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 58
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1108408027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1108408027
		arg_108_1.duration_ = 6.6

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1108408028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1084ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action425")
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.65

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_9 = arg_108_1:GetWordFromCfg(1108408027)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 26
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb")

						arg_108_1:RecordAudio("1108408027", var_111_15)
						arg_108_1:RecordAudio("1108408027", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408027", "story_v_side_new_1108408.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1108408028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1108408028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1108408029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1084ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, 100, 0)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, 100, 0)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1084ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_9) then
					local var_115_13 = Mathf.Lerp(0, 0.5, var_115_12)

					arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1084ui_story.fillRatio = var_115_13
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1084ui_story then
				local var_115_14 = 0.5

				arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1084ui_story.fillRatio = var_115_14
			end

			local var_115_15 = 0
			local var_115_16 = 1.575

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_17 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_17:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(1108408028)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 63
				local var_115_21 = utf8.len(var_115_19)
				local var_115_22 = var_115_20 <= 0 and var_115_16 or var_115_16 * (var_115_21 / var_115_20)

				if var_115_22 > 0 and var_115_16 < var_115_22 then
					arg_112_1.talkMaxDuration = var_115_22
					var_115_15 = var_115_15 + 0.3

					if var_115_22 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_15
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_23 = var_115_15 + 0.3
			local var_115_24 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_24 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_24

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_24 and arg_112_1.time_ < var_115_23 + var_115_24 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play1108408029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1108408029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1108408030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, -0.97, -6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["1084ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action458")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_121_15 = 0
			local var_121_16 = 0.55

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(1108408029)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 22
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb")

						arg_118_1:RecordAudio("1108408029", var_121_24)
						arg_118_1:RecordAudio("1108408029", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408029", "story_v_side_new_1108408.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play1108408030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1108408030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1108408031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1084ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.925

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(1108408030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 37
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1108408031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1108408031
		arg_126_1.duration_ = 9.37

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1108408032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "R8405"

			if arg_126_1.bgs_[var_129_0] == nil then
				local var_129_1 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_129_0)
				var_129_1.name = var_129_0
				var_129_1.transform.parent = arg_126_1.stage_.transform
				var_129_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_[var_129_0] = var_129_1
			end

			local var_129_2 = 0.966666666666667

			if var_129_2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				local var_129_3 = manager.ui.mainCamera.transform.localPosition
				local var_129_4 = Vector3.New(0, 0, 10) + Vector3.New(var_129_3.x, var_129_3.y, 0)
				local var_129_5 = arg_126_1.bgs_.R8405

				var_129_5.transform.localPosition = var_129_4
				var_129_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_6 = var_129_5:GetComponent("SpriteRenderer")

				if var_129_6 and var_129_6.sprite then
					local var_129_7 = (var_129_5.transform.localPosition - var_129_3).z
					local var_129_8 = manager.ui.mainCameraCom_
					local var_129_9 = 2 * var_129_7 * Mathf.Tan(var_129_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_129_10 = var_129_9 * var_129_8.aspect
					local var_129_11 = var_129_6.sprite.bounds.size.x
					local var_129_12 = var_129_6.sprite.bounds.size.y
					local var_129_13 = var_129_10 / var_129_11
					local var_129_14 = var_129_9 / var_129_12
					local var_129_15 = var_129_14 < var_129_13 and var_129_13 or var_129_14

					var_129_5.transform.localScale = Vector3.New(var_129_15, var_129_15, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "R8405" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_16 = 2

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			local var_129_17 = 0.3

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end

			local var_129_18 = manager.ui.mainCamera.transform
			local var_129_19 = 0

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				local var_129_20 = arg_126_1.var_.effectjinguangshanshuo1
				local var_129_21
				local var_129_22 = var_129_18

				if not var_129_20 then
					var_129_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_129_22)
					var_129_20.name = "jinguangshanshuo1"
					arg_126_1.var_.effectjinguangshanshuo1 = var_129_20
				else
					var_129_20.transform:SetParent(var_129_22)
				end

				var_129_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_129_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_129_23 = arg_126_1.actors_["1084ui_story"].transform
			local var_129_24 = 0

			if var_129_24 < arg_126_1.time_ and arg_126_1.time_ <= var_129_24 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_23.localPosition
			end

			local var_129_25 = 0.001

			if var_129_24 <= arg_126_1.time_ and arg_126_1.time_ < var_129_24 + var_129_25 then
				local var_129_26 = (arg_126_1.time_ - var_129_24) / var_129_25
				local var_129_27 = Vector3.New(0, 100, 0)

				var_129_23.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, var_129_27, var_129_26)

				local var_129_28 = manager.ui.mainCamera.transform.position - var_129_23.position

				var_129_23.forward = Vector3.New(var_129_28.x, var_129_28.y, var_129_28.z)

				local var_129_29 = var_129_23.localEulerAngles

				var_129_29.z = 0
				var_129_29.x = 0
				var_129_23.localEulerAngles = var_129_29
			end

			if arg_126_1.time_ >= var_129_24 + var_129_25 and arg_126_1.time_ < var_129_24 + var_129_25 + arg_129_0 then
				var_129_23.localPosition = Vector3.New(0, 100, 0)

				local var_129_30 = manager.ui.mainCamera.transform.position - var_129_23.position

				var_129_23.forward = Vector3.New(var_129_30.x, var_129_30.y, var_129_30.z)

				local var_129_31 = var_129_23.localEulerAngles

				var_129_31.z = 0
				var_129_31.x = 0
				var_129_23.localEulerAngles = var_129_31
			end

			local var_129_32 = manager.ui.mainCamera.transform
			local var_129_33 = 1.5

			if var_129_33 < arg_126_1.time_ and arg_126_1.time_ <= var_129_33 + arg_129_0 then
				local var_129_34 = arg_126_1.var_.effectjinguangshanshuo2
				local var_129_35
				local var_129_36 = var_129_32

				if not var_129_34 then
					var_129_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_129_36)
					var_129_34.name = "jinguangshanshuo2"
					arg_126_1.var_.effectjinguangshanshuo2 = var_129_34
				else
					var_129_34.transform:SetParent(var_129_36)
				end

				var_129_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_129_34.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_129_37 = manager.ui.mainCamera.transform
			local var_129_38 = 2.3

			if var_129_38 < arg_126_1.time_ and arg_126_1.time_ <= var_129_38 + arg_129_0 then
				local var_129_39 = arg_126_1.var_.effectjinguangshanshuo2

				if var_129_39 then
					Object.Destroy(var_129_39)

					arg_126_1.var_.effectjinguangshanshuo2 = nil
				end
			end

			local var_129_40 = manager.ui.mainCamera.transform
			local var_129_41 = 1.5

			if var_129_41 < arg_126_1.time_ and arg_126_1.time_ <= var_129_41 + arg_129_0 then
				local var_129_42 = arg_126_1.var_.effectjinguangshanshuo1

				if var_129_42 then
					Object.Destroy(var_129_42)

					arg_126_1.var_.effectjinguangshanshuo1 = nil
				end
			end

			local var_129_43 = 1
			local var_129_44 = 1

			if var_129_43 < arg_126_1.time_ and arg_126_1.time_ <= var_129_43 + arg_129_0 then
				local var_129_45 = "play"
				local var_129_46 = "music"

				arg_126_1:AudioAction(var_129_45, var_129_46, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_129_47 = ""
				local var_129_48 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_129_48 ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_48 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_48

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_48
						arg_126_1.bgmTxt2_.text = var_129_48
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_129_49 = 0
			local var_129_50 = 1

			if var_129_49 < arg_126_1.time_ and arg_126_1.time_ <= var_129_49 + arg_129_0 then
				local var_129_51 = "play"
				local var_129_52 = "effect"

				arg_126_1:AudioAction(var_129_51, var_129_52, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_129_53 = manager.ui.mainCamera.transform
			local var_129_54 = 0.9

			if var_129_54 < arg_126_1.time_ and arg_126_1.time_ <= var_129_54 + arg_129_0 then
				local var_129_55 = arg_126_1.var_.effectxiyangluoxia

				if var_129_55 then
					Object.Destroy(var_129_55)

					arg_126_1.var_.effectxiyangluoxia = nil
				end
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_56 = 2
			local var_129_57 = 0.8

			if var_129_56 < arg_126_1.time_ and arg_126_1.time_ <= var_129_56 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_58 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_58:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_126_1.dialogCg_.alpha = arg_131_0
				end))
				var_129_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_59 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_60 = arg_126_1:GetWordFromCfg(1108408031)
				local var_129_61 = arg_126_1:FormatText(var_129_60.content)

				arg_126_1.text_.text = var_129_61

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_62 = 32
				local var_129_63 = utf8.len(var_129_61)
				local var_129_64 = var_129_62 <= 0 and var_129_57 or var_129_57 * (var_129_63 / var_129_62)

				if var_129_64 > 0 and var_129_57 < var_129_64 then
					arg_126_1.talkMaxDuration = var_129_64
					var_129_56 = var_129_56 + 0.3

					if var_129_64 + var_129_56 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_64 + var_129_56
					end
				end

				arg_126_1.text_.text = var_129_61
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb") ~= 0 then
					local var_129_65 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb") / 1000

					if var_129_65 + var_129_56 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_65 + var_129_56
					end

					if var_129_60.prefab_name ~= "" and arg_126_1.actors_[var_129_60.prefab_name] ~= nil then
						local var_129_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_60.prefab_name].transform, "story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb")

						arg_126_1:RecordAudio("1108408031", var_129_66)
						arg_126_1:RecordAudio("1108408031", var_129_66)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408031", "story_v_side_new_1108408.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_67 = var_129_56 + 0.3
			local var_129_68 = math.max(var_129_57, arg_126_1.talkMaxDuration)

			if var_129_67 <= arg_126_1.time_ and arg_126_1.time_ < var_129_67 + var_129_68 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_67) / var_129_68

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_67 + var_129_68 and arg_126_1.time_ < var_129_67 + var_129_68 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play1108408032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1108408032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1108408033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.5

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(1108408032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 20
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1108408033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1108408033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1108408034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.4

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(1108408033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 16
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
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1108408034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1108408034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1108408035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.3
			local var_144_1 = 1

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				local var_144_2 = "play"
				local var_144_3 = "effect"

				arg_141_1:AudioAction(var_144_2, var_144_3, "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_144_4 = 0
			local var_144_5 = 0.75

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(1108408034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_8 = 30
				local var_144_9 = utf8.len(var_144_7)
				local var_144_10 = var_144_8 <= 0 and var_144_5 or var_144_5 * (var_144_9 / var_144_8)

				if var_144_10 > 0 and var_144_5 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_11 and arg_141_1.time_ < var_144_4 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1108408035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1108408035
		arg_145_1.duration_ = 3.3

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1108408036(arg_145_1)
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

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(1108408035)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb")

						arg_145_1:RecordAudio("1108408035", var_148_9)
						arg_145_1:RecordAudio("1108408035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408035", "story_v_side_new_1108408.awb")
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
	Play1108408036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1108408036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1108408037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.825

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

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(1108408036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 33
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
	Play1108408037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1108408037
		arg_153_1.duration_ = 5.33

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1108408038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.875

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[6].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(1108408037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb")

						arg_153_1:RecordAudio("1108408037", var_156_9)
						arg_153_1:RecordAudio("1108408037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408037", "story_v_side_new_1108408.awb")
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
	Play1108408038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1108408038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1108408039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.325

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(1108408038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 13
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
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1108408039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1108408039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1108408040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.45

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(1108408039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 58
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1108408040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1108408040
		arg_165_1.duration_ = 2.93

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1108408041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.35

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[6].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(1108408040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb")

						arg_165_1:RecordAudio("1108408040", var_168_9)
						arg_165_1:RecordAudio("1108408040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408040", "story_v_side_new_1108408.awb")
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
	Play1108408041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1108408041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1108408042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.525

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(1108408041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 21
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
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1108408042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108408042
		arg_173_1.duration_ = 1.33

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1108408043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.1

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[6].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(1108408042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb")

						arg_173_1:RecordAudio("1108408042", var_176_9)
						arg_173_1:RecordAudio("1108408042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408042", "story_v_side_new_1108408.awb")
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
	Play1108408043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1108408043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1108408044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 1.35

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

				local var_180_2 = arg_177_1:GetWordFromCfg(1108408043)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 54
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
	Play1108408044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1108408044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1108408045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.3

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(1108408044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 52
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1108408045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1108408045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1108408046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.8

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(1108408045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 32
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
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1108408046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1108408046
		arg_189_1.duration_ = 4

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1108408047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.475

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[6].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(1108408046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb")

						arg_189_1:RecordAudio("1108408046", var_192_9)
						arg_189_1:RecordAudio("1108408046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408046", "story_v_side_new_1108408.awb")
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
	Play1108408047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1108408047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1108408048(arg_193_1)
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

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(1108408047)
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
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1108408048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1108408048
		arg_197_1.duration_ = 1.37

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1108408049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.125

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[6].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(1108408048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb")

						arg_197_1:RecordAudio("1108408048", var_200_9)
						arg_197_1:RecordAudio("1108408048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408048", "story_v_side_new_1108408.awb")
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
	Play1108408049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1108408049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1108408050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.1

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(1108408049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 44
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
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1108408050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1108408050
		arg_205_1.duration_ = 14.37

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1108408051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.875

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

				local var_208_3 = arg_205_1:GetWordFromCfg(1108408050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 75
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb")

						arg_205_1:RecordAudio("1108408050", var_208_9)
						arg_205_1:RecordAudio("1108408050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408050", "story_v_side_new_1108408.awb")
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
	Play1108408051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108408051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1108408052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.5

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(1108408051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 20
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
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1108408052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108408052
		arg_213_1.duration_ = 10.5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1108408053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1.175

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[6].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(1108408052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb")

						arg_213_1:RecordAudio("1108408052", var_216_9)
						arg_213_1:RecordAudio("1108408052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408052", "story_v_side_new_1108408.awb")
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
	Play1108408053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1108408053
		arg_217_1.duration_ = 12.77

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1108408054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.575

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[6].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(1108408053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 61
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb")

						arg_217_1:RecordAudio("1108408053", var_220_9)
						arg_217_1:RecordAudio("1108408053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408053", "story_v_side_new_1108408.awb")
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
	Play1108408054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1108408054
		arg_221_1.duration_ = 8.07

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1108408055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1

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

				local var_224_3 = arg_221_1:GetWordFromCfg(1108408054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb")

						arg_221_1:RecordAudio("1108408054", var_224_9)
						arg_221_1:RecordAudio("1108408054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408054", "story_v_side_new_1108408.awb")
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
	Play1108408055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1108408055
		arg_225_1.duration_ = 1

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"

			SetActive(arg_225_1.choicesGo_, true)

			for iter_226_0, iter_226_1 in ipairs(arg_225_1.choices_) do
				local var_226_0 = iter_226_0 <= 2

				SetActive(iter_226_1.go, var_226_0)
			end

			arg_225_1.choices_[1].txt.text = arg_225_1:FormatText(StoryChoiceCfg[1690].name)
			arg_225_1.choices_[2].txt.text = arg_225_1:FormatText(StoryChoiceCfg[1691].name)
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1108408056(arg_225_1)
			end

			if arg_227_0 == 2 then
				arg_225_0:Play1108408056(arg_225_1)
			end

			arg_225_1:RecordChoiceLog(1108408055, 1690, 1691)
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			local var_228_1 = 1

			if arg_225_1.time_ >= var_228_0 + var_228_1 and arg_225_1.time_ < var_228_0 + var_228_1 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1108408056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1108408056
		arg_229_1.duration_ = 9.8

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1108408057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.075

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(1108408056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb")

						arg_229_1:RecordAudio("1108408056", var_232_9)
						arg_229_1:RecordAudio("1108408056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408056", "story_v_side_new_1108408.awb")
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
	Play1108408057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1108408057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1108408058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.075

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(1108408057)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 43
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1108408058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108408058
		arg_237_1.duration_ = 9.9

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108408059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "H02a"

			if arg_237_1.bgs_[var_240_0] == nil then
				local var_240_1 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_240_0)
				var_240_1.name = var_240_0
				var_240_1.transform.parent = arg_237_1.stage_.transform
				var_240_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_[var_240_0] = var_240_1
			end

			local var_240_2 = 2

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				local var_240_3 = manager.ui.mainCamera.transform.localPosition
				local var_240_4 = Vector3.New(0, 0, 10) + Vector3.New(var_240_3.x, var_240_3.y, 0)
				local var_240_5 = arg_237_1.bgs_.H02a

				var_240_5.transform.localPosition = var_240_4
				var_240_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_6 = var_240_5:GetComponent("SpriteRenderer")

				if var_240_6 and var_240_6.sprite then
					local var_240_7 = (var_240_5.transform.localPosition - var_240_3).z
					local var_240_8 = manager.ui.mainCameraCom_
					local var_240_9 = 2 * var_240_7 * Mathf.Tan(var_240_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_240_10 = var_240_9 * var_240_8.aspect
					local var_240_11 = var_240_6.sprite.bounds.size.x
					local var_240_12 = var_240_6.sprite.bounds.size.y
					local var_240_13 = var_240_10 / var_240_11
					local var_240_14 = var_240_9 / var_240_12
					local var_240_15 = var_240_14 < var_240_13 and var_240_13 or var_240_14

					var_240_5.transform.localScale = Vector3.New(var_240_15, var_240_15, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "H02a" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_16 = 4.00000000298023

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			local var_240_17 = 0.3

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_18 = 0

			if var_240_18 < arg_237_1.time_ and arg_237_1.time_ <= var_240_18 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_19 = 2

			if var_240_18 <= arg_237_1.time_ and arg_237_1.time_ < var_240_18 + var_240_19 then
				local var_240_20 = (arg_237_1.time_ - var_240_18) / var_240_19
				local var_240_21 = Color.New(0, 0, 0)

				var_240_21.a = Mathf.Lerp(0, 1, var_240_20)
				arg_237_1.mask_.color = var_240_21
			end

			if arg_237_1.time_ >= var_240_18 + var_240_19 and arg_237_1.time_ < var_240_18 + var_240_19 + arg_240_0 then
				local var_240_22 = Color.New(0, 0, 0)

				var_240_22.a = 1
				arg_237_1.mask_.color = var_240_22
			end

			local var_240_23 = 2

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_24 = 2

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24
				local var_240_26 = Color.New(0, 0, 0)

				var_240_26.a = Mathf.Lerp(1, 0, var_240_25)
				arg_237_1.mask_.color = var_240_26
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 then
				local var_240_27 = Color.New(0, 0, 0)
				local var_240_28 = 0

				arg_237_1.mask_.enabled = false
				var_240_27.a = var_240_28
				arg_237_1.mask_.color = var_240_27
			end

			local var_240_29 = arg_237_1.actors_["1084ui_story"].transform
			local var_240_30 = 3.8

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.var_.moveOldPos1084ui_story = var_240_29.localPosition
			end

			local var_240_31 = 0.001

			if var_240_30 <= arg_237_1.time_ and arg_237_1.time_ < var_240_30 + var_240_31 then
				local var_240_32 = (arg_237_1.time_ - var_240_30) / var_240_31
				local var_240_33 = Vector3.New(0, -0.97, -6)

				var_240_29.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1084ui_story, var_240_33, var_240_32)

				local var_240_34 = manager.ui.mainCamera.transform.position - var_240_29.position

				var_240_29.forward = Vector3.New(var_240_34.x, var_240_34.y, var_240_34.z)

				local var_240_35 = var_240_29.localEulerAngles

				var_240_35.z = 0
				var_240_35.x = 0
				var_240_29.localEulerAngles = var_240_35
			end

			if arg_237_1.time_ >= var_240_30 + var_240_31 and arg_237_1.time_ < var_240_30 + var_240_31 + arg_240_0 then
				var_240_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_240_36 = manager.ui.mainCamera.transform.position - var_240_29.position

				var_240_29.forward = Vector3.New(var_240_36.x, var_240_36.y, var_240_36.z)

				local var_240_37 = var_240_29.localEulerAngles

				var_240_37.z = 0
				var_240_37.x = 0
				var_240_29.localEulerAngles = var_240_37
			end

			local var_240_38 = arg_237_1.actors_["1084ui_story"]
			local var_240_39 = 3.8

			if var_240_39 < arg_237_1.time_ and arg_237_1.time_ <= var_240_39 + arg_240_0 and not isNil(var_240_38) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_40 = 0.200000002980232

			if var_240_39 <= arg_237_1.time_ and arg_237_1.time_ < var_240_39 + var_240_40 and not isNil(var_240_38) then
				local var_240_41 = (arg_237_1.time_ - var_240_39) / var_240_40

				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_38) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_39 + var_240_40 and arg_237_1.time_ < var_240_39 + var_240_40 + arg_240_0 and not isNil(var_240_38) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_240_42 = 3.8

			if var_240_42 < arg_237_1.time_ and arg_237_1.time_ <= var_240_42 + arg_240_0 then
				arg_237_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_240_43 = 3.8

			if var_240_43 < arg_237_1.time_ and arg_237_1.time_ <= var_240_43 + arg_240_0 then
				arg_237_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_44 = 4.00000000298023
			local var_240_45 = 0.65

			if var_240_44 < arg_237_1.time_ and arg_237_1.time_ <= var_240_44 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_46 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_46:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_47 = arg_237_1:FormatText(StoryNameCfg[6].name)

				arg_237_1.leftNameTxt_.text = var_240_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_48 = arg_237_1:GetWordFromCfg(1108408058)
				local var_240_49 = arg_237_1:FormatText(var_240_48.content)

				arg_237_1.text_.text = var_240_49

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_50 = 26
				local var_240_51 = utf8.len(var_240_49)
				local var_240_52 = var_240_50 <= 0 and var_240_45 or var_240_45 * (var_240_51 / var_240_50)

				if var_240_52 > 0 and var_240_45 < var_240_52 then
					arg_237_1.talkMaxDuration = var_240_52
					var_240_44 = var_240_44 + 0.3

					if var_240_52 + var_240_44 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_52 + var_240_44
					end
				end

				arg_237_1.text_.text = var_240_49
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb") ~= 0 then
					local var_240_53 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb") / 1000

					if var_240_53 + var_240_44 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_53 + var_240_44
					end

					if var_240_48.prefab_name ~= "" and arg_237_1.actors_[var_240_48.prefab_name] ~= nil then
						local var_240_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_48.prefab_name].transform, "story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb")

						arg_237_1:RecordAudio("1108408058", var_240_54)
						arg_237_1:RecordAudio("1108408058", var_240_54)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408058", "story_v_side_new_1108408.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_55 = var_240_44 + 0.3
			local var_240_56 = math.max(var_240_45, arg_237_1.talkMaxDuration)

			if var_240_55 <= arg_237_1.time_ and arg_237_1.time_ < var_240_55 + var_240_56 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_55) / var_240_56

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_55 + var_240_56 and arg_237_1.time_ < var_240_55 + var_240_56 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108408059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1108408059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1108408060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1084ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1084ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1084ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1084ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1084ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 0.2

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

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(1108408059)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 8
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
	Play1108408060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1108408060
		arg_247_1.duration_ = 2.23

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1108408061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1084ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1084ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_250_4 = 0

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_250_6 = 0
			local var_250_7 = 0.175

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[6].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_9 = arg_247_1:GetWordFromCfg(1108408060)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 7
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb") / 1000

					if var_250_14 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_6
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb")

						arg_247_1:RecordAudio("1108408060", var_250_15)
						arg_247_1:RecordAudio("1108408060", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408060", "story_v_side_new_1108408.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_16 and arg_247_1.time_ < var_250_6 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1108408061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1108408061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1108408062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1084ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1084ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1084ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 1.075

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(1108408061)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 43
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1108408062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1108408062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1108408063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.725

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[7].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(1108408062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 29
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_8 and arg_255_1.time_ < var_258_0 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1108408063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1108408063
		arg_259_1.duration_ = 2

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1108408064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1084ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_0) then
					arg_259_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1084ui_story then
				arg_259_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_262_4 = 0

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_262_5 = 0

			if var_262_5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_262_6 = 0
			local var_262_7 = 0.1

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[6].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_9 = arg_259_1:GetWordFromCfg(1108408063)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 4
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb") / 1000

					if var_262_14 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_6
					end

					if var_262_9.prefab_name ~= "" and arg_259_1.actors_[var_262_9.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_9.prefab_name].transform, "story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb")

						arg_259_1:RecordAudio("1108408063", var_262_15)
						arg_259_1:RecordAudio("1108408063", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408063", "story_v_side_new_1108408.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_16 and arg_259_1.time_ < var_262_6 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1108408064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1108408064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1108408065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1084ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1084ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, 100, 0)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1084ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, 100, 0)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1084ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1084ui_story == nil then
				arg_263_1.var_.characterEffect1084ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1084ui_story and not isNil(var_266_9) then
					local var_266_13 = Mathf.Lerp(0, 0.5, var_266_12)

					arg_263_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1084ui_story.fillRatio = var_266_13
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1084ui_story then
				local var_266_14 = 0.5

				arg_263_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1084ui_story.fillRatio = var_266_14
			end

			local var_266_15 = 0
			local var_266_16 = 1.15

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_17 = arg_263_1:GetWordFromCfg(1108408064)
				local var_266_18 = arg_263_1:FormatText(var_266_17.content)

				arg_263_1.text_.text = var_266_18

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_19 = 46
				local var_266_20 = utf8.len(var_266_18)
				local var_266_21 = var_266_19 <= 0 and var_266_16 or var_266_16 * (var_266_20 / var_266_19)

				if var_266_21 > 0 and var_266_16 < var_266_21 then
					arg_263_1.talkMaxDuration = var_266_21

					if var_266_21 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_21 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_18
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_22 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_22 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_22

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_22 and arg_263_1.time_ < var_266_15 + var_266_22 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play1108408065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1108408065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1108408066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.225

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(1108408065)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 49
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1108408066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1108408066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1108408067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.425

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(1108408066)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 17
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_8 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_8 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_8

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_8 and arg_271_1.time_ < var_274_0 + var_274_8 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1108408067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1108408067
		arg_275_1.duration_ = 9.57

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1108408068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1084ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos1084ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0, -0.97, -6)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1084ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["1084ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect1084ui_story and not isNil(var_278_9) then
					arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1084ui_story then
				arg_275_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_278_13 = 0

			if var_278_13 < arg_275_1.time_ and arg_275_1.time_ <= var_278_13 + arg_278_0 then
				arg_275_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_278_14 = 0

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 then
				arg_275_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_278_15 = 0
			local var_278_16 = 0.925

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_17 = arg_275_1:FormatText(StoryNameCfg[6].name)

				arg_275_1.leftNameTxt_.text = var_278_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_18 = arg_275_1:GetWordFromCfg(1108408067)
				local var_278_19 = arg_275_1:FormatText(var_278_18.content)

				arg_275_1.text_.text = var_278_19

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_20 = 37
				local var_278_21 = utf8.len(var_278_19)
				local var_278_22 = var_278_20 <= 0 and var_278_16 or var_278_16 * (var_278_21 / var_278_20)

				if var_278_22 > 0 and var_278_16 < var_278_22 then
					arg_275_1.talkMaxDuration = var_278_22

					if var_278_22 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_19
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb") ~= 0 then
					local var_278_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb") / 1000

					if var_278_23 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_15
					end

					if var_278_18.prefab_name ~= "" and arg_275_1.actors_[var_278_18.prefab_name] ~= nil then
						local var_278_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_18.prefab_name].transform, "story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb")

						arg_275_1:RecordAudio("1108408067", var_278_24)
						arg_275_1:RecordAudio("1108408067", var_278_24)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408067", "story_v_side_new_1108408.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_25 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_25 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_25

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_25 and arg_275_1.time_ < var_278_15 + var_278_25 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play1108408068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1108408068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1108408069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1084ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1084ui_story == nil then
				arg_279_1.var_.characterEffect1084ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1084ui_story and not isNil(var_282_0) then
					local var_282_4 = Mathf.Lerp(0, 0.5, var_282_3)

					arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1084ui_story.fillRatio = var_282_4
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1084ui_story then
				local var_282_5 = 0.5

				arg_279_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1084ui_story.fillRatio = var_282_5
			end

			local var_282_6 = 0
			local var_282_7 = 0.425

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_9 = arg_279_1:GetWordFromCfg(1108408068)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 17
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1108408069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1108408069
		arg_283_1.duration_ = 5.03

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1108408070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1084ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1084ui_story == nil then
				arg_283_1.var_.characterEffect1084ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1084ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1084ui_story then
				arg_283_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_286_4 = 0

			if var_286_4 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_286_6 = 0
			local var_286_7 = 0.45

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[6].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_9 = arg_283_1:GetWordFromCfg(1108408069)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 18
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb") / 1000

					if var_286_14 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_6
					end

					if var_286_9.prefab_name ~= "" and arg_283_1.actors_[var_286_9.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_9.prefab_name].transform, "story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb")

						arg_283_1:RecordAudio("1108408069", var_286_15)
						arg_283_1:RecordAudio("1108408069", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408069", "story_v_side_new_1108408.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_16 and arg_283_1.time_ < var_286_6 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1108408070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1108408070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1108408071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1084ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1084ui_story == nil then
				arg_287_1.var_.characterEffect1084ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1084ui_story and not isNil(var_290_0) then
					local var_290_4 = Mathf.Lerp(0, 0.5, var_290_3)

					arg_287_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1084ui_story.fillRatio = var_290_4
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1084ui_story then
				local var_290_5 = 0.5

				arg_287_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1084ui_story.fillRatio = var_290_5
			end

			local var_290_6 = 0
			local var_290_7 = 0.125

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_8 = arg_287_1:FormatText(StoryNameCfg[7].name)

				arg_287_1.leftNameTxt_.text = var_290_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_9 = arg_287_1:GetWordFromCfg(1108408070)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 5
				local var_290_12 = utf8.len(var_290_10)
				local var_290_13 = var_290_11 <= 0 and var_290_7 or var_290_7 * (var_290_12 / var_290_11)

				if var_290_13 > 0 and var_290_7 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1108408071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1108408071
		arg_291_1.duration_ = 3.5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1108408072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1084ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1084ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1084ui_story then
				arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_294_4 = 0

			if var_294_4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_294_5 = 0

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_294_6 = 0
			local var_294_7 = 0.3

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_8 = arg_291_1:FormatText(StoryNameCfg[6].name)

				arg_291_1.leftNameTxt_.text = var_294_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_9 = arg_291_1:GetWordFromCfg(1108408071)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 12
				local var_294_12 = utf8.len(var_294_10)
				local var_294_13 = var_294_11 <= 0 and var_294_7 or var_294_7 * (var_294_12 / var_294_11)

				if var_294_13 > 0 and var_294_7 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb") / 1000

					if var_294_14 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_6
					end

					if var_294_9.prefab_name ~= "" and arg_291_1.actors_[var_294_9.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_9.prefab_name].transform, "story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb")

						arg_291_1:RecordAudio("1108408071", var_294_15)
						arg_291_1:RecordAudio("1108408071", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408071", "story_v_side_new_1108408.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_16 and arg_291_1.time_ < var_294_6 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1108408072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1108408072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1108408073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1084ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1084ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, 100, 0)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1084ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, 100, 0)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1084ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1084ui_story and not isNil(var_298_9) then
					local var_298_13 = Mathf.Lerp(0, 0.5, var_298_12)

					arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1084ui_story.fillRatio = var_298_13
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1084ui_story then
				local var_298_14 = 0.5

				arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1084ui_story.fillRatio = var_298_14
			end

			local var_298_15 = 0
			local var_298_16 = 1.6

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_17 = arg_295_1:GetWordFromCfg(1108408072)
				local var_298_18 = arg_295_1:FormatText(var_298_17.content)

				arg_295_1.text_.text = var_298_18

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_19 = 64
				local var_298_20 = utf8.len(var_298_18)
				local var_298_21 = var_298_19 <= 0 and var_298_16 or var_298_16 * (var_298_20 / var_298_19)

				if var_298_21 > 0 and var_298_16 < var_298_21 then
					arg_295_1.talkMaxDuration = var_298_21

					if var_298_21 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_21 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_18
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_22 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_22 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_22

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_22 and arg_295_1.time_ < var_298_15 + var_298_22 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play1108408073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1108408073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1108408074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.825

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:GetWordFromCfg(1108408073)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 33
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_8 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_8 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_8

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_8 and arg_299_1.time_ < var_302_0 + var_302_8 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1108408074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1108408074
		arg_303_1.duration_ = 4.3

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1108408075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1084ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1084ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(0, -0.97, -6)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1084ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["1084ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1084ui_story == nil then
				arg_303_1.var_.characterEffect1084ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect1084ui_story and not isNil(var_306_9) then
					arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1084ui_story then
				arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_306_15 = 0
			local var_306_16 = 0.5

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_17 = arg_303_1:FormatText(StoryNameCfg[6].name)

				arg_303_1.leftNameTxt_.text = var_306_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_18 = arg_303_1:GetWordFromCfg(1108408074)
				local var_306_19 = arg_303_1:FormatText(var_306_18.content)

				arg_303_1.text_.text = var_306_19

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_20 = 20
				local var_306_21 = utf8.len(var_306_19)
				local var_306_22 = var_306_20 <= 0 and var_306_16 or var_306_16 * (var_306_21 / var_306_20)

				if var_306_22 > 0 and var_306_16 < var_306_22 then
					arg_303_1.talkMaxDuration = var_306_22

					if var_306_22 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_22 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_19
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb") ~= 0 then
					local var_306_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb") / 1000

					if var_306_23 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_15
					end

					if var_306_18.prefab_name ~= "" and arg_303_1.actors_[var_306_18.prefab_name] ~= nil then
						local var_306_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_18.prefab_name].transform, "story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb")

						arg_303_1:RecordAudio("1108408074", var_306_24)
						arg_303_1:RecordAudio("1108408074", var_306_24)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408074", "story_v_side_new_1108408.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_25 and arg_303_1.time_ < var_306_15 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play1108408075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1108408075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1108408076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1084ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1084ui_story == nil then
				arg_307_1.var_.characterEffect1084ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1084ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1084ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1084ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1084ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0
			local var_310_7 = 0.4

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_8 = arg_307_1:FormatText(StoryNameCfg[7].name)

				arg_307_1.leftNameTxt_.text = var_310_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_9 = arg_307_1:GetWordFromCfg(1108408075)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 16
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_7 or var_310_7 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_7 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1108408076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1108408076
		arg_311_1.duration_ = 16.33

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1108408077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1084ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1084ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1084ui_story then
				arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_314_4 = 0

			if var_314_4 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_314_6 = 0
			local var_314_7 = 1.375

			if var_314_6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_8 = arg_311_1:FormatText(StoryNameCfg[6].name)

				arg_311_1.leftNameTxt_.text = var_314_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_9 = arg_311_1:GetWordFromCfg(1108408076)
				local var_314_10 = arg_311_1:FormatText(var_314_9.content)

				arg_311_1.text_.text = var_314_10

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 55
				local var_314_12 = utf8.len(var_314_10)
				local var_314_13 = var_314_11 <= 0 and var_314_7 or var_314_7 * (var_314_12 / var_314_11)

				if var_314_13 > 0 and var_314_7 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_10
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb") ~= 0 then
					local var_314_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb") / 1000

					if var_314_14 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_6
					end

					if var_314_9.prefab_name ~= "" and arg_311_1.actors_[var_314_9.prefab_name] ~= nil then
						local var_314_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_9.prefab_name].transform, "story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb")

						arg_311_1:RecordAudio("1108408076", var_314_15)
						arg_311_1:RecordAudio("1108408076", var_314_15)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408076", "story_v_side_new_1108408.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_16 and arg_311_1.time_ < var_314_6 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1108408077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1108408077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1108408078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1084ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos1084ui_story = var_318_0.localPosition
			end

			local var_318_2 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2
				local var_318_4 = Vector3.New(0, 100, 0)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1084ui_story, var_318_4, var_318_3)

				local var_318_5 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_5.x, var_318_5.y, var_318_5.z)

				local var_318_6 = var_318_0.localEulerAngles

				var_318_6.z = 0
				var_318_6.x = 0
				var_318_0.localEulerAngles = var_318_6
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(0, 100, 0)

				local var_318_7 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_7.x, var_318_7.y, var_318_7.z)

				local var_318_8 = var_318_0.localEulerAngles

				var_318_8.z = 0
				var_318_8.x = 0
				var_318_0.localEulerAngles = var_318_8
			end

			local var_318_9 = arg_315_1.actors_["1084ui_story"]
			local var_318_10 = 0

			if var_318_10 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect1084ui_story == nil then
				arg_315_1.var_.characterEffect1084ui_story = var_318_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_11 = 0.200000002980232

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_11 and not isNil(var_318_9) then
				local var_318_12 = (arg_315_1.time_ - var_318_10) / var_318_11

				if arg_315_1.var_.characterEffect1084ui_story and not isNil(var_318_9) then
					local var_318_13 = Mathf.Lerp(0, 0.5, var_318_12)

					arg_315_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1084ui_story.fillRatio = var_318_13
				end
			end

			if arg_315_1.time_ >= var_318_10 + var_318_11 and arg_315_1.time_ < var_318_10 + var_318_11 + arg_318_0 and not isNil(var_318_9) and arg_315_1.var_.characterEffect1084ui_story then
				local var_318_14 = 0.5

				arg_315_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1084ui_story.fillRatio = var_318_14
			end

			local var_318_15 = 0
			local var_318_16 = 1

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_17 = arg_315_1:GetWordFromCfg(1108408077)
				local var_318_18 = arg_315_1:FormatText(var_318_17.content)

				arg_315_1.text_.text = var_318_18

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_19 = 40
				local var_318_20 = utf8.len(var_318_18)
				local var_318_21 = var_318_19 <= 0 and var_318_16 or var_318_16 * (var_318_20 / var_318_19)

				if var_318_21 > 0 and var_318_16 < var_318_21 then
					arg_315_1.talkMaxDuration = var_318_21

					if var_318_21 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_21 + var_318_15
					end
				end

				arg_315_1.text_.text = var_318_18
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_22 = math.max(var_318_16, arg_315_1.talkMaxDuration)

			if var_318_15 <= arg_315_1.time_ and arg_315_1.time_ < var_318_15 + var_318_22 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_15) / var_318_22

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_15 + var_318_22 and arg_315_1.time_ < var_318_15 + var_318_22 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play1108408078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1108408078
		arg_319_1.duration_ = 1

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"

			SetActive(arg_319_1.choicesGo_, true)

			for iter_320_0, iter_320_1 in ipairs(arg_319_1.choices_) do
				local var_320_0 = iter_320_0 <= 2

				SetActive(iter_320_1.go, var_320_0)
			end

			arg_319_1.choices_[1].txt.text = arg_319_1:FormatText(StoryChoiceCfg[1692].name)
			arg_319_1.choices_[2].txt.text = arg_319_1:FormatText(StoryChoiceCfg[1693].name)
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1108408079(arg_319_1)
			end

			if arg_321_0 == 2 then
				arg_319_0:Play1108408079(arg_319_1)
			end

			arg_319_1:RecordChoiceLog(1108408078, 1692, 1693)
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			local var_322_1 = 0.5

			if arg_319_1.time_ >= var_322_0 + var_322_1 and arg_319_1.time_ < var_322_0 + var_322_1 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1108408079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1108408079
		arg_323_1.duration_ = 3.4

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1108408080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1084ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos1084ui_story = var_326_0.localPosition
			end

			local var_326_2 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2
				local var_326_4 = Vector3.New(0, -0.97, -6)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1084ui_story, var_326_4, var_326_3)

				local var_326_5 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_5.x, var_326_5.y, var_326_5.z)

				local var_326_6 = var_326_0.localEulerAngles

				var_326_6.z = 0
				var_326_6.x = 0
				var_326_0.localEulerAngles = var_326_6
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_326_7 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_7.x, var_326_7.y, var_326_7.z)

				local var_326_8 = var_326_0.localEulerAngles

				var_326_8.z = 0
				var_326_8.x = 0
				var_326_0.localEulerAngles = var_326_8
			end

			local var_326_9 = arg_323_1.actors_["1084ui_story"]
			local var_326_10 = 0

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect1084ui_story == nil then
				arg_323_1.var_.characterEffect1084ui_story = var_326_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.200000002980232

			if var_326_10 <= arg_323_1.time_ and arg_323_1.time_ < var_326_10 + var_326_11 and not isNil(var_326_9) then
				local var_326_12 = (arg_323_1.time_ - var_326_10) / var_326_11

				if arg_323_1.var_.characterEffect1084ui_story and not isNil(var_326_9) then
					arg_323_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_10 + var_326_11 and arg_323_1.time_ < var_326_10 + var_326_11 + arg_326_0 and not isNil(var_326_9) and arg_323_1.var_.characterEffect1084ui_story then
				arg_323_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_326_13 = 0
			local var_326_14 = 0.2

			if var_326_13 < arg_323_1.time_ and arg_323_1.time_ <= var_326_13 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_15 = arg_323_1:FormatText(StoryNameCfg[6].name)

				arg_323_1.leftNameTxt_.text = var_326_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_16 = arg_323_1:GetWordFromCfg(1108408079)
				local var_326_17 = arg_323_1:FormatText(var_326_16.content)

				arg_323_1.text_.text = var_326_17

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_18 = 8
				local var_326_19 = utf8.len(var_326_17)
				local var_326_20 = var_326_18 <= 0 and var_326_14 or var_326_14 * (var_326_19 / var_326_18)

				if var_326_20 > 0 and var_326_14 < var_326_20 then
					arg_323_1.talkMaxDuration = var_326_20

					if var_326_20 + var_326_13 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_20 + var_326_13
					end
				end

				arg_323_1.text_.text = var_326_17
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb") ~= 0 then
					local var_326_21 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb") / 1000

					if var_326_21 + var_326_13 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_21 + var_326_13
					end

					if var_326_16.prefab_name ~= "" and arg_323_1.actors_[var_326_16.prefab_name] ~= nil then
						local var_326_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_16.prefab_name].transform, "story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb")

						arg_323_1:RecordAudio("1108408079", var_326_22)
						arg_323_1:RecordAudio("1108408079", var_326_22)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408079", "story_v_side_new_1108408.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_23 = math.max(var_326_14, arg_323_1.talkMaxDuration)

			if var_326_13 <= arg_323_1.time_ and arg_323_1.time_ < var_326_13 + var_326_23 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_13) / var_326_23

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_13 + var_326_23 and arg_323_1.time_ < var_326_13 + var_326_23 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play1108408080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1108408080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1108408081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1084ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1084ui_story == nil then
				arg_327_1.var_.characterEffect1084ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1084ui_story and not isNil(var_330_0) then
					local var_330_4 = Mathf.Lerp(0, 0.5, var_330_3)

					arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1084ui_story.fillRatio = var_330_4
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1084ui_story then
				local var_330_5 = 0.5

				arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1084ui_story.fillRatio = var_330_5
			end

			local var_330_6 = 0
			local var_330_7 = 0.525

			if var_330_6 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_8 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_9 = arg_327_1:GetWordFromCfg(1108408080)
				local var_330_10 = arg_327_1:FormatText(var_330_9.content)

				arg_327_1.text_.text = var_330_10

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_11 = 21
				local var_330_12 = utf8.len(var_330_10)
				local var_330_13 = var_330_11 <= 0 and var_330_7 or var_330_7 * (var_330_12 / var_330_11)

				if var_330_13 > 0 and var_330_7 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_6
					end
				end

				arg_327_1.text_.text = var_330_10
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_7, arg_327_1.talkMaxDuration)

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_6) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_6 + var_330_14 and arg_327_1.time_ < var_330_6 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1108408081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1108408081
		arg_331_1.duration_ = 9

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1108408082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.999999999999

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				local var_334_1 = manager.ui.mainCamera.transform.localPosition
				local var_334_2 = Vector3.New(0, 0, 10) + Vector3.New(var_334_1.x, var_334_1.y, 0)
				local var_334_3 = arg_331_1.bgs_.H02a

				var_334_3.transform.localPosition = var_334_2
				var_334_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_334_4 = var_334_3:GetComponent("SpriteRenderer")

				if var_334_4 and var_334_4.sprite then
					local var_334_5 = (var_334_3.transform.localPosition - var_334_1).z
					local var_334_6 = manager.ui.mainCameraCom_
					local var_334_7 = 2 * var_334_5 * Mathf.Tan(var_334_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_334_8 = var_334_7 * var_334_6.aspect
					local var_334_9 = var_334_4.sprite.bounds.size.x
					local var_334_10 = var_334_4.sprite.bounds.size.y
					local var_334_11 = var_334_8 / var_334_9
					local var_334_12 = var_334_7 / var_334_10
					local var_334_13 = var_334_12 < var_334_11 and var_334_11 or var_334_12

					var_334_3.transform.localScale = Vector3.New(var_334_13, var_334_13, 0)
				end

				for iter_334_0, iter_334_1 in pairs(arg_331_1.bgs_) do
					if iter_334_0 ~= "H02a" then
						iter_334_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_334_14 = 3.999999999999

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1.allBtn_.enabled = false
			end

			local var_334_15 = 0.3

			if arg_331_1.time_ >= var_334_14 + var_334_15 and arg_331_1.time_ < var_334_14 + var_334_15 + arg_334_0 then
				arg_331_1.allBtn_.enabled = true
			end

			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_17 = 2

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17
				local var_334_19 = Color.New(0, 0, 0)

				var_334_19.a = Mathf.Lerp(0, 1, var_334_18)
				arg_331_1.mask_.color = var_334_19
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 then
				local var_334_20 = Color.New(0, 0, 0)

				var_334_20.a = 1
				arg_331_1.mask_.color = var_334_20
			end

			local var_334_21 = 2

			if var_334_21 < arg_331_1.time_ and arg_331_1.time_ <= var_334_21 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_22 = 2

			if var_334_21 <= arg_331_1.time_ and arg_331_1.time_ < var_334_21 + var_334_22 then
				local var_334_23 = (arg_331_1.time_ - var_334_21) / var_334_22
				local var_334_24 = Color.New(0, 0, 0)

				var_334_24.a = Mathf.Lerp(1, 0, var_334_23)
				arg_331_1.mask_.color = var_334_24
			end

			if arg_331_1.time_ >= var_334_21 + var_334_22 and arg_331_1.time_ < var_334_21 + var_334_22 + arg_334_0 then
				local var_334_25 = Color.New(0, 0, 0)
				local var_334_26 = 0

				arg_331_1.mask_.enabled = false
				var_334_25.a = var_334_26
				arg_331_1.mask_.color = var_334_25
			end

			local var_334_27 = arg_331_1.actors_["1084ui_story"].transform
			local var_334_28 = 1.96599999815226

			if var_334_28 < arg_331_1.time_ and arg_331_1.time_ <= var_334_28 + arg_334_0 then
				arg_331_1.var_.moveOldPos1084ui_story = var_334_27.localPosition
			end

			local var_334_29 = 0.001

			if var_334_28 <= arg_331_1.time_ and arg_331_1.time_ < var_334_28 + var_334_29 then
				local var_334_30 = (arg_331_1.time_ - var_334_28) / var_334_29
				local var_334_31 = Vector3.New(0, 100, 0)

				var_334_27.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1084ui_story, var_334_31, var_334_30)

				local var_334_32 = manager.ui.mainCamera.transform.position - var_334_27.position

				var_334_27.forward = Vector3.New(var_334_32.x, var_334_32.y, var_334_32.z)

				local var_334_33 = var_334_27.localEulerAngles

				var_334_33.z = 0
				var_334_33.x = 0
				var_334_27.localEulerAngles = var_334_33
			end

			if arg_331_1.time_ >= var_334_28 + var_334_29 and arg_331_1.time_ < var_334_28 + var_334_29 + arg_334_0 then
				var_334_27.localPosition = Vector3.New(0, 100, 0)

				local var_334_34 = manager.ui.mainCamera.transform.position - var_334_27.position

				var_334_27.forward = Vector3.New(var_334_34.x, var_334_34.y, var_334_34.z)

				local var_334_35 = var_334_27.localEulerAngles

				var_334_35.z = 0
				var_334_35.x = 0
				var_334_27.localEulerAngles = var_334_35
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_36 = 3.999999999999
			local var_334_37 = 1.375

			if var_334_36 < arg_331_1.time_ and arg_331_1.time_ <= var_334_36 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_38 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_38:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_39 = arg_331_1:GetWordFromCfg(1108408081)
				local var_334_40 = arg_331_1:FormatText(var_334_39.content)

				arg_331_1.text_.text = var_334_40

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_41 = 55
				local var_334_42 = utf8.len(var_334_40)
				local var_334_43 = var_334_41 <= 0 and var_334_37 or var_334_37 * (var_334_42 / var_334_41)

				if var_334_43 > 0 and var_334_37 < var_334_43 then
					arg_331_1.talkMaxDuration = var_334_43
					var_334_36 = var_334_36 + 0.3

					if var_334_43 + var_334_36 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_43 + var_334_36
					end
				end

				arg_331_1.text_.text = var_334_40
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_44 = var_334_36 + 0.3
			local var_334_45 = math.max(var_334_37, arg_331_1.talkMaxDuration)

			if var_334_44 <= arg_331_1.time_ and arg_331_1.time_ < var_334_44 + var_334_45 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_44) / var_334_45

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_44 + var_334_45 and arg_331_1.time_ < var_334_44 + var_334_45 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play1108408082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108408082
		arg_337_1.duration_ = 3.73

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108408083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1084ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1084ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0, -0.97, -6)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1084ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = arg_337_1.actors_["1084ui_story"]
			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = var_340_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_11 = 0.200000002980232

			if var_340_10 <= arg_337_1.time_ and arg_337_1.time_ < var_340_10 + var_340_11 and not isNil(var_340_9) then
				local var_340_12 = (arg_337_1.time_ - var_340_10) / var_340_11

				if arg_337_1.var_.characterEffect1084ui_story and not isNil(var_340_9) then
					arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_10 + var_340_11 and arg_337_1.time_ < var_340_10 + var_340_11 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect1084ui_story then
				arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_340_13 = 0

			if var_340_13 < arg_337_1.time_ and arg_337_1.time_ <= var_340_13 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_340_14 = 0

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_340_15 = 0
			local var_340_16 = 0.5

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_17 = arg_337_1:FormatText(StoryNameCfg[6].name)

				arg_337_1.leftNameTxt_.text = var_340_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_18 = arg_337_1:GetWordFromCfg(1108408082)
				local var_340_19 = arg_337_1:FormatText(var_340_18.content)

				arg_337_1.text_.text = var_340_19

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_20 = 20
				local var_340_21 = utf8.len(var_340_19)
				local var_340_22 = var_340_20 <= 0 and var_340_16 or var_340_16 * (var_340_21 / var_340_20)

				if var_340_22 > 0 and var_340_16 < var_340_22 then
					arg_337_1.talkMaxDuration = var_340_22

					if var_340_22 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_15
					end
				end

				arg_337_1.text_.text = var_340_19
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb") ~= 0 then
					local var_340_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb") / 1000

					if var_340_23 + var_340_15 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_23 + var_340_15
					end

					if var_340_18.prefab_name ~= "" and arg_337_1.actors_[var_340_18.prefab_name] ~= nil then
						local var_340_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_18.prefab_name].transform, "story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb")

						arg_337_1:RecordAudio("1108408082", var_340_24)
						arg_337_1:RecordAudio("1108408082", var_340_24)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408082", "story_v_side_new_1108408.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_25 = math.max(var_340_16, arg_337_1.talkMaxDuration)

			if var_340_15 <= arg_337_1.time_ and arg_337_1.time_ < var_340_15 + var_340_25 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_15) / var_340_25

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_15 + var_340_25 and arg_337_1.time_ < var_340_15 + var_340_25 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play1108408083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108408083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108408084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1084ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1084ui_story and not isNil(var_344_0) then
					local var_344_4 = Mathf.Lerp(0, 0.5, var_344_3)

					arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1084ui_story.fillRatio = var_344_4
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1084ui_story then
				local var_344_5 = 0.5

				arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1084ui_story.fillRatio = var_344_5
			end

			local var_344_6 = 0
			local var_344_7 = 0.475

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_9 = arg_341_1:GetWordFromCfg(1108408083)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 19
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_14 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_14

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_14 and arg_341_1.time_ < var_344_6 + var_344_14 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1108408084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108408084
		arg_345_1.duration_ = 3.2

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108408085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1084ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1084ui_story == nil then
				arg_345_1.var_.characterEffect1084ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1084ui_story and not isNil(var_348_0) then
					arg_345_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1084ui_story then
				arg_345_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_348_4 = 0

			if var_348_4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_348_5 = 0

			if var_348_5 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_348_6 = 0
			local var_348_7 = 0.125

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[6].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_9 = arg_345_1:GetWordFromCfg(1108408084)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 5
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb") ~= 0 then
					local var_348_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb") / 1000

					if var_348_14 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_6
					end

					if var_348_9.prefab_name ~= "" and arg_345_1.actors_[var_348_9.prefab_name] ~= nil then
						local var_348_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_9.prefab_name].transform, "story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb")

						arg_345_1:RecordAudio("1108408084", var_348_15)
						arg_345_1:RecordAudio("1108408084", var_348_15)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408084", "story_v_side_new_1108408.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_16 and arg_345_1.time_ < var_348_6 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108408085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108408085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108408086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1084ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1084ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, 100, 0)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1084ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, 100, 0)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1084ui_story"]
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1084ui_story == nil then
				arg_349_1.var_.characterEffect1084ui_story = var_352_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_11 = 0.200000002980232

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 and not isNil(var_352_9) then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11

				if arg_349_1.var_.characterEffect1084ui_story and not isNil(var_352_9) then
					local var_352_13 = Mathf.Lerp(0, 0.5, var_352_12)

					arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1084ui_story.fillRatio = var_352_13
				end
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1084ui_story then
				local var_352_14 = 0.5

				arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1084ui_story.fillRatio = var_352_14
			end

			local var_352_15 = 0
			local var_352_16 = 1.575

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_17 = arg_349_1:GetWordFromCfg(1108408085)
				local var_352_18 = arg_349_1:FormatText(var_352_17.content)

				arg_349_1.text_.text = var_352_18

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_19 = 63
				local var_352_20 = utf8.len(var_352_18)
				local var_352_21 = var_352_19 <= 0 and var_352_16 or var_352_16 * (var_352_20 / var_352_19)

				if var_352_21 > 0 and var_352_16 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21

					if var_352_21 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_15
					end
				end

				arg_349_1.text_.text = var_352_18
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_22 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_22 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_15) / var_352_22

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_15 + var_352_22 and arg_349_1.time_ < var_352_15 + var_352_22 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play1108408086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1108408086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1108408087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.85

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[7].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(1108408086)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 34
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_8 and arg_353_1.time_ < var_356_0 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1108408087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1108408087
		arg_357_1.duration_ = 3.53

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1108408088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1084ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1084ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, -0.97, -6)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1084ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = arg_357_1.actors_["1084ui_story"]
			local var_360_10 = 0

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1084ui_story == nil then
				arg_357_1.var_.characterEffect1084ui_story = var_360_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_11 = 0.200000002980232

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_11 and not isNil(var_360_9) then
				local var_360_12 = (arg_357_1.time_ - var_360_10) / var_360_11

				if arg_357_1.var_.characterEffect1084ui_story and not isNil(var_360_9) then
					arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_10 + var_360_11 and arg_357_1.time_ < var_360_10 + var_360_11 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1084ui_story then
				arg_357_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_360_13 = 0

			if var_360_13 < arg_357_1.time_ and arg_357_1.time_ <= var_360_13 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_360_14 = 0

			if var_360_14 < arg_357_1.time_ and arg_357_1.time_ <= var_360_14 + arg_360_0 then
				arg_357_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_15 = 0
			local var_360_16 = 0.425

			if var_360_15 < arg_357_1.time_ and arg_357_1.time_ <= var_360_15 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_17 = arg_357_1:FormatText(StoryNameCfg[6].name)

				arg_357_1.leftNameTxt_.text = var_360_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_18 = arg_357_1:GetWordFromCfg(1108408087)
				local var_360_19 = arg_357_1:FormatText(var_360_18.content)

				arg_357_1.text_.text = var_360_19

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_20 = 17
				local var_360_21 = utf8.len(var_360_19)
				local var_360_22 = var_360_20 <= 0 and var_360_16 or var_360_16 * (var_360_21 / var_360_20)

				if var_360_22 > 0 and var_360_16 < var_360_22 then
					arg_357_1.talkMaxDuration = var_360_22

					if var_360_22 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_22 + var_360_15
					end
				end

				arg_357_1.text_.text = var_360_19
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb") ~= 0 then
					local var_360_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb") / 1000

					if var_360_23 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_15
					end

					if var_360_18.prefab_name ~= "" and arg_357_1.actors_[var_360_18.prefab_name] ~= nil then
						local var_360_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_18.prefab_name].transform, "story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb")

						arg_357_1:RecordAudio("1108408087", var_360_24)
						arg_357_1:RecordAudio("1108408087", var_360_24)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408087", "story_v_side_new_1108408.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_25 = math.max(var_360_16, arg_357_1.talkMaxDuration)

			if var_360_15 <= arg_357_1.time_ and arg_357_1.time_ < var_360_15 + var_360_25 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_15) / var_360_25

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_15 + var_360_25 and arg_357_1.time_ < var_360_15 + var_360_25 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play1108408088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1108408088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1108408089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1084ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1084ui_story == nil then
				arg_361_1.var_.characterEffect1084ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1084ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1084ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1084ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1084ui_story.fillRatio = var_364_5
			end

			local var_364_6 = 0
			local var_364_7 = 1.35

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_8 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_9 = arg_361_1:GetWordFromCfg(1108408088)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 54
				local var_364_12 = utf8.len(var_364_10)
				local var_364_13 = var_364_11 <= 0 and var_364_7 or var_364_7 * (var_364_12 / var_364_11)

				if var_364_13 > 0 and var_364_7 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_14 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_14 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_14

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_14 and arg_361_1.time_ < var_364_6 + var_364_14 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1108408089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1108408089
		arg_365_1.duration_ = 4.57

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1108408090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1084ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1084ui_story == nil then
				arg_365_1.var_.characterEffect1084ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1084ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1084ui_story then
				arg_365_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_368_4 = 0

			if var_368_4 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_368_6 = 0
			local var_368_7 = 0.675

			if var_368_6 < arg_365_1.time_ and arg_365_1.time_ <= var_368_6 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_8 = arg_365_1:FormatText(StoryNameCfg[6].name)

				arg_365_1.leftNameTxt_.text = var_368_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_9 = arg_365_1:GetWordFromCfg(1108408089)
				local var_368_10 = arg_365_1:FormatText(var_368_9.content)

				arg_365_1.text_.text = var_368_10

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_11 = 27
				local var_368_12 = utf8.len(var_368_10)
				local var_368_13 = var_368_11 <= 0 and var_368_7 or var_368_7 * (var_368_12 / var_368_11)

				if var_368_13 > 0 and var_368_7 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_6
					end
				end

				arg_365_1.text_.text = var_368_10
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb") ~= 0 then
					local var_368_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb") / 1000

					if var_368_14 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_6
					end

					if var_368_9.prefab_name ~= "" and arg_365_1.actors_[var_368_9.prefab_name] ~= nil then
						local var_368_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_9.prefab_name].transform, "story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb")

						arg_365_1:RecordAudio("1108408089", var_368_15)
						arg_365_1:RecordAudio("1108408089", var_368_15)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408089", "story_v_side_new_1108408.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_16 = math.max(var_368_7, arg_365_1.talkMaxDuration)

			if var_368_6 <= arg_365_1.time_ and arg_365_1.time_ < var_368_6 + var_368_16 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_6) / var_368_16

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_6 + var_368_16 and arg_365_1.time_ < var_368_6 + var_368_16 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1108408090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1108408090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1108408091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1084ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1084ui_story == nil then
				arg_369_1.var_.characterEffect1084ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect1084ui_story and not isNil(var_372_0) then
					local var_372_4 = Mathf.Lerp(0, 0.5, var_372_3)

					arg_369_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1084ui_story.fillRatio = var_372_4
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect1084ui_story then
				local var_372_5 = 0.5

				arg_369_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1084ui_story.fillRatio = var_372_5
			end

			local var_372_6 = 0
			local var_372_7 = 1.125

			if var_372_6 < arg_369_1.time_ and arg_369_1.time_ <= var_372_6 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_8 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_9 = arg_369_1:GetWordFromCfg(1108408090)
				local var_372_10 = arg_369_1:FormatText(var_372_9.content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_11 = 45
				local var_372_12 = utf8.len(var_372_10)
				local var_372_13 = var_372_11 <= 0 and var_372_7 or var_372_7 * (var_372_12 / var_372_11)

				if var_372_13 > 0 and var_372_7 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_6 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_6
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_14 = math.max(var_372_7, arg_369_1.talkMaxDuration)

			if var_372_6 <= arg_369_1.time_ and arg_369_1.time_ < var_372_6 + var_372_14 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_6) / var_372_14

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_6 + var_372_14 and arg_369_1.time_ < var_372_6 + var_372_14 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1108408091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1108408091
		arg_373_1.duration_ = 2.17

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1108408092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1084ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1084ui_story == nil then
				arg_373_1.var_.characterEffect1084ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1084ui_story and not isNil(var_376_0) then
					arg_373_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1084ui_story then
				arg_373_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_376_4 = 0

			if var_376_4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_376_5 = 0

			if var_376_5 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_376_6 = 0
			local var_376_7 = 0.225

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_8 = arg_373_1:FormatText(StoryNameCfg[6].name)

				arg_373_1.leftNameTxt_.text = var_376_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_9 = arg_373_1:GetWordFromCfg(1108408091)
				local var_376_10 = arg_373_1:FormatText(var_376_9.content)

				arg_373_1.text_.text = var_376_10

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_11 = 9
				local var_376_12 = utf8.len(var_376_10)
				local var_376_13 = var_376_11 <= 0 and var_376_7 or var_376_7 * (var_376_12 / var_376_11)

				if var_376_13 > 0 and var_376_7 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_10
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb") ~= 0 then
					local var_376_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb") / 1000

					if var_376_14 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_6
					end

					if var_376_9.prefab_name ~= "" and arg_373_1.actors_[var_376_9.prefab_name] ~= nil then
						local var_376_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_9.prefab_name].transform, "story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb")

						arg_373_1:RecordAudio("1108408091", var_376_15)
						arg_373_1:RecordAudio("1108408091", var_376_15)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408091", "story_v_side_new_1108408.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_16 and arg_373_1.time_ < var_376_6 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1108408092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1108408092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1108408093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1084ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1084ui_story == nil then
				arg_377_1.var_.characterEffect1084ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1084ui_story and not isNil(var_380_0) then
					local var_380_4 = Mathf.Lerp(0, 0.5, var_380_3)

					arg_377_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1084ui_story.fillRatio = var_380_4
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1084ui_story then
				local var_380_5 = 0.5

				arg_377_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1084ui_story.fillRatio = var_380_5
			end

			local var_380_6 = 0
			local var_380_7 = 0.525

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_8 = arg_377_1:FormatText(StoryNameCfg[7].name)

				arg_377_1.leftNameTxt_.text = var_380_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_9 = arg_377_1:GetWordFromCfg(1108408092)
				local var_380_10 = arg_377_1:FormatText(var_380_9.content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_11 = 21
				local var_380_12 = utf8.len(var_380_10)
				local var_380_13 = var_380_11 <= 0 and var_380_7 or var_380_7 * (var_380_12 / var_380_11)

				if var_380_13 > 0 and var_380_7 < var_380_13 then
					arg_377_1.talkMaxDuration = var_380_13

					if var_380_13 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_13 + var_380_6
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_14 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_14 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_14

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_14 and arg_377_1.time_ < var_380_6 + var_380_14 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1108408093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1108408093
		arg_381_1.duration_ = 2.57

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1108408094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1084ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1084ui_story == nil then
				arg_381_1.var_.characterEffect1084ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1084ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1084ui_story then
				arg_381_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_384_4 = 0

			if var_384_4 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_384_5 = 0

			if var_384_5 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_384_6 = 0
			local var_384_7 = 0.5

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_8 = arg_381_1:FormatText(StoryNameCfg[6].name)

				arg_381_1.leftNameTxt_.text = var_384_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_9 = arg_381_1:GetWordFromCfg(1108408093)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 20
				local var_384_12 = utf8.len(var_384_10)
				local var_384_13 = var_384_11 <= 0 and var_384_7 or var_384_7 * (var_384_12 / var_384_11)

				if var_384_13 > 0 and var_384_7 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb") ~= 0 then
					local var_384_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb") / 1000

					if var_384_14 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_14 + var_384_6
					end

					if var_384_9.prefab_name ~= "" and arg_381_1.actors_[var_384_9.prefab_name] ~= nil then
						local var_384_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_9.prefab_name].transform, "story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb")

						arg_381_1:RecordAudio("1108408093", var_384_15)
						arg_381_1:RecordAudio("1108408093", var_384_15)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408093", "story_v_side_new_1108408.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_16 and arg_381_1.time_ < var_384_6 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1108408094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1108408094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1108408095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1084ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1084ui_story == nil then
				arg_385_1.var_.characterEffect1084ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1084ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1084ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1084ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1084ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 0.325

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_8 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_9 = arg_385_1:GetWordFromCfg(1108408094)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 13
				local var_388_12 = utf8.len(var_388_10)
				local var_388_13 = var_388_11 <= 0 and var_388_7 or var_388_7 * (var_388_12 / var_388_11)

				if var_388_13 > 0 and var_388_7 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_14 and arg_385_1.time_ < var_388_6 + var_388_14 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1108408095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1108408095
		arg_389_1.duration_ = 2

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1108408096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1084ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect1084ui_story and not isNil(var_392_0) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_392_4 = 0

			if var_392_4 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_392_5 = 0

			if var_392_5 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_392_6 = 0
			local var_392_7 = 0.125

			if var_392_6 < arg_389_1.time_ and arg_389_1.time_ <= var_392_6 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_8 = arg_389_1:FormatText(StoryNameCfg[6].name)

				arg_389_1.leftNameTxt_.text = var_392_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_9 = arg_389_1:GetWordFromCfg(1108408095)
				local var_392_10 = arg_389_1:FormatText(var_392_9.content)

				arg_389_1.text_.text = var_392_10

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_11 = 5
				local var_392_12 = utf8.len(var_392_10)
				local var_392_13 = var_392_11 <= 0 and var_392_7 or var_392_7 * (var_392_12 / var_392_11)

				if var_392_13 > 0 and var_392_7 < var_392_13 then
					arg_389_1.talkMaxDuration = var_392_13

					if var_392_13 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_6
					end
				end

				arg_389_1.text_.text = var_392_10
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb") ~= 0 then
					local var_392_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb") / 1000

					if var_392_14 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_6
					end

					if var_392_9.prefab_name ~= "" and arg_389_1.actors_[var_392_9.prefab_name] ~= nil then
						local var_392_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_9.prefab_name].transform, "story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb")

						arg_389_1:RecordAudio("1108408095", var_392_15)
						arg_389_1:RecordAudio("1108408095", var_392_15)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408095", "story_v_side_new_1108408.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_16 = math.max(var_392_7, arg_389_1.talkMaxDuration)

			if var_392_6 <= arg_389_1.time_ and arg_389_1.time_ < var_392_6 + var_392_16 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_6) / var_392_16

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_6 + var_392_16 and arg_389_1.time_ < var_392_6 + var_392_16 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1108408096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1108408096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1108408097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1084ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1084ui_story == nil then
				arg_393_1.var_.characterEffect1084ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1084ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1084ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1084ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1084ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.375

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_9 = arg_393_1:GetWordFromCfg(1108408096)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 15
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1108408097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1108408097
		arg_397_1.duration_ = 6.23

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1108408098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1084ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1084ui_story == nil then
				arg_397_1.var_.characterEffect1084ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1084ui_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1084ui_story then
				arg_397_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_400_5 = 0

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_400_6 = 0
			local var_400_7 = 0.525

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[6].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_9 = arg_397_1:GetWordFromCfg(1108408097)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 21
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb") / 1000

					if var_400_14 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_6
					end

					if var_400_9.prefab_name ~= "" and arg_397_1.actors_[var_400_9.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_9.prefab_name].transform, "story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb")

						arg_397_1:RecordAudio("1108408097", var_400_15)
						arg_397_1:RecordAudio("1108408097", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408097", "story_v_side_new_1108408.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_16 and arg_397_1.time_ < var_400_6 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1108408098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1108408098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1108408099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1084ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1084ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, 100, 0)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1084ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, 100, 0)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1084ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1084ui_story == nil then
				arg_401_1.var_.characterEffect1084ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect1084ui_story and not isNil(var_404_9) then
					local var_404_13 = Mathf.Lerp(0, 0.5, var_404_12)

					arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1084ui_story.fillRatio = var_404_13
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1084ui_story then
				local var_404_14 = 0.5

				arg_401_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1084ui_story.fillRatio = var_404_14
			end

			local var_404_15 = 0
			local var_404_16 = 1.25

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_17 = arg_401_1:GetWordFromCfg(1108408098)
				local var_404_18 = arg_401_1:FormatText(var_404_17.content)

				arg_401_1.text_.text = var_404_18

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_19 = 50
				local var_404_20 = utf8.len(var_404_18)
				local var_404_21 = var_404_19 <= 0 and var_404_16 or var_404_16 * (var_404_20 / var_404_19)

				if var_404_21 > 0 and var_404_16 < var_404_21 then
					arg_401_1.talkMaxDuration = var_404_21

					if var_404_21 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_21 + var_404_15
					end
				end

				arg_401_1.text_.text = var_404_18
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_22 = math.max(var_404_16, arg_401_1.talkMaxDuration)

			if var_404_15 <= arg_401_1.time_ and arg_401_1.time_ < var_404_15 + var_404_22 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_15) / var_404_22

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_15 + var_404_22 and arg_401_1.time_ < var_404_15 + var_404_22 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play1108408099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1108408099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1108408100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.2

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(1108408099)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 8
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_8 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_8 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_8

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_8 and arg_405_1.time_ < var_408_0 + var_408_8 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1108408100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1108408100
		arg_409_1.duration_ = 2.67

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1108408101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1084ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1084ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -0.97, -6)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1084ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1084ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1084ui_story == nil then
				arg_409_1.var_.characterEffect1084ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1084ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1084ui_story then
				arg_409_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action434")
			end

			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				arg_409_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_412_15 = 0
			local var_412_16 = 0.4

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_17 = arg_409_1:FormatText(StoryNameCfg[6].name)

				arg_409_1.leftNameTxt_.text = var_412_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_18 = arg_409_1:GetWordFromCfg(1108408100)
				local var_412_19 = arg_409_1:FormatText(var_412_18.content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_20 = 16
				local var_412_21 = utf8.len(var_412_19)
				local var_412_22 = var_412_20 <= 0 and var_412_16 or var_412_16 * (var_412_21 / var_412_20)

				if var_412_22 > 0 and var_412_16 < var_412_22 then
					arg_409_1.talkMaxDuration = var_412_22

					if var_412_22 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb") ~= 0 then
					local var_412_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb") / 1000

					if var_412_23 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_15
					end

					if var_412_18.prefab_name ~= "" and arg_409_1.actors_[var_412_18.prefab_name] ~= nil then
						local var_412_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_18.prefab_name].transform, "story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb")

						arg_409_1:RecordAudio("1108408100", var_412_24)
						arg_409_1:RecordAudio("1108408100", var_412_24)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408100", "story_v_side_new_1108408.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_25 and arg_409_1.time_ < var_412_15 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play1108408101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1108408101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1108408102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1084ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1084ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0, 100, 0)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1084ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, 100, 0)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["1084ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1084ui_story == nil then
				arg_413_1.var_.characterEffect1084ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect1084ui_story and not isNil(var_416_9) then
					local var_416_13 = Mathf.Lerp(0, 0.5, var_416_12)

					arg_413_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1084ui_story.fillRatio = var_416_13
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect1084ui_story then
				local var_416_14 = 0.5

				arg_413_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1084ui_story.fillRatio = var_416_14
			end

			local var_416_15 = 0
			local var_416_16 = 0.525

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_17 = arg_413_1:GetWordFromCfg(1108408101)
				local var_416_18 = arg_413_1:FormatText(var_416_17.content)

				arg_413_1.text_.text = var_416_18

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_19 = 21
				local var_416_20 = utf8.len(var_416_18)
				local var_416_21 = var_416_19 <= 0 and var_416_16 or var_416_16 * (var_416_20 / var_416_19)

				if var_416_21 > 0 and var_416_16 < var_416_21 then
					arg_413_1.talkMaxDuration = var_416_21

					if var_416_21 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_21 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_18
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_22 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_22 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_22

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_22 and arg_413_1.time_ < var_416_15 + var_416_22 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play1108408102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1108408102
		arg_417_1.duration_ = 5.27

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1108408103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = manager.ui.mainCamera.transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.shakeOldPos = var_420_0.localPosition
			end

			local var_420_2 = 0.266666666666667

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / 0.066
				local var_420_4, var_420_5 = math.modf(var_420_3)

				var_420_0.localPosition = Vector3.New(var_420_5 * 0.13, var_420_5 * 0.13, var_420_5 * 0.13) + arg_417_1.var_.shakeOldPos
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = arg_417_1.var_.shakeOldPos
			end

			local var_420_6 = 0

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.allBtn_.enabled = false
			end

			local var_420_7 = 0.266666666666667

			if arg_417_1.time_ >= var_420_6 + var_420_7 and arg_417_1.time_ < var_420_6 + var_420_7 + arg_420_0 then
				arg_417_1.allBtn_.enabled = true
			end

			if arg_417_1.frameCnt_ <= 1 then
				arg_417_1.dialog_:SetActive(false)
			end

			local var_420_8 = 0.266666666666667
			local var_420_9 = 0.125

			if var_420_8 < arg_417_1.time_ and arg_417_1.time_ <= var_420_8 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0

				arg_417_1.dialog_:SetActive(true)

				arg_417_1.dialogCg_.alpha = 0

				local var_420_10 = LeanTween.value(arg_417_1.dialog_, 0, 1, 0.3)

				var_420_10:setOnUpdate(LuaHelper.FloatAction(function(arg_421_0)
					arg_417_1.dialogCg_.alpha = arg_421_0
				end))
				var_420_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_417_1.dialog_)
					var_420_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_417_1.duration_ = arg_417_1.duration_ + 0.3

				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_11 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_12 = arg_417_1:GetWordFromCfg(1108408102)
				local var_420_13 = arg_417_1:FormatText(var_420_12.content)

				arg_417_1.text_.text = var_420_13

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_14 = 5
				local var_420_15 = utf8.len(var_420_13)
				local var_420_16 = var_420_14 <= 0 and var_420_9 or var_420_9 * (var_420_15 / var_420_14)

				if var_420_16 > 0 and var_420_9 < var_420_16 then
					arg_417_1.talkMaxDuration = var_420_16
					var_420_8 = var_420_8 + 0.3

					if var_420_16 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_16 + var_420_8
					end
				end

				arg_417_1.text_.text = var_420_13
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_17 = var_420_8 + 0.3
			local var_420_18 = math.max(var_420_9, arg_417_1.talkMaxDuration)

			if var_420_17 <= arg_417_1.time_ and arg_417_1.time_ < var_420_17 + var_420_18 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_17) / var_420_18

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_17 + var_420_18 and arg_417_1.time_ < var_420_17 + var_420_18 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1108408103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1108408103
		arg_423_1.duration_ = 3.57

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1108408104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1084ui_story"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos1084ui_story = var_426_0.localPosition
			end

			local var_426_2 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2
				local var_426_4 = Vector3.New(0, -0.97, -6)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1084ui_story, var_426_4, var_426_3)

				local var_426_5 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_5.x, var_426_5.y, var_426_5.z)

				local var_426_6 = var_426_0.localEulerAngles

				var_426_6.z = 0
				var_426_6.x = 0
				var_426_0.localEulerAngles = var_426_6
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_426_7 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_7.x, var_426_7.y, var_426_7.z)

				local var_426_8 = var_426_0.localEulerAngles

				var_426_8.z = 0
				var_426_8.x = 0
				var_426_0.localEulerAngles = var_426_8
			end

			local var_426_9 = arg_423_1.actors_["1084ui_story"]
			local var_426_10 = 0

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1084ui_story == nil then
				arg_423_1.var_.characterEffect1084ui_story = var_426_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_11 = 0.200000002980232

			if var_426_10 <= arg_423_1.time_ and arg_423_1.time_ < var_426_10 + var_426_11 and not isNil(var_426_9) then
				local var_426_12 = (arg_423_1.time_ - var_426_10) / var_426_11

				if arg_423_1.var_.characterEffect1084ui_story and not isNil(var_426_9) then
					arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_10 + var_426_11 and arg_423_1.time_ < var_426_10 + var_426_11 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1084ui_story then
				arg_423_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_426_13 = 0

			if var_426_13 < arg_423_1.time_ and arg_423_1.time_ <= var_426_13 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_426_14 = 0

			if var_426_14 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_426_15 = 0
			local var_426_16 = 0.725

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_17 = arg_423_1:FormatText(StoryNameCfg[6].name)

				arg_423_1.leftNameTxt_.text = var_426_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_18 = arg_423_1:GetWordFromCfg(1108408103)
				local var_426_19 = arg_423_1:FormatText(var_426_18.content)

				arg_423_1.text_.text = var_426_19

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_20 = 29
				local var_426_21 = utf8.len(var_426_19)
				local var_426_22 = var_426_20 <= 0 and var_426_16 or var_426_16 * (var_426_21 / var_426_20)

				if var_426_22 > 0 and var_426_16 < var_426_22 then
					arg_423_1.talkMaxDuration = var_426_22

					if var_426_22 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_22 + var_426_15
					end
				end

				arg_423_1.text_.text = var_426_19
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb") ~= 0 then
					local var_426_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb") / 1000

					if var_426_23 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_23 + var_426_15
					end

					if var_426_18.prefab_name ~= "" and arg_423_1.actors_[var_426_18.prefab_name] ~= nil then
						local var_426_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_18.prefab_name].transform, "story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb")

						arg_423_1:RecordAudio("1108408103", var_426_24)
						arg_423_1:RecordAudio("1108408103", var_426_24)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408103", "story_v_side_new_1108408.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_25 = math.max(var_426_16, arg_423_1.talkMaxDuration)

			if var_426_15 <= arg_423_1.time_ and arg_423_1.time_ < var_426_15 + var_426_25 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_15) / var_426_25

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_15 + var_426_25 and arg_423_1.time_ < var_426_15 + var_426_25 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
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

		arg_423_1:InitPlayNodeList()
	end,
	Play1108408104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1108408104
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1108408105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1084ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1084ui_story == nil then
				arg_427_1.var_.characterEffect1084ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1084ui_story and not isNil(var_430_0) then
					local var_430_4 = Mathf.Lerp(0, 0.5, var_430_3)

					arg_427_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1084ui_story.fillRatio = var_430_4
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect1084ui_story then
				local var_430_5 = 0.5

				arg_427_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1084ui_story.fillRatio = var_430_5
			end

			local var_430_6 = 0
			local var_430_7 = 0.3

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_8 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_9 = arg_427_1:GetWordFromCfg(1108408104)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 12
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_7 or var_430_7 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_7 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_14 and arg_427_1.time_ < var_430_6 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1108408105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108408105
		arg_431_1.duration_ = 2.6

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108408106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1084ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1084ui_story == nil then
				arg_431_1.var_.characterEffect1084ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1084ui_story and not isNil(var_434_0) then
					arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1084ui_story then
				arg_431_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_434_4 = 0

			if var_434_4 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_434_5 = 0

			if var_434_5 < arg_431_1.time_ and arg_431_1.time_ <= var_434_5 + arg_434_0 then
				arg_431_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_434_6 = 0
			local var_434_7 = 0.225

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[6].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_9 = arg_431_1:GetWordFromCfg(1108408105)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb") ~= 0 then
					local var_434_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb") / 1000

					if var_434_14 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_6
					end

					if var_434_9.prefab_name ~= "" and arg_431_1.actors_[var_434_9.prefab_name] ~= nil then
						local var_434_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_9.prefab_name].transform, "story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb")

						arg_431_1:RecordAudio("1108408105", var_434_15)
						arg_431_1:RecordAudio("1108408105", var_434_15)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408105", "story_v_side_new_1108408.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_16 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_16 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_16

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_16 and arg_431_1.time_ < var_434_6 + var_434_16 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108408106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108408106
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108408107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1084ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1084ui_story == nil then
				arg_435_1.var_.characterEffect1084ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1084ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1084ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1084ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1084ui_story.fillRatio = var_438_5
			end

			local var_438_6 = 0
			local var_438_7 = 0.575

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_9 = arg_435_1:GetWordFromCfg(1108408106)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 23
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_14 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_14

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_14 and arg_435_1.time_ < var_438_6 + var_438_14 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108408107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108408107
		arg_439_1.duration_ = 2

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108408108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1084ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1084ui_story == nil then
				arg_439_1.var_.characterEffect1084ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1084ui_story and not isNil(var_442_0) then
					arg_439_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1084ui_story then
				arg_439_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_442_4 = 0

			if var_442_4 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_442_5 = 0

			if var_442_5 < arg_439_1.time_ and arg_439_1.time_ <= var_442_5 + arg_442_0 then
				arg_439_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_442_6 = 0
			local var_442_7 = 0.15

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_8 = arg_439_1:FormatText(StoryNameCfg[6].name)

				arg_439_1.leftNameTxt_.text = var_442_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_9 = arg_439_1:GetWordFromCfg(1108408107)
				local var_442_10 = arg_439_1:FormatText(var_442_9.content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 6
				local var_442_12 = utf8.len(var_442_10)
				local var_442_13 = var_442_11 <= 0 and var_442_7 or var_442_7 * (var_442_12 / var_442_11)

				if var_442_13 > 0 and var_442_7 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_10
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb") ~= 0 then
					local var_442_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb") / 1000

					if var_442_14 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_14 + var_442_6
					end

					if var_442_9.prefab_name ~= "" and arg_439_1.actors_[var_442_9.prefab_name] ~= nil then
						local var_442_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_9.prefab_name].transform, "story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb")

						arg_439_1:RecordAudio("1108408107", var_442_15)
						arg_439_1:RecordAudio("1108408107", var_442_15)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408107", "story_v_side_new_1108408.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_16 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_16 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_16

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_16 and arg_439_1.time_ < var_442_6 + var_442_16 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108408108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108408108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108408109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1084ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos1084ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(0, 100, 0)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1084ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0, 100, 0)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = arg_443_1.actors_["1084ui_story"]
			local var_446_10 = 0

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect1084ui_story == nil then
				arg_443_1.var_.characterEffect1084ui_story = var_446_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_11 = 0.200000002980232

			if var_446_10 <= arg_443_1.time_ and arg_443_1.time_ < var_446_10 + var_446_11 and not isNil(var_446_9) then
				local var_446_12 = (arg_443_1.time_ - var_446_10) / var_446_11

				if arg_443_1.var_.characterEffect1084ui_story and not isNil(var_446_9) then
					local var_446_13 = Mathf.Lerp(0, 0.5, var_446_12)

					arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1084ui_story.fillRatio = var_446_13
				end
			end

			if arg_443_1.time_ >= var_446_10 + var_446_11 and arg_443_1.time_ < var_446_10 + var_446_11 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect1084ui_story then
				local var_446_14 = 0.5

				arg_443_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1084ui_story.fillRatio = var_446_14
			end

			local var_446_15 = 0
			local var_446_16 = 0.925

			if var_446_15 < arg_443_1.time_ and arg_443_1.time_ <= var_446_15 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_17 = arg_443_1:GetWordFromCfg(1108408108)
				local var_446_18 = arg_443_1:FormatText(var_446_17.content)

				arg_443_1.text_.text = var_446_18

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_19 = 37
				local var_446_20 = utf8.len(var_446_18)
				local var_446_21 = var_446_19 <= 0 and var_446_16 or var_446_16 * (var_446_20 / var_446_19)

				if var_446_21 > 0 and var_446_16 < var_446_21 then
					arg_443_1.talkMaxDuration = var_446_21

					if var_446_21 + var_446_15 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_21 + var_446_15
					end
				end

				arg_443_1.text_.text = var_446_18
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_22 = math.max(var_446_16, arg_443_1.talkMaxDuration)

			if var_446_15 <= arg_443_1.time_ and arg_443_1.time_ < var_446_15 + var_446_22 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_15) / var_446_22

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_15 + var_446_22 and arg_443_1.time_ < var_446_15 + var_446_22 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
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

		arg_443_1:InitPlayNodeList()
	end,
	Play1108408109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108408109
		arg_447_1.duration_ = 11.9

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108408110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = "A00"

			if arg_447_1.bgs_[var_450_0] == nil then
				local var_450_1 = Object.Instantiate(arg_447_1.paintGo_)

				var_450_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_450_0)
				var_450_1.name = var_450_0
				var_450_1.transform.parent = arg_447_1.stage_.transform
				var_450_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.bgs_[var_450_0] = var_450_1
			end

			local var_450_2 = 2

			if var_450_2 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				local var_450_3 = manager.ui.mainCamera.transform.localPosition
				local var_450_4 = Vector3.New(0, 0, 10) + Vector3.New(var_450_3.x, var_450_3.y, 0)
				local var_450_5 = arg_447_1.bgs_.A00

				var_450_5.transform.localPosition = var_450_4
				var_450_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_450_6 = var_450_5:GetComponent("SpriteRenderer")

				if var_450_6 and var_450_6.sprite then
					local var_450_7 = (var_450_5.transform.localPosition - var_450_3).z
					local var_450_8 = manager.ui.mainCameraCom_
					local var_450_9 = 2 * var_450_7 * Mathf.Tan(var_450_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_450_10 = var_450_9 * var_450_8.aspect
					local var_450_11 = var_450_6.sprite.bounds.size.x
					local var_450_12 = var_450_6.sprite.bounds.size.y
					local var_450_13 = var_450_10 / var_450_11
					local var_450_14 = var_450_9 / var_450_12
					local var_450_15 = var_450_14 < var_450_13 and var_450_13 or var_450_14

					var_450_5.transform.localScale = Vector3.New(var_450_15, var_450_15, 0)
				end

				for iter_450_0, iter_450_1 in pairs(arg_447_1.bgs_) do
					if iter_450_0 ~= "A00" then
						iter_450_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_450_16 = 4.00000000298023

			if var_450_16 < arg_447_1.time_ and arg_447_1.time_ <= var_450_16 + arg_450_0 then
				arg_447_1.allBtn_.enabled = false
			end

			local var_450_17 = 0.3

			if arg_447_1.time_ >= var_450_16 + var_450_17 and arg_447_1.time_ < var_450_16 + var_450_17 + arg_450_0 then
				arg_447_1.allBtn_.enabled = true
			end

			local var_450_18 = 0

			if var_450_18 < arg_447_1.time_ and arg_447_1.time_ <= var_450_18 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_19 = 2

			if var_450_18 <= arg_447_1.time_ and arg_447_1.time_ < var_450_18 + var_450_19 then
				local var_450_20 = (arg_447_1.time_ - var_450_18) / var_450_19
				local var_450_21 = Color.New(0, 0, 0)

				var_450_21.a = Mathf.Lerp(0, 1, var_450_20)
				arg_447_1.mask_.color = var_450_21
			end

			if arg_447_1.time_ >= var_450_18 + var_450_19 and arg_447_1.time_ < var_450_18 + var_450_19 + arg_450_0 then
				local var_450_22 = Color.New(0, 0, 0)

				var_450_22.a = 1
				arg_447_1.mask_.color = var_450_22
			end

			local var_450_23 = 2

			if var_450_23 < arg_447_1.time_ and arg_447_1.time_ <= var_450_23 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_24 = 2

			if var_450_23 <= arg_447_1.time_ and arg_447_1.time_ < var_450_23 + var_450_24 then
				local var_450_25 = (arg_447_1.time_ - var_450_23) / var_450_24
				local var_450_26 = Color.New(0, 0, 0)

				var_450_26.a = Mathf.Lerp(1, 0, var_450_25)
				arg_447_1.mask_.color = var_450_26
			end

			if arg_447_1.time_ >= var_450_23 + var_450_24 and arg_447_1.time_ < var_450_23 + var_450_24 + arg_450_0 then
				local var_450_27 = Color.New(0, 0, 0)
				local var_450_28 = 0

				arg_447_1.mask_.enabled = false
				var_450_27.a = var_450_28
				arg_447_1.mask_.color = var_450_27
			end

			local var_450_29 = arg_447_1.actors_["1084ui_story"].transform
			local var_450_30 = 3.8

			if var_450_30 < arg_447_1.time_ and arg_447_1.time_ <= var_450_30 + arg_450_0 then
				arg_447_1.var_.moveOldPos1084ui_story = var_450_29.localPosition
			end

			local var_450_31 = 0.001

			if var_450_30 <= arg_447_1.time_ and arg_447_1.time_ < var_450_30 + var_450_31 then
				local var_450_32 = (arg_447_1.time_ - var_450_30) / var_450_31
				local var_450_33 = Vector3.New(0, -0.97, -6)

				var_450_29.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1084ui_story, var_450_33, var_450_32)

				local var_450_34 = manager.ui.mainCamera.transform.position - var_450_29.position

				var_450_29.forward = Vector3.New(var_450_34.x, var_450_34.y, var_450_34.z)

				local var_450_35 = var_450_29.localEulerAngles

				var_450_35.z = 0
				var_450_35.x = 0
				var_450_29.localEulerAngles = var_450_35
			end

			if arg_447_1.time_ >= var_450_30 + var_450_31 and arg_447_1.time_ < var_450_30 + var_450_31 + arg_450_0 then
				var_450_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_450_36 = manager.ui.mainCamera.transform.position - var_450_29.position

				var_450_29.forward = Vector3.New(var_450_36.x, var_450_36.y, var_450_36.z)

				local var_450_37 = var_450_29.localEulerAngles

				var_450_37.z = 0
				var_450_37.x = 0
				var_450_29.localEulerAngles = var_450_37
			end

			local var_450_38 = arg_447_1.actors_["1084ui_story"]
			local var_450_39 = 3.8

			if var_450_39 < arg_447_1.time_ and arg_447_1.time_ <= var_450_39 + arg_450_0 and not isNil(var_450_38) and arg_447_1.var_.characterEffect1084ui_story == nil then
				arg_447_1.var_.characterEffect1084ui_story = var_450_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_40 = 0.200000002980232

			if var_450_39 <= arg_447_1.time_ and arg_447_1.time_ < var_450_39 + var_450_40 and not isNil(var_450_38) then
				local var_450_41 = (arg_447_1.time_ - var_450_39) / var_450_40

				if arg_447_1.var_.characterEffect1084ui_story and not isNil(var_450_38) then
					arg_447_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= var_450_39 + var_450_40 and arg_447_1.time_ < var_450_39 + var_450_40 + arg_450_0 and not isNil(var_450_38) and arg_447_1.var_.characterEffect1084ui_story then
				arg_447_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_450_42 = 3.8

			if var_450_42 < arg_447_1.time_ and arg_447_1.time_ <= var_450_42 + arg_450_0 then
				arg_447_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_450_43 = 3.8

			if var_450_43 < arg_447_1.time_ and arg_447_1.time_ <= var_450_43 + arg_450_0 then
				arg_447_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_450_44 = 1.2
			local var_450_45 = 1

			if var_450_44 < arg_447_1.time_ and arg_447_1.time_ <= var_450_44 + arg_450_0 then
				local var_450_46 = "play"
				local var_450_47 = "effect"

				arg_447_1:AudioAction(var_450_46, var_450_47, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_450_48 = 0.2
			local var_450_49 = 1

			if var_450_48 < arg_447_1.time_ and arg_447_1.time_ <= var_450_48 + arg_450_0 then
				local var_450_50 = "stop"
				local var_450_51 = "effect"

				arg_447_1:AudioAction(var_450_50, var_450_51, "se_story_133", "se_story_133_sea", "")
			end

			local var_450_52 = 0
			local var_450_53 = 1

			if var_450_52 < arg_447_1.time_ and arg_447_1.time_ <= var_450_52 + arg_450_0 then
				local var_450_54 = "play"
				local var_450_55 = "music"

				arg_447_1:AudioAction(var_450_54, var_450_55, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_450_56 = ""
				local var_450_57 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if var_450_57 ~= "" then
					if arg_447_1.bgmTxt_.text ~= var_450_57 and arg_447_1.bgmTxt_.text ~= "" then
						if arg_447_1.bgmTxt2_.text ~= "" then
							arg_447_1.bgmTxt_.text = arg_447_1.bgmTxt2_.text
						end

						arg_447_1.bgmTxt2_.text = var_450_57

						arg_447_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_447_1.bgmTxt_.text = var_450_57
						arg_447_1.bgmTxt2_.text = var_450_57
					end

					if arg_447_1.bgmTimer then
						arg_447_1.bgmTimer:Stop()

						arg_447_1.bgmTimer = nil
					end

					if arg_447_1.settingData.show_music_name == 1 then
						arg_447_1.musicController:SetSelectedState("show")
						arg_447_1.musicAnimator_:Play("open", 0, 0)

						if arg_447_1.settingData.music_time ~= 0 then
							arg_447_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_447_1.settingData.music_time), function()
								if arg_447_1 == nil or isNil(arg_447_1.bgmTxt_) then
									return
								end

								arg_447_1.musicController:SetSelectedState("hide")
								arg_447_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_447_1.frameCnt_ <= 1 then
				arg_447_1.dialog_:SetActive(false)
			end

			local var_450_58 = 4
			local var_450_59 = 0.9

			if var_450_58 < arg_447_1.time_ and arg_447_1.time_ <= var_450_58 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				arg_447_1.dialog_:SetActive(true)

				arg_447_1.dialogCg_.alpha = 0

				local var_450_60 = LeanTween.value(arg_447_1.dialog_, 0, 1, 0.3)

				var_450_60:setOnUpdate(LuaHelper.FloatAction(function(arg_452_0)
					arg_447_1.dialogCg_.alpha = arg_452_0
				end))
				var_450_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_447_1.dialog_)
					var_450_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_447_1.duration_ = arg_447_1.duration_ + 0.3

				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_61 = arg_447_1:FormatText(StoryNameCfg[6].name)

				arg_447_1.leftNameTxt_.text = var_450_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_62 = arg_447_1:GetWordFromCfg(1108408109)
				local var_450_63 = arg_447_1:FormatText(var_450_62.content)

				arg_447_1.text_.text = var_450_63

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_64 = 36
				local var_450_65 = utf8.len(var_450_63)
				local var_450_66 = var_450_64 <= 0 and var_450_59 or var_450_59 * (var_450_65 / var_450_64)

				if var_450_66 > 0 and var_450_59 < var_450_66 then
					arg_447_1.talkMaxDuration = var_450_66
					var_450_58 = var_450_58 + 0.3

					if var_450_66 + var_450_58 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_66 + var_450_58
					end
				end

				arg_447_1.text_.text = var_450_63
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb") ~= 0 then
					local var_450_67 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb") / 1000

					if var_450_67 + var_450_58 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_67 + var_450_58
					end

					if var_450_62.prefab_name ~= "" and arg_447_1.actors_[var_450_62.prefab_name] ~= nil then
						local var_450_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_62.prefab_name].transform, "story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb")

						arg_447_1:RecordAudio("1108408109", var_450_68)
						arg_447_1:RecordAudio("1108408109", var_450_68)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408109", "story_v_side_new_1108408.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_69 = var_450_58 + 0.3
			local var_450_70 = math.max(var_450_59, arg_447_1.talkMaxDuration)

			if var_450_69 <= arg_447_1.time_ and arg_447_1.time_ < var_450_69 + var_450_70 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_69) / var_450_70

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_69 + var_450_70 and arg_447_1.time_ < var_450_69 + var_450_70 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1108408110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1108408110
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1108408111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1084ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1084ui_story == nil then
				arg_454_1.var_.characterEffect1084ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1084ui_story and not isNil(var_457_0) then
					local var_457_4 = Mathf.Lerp(0, 0.5, var_457_3)

					arg_454_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1084ui_story.fillRatio = var_457_4
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1084ui_story then
				local var_457_5 = 0.5

				arg_454_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1084ui_story.fillRatio = var_457_5
			end

			local var_457_6 = 0
			local var_457_7 = 0.775

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_8 = arg_454_1:FormatText(StoryNameCfg[7].name)

				arg_454_1.leftNameTxt_.text = var_457_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_9 = arg_454_1:GetWordFromCfg(1108408110)
				local var_457_10 = arg_454_1:FormatText(var_457_9.content)

				arg_454_1.text_.text = var_457_10

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_11 = 31
				local var_457_12 = utf8.len(var_457_10)
				local var_457_13 = var_457_11 <= 0 and var_457_7 or var_457_7 * (var_457_12 / var_457_11)

				if var_457_13 > 0 and var_457_7 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_6
					end
				end

				arg_454_1.text_.text = var_457_10
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_14 = math.max(var_457_7, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_14 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_6) / var_457_14

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_14 and arg_454_1.time_ < var_457_6 + var_457_14 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1108408111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1108408111
		arg_458_1.duration_ = 6.53

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1108408112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1084ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1084ui_story == nil then
				arg_458_1.var_.characterEffect1084ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1084ui_story and not isNil(var_461_0) then
					arg_458_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1084ui_story then
				arg_458_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_461_4 = 0

			if var_461_4 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_461_5 = 0

			if var_461_5 < arg_458_1.time_ and arg_458_1.time_ <= var_461_5 + arg_461_0 then
				arg_458_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_461_6 = 0
			local var_461_7 = 0.475

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_8 = arg_458_1:FormatText(StoryNameCfg[6].name)

				arg_458_1.leftNameTxt_.text = var_461_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_9 = arg_458_1:GetWordFromCfg(1108408111)
				local var_461_10 = arg_458_1:FormatText(var_461_9.content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 19
				local var_461_12 = utf8.len(var_461_10)
				local var_461_13 = var_461_11 <= 0 and var_461_7 or var_461_7 * (var_461_12 / var_461_11)

				if var_461_13 > 0 and var_461_7 < var_461_13 then
					arg_458_1.talkMaxDuration = var_461_13

					if var_461_13 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_13 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_10
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb") ~= 0 then
					local var_461_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb") / 1000

					if var_461_14 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_14 + var_461_6
					end

					if var_461_9.prefab_name ~= "" and arg_458_1.actors_[var_461_9.prefab_name] ~= nil then
						local var_461_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_9.prefab_name].transform, "story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb")

						arg_458_1:RecordAudio("1108408111", var_461_15)
						arg_458_1:RecordAudio("1108408111", var_461_15)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408111", "story_v_side_new_1108408.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_16 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_16 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_16

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_16 and arg_458_1.time_ < var_461_6 + var_461_16 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1108408112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1108408112
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1108408113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1084ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1084ui_story == nil then
				arg_462_1.var_.characterEffect1084ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect1084ui_story and not isNil(var_465_0) then
					local var_465_4 = Mathf.Lerp(0, 0.5, var_465_3)

					arg_462_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1084ui_story.fillRatio = var_465_4
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1084ui_story then
				local var_465_5 = 0.5

				arg_462_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1084ui_story.fillRatio = var_465_5
			end

			local var_465_6 = 0
			local var_465_7 = 1.075

			if var_465_6 < arg_462_1.time_ and arg_462_1.time_ <= var_465_6 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_8 = arg_462_1:FormatText(StoryNameCfg[7].name)

				arg_462_1.leftNameTxt_.text = var_465_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_9 = arg_462_1:GetWordFromCfg(1108408112)
				local var_465_10 = arg_462_1:FormatText(var_465_9.content)

				arg_462_1.text_.text = var_465_10

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_11 = 43
				local var_465_12 = utf8.len(var_465_10)
				local var_465_13 = var_465_11 <= 0 and var_465_7 or var_465_7 * (var_465_12 / var_465_11)

				if var_465_13 > 0 and var_465_7 < var_465_13 then
					arg_462_1.talkMaxDuration = var_465_13

					if var_465_13 + var_465_6 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_13 + var_465_6
					end
				end

				arg_462_1.text_.text = var_465_10
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_14 = math.max(var_465_7, arg_462_1.talkMaxDuration)

			if var_465_6 <= arg_462_1.time_ and arg_462_1.time_ < var_465_6 + var_465_14 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_6) / var_465_14

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_6 + var_465_14 and arg_462_1.time_ < var_465_6 + var_465_14 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1108408113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1108408113
		arg_466_1.duration_ = 3

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1108408114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1084ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1084ui_story == nil then
				arg_466_1.var_.characterEffect1084ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1084ui_story and not isNil(var_469_0) then
					arg_466_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1084ui_story then
				arg_466_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_469_4 = 0

			if var_469_4 < arg_466_1.time_ and arg_466_1.time_ <= var_469_4 + arg_469_0 then
				arg_466_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_469_5 = 0

			if var_469_5 < arg_466_1.time_ and arg_466_1.time_ <= var_469_5 + arg_469_0 then
				arg_466_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_469_6 = 0
			local var_469_7 = 0.55

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[6].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_9 = arg_466_1:GetWordFromCfg(1108408113)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 22
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb") ~= 0 then
					local var_469_14 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb") / 1000

					if var_469_14 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_14 + var_469_6
					end

					if var_469_9.prefab_name ~= "" and arg_466_1.actors_[var_469_9.prefab_name] ~= nil then
						local var_469_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_9.prefab_name].transform, "story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb")

						arg_466_1:RecordAudio("1108408113", var_469_15)
						arg_466_1:RecordAudio("1108408113", var_469_15)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408113", "story_v_side_new_1108408.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_16 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_16 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_16

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_16 and arg_466_1.time_ < var_469_6 + var_469_16 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1108408114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1108408114
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1108408115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1084ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1084ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1084ui_story, var_473_4, var_473_3)

				local var_473_5 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_5.x, var_473_5.y, var_473_5.z)

				local var_473_6 = var_473_0.localEulerAngles

				var_473_6.z = 0
				var_473_6.x = 0
				var_473_0.localEulerAngles = var_473_6
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, 100, 0)

				local var_473_7 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_7.x, var_473_7.y, var_473_7.z)

				local var_473_8 = var_473_0.localEulerAngles

				var_473_8.z = 0
				var_473_8.x = 0
				var_473_0.localEulerAngles = var_473_8
			end

			local var_473_9 = arg_470_1.actors_["1084ui_story"]
			local var_473_10 = 0

			if var_473_10 < arg_470_1.time_ and arg_470_1.time_ <= var_473_10 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect1084ui_story == nil then
				arg_470_1.var_.characterEffect1084ui_story = var_473_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_11 = 0.200000002980232

			if var_473_10 <= arg_470_1.time_ and arg_470_1.time_ < var_473_10 + var_473_11 and not isNil(var_473_9) then
				local var_473_12 = (arg_470_1.time_ - var_473_10) / var_473_11

				if arg_470_1.var_.characterEffect1084ui_story and not isNil(var_473_9) then
					local var_473_13 = Mathf.Lerp(0, 0.5, var_473_12)

					arg_470_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1084ui_story.fillRatio = var_473_13
				end
			end

			if arg_470_1.time_ >= var_473_10 + var_473_11 and arg_470_1.time_ < var_473_10 + var_473_11 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect1084ui_story then
				local var_473_14 = 0.5

				arg_470_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1084ui_story.fillRatio = var_473_14
			end

			local var_473_15 = 0
			local var_473_16 = 0.825

			if var_473_15 < arg_470_1.time_ and arg_470_1.time_ <= var_473_15 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_17 = arg_470_1:GetWordFromCfg(1108408114)
				local var_473_18 = arg_470_1:FormatText(var_473_17.content)

				arg_470_1.text_.text = var_473_18

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_19 = 33
				local var_473_20 = utf8.len(var_473_18)
				local var_473_21 = var_473_19 <= 0 and var_473_16 or var_473_16 * (var_473_20 / var_473_19)

				if var_473_21 > 0 and var_473_16 < var_473_21 then
					arg_470_1.talkMaxDuration = var_473_21

					if var_473_21 + var_473_15 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_21 + var_473_15
					end
				end

				arg_470_1.text_.text = var_473_18
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_22 = math.max(var_473_16, arg_470_1.talkMaxDuration)

			if var_473_15 <= arg_470_1.time_ and arg_470_1.time_ < var_473_15 + var_473_22 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_15) / var_473_22

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_15 + var_473_22 and arg_470_1.time_ < var_473_15 + var_473_22 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
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

		arg_470_1:InitPlayNodeList()
	end,
	Play1108408115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1108408115
		arg_474_1.duration_ = 3.7

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1108408116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = "1047ui_story"

			if arg_474_1.actors_[var_477_0] == nil then
				local var_477_1 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_477_1) then
					local var_477_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_474_1.stage_.transform)

					var_477_2.name = var_477_0
					var_477_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_474_1.actors_[var_477_0] = var_477_2

					local var_477_3 = var_477_2:GetComponentInChildren(typeof(CharacterEffect))

					var_477_3.enabled = true

					local var_477_4 = GameObjectTools.GetOrAddComponent(var_477_2, typeof(DynamicBoneHelper))

					if var_477_4 then
						var_477_4:EnableDynamicBone(false)
					end

					arg_474_1:ShowWeapon(var_477_3.transform, false)

					arg_474_1.var_[var_477_0 .. "Animator"] = var_477_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_474_1.var_[var_477_0 .. "Animator"].applyRootMotion = true
					arg_474_1.var_[var_477_0 .. "LipSync"] = var_477_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_477_5 = arg_474_1.actors_["1047ui_story"].transform
			local var_477_6 = 0

			if var_477_6 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.var_.moveOldPos1047ui_story = var_477_5.localPosition
			end

			local var_477_7 = 0.001

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_7 then
				local var_477_8 = (arg_474_1.time_ - var_477_6) / var_477_7
				local var_477_9 = Vector3.New(-0.6, -1.13, -6.2)

				var_477_5.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1047ui_story, var_477_9, var_477_8)

				local var_477_10 = manager.ui.mainCamera.transform.position - var_477_5.position

				var_477_5.forward = Vector3.New(var_477_10.x, var_477_10.y, var_477_10.z)

				local var_477_11 = var_477_5.localEulerAngles

				var_477_11.z = 0
				var_477_11.x = 0
				var_477_5.localEulerAngles = var_477_11
			end

			if arg_474_1.time_ >= var_477_6 + var_477_7 and arg_474_1.time_ < var_477_6 + var_477_7 + arg_477_0 then
				var_477_5.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_477_12 = manager.ui.mainCamera.transform.position - var_477_5.position

				var_477_5.forward = Vector3.New(var_477_12.x, var_477_12.y, var_477_12.z)

				local var_477_13 = var_477_5.localEulerAngles

				var_477_13.z = 0
				var_477_13.x = 0
				var_477_5.localEulerAngles = var_477_13
			end

			local var_477_14 = arg_474_1.actors_["1047ui_story"]
			local var_477_15 = 0

			if var_477_15 < arg_474_1.time_ and arg_474_1.time_ <= var_477_15 + arg_477_0 and not isNil(var_477_14) and arg_474_1.var_.characterEffect1047ui_story == nil then
				arg_474_1.var_.characterEffect1047ui_story = var_477_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_16 = 0.200000002980232

			if var_477_15 <= arg_474_1.time_ and arg_474_1.time_ < var_477_15 + var_477_16 and not isNil(var_477_14) then
				local var_477_17 = (arg_474_1.time_ - var_477_15) / var_477_16

				if arg_474_1.var_.characterEffect1047ui_story and not isNil(var_477_14) then
					arg_474_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_15 + var_477_16 and arg_474_1.time_ < var_477_15 + var_477_16 + arg_477_0 and not isNil(var_477_14) and arg_474_1.var_.characterEffect1047ui_story then
				arg_474_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_477_18 = 0

			if var_477_18 < arg_474_1.time_ and arg_474_1.time_ <= var_477_18 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_477_19 = 0

			if var_477_19 < arg_474_1.time_ and arg_474_1.time_ <= var_477_19 + arg_477_0 then
				arg_474_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_477_20 = 0
			local var_477_21 = 0.4

			if var_477_20 < arg_474_1.time_ and arg_474_1.time_ <= var_477_20 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_22 = arg_474_1:FormatText(StoryNameCfg[1296].name)

				arg_474_1.leftNameTxt_.text = var_477_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_23 = arg_474_1:GetWordFromCfg(1108408115)
				local var_477_24 = arg_474_1:FormatText(var_477_23.content)

				arg_474_1.text_.text = var_477_24

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_25 = 16
				local var_477_26 = utf8.len(var_477_24)
				local var_477_27 = var_477_25 <= 0 and var_477_21 or var_477_21 * (var_477_26 / var_477_25)

				if var_477_27 > 0 and var_477_21 < var_477_27 then
					arg_474_1.talkMaxDuration = var_477_27

					if var_477_27 + var_477_20 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_27 + var_477_20
					end
				end

				arg_474_1.text_.text = var_477_24
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb") ~= 0 then
					local var_477_28 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb") / 1000

					if var_477_28 + var_477_20 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_28 + var_477_20
					end

					if var_477_23.prefab_name ~= "" and arg_474_1.actors_[var_477_23.prefab_name] ~= nil then
						local var_477_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_23.prefab_name].transform, "story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb")

						arg_474_1:RecordAudio("1108408115", var_477_29)
						arg_474_1:RecordAudio("1108408115", var_477_29)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408115", "story_v_side_new_1108408.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_30 = math.max(var_477_21, arg_474_1.talkMaxDuration)

			if var_477_20 <= arg_474_1.time_ and arg_474_1.time_ < var_477_20 + var_477_30 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_20) / var_477_30

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_20 + var_477_30 and arg_474_1.time_ < var_477_20 + var_477_30 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
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

		arg_474_1:InitPlayNodeList()
	end,
	Play1108408116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1108408116
		arg_478_1.duration_ = 4.4

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1108408117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["1084ui_story"].transform
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.var_.moveOldPos1084ui_story = var_481_0.localPosition
			end

			local var_481_2 = 0.001

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2
				local var_481_4 = Vector3.New(0.7, -0.97, -6)

				var_481_0.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1084ui_story, var_481_4, var_481_3)

				local var_481_5 = manager.ui.mainCamera.transform.position - var_481_0.position

				var_481_0.forward = Vector3.New(var_481_5.x, var_481_5.y, var_481_5.z)

				local var_481_6 = var_481_0.localEulerAngles

				var_481_6.z = 0
				var_481_6.x = 0
				var_481_0.localEulerAngles = var_481_6
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 then
				var_481_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_481_7 = manager.ui.mainCamera.transform.position - var_481_0.position

				var_481_0.forward = Vector3.New(var_481_7.x, var_481_7.y, var_481_7.z)

				local var_481_8 = var_481_0.localEulerAngles

				var_481_8.z = 0
				var_481_8.x = 0
				var_481_0.localEulerAngles = var_481_8
			end

			local var_481_9 = arg_478_1.actors_["1084ui_story"]
			local var_481_10 = 0

			if var_481_10 < arg_478_1.time_ and arg_478_1.time_ <= var_481_10 + arg_481_0 and not isNil(var_481_9) and arg_478_1.var_.characterEffect1084ui_story == nil then
				arg_478_1.var_.characterEffect1084ui_story = var_481_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_11 = 0.200000002980232

			if var_481_10 <= arg_478_1.time_ and arg_478_1.time_ < var_481_10 + var_481_11 and not isNil(var_481_9) then
				local var_481_12 = (arg_478_1.time_ - var_481_10) / var_481_11

				if arg_478_1.var_.characterEffect1084ui_story and not isNil(var_481_9) then
					arg_478_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_10 + var_481_11 and arg_478_1.time_ < var_481_10 + var_481_11 + arg_481_0 and not isNil(var_481_9) and arg_478_1.var_.characterEffect1084ui_story then
				arg_478_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_481_13 = arg_478_1.actors_["1047ui_story"]
			local var_481_14 = 0

			if var_481_14 < arg_478_1.time_ and arg_478_1.time_ <= var_481_14 + arg_481_0 and not isNil(var_481_13) and arg_478_1.var_.characterEffect1047ui_story == nil then
				arg_478_1.var_.characterEffect1047ui_story = var_481_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_15 = 0.200000002980232

			if var_481_14 <= arg_478_1.time_ and arg_478_1.time_ < var_481_14 + var_481_15 and not isNil(var_481_13) then
				local var_481_16 = (arg_478_1.time_ - var_481_14) / var_481_15

				if arg_478_1.var_.characterEffect1047ui_story and not isNil(var_481_13) then
					local var_481_17 = Mathf.Lerp(0, 0.5, var_481_16)

					arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1047ui_story.fillRatio = var_481_17
				end
			end

			if arg_478_1.time_ >= var_481_14 + var_481_15 and arg_478_1.time_ < var_481_14 + var_481_15 + arg_481_0 and not isNil(var_481_13) and arg_478_1.var_.characterEffect1047ui_story then
				local var_481_18 = 0.5

				arg_478_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1047ui_story.fillRatio = var_481_18
			end

			local var_481_19 = 0

			if var_481_19 < arg_478_1.time_ and arg_478_1.time_ <= var_481_19 + arg_481_0 then
				arg_478_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_481_20 = 0

			if var_481_20 < arg_478_1.time_ and arg_478_1.time_ <= var_481_20 + arg_481_0 then
				arg_478_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_481_21 = 0
			local var_481_22 = 0.65

			if var_481_21 < arg_478_1.time_ and arg_478_1.time_ <= var_481_21 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_23 = arg_478_1:FormatText(StoryNameCfg[6].name)

				arg_478_1.leftNameTxt_.text = var_481_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_24 = arg_478_1:GetWordFromCfg(1108408116)
				local var_481_25 = arg_478_1:FormatText(var_481_24.content)

				arg_478_1.text_.text = var_481_25

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_26 = 26
				local var_481_27 = utf8.len(var_481_25)
				local var_481_28 = var_481_26 <= 0 and var_481_22 or var_481_22 * (var_481_27 / var_481_26)

				if var_481_28 > 0 and var_481_22 < var_481_28 then
					arg_478_1.talkMaxDuration = var_481_28

					if var_481_28 + var_481_21 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_28 + var_481_21
					end
				end

				arg_478_1.text_.text = var_481_25
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb") ~= 0 then
					local var_481_29 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb") / 1000

					if var_481_29 + var_481_21 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_29 + var_481_21
					end

					if var_481_24.prefab_name ~= "" and arg_478_1.actors_[var_481_24.prefab_name] ~= nil then
						local var_481_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_24.prefab_name].transform, "story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb")

						arg_478_1:RecordAudio("1108408116", var_481_30)
						arg_478_1:RecordAudio("1108408116", var_481_30)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408116", "story_v_side_new_1108408.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_31 = math.max(var_481_22, arg_478_1.talkMaxDuration)

			if var_481_21 <= arg_478_1.time_ and arg_478_1.time_ < var_481_21 + var_481_31 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_21) / var_481_31

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_21 + var_481_31 and arg_478_1.time_ < var_481_21 + var_481_31 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
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

		arg_478_1:InitPlayNodeList()
	end,
	Play1108408117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1108408117
		arg_482_1.duration_ = 15.9

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1108408118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1047ui_story"].transform
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.var_.moveOldPos1047ui_story = var_485_0.localPosition
			end

			local var_485_2 = 0.001

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2
				local var_485_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_485_0.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos1047ui_story, var_485_4, var_485_3)

				local var_485_5 = manager.ui.mainCamera.transform.position - var_485_0.position

				var_485_0.forward = Vector3.New(var_485_5.x, var_485_5.y, var_485_5.z)

				local var_485_6 = var_485_0.localEulerAngles

				var_485_6.z = 0
				var_485_6.x = 0
				var_485_0.localEulerAngles = var_485_6
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 then
				var_485_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_485_7 = manager.ui.mainCamera.transform.position - var_485_0.position

				var_485_0.forward = Vector3.New(var_485_7.x, var_485_7.y, var_485_7.z)

				local var_485_8 = var_485_0.localEulerAngles

				var_485_8.z = 0
				var_485_8.x = 0
				var_485_0.localEulerAngles = var_485_8
			end

			local var_485_9 = arg_482_1.actors_["1047ui_story"]
			local var_485_10 = 0

			if var_485_10 < arg_482_1.time_ and arg_482_1.time_ <= var_485_10 + arg_485_0 and not isNil(var_485_9) and arg_482_1.var_.characterEffect1047ui_story == nil then
				arg_482_1.var_.characterEffect1047ui_story = var_485_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_11 = 0.200000002980232

			if var_485_10 <= arg_482_1.time_ and arg_482_1.time_ < var_485_10 + var_485_11 and not isNil(var_485_9) then
				local var_485_12 = (arg_482_1.time_ - var_485_10) / var_485_11

				if arg_482_1.var_.characterEffect1047ui_story and not isNil(var_485_9) then
					arg_482_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= var_485_10 + var_485_11 and arg_482_1.time_ < var_485_10 + var_485_11 + arg_485_0 and not isNil(var_485_9) and arg_482_1.var_.characterEffect1047ui_story then
				arg_482_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_485_13 = arg_482_1.actors_["1084ui_story"]
			local var_485_14 = 0

			if var_485_14 < arg_482_1.time_ and arg_482_1.time_ <= var_485_14 + arg_485_0 and not isNil(var_485_13) and arg_482_1.var_.characterEffect1084ui_story == nil then
				arg_482_1.var_.characterEffect1084ui_story = var_485_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_15 = 0.200000002980232

			if var_485_14 <= arg_482_1.time_ and arg_482_1.time_ < var_485_14 + var_485_15 and not isNil(var_485_13) then
				local var_485_16 = (arg_482_1.time_ - var_485_14) / var_485_15

				if arg_482_1.var_.characterEffect1084ui_story and not isNil(var_485_13) then
					local var_485_17 = Mathf.Lerp(0, 0.5, var_485_16)

					arg_482_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1084ui_story.fillRatio = var_485_17
				end
			end

			if arg_482_1.time_ >= var_485_14 + var_485_15 and arg_482_1.time_ < var_485_14 + var_485_15 + arg_485_0 and not isNil(var_485_13) and arg_482_1.var_.characterEffect1084ui_story then
				local var_485_18 = 0.5

				arg_482_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1084ui_story.fillRatio = var_485_18
			end

			local var_485_19 = 0

			if var_485_19 < arg_482_1.time_ and arg_482_1.time_ <= var_485_19 + arg_485_0 then
				arg_482_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_485_20 = 0

			if var_485_20 < arg_482_1.time_ and arg_482_1.time_ <= var_485_20 + arg_485_0 then
				arg_482_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_485_21 = 0
			local var_485_22 = 1.5

			if var_485_21 < arg_482_1.time_ and arg_482_1.time_ <= var_485_21 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_23 = arg_482_1:FormatText(StoryNameCfg[1296].name)

				arg_482_1.leftNameTxt_.text = var_485_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_24 = arg_482_1:GetWordFromCfg(1108408117)
				local var_485_25 = arg_482_1:FormatText(var_485_24.content)

				arg_482_1.text_.text = var_485_25

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_26 = 60
				local var_485_27 = utf8.len(var_485_25)
				local var_485_28 = var_485_26 <= 0 and var_485_22 or var_485_22 * (var_485_27 / var_485_26)

				if var_485_28 > 0 and var_485_22 < var_485_28 then
					arg_482_1.talkMaxDuration = var_485_28

					if var_485_28 + var_485_21 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_28 + var_485_21
					end
				end

				arg_482_1.text_.text = var_485_25
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb") ~= 0 then
					local var_485_29 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb") / 1000

					if var_485_29 + var_485_21 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_29 + var_485_21
					end

					if var_485_24.prefab_name ~= "" and arg_482_1.actors_[var_485_24.prefab_name] ~= nil then
						local var_485_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_24.prefab_name].transform, "story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb")

						arg_482_1:RecordAudio("1108408117", var_485_30)
						arg_482_1:RecordAudio("1108408117", var_485_30)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408117", "story_v_side_new_1108408.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_31 = math.max(var_485_22, arg_482_1.talkMaxDuration)

			if var_485_21 <= arg_482_1.time_ and arg_482_1.time_ < var_485_21 + var_485_31 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_21) / var_485_31

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_21 + var_485_31 and arg_482_1.time_ < var_485_21 + var_485_31 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
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

		arg_482_1:InitPlayNodeList()
	end,
	Play1108408118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1108408118
		arg_486_1.duration_ = 7.8

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1108408119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1084ui_story"].transform
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.var_.moveOldPos1084ui_story = var_489_0.localPosition
			end

			local var_489_2 = 0.001

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2
				local var_489_4 = Vector3.New(0.7, -0.97, -6)

				var_489_0.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1084ui_story, var_489_4, var_489_3)

				local var_489_5 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_5.x, var_489_5.y, var_489_5.z)

				local var_489_6 = var_489_0.localEulerAngles

				var_489_6.z = 0
				var_489_6.x = 0
				var_489_0.localEulerAngles = var_489_6
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 then
				var_489_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_489_7 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_7.x, var_489_7.y, var_489_7.z)

				local var_489_8 = var_489_0.localEulerAngles

				var_489_8.z = 0
				var_489_8.x = 0
				var_489_0.localEulerAngles = var_489_8
			end

			local var_489_9 = arg_486_1.actors_["1084ui_story"]
			local var_489_10 = 0

			if var_489_10 < arg_486_1.time_ and arg_486_1.time_ <= var_489_10 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect1084ui_story == nil then
				arg_486_1.var_.characterEffect1084ui_story = var_489_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_11 = 0.200000002980232

			if var_489_10 <= arg_486_1.time_ and arg_486_1.time_ < var_489_10 + var_489_11 and not isNil(var_489_9) then
				local var_489_12 = (arg_486_1.time_ - var_489_10) / var_489_11

				if arg_486_1.var_.characterEffect1084ui_story and not isNil(var_489_9) then
					arg_486_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_10 + var_489_11 and arg_486_1.time_ < var_489_10 + var_489_11 + arg_489_0 and not isNil(var_489_9) and arg_486_1.var_.characterEffect1084ui_story then
				arg_486_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_489_13 = arg_486_1.actors_["1047ui_story"]
			local var_489_14 = 0

			if var_489_14 < arg_486_1.time_ and arg_486_1.time_ <= var_489_14 + arg_489_0 and not isNil(var_489_13) and arg_486_1.var_.characterEffect1047ui_story == nil then
				arg_486_1.var_.characterEffect1047ui_story = var_489_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_15 = 0.200000002980232

			if var_489_14 <= arg_486_1.time_ and arg_486_1.time_ < var_489_14 + var_489_15 and not isNil(var_489_13) then
				local var_489_16 = (arg_486_1.time_ - var_489_14) / var_489_15

				if arg_486_1.var_.characterEffect1047ui_story and not isNil(var_489_13) then
					local var_489_17 = Mathf.Lerp(0, 0.5, var_489_16)

					arg_486_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1047ui_story.fillRatio = var_489_17
				end
			end

			if arg_486_1.time_ >= var_489_14 + var_489_15 and arg_486_1.time_ < var_489_14 + var_489_15 + arg_489_0 and not isNil(var_489_13) and arg_486_1.var_.characterEffect1047ui_story then
				local var_489_18 = 0.5

				arg_486_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1047ui_story.fillRatio = var_489_18
			end

			local var_489_19 = 0

			if var_489_19 < arg_486_1.time_ and arg_486_1.time_ <= var_489_19 + arg_489_0 then
				arg_486_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_489_20 = 0

			if var_489_20 < arg_486_1.time_ and arg_486_1.time_ <= var_489_20 + arg_489_0 then
				arg_486_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_489_21 = 0
			local var_489_22 = 1.15

			if var_489_21 < arg_486_1.time_ and arg_486_1.time_ <= var_489_21 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_23 = arg_486_1:FormatText(StoryNameCfg[6].name)

				arg_486_1.leftNameTxt_.text = var_489_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_24 = arg_486_1:GetWordFromCfg(1108408118)
				local var_489_25 = arg_486_1:FormatText(var_489_24.content)

				arg_486_1.text_.text = var_489_25

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_26 = 46
				local var_489_27 = utf8.len(var_489_25)
				local var_489_28 = var_489_26 <= 0 and var_489_22 or var_489_22 * (var_489_27 / var_489_26)

				if var_489_28 > 0 and var_489_22 < var_489_28 then
					arg_486_1.talkMaxDuration = var_489_28

					if var_489_28 + var_489_21 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_28 + var_489_21
					end
				end

				arg_486_1.text_.text = var_489_25
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb") ~= 0 then
					local var_489_29 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb") / 1000

					if var_489_29 + var_489_21 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_29 + var_489_21
					end

					if var_489_24.prefab_name ~= "" and arg_486_1.actors_[var_489_24.prefab_name] ~= nil then
						local var_489_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_24.prefab_name].transform, "story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb")

						arg_486_1:RecordAudio("1108408118", var_489_30)
						arg_486_1:RecordAudio("1108408118", var_489_30)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408118", "story_v_side_new_1108408.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_31 = math.max(var_489_22, arg_486_1.talkMaxDuration)

			if var_489_21 <= arg_486_1.time_ and arg_486_1.time_ < var_489_21 + var_489_31 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_21) / var_489_31

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_21 + var_489_31 and arg_486_1.time_ < var_489_21 + var_489_31 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
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

		arg_486_1:InitPlayNodeList()
	end,
	Play1108408119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1108408119
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1108408120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1084ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1084ui_story == nil then
				arg_490_1.var_.characterEffect1084ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect1084ui_story and not isNil(var_493_0) then
					local var_493_4 = Mathf.Lerp(0, 0.5, var_493_3)

					arg_490_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1084ui_story.fillRatio = var_493_4
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1084ui_story then
				local var_493_5 = 0.5

				arg_490_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1084ui_story.fillRatio = var_493_5
			end

			local var_493_6 = 0
			local var_493_7 = 0.675

			if var_493_6 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_8 = arg_490_1:FormatText(StoryNameCfg[7].name)

				arg_490_1.leftNameTxt_.text = var_493_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_9 = arg_490_1:GetWordFromCfg(1108408119)
				local var_493_10 = arg_490_1:FormatText(var_493_9.content)

				arg_490_1.text_.text = var_493_10

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_11 = 27
				local var_493_12 = utf8.len(var_493_10)
				local var_493_13 = var_493_11 <= 0 and var_493_7 or var_493_7 * (var_493_12 / var_493_11)

				if var_493_13 > 0 and var_493_7 < var_493_13 then
					arg_490_1.talkMaxDuration = var_493_13

					if var_493_13 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_13 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_10
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_14 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_14 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_14

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_14 and arg_490_1.time_ < var_493_6 + var_493_14 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1108408120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1108408120
		arg_494_1.duration_ = 6.47

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1108408121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1047ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos1047ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1047ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["1047ui_story"]
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1047ui_story == nil then
				arg_494_1.var_.characterEffect1047ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_11 = 0.200000002980232

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 and not isNil(var_497_9) then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11

				if arg_494_1.var_.characterEffect1047ui_story and not isNil(var_497_9) then
					arg_494_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1047ui_story then
				arg_494_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_497_13 = 0

			if var_497_13 < arg_494_1.time_ and arg_494_1.time_ <= var_497_13 + arg_497_0 then
				arg_494_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_497_14 = 0

			if var_497_14 < arg_494_1.time_ and arg_494_1.time_ <= var_497_14 + arg_497_0 then
				arg_494_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_497_15 = 0
			local var_497_16 = 0.675

			if var_497_15 < arg_494_1.time_ and arg_494_1.time_ <= var_497_15 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_17 = arg_494_1:FormatText(StoryNameCfg[1296].name)

				arg_494_1.leftNameTxt_.text = var_497_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_18 = arg_494_1:GetWordFromCfg(1108408120)
				local var_497_19 = arg_494_1:FormatText(var_497_18.content)

				arg_494_1.text_.text = var_497_19

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_20 = 27
				local var_497_21 = utf8.len(var_497_19)
				local var_497_22 = var_497_20 <= 0 and var_497_16 or var_497_16 * (var_497_21 / var_497_20)

				if var_497_22 > 0 and var_497_16 < var_497_22 then
					arg_494_1.talkMaxDuration = var_497_22

					if var_497_22 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_22 + var_497_15
					end
				end

				arg_494_1.text_.text = var_497_19
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb") ~= 0 then
					local var_497_23 = manager.audio:GetVoiceLength("story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb") / 1000

					if var_497_23 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_23 + var_497_15
					end

					if var_497_18.prefab_name ~= "" and arg_494_1.actors_[var_497_18.prefab_name] ~= nil then
						local var_497_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_18.prefab_name].transform, "story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb")

						arg_494_1:RecordAudio("1108408120", var_497_24)
						arg_494_1:RecordAudio("1108408120", var_497_24)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1108408", "1108408120", "story_v_side_new_1108408.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_25 = math.max(var_497_16, arg_494_1.talkMaxDuration)

			if var_497_15 <= arg_494_1.time_ and arg_494_1.time_ < var_497_15 + var_497_25 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_15) / var_497_25

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_15 + var_497_25 and arg_494_1.time_ < var_497_15 + var_497_25 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
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

		arg_494_1:InitPlayNodeList()
	end,
	Play1108408121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1108408121
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1108408122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1047ui_story"].transform
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.var_.moveOldPos1047ui_story = var_501_0.localPosition
			end

			local var_501_2 = 0.001

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2
				local var_501_4 = Vector3.New(0, 100, 0)

				var_501_0.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1047ui_story, var_501_4, var_501_3)

				local var_501_5 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_5.x, var_501_5.y, var_501_5.z)

				local var_501_6 = var_501_0.localEulerAngles

				var_501_6.z = 0
				var_501_6.x = 0
				var_501_0.localEulerAngles = var_501_6
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 then
				var_501_0.localPosition = Vector3.New(0, 100, 0)

				local var_501_7 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_7.x, var_501_7.y, var_501_7.z)

				local var_501_8 = var_501_0.localEulerAngles

				var_501_8.z = 0
				var_501_8.x = 0
				var_501_0.localEulerAngles = var_501_8
			end

			local var_501_9 = arg_498_1.actors_["1084ui_story"].transform
			local var_501_10 = 0

			if var_501_10 < arg_498_1.time_ and arg_498_1.time_ <= var_501_10 + arg_501_0 then
				arg_498_1.var_.moveOldPos1084ui_story = var_501_9.localPosition
			end

			local var_501_11 = 0.001

			if var_501_10 <= arg_498_1.time_ and arg_498_1.time_ < var_501_10 + var_501_11 then
				local var_501_12 = (arg_498_1.time_ - var_501_10) / var_501_11
				local var_501_13 = Vector3.New(0, 100, 0)

				var_501_9.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1084ui_story, var_501_13, var_501_12)

				local var_501_14 = manager.ui.mainCamera.transform.position - var_501_9.position

				var_501_9.forward = Vector3.New(var_501_14.x, var_501_14.y, var_501_14.z)

				local var_501_15 = var_501_9.localEulerAngles

				var_501_15.z = 0
				var_501_15.x = 0
				var_501_9.localEulerAngles = var_501_15
			end

			if arg_498_1.time_ >= var_501_10 + var_501_11 and arg_498_1.time_ < var_501_10 + var_501_11 + arg_501_0 then
				var_501_9.localPosition = Vector3.New(0, 100, 0)

				local var_501_16 = manager.ui.mainCamera.transform.position - var_501_9.position

				var_501_9.forward = Vector3.New(var_501_16.x, var_501_16.y, var_501_16.z)

				local var_501_17 = var_501_9.localEulerAngles

				var_501_17.z = 0
				var_501_17.x = 0
				var_501_9.localEulerAngles = var_501_17
			end

			local var_501_18 = arg_498_1.actors_["1047ui_story"]
			local var_501_19 = 0

			if var_501_19 < arg_498_1.time_ and arg_498_1.time_ <= var_501_19 + arg_501_0 and not isNil(var_501_18) and arg_498_1.var_.characterEffect1047ui_story == nil then
				arg_498_1.var_.characterEffect1047ui_story = var_501_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_20 = 0.200000002980232

			if var_501_19 <= arg_498_1.time_ and arg_498_1.time_ < var_501_19 + var_501_20 and not isNil(var_501_18) then
				local var_501_21 = (arg_498_1.time_ - var_501_19) / var_501_20

				if arg_498_1.var_.characterEffect1047ui_story and not isNil(var_501_18) then
					local var_501_22 = Mathf.Lerp(0, 0.5, var_501_21)

					arg_498_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1047ui_story.fillRatio = var_501_22
				end
			end

			if arg_498_1.time_ >= var_501_19 + var_501_20 and arg_498_1.time_ < var_501_19 + var_501_20 + arg_501_0 and not isNil(var_501_18) and arg_498_1.var_.characterEffect1047ui_story then
				local var_501_23 = 0.5

				arg_498_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1047ui_story.fillRatio = var_501_23
			end

			local var_501_24 = 0
			local var_501_25 = 1.25

			if var_501_24 < arg_498_1.time_ and arg_498_1.time_ <= var_501_24 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_26 = arg_498_1:GetWordFromCfg(1108408121)
				local var_501_27 = arg_498_1:FormatText(var_501_26.content)

				arg_498_1.text_.text = var_501_27

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_28 = 50
				local var_501_29 = utf8.len(var_501_27)
				local var_501_30 = var_501_28 <= 0 and var_501_25 or var_501_25 * (var_501_29 / var_501_28)

				if var_501_30 > 0 and var_501_25 < var_501_30 then
					arg_498_1.talkMaxDuration = var_501_30

					if var_501_30 + var_501_24 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_30 + var_501_24
					end
				end

				arg_498_1.text_.text = var_501_27
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_31 = math.max(var_501_25, arg_498_1.talkMaxDuration)

			if var_501_24 <= arg_498_1.time_ and arg_498_1.time_ < var_501_24 + var_501_31 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_24) / var_501_31

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_24 + var_501_31 and arg_498_1.time_ < var_501_24 + var_501_31 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play1108408122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1108408122
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
			arg_502_1.auto_ = false
		end

		function arg_502_1.playNext_(arg_504_0)
			arg_502_1.onStoryFinished_()
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 1

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				local var_505_2 = "play"
				local var_505_3 = "effect"

				arg_502_1:AudioAction(var_505_2, var_505_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_505_4 = 0
			local var_505_5 = 1.025

			if var_505_4 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(1108408122)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_8 = 41
				local var_505_9 = utf8.len(var_505_7)
				local var_505_10 = var_505_8 <= 0 and var_505_5 or var_505_5 * (var_505_9 / var_505_8)

				if var_505_10 > 0 and var_505_5 < var_505_10 then
					arg_502_1.talkMaxDuration = var_505_10

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_11 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_11 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_11

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_11 and arg_502_1.time_ < var_505_4 + var_505_11 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02",
		"TextureConfig/Background/R8405",
		"TextureConfig/Background/H02a",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_side_new_1108408.awb"
	}
}
