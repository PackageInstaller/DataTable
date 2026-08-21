return {
	Play303011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 303011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play303011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A00"

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
				local var_4_5 = arg_1_1.bgs_.A00

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
					if iter_4_0 ~= "A00" then
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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

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

			local var_4_38 = 2
			local var_4_39 = 0.475

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

				local var_4_41 = arg_1_1:GetWordFromCfg(303011001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 19
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
	Play303011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 303011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play303011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

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

				local var_11_2 = arg_8_1:GetWordFromCfg(303011002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 40
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
	Play303011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 303011003
		arg_12_1.duration_ = 5.9

		local var_12_0 = {
			zh = 5.9,
			ja = 2.366
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
				arg_12_0:Play303011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1019ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1019ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_15_20 = 0
			local var_15_21 = 0.3

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[13].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(303011003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011003", "story_v_out_303011.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_out_303011", "303011003", "story_v_out_303011.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_out_303011", "303011003", "story_v_out_303011.awb")

						arg_12_1:RecordAudio("303011003", var_15_29)
						arg_12_1:RecordAudio("303011003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_303011", "303011003", "story_v_out_303011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_303011", "303011003", "story_v_out_303011.awb")
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
				actorName = "1019ui_story",
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
	Play303011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 303011004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play303011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1019ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1019ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1019ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.075

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(303011004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 3
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play303011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 303011005
		arg_20_1.duration_ = 2.5

		local var_20_0 = {
			zh = 2.5,
			ja = 1.999999999999
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
				arg_20_0:Play303011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1166ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1166ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["1166ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1166ui_story = var_23_5.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_6) / var_23_8
				local var_23_10 = Vector3.New(0.7, -0.75, -6.25)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1166ui_story, var_23_10, var_23_9)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_5.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_5.localEulerAngles = var_23_12
			end

			if arg_20_1.time_ >= var_23_6 + var_23_8 and arg_20_1.time_ < var_23_6 + var_23_8 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -0.75, -6.25)

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

			local var_23_16 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_16.localPosition
			end

			local var_23_18 = 0.001

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_18 then
				local var_23_19 = (arg_20_1.time_ - var_23_17) / var_23_18
				local var_23_20 = Vector3.New(-0.7, -1.08, -5.9)

				var_23_16.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_20, var_23_19)

				local var_23_21 = manager.ui.mainCamera.transform.position - var_23_16.position

				var_23_16.forward = Vector3.New(var_23_21.x, var_23_21.y, var_23_21.z)

				local var_23_22 = var_23_16.localEulerAngles

				var_23_22.z = 0
				var_23_22.x = 0
				var_23_16.localEulerAngles = var_23_22
			end

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 then
				var_23_16.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_23_23 = manager.ui.mainCamera.transform.position - var_23_16.position

				var_23_16.forward = Vector3.New(var_23_23.x, var_23_23.y, var_23_23.z)

				local var_23_24 = var_23_16.localEulerAngles

				var_23_24.z = 0
				var_23_24.x = 0
				var_23_16.localEulerAngles = var_23_24
			end

			local var_23_25 = arg_20_1.actors_["1166ui_story"]
			local var_23_26 = 0

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 and not isNil(var_23_25) and arg_20_1.var_.characterEffect1166ui_story == nil then
				arg_20_1.var_.characterEffect1166ui_story = var_23_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_27 = 0.200000002980232

			if var_23_26 <= arg_20_1.time_ and arg_20_1.time_ < var_23_26 + var_23_27 and not isNil(var_23_25) then
				local var_23_28 = (arg_20_1.time_ - var_23_26) / var_23_27

				if arg_20_1.var_.characterEffect1166ui_story and not isNil(var_23_25) then
					arg_20_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_26 + var_23_27 and arg_20_1.time_ < var_23_26 + var_23_27 + arg_23_0 and not isNil(var_23_25) and arg_20_1.var_.characterEffect1166ui_story then
				arg_20_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_23_29 = 0

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			local var_23_30 = 0

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_23_31 = 0
			local var_23_32 = 0.3

			if var_23_31 < arg_20_1.time_ and arg_20_1.time_ <= var_23_31 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_33 = arg_20_1:FormatText(StoryNameCfg[32].name)

				arg_20_1.leftNameTxt_.text = var_23_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_34 = arg_20_1:GetWordFromCfg(303011005)
				local var_23_35 = arg_20_1:FormatText(var_23_34.content)

				arg_20_1.text_.text = var_23_35

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_36 = 12
				local var_23_37 = utf8.len(var_23_35)
				local var_23_38 = var_23_36 <= 0 and var_23_32 or var_23_32 * (var_23_37 / var_23_36)

				if var_23_38 > 0 and var_23_32 < var_23_38 then
					arg_20_1.talkMaxDuration = var_23_38

					if var_23_38 + var_23_31 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_38 + var_23_31
					end
				end

				arg_20_1.text_.text = var_23_35
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011005", "story_v_out_303011.awb") ~= 0 then
					local var_23_39 = manager.audio:GetVoiceLength("story_v_out_303011", "303011005", "story_v_out_303011.awb") / 1000

					if var_23_39 + var_23_31 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_39 + var_23_31
					end

					if var_23_34.prefab_name ~= "" and arg_20_1.actors_[var_23_34.prefab_name] ~= nil then
						local var_23_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_34.prefab_name].transform, "story_v_out_303011", "303011005", "story_v_out_303011.awb")

						arg_20_1:RecordAudio("303011005", var_23_40)
						arg_20_1:RecordAudio("303011005", var_23_40)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_303011", "303011005", "story_v_out_303011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_303011", "303011005", "story_v_out_303011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_41 = math.max(var_23_32, arg_20_1.talkMaxDuration)

			if var_23_31 <= arg_20_1.time_ and arg_20_1.time_ < var_23_31 + var_23_41 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_31) / var_23_41

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_31 + var_23_41 and arg_20_1.time_ < var_23_31 + var_23_41 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play303011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 303011006
		arg_24_1.duration_ = 10.2

		local var_24_0 = {
			zh = 4.9,
			ja = 10.2
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
				arg_24_0:Play303011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1166ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1166ui_story == nil then
				arg_24_1.var_.characterEffect1166ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1166ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1166ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1166ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1166ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_12 = 0
			local var_27_13 = 0.6

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_15 = arg_24_1:GetWordFromCfg(303011006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011006", "story_v_out_303011.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011006", "story_v_out_303011.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_303011", "303011006", "story_v_out_303011.awb")

						arg_24_1:RecordAudio("303011006", var_27_21)
						arg_24_1:RecordAudio("303011006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_303011", "303011006", "story_v_out_303011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_303011", "303011006", "story_v_out_303011.awb")
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
	Play303011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 303011007
		arg_28_1.duration_ = 12.17

		local var_28_0 = {
			zh = 8,
			ja = 12.166
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
				arg_28_0:Play303011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.95

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(303011007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011007", "story_v_out_303011.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011007", "story_v_out_303011.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_303011", "303011007", "story_v_out_303011.awb")

						arg_28_1:RecordAudio("303011007", var_31_9)
						arg_28_1:RecordAudio("303011007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_303011", "303011007", "story_v_out_303011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_303011", "303011007", "story_v_out_303011.awb")
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
	Play303011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 303011008
		arg_32_1.duration_ = 5.67

		local var_32_0 = {
			zh = 3.666,
			ja = 5.666
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
				arg_32_0:Play303011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.375

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:GetWordFromCfg(303011008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011008", "story_v_out_303011.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011008", "story_v_out_303011.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_303011", "303011008", "story_v_out_303011.awb")

						arg_32_1:RecordAudio("303011008", var_35_9)
						arg_32_1:RecordAudio("303011008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_303011", "303011008", "story_v_out_303011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_303011", "303011008", "story_v_out_303011.awb")
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
	Play303011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 303011009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play303011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1019ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.775

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

				local var_39_9 = arg_36_1:GetWordFromCfg(303011009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 31
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
	Play303011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 303011010
		arg_40_1.duration_ = 8.47

		local var_40_0 = {
			zh = 8.466,
			ja = 1.999999999999
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
				arg_40_0:Play303011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1166ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1166ui_story == nil then
				arg_40_1.var_.characterEffect1166ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1166ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1166ui_story then
				arg_40_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166actionlink/1166action434")
			end

			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_43_6 = 0
			local var_43_7 = 0.675

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[32].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_9 = arg_40_1:GetWordFromCfg(303011010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 27
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011010", "story_v_out_303011.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011010", "story_v_out_303011.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_303011", "303011010", "story_v_out_303011.awb")

						arg_40_1:RecordAudio("303011010", var_43_15)
						arg_40_1:RecordAudio("303011010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_303011", "303011010", "story_v_out_303011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_303011", "303011010", "story_v_out_303011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play303011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 303011011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play303011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1166ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1166ui_story == nil then
				arg_44_1.var_.characterEffect1166ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1166ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1166ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1166ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1166ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.6

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(303011011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 24
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play303011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 303011012
		arg_48_1.duration_ = 7.3

		local var_48_0 = {
			zh = 6.766,
			ja = 7.3
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
				arg_48_0:Play303011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "1084ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_5.localPosition
			end

			local var_51_7 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7
				local var_51_9 = Vector3.New(0, -0.97, -6)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_9, var_51_8)

				local var_51_10 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_10.x, var_51_10.y, var_51_10.z)

				local var_51_11 = var_51_5.localEulerAngles

				var_51_11.z = 0
				var_51_11.x = 0
				var_51_5.localEulerAngles = var_51_11
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_51_12 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_12.x, var_51_12.y, var_51_12.z)

				local var_51_13 = var_51_5.localEulerAngles

				var_51_13.z = 0
				var_51_13.x = 0
				var_51_5.localEulerAngles = var_51_13
			end

			local var_51_14 = arg_48_1.actors_["1166ui_story"].transform
			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.var_.moveOldPos1166ui_story = var_51_14.localPosition

				local var_51_16 = GameObjectTools.GetOrAddComponent(var_51_14.gameObject, typeof(DynamicBoneHelper))

				if var_51_16 then
					var_51_16:EnableDynamicBone(false)
				end
			end

			local var_51_17 = 0.001

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_17 then
				local var_51_18 = (arg_48_1.time_ - var_51_15) / var_51_17
				local var_51_19 = Vector3.New(0, 100, 0)

				var_51_14.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1166ui_story, var_51_19, var_51_18)

				local var_51_20 = manager.ui.mainCamera.transform.position - var_51_14.position

				var_51_14.forward = Vector3.New(var_51_20.x, var_51_20.y, var_51_20.z)

				local var_51_21 = var_51_14.localEulerAngles

				var_51_21.z = 0
				var_51_21.x = 0
				var_51_14.localEulerAngles = var_51_21
			end

			if arg_48_1.time_ >= var_51_15 + var_51_17 and arg_48_1.time_ < var_51_15 + var_51_17 + arg_51_0 then
				var_51_14.localPosition = Vector3.New(0, 100, 0)

				local var_51_22 = manager.ui.mainCamera.transform.position - var_51_14.position

				var_51_14.forward = Vector3.New(var_51_22.x, var_51_22.y, var_51_22.z)

				local var_51_23 = var_51_14.localEulerAngles

				var_51_23.z = 0
				var_51_23.x = 0
				var_51_14.localEulerAngles = var_51_23

				local var_51_24 = GameObjectTools.GetOrAddComponent(var_51_14.gameObject, typeof(DynamicBoneHelper))

				if var_51_24 then
					var_51_24:EnableDynamicBone(true)
				end
			end

			local var_51_25 = arg_48_1.actors_["1019ui_story"].transform
			local var_51_26 = 0

			if var_51_26 < arg_48_1.time_ and arg_48_1.time_ <= var_51_26 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_25.localPosition
			end

			local var_51_27 = 0.001

			if var_51_26 <= arg_48_1.time_ and arg_48_1.time_ < var_51_26 + var_51_27 then
				local var_51_28 = (arg_48_1.time_ - var_51_26) / var_51_27
				local var_51_29 = Vector3.New(0, 100, 0)

				var_51_25.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, var_51_29, var_51_28)

				local var_51_30 = manager.ui.mainCamera.transform.position - var_51_25.position

				var_51_25.forward = Vector3.New(var_51_30.x, var_51_30.y, var_51_30.z)

				local var_51_31 = var_51_25.localEulerAngles

				var_51_31.z = 0
				var_51_31.x = 0
				var_51_25.localEulerAngles = var_51_31
			end

			if arg_48_1.time_ >= var_51_26 + var_51_27 and arg_48_1.time_ < var_51_26 + var_51_27 + arg_51_0 then
				var_51_25.localPosition = Vector3.New(0, 100, 0)

				local var_51_32 = manager.ui.mainCamera.transform.position - var_51_25.position

				var_51_25.forward = Vector3.New(var_51_32.x, var_51_32.y, var_51_32.z)

				local var_51_33 = var_51_25.localEulerAngles

				var_51_33.z = 0
				var_51_33.x = 0
				var_51_25.localEulerAngles = var_51_33
			end

			local var_51_34 = arg_48_1.actors_["1084ui_story"]
			local var_51_35 = 0

			if var_51_35 < arg_48_1.time_ and arg_48_1.time_ <= var_51_35 + arg_51_0 and not isNil(var_51_34) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_36 = 0.200000002980232

			if var_51_35 <= arg_48_1.time_ and arg_48_1.time_ < var_51_35 + var_51_36 and not isNil(var_51_34) then
				local var_51_37 = (arg_48_1.time_ - var_51_35) / var_51_36

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_34) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_35 + var_51_36 and arg_48_1.time_ < var_51_35 + var_51_36 + arg_51_0 and not isNil(var_51_34) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_38 = 0

			if var_51_38 < arg_48_1.time_ and arg_48_1.time_ <= var_51_38 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_51_39 = 0

			if var_51_39 < arg_48_1.time_ and arg_48_1.time_ <= var_51_39 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_40 = 0
			local var_51_41 = 0.7

			if var_51_40 < arg_48_1.time_ and arg_48_1.time_ <= var_51_40 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_42 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_43 = arg_48_1:GetWordFromCfg(303011012)
				local var_51_44 = arg_48_1:FormatText(var_51_43.content)

				arg_48_1.text_.text = var_51_44

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_45 = 28
				local var_51_46 = utf8.len(var_51_44)
				local var_51_47 = var_51_45 <= 0 and var_51_41 or var_51_41 * (var_51_46 / var_51_45)

				if var_51_47 > 0 and var_51_41 < var_51_47 then
					arg_48_1.talkMaxDuration = var_51_47

					if var_51_47 + var_51_40 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_47 + var_51_40
					end
				end

				arg_48_1.text_.text = var_51_44
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011012", "story_v_out_303011.awb") ~= 0 then
					local var_51_48 = manager.audio:GetVoiceLength("story_v_out_303011", "303011012", "story_v_out_303011.awb") / 1000

					if var_51_48 + var_51_40 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_48 + var_51_40
					end

					if var_51_43.prefab_name ~= "" and arg_48_1.actors_[var_51_43.prefab_name] ~= nil then
						local var_51_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_43.prefab_name].transform, "story_v_out_303011", "303011012", "story_v_out_303011.awb")

						arg_48_1:RecordAudio("303011012", var_51_49)
						arg_48_1:RecordAudio("303011012", var_51_49)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_303011", "303011012", "story_v_out_303011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_303011", "303011012", "story_v_out_303011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_50 = math.max(var_51_41, arg_48_1.talkMaxDuration)

			if var_51_40 <= arg_48_1.time_ and arg_48_1.time_ < var_51_40 + var_51_50 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_40) / var_51_50

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_40 + var_51_50 and arg_48_1.time_ < var_51_40 + var_51_50 + arg_51_0 then
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
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
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
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play303011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 303011013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play303011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1084ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.225

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(303011013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 9
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play303011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 303011014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play303011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.875

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(303011014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 35
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
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play303011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 303011015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play303011016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.625

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(303011015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 25
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
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play303011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 303011016
		arg_64_1.duration_ = 9.5

		local var_64_0 = {
			zh = 5.5,
			ja = 9.5
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
				arg_64_0:Play303011017(arg_64_1)
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
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_4 = 0

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_67_6 = 0
			local var_67_7 = 0.625

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_9 = arg_64_1:GetWordFromCfg(303011016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011016", "story_v_out_303011.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011016", "story_v_out_303011.awb") / 1000

					if var_67_14 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_6
					end

					if var_67_9.prefab_name ~= "" and arg_64_1.actors_[var_67_9.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_9.prefab_name].transform, "story_v_out_303011", "303011016", "story_v_out_303011.awb")

						arg_64_1:RecordAudio("303011016", var_67_15)
						arg_64_1:RecordAudio("303011016", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_303011", "303011016", "story_v_out_303011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_303011", "303011016", "story_v_out_303011.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_16 and arg_64_1.time_ < var_67_6 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play303011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 303011017
		arg_68_1.duration_ = 6.3

		local var_68_0 = {
			zh = 6.3,
			ja = 4.333
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play303011018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.6

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(303011017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 24
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011017", "story_v_out_303011.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011017", "story_v_out_303011.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_303011", "303011017", "story_v_out_303011.awb")

						arg_68_1:RecordAudio("303011017", var_71_9)
						arg_68_1:RecordAudio("303011017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_303011", "303011017", "story_v_out_303011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_303011", "303011017", "story_v_out_303011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play303011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 303011018
		arg_72_1.duration_ = 3.3

		local var_72_0 = {
			zh = 3.3,
			ja = 1.333
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
				arg_72_0:Play303011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1166ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1166ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(0.7, -0.75, -6.25)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1166ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0.7, -0.75, -6.25)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_11.localPosition
			end

			local var_75_13 = 0.001

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13
				local var_75_15 = Vector3.New(-0.7, -0.97, -6)

				var_75_11.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_15, var_75_14)

				local var_75_16 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_16.x, var_75_16.y, var_75_16.z)

				local var_75_17 = var_75_11.localEulerAngles

				var_75_17.z = 0
				var_75_17.x = 0
				var_75_11.localEulerAngles = var_75_17
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 then
				var_75_11.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_11.position

				var_75_11.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_11.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_11.localEulerAngles = var_75_19
			end

			local var_75_20 = arg_72_1.actors_["1166ui_story"]
			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1166ui_story == nil then
				arg_72_1.var_.characterEffect1166ui_story = var_75_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_22 = 0.200000002980232

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_22 and not isNil(var_75_20) then
				local var_75_23 = (arg_72_1.time_ - var_75_21) / var_75_22

				if arg_72_1.var_.characterEffect1166ui_story and not isNil(var_75_20) then
					arg_72_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_21 + var_75_22 and arg_72_1.time_ < var_75_21 + var_75_22 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1166ui_story then
				arg_72_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_75_24 = arg_72_1.actors_["1084ui_story"]
			local var_75_25 = 0

			if var_75_25 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 and not isNil(var_75_24) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_26 = 0.200000002980232

			if var_75_25 <= arg_72_1.time_ and arg_72_1.time_ < var_75_25 + var_75_26 and not isNil(var_75_24) then
				local var_75_27 = (arg_72_1.time_ - var_75_25) / var_75_26

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_24) then
					local var_75_28 = Mathf.Lerp(0, 0.5, var_75_27)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_28
				end
			end

			if arg_72_1.time_ >= var_75_25 + var_75_26 and arg_72_1.time_ < var_75_25 + var_75_26 + arg_75_0 and not isNil(var_75_24) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_29 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_29
			end

			local var_75_30 = 0

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_75_31 = 0

			if var_75_31 < arg_72_1.time_ and arg_72_1.time_ <= var_75_31 + arg_75_0 then
				arg_72_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_32 = 0
			local var_75_33 = 0.35

			if var_75_32 < arg_72_1.time_ and arg_72_1.time_ <= var_75_32 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_34 = arg_72_1:FormatText(StoryNameCfg[32].name)

				arg_72_1.leftNameTxt_.text = var_75_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_35 = arg_72_1:GetWordFromCfg(303011018)
				local var_75_36 = arg_72_1:FormatText(var_75_35.content)

				arg_72_1.text_.text = var_75_36

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_37 = 14
				local var_75_38 = utf8.len(var_75_36)
				local var_75_39 = var_75_37 <= 0 and var_75_33 or var_75_33 * (var_75_38 / var_75_37)

				if var_75_39 > 0 and var_75_33 < var_75_39 then
					arg_72_1.talkMaxDuration = var_75_39

					if var_75_39 + var_75_32 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_39 + var_75_32
					end
				end

				arg_72_1.text_.text = var_75_36
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011018", "story_v_out_303011.awb") ~= 0 then
					local var_75_40 = manager.audio:GetVoiceLength("story_v_out_303011", "303011018", "story_v_out_303011.awb") / 1000

					if var_75_40 + var_75_32 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_40 + var_75_32
					end

					if var_75_35.prefab_name ~= "" and arg_72_1.actors_[var_75_35.prefab_name] ~= nil then
						local var_75_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_35.prefab_name].transform, "story_v_out_303011", "303011018", "story_v_out_303011.awb")

						arg_72_1:RecordAudio("303011018", var_75_41)
						arg_72_1:RecordAudio("303011018", var_75_41)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_303011", "303011018", "story_v_out_303011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_303011", "303011018", "story_v_out_303011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_42 = math.max(var_75_33, arg_72_1.talkMaxDuration)

			if var_75_32 <= arg_72_1.time_ and arg_72_1.time_ < var_75_32 + var_75_42 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_32) / var_75_42

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_32 + var_75_42 and arg_72_1.time_ < var_75_32 + var_75_42 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_72_1:InitPlayNodeList()
	end,
	Play303011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 303011019
		arg_76_1.duration_ = 3.33

		local var_76_0 = {
			zh = 3.1,
			ja = 3.333
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play303011020(arg_76_1)
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

			local var_79_4 = arg_76_1.actors_["1166ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1166ui_story == nil then
				arg_76_1.var_.characterEffect1166ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.200000002980232

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1166ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1166ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1166ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1166ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_12 = 0
			local var_79_13 = 0.3

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_14 = arg_76_1:FormatText(StoryNameCfg[6].name)

				arg_76_1.leftNameTxt_.text = var_79_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_15 = arg_76_1:GetWordFromCfg(303011019)
				local var_79_16 = arg_76_1:FormatText(var_79_15.content)

				arg_76_1.text_.text = var_79_16

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_17 = 12
				local var_79_18 = utf8.len(var_79_16)
				local var_79_19 = var_79_17 <= 0 and var_79_13 or var_79_13 * (var_79_18 / var_79_17)

				if var_79_19 > 0 and var_79_13 < var_79_19 then
					arg_76_1.talkMaxDuration = var_79_19

					if var_79_19 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_12
					end
				end

				arg_76_1.text_.text = var_79_16
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011019", "story_v_out_303011.awb") ~= 0 then
					local var_79_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011019", "story_v_out_303011.awb") / 1000

					if var_79_20 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_12
					end

					if var_79_15.prefab_name ~= "" and arg_76_1.actors_[var_79_15.prefab_name] ~= nil then
						local var_79_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_15.prefab_name].transform, "story_v_out_303011", "303011019", "story_v_out_303011.awb")

						arg_76_1:RecordAudio("303011019", var_79_21)
						arg_76_1:RecordAudio("303011019", var_79_21)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_303011", "303011019", "story_v_out_303011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_303011", "303011019", "story_v_out_303011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_13, arg_76_1.talkMaxDuration)

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_12) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_12 + var_79_22 and arg_76_1.time_ < var_79_12 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play303011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 303011020
		arg_80_1.duration_ = 1.33

		local var_80_0 = {
			zh = 1.033,
			ja = 1.333
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play303011021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1166ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1166ui_story == nil then
				arg_80_1.var_.characterEffect1166ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1166ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1166ui_story then
				arg_80_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1084ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1084ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_83_12 = 0
			local var_83_13 = 0.075

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_14 = arg_80_1:FormatText(StoryNameCfg[32].name)

				arg_80_1.leftNameTxt_.text = var_83_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_15 = arg_80_1:GetWordFromCfg(303011020)
				local var_83_16 = arg_80_1:FormatText(var_83_15.content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 3
				local var_83_18 = utf8.len(var_83_16)
				local var_83_19 = var_83_17 <= 0 and var_83_13 or var_83_13 * (var_83_18 / var_83_17)

				if var_83_19 > 0 and var_83_13 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011020", "story_v_out_303011.awb") ~= 0 then
					local var_83_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011020", "story_v_out_303011.awb") / 1000

					if var_83_20 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_12
					end

					if var_83_15.prefab_name ~= "" and arg_80_1.actors_[var_83_15.prefab_name] ~= nil then
						local var_83_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_15.prefab_name].transform, "story_v_out_303011", "303011020", "story_v_out_303011.awb")

						arg_80_1:RecordAudio("303011020", var_83_21)
						arg_80_1:RecordAudio("303011020", var_83_21)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_303011", "303011020", "story_v_out_303011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_303011", "303011020", "story_v_out_303011.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_22 and arg_80_1.time_ < var_83_12 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play303011021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 303011021
		arg_84_1.duration_ = 2

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play303011022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1166ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1166ui_story == nil then
				arg_84_1.var_.characterEffect1166ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1166ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1166ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1166ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1166ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_87_8 = arg_84_1.actors_["1084ui_story"]
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_10 = 0.200000002980232

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 and not isNil(var_87_8) then
				local var_87_11 = (arg_84_1.time_ - var_87_9) / var_87_10

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_8) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_12 = 0
			local var_87_13 = 0.05

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_14 = arg_84_1:FormatText(StoryNameCfg[334].name)

				arg_84_1.leftNameTxt_.text = var_87_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_15 = arg_84_1:GetWordFromCfg(303011021)
				local var_87_16 = arg_84_1:FormatText(var_87_15.content)

				arg_84_1.text_.text = var_87_16

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_17 = 2
				local var_87_18 = utf8.len(var_87_16)
				local var_87_19 = var_87_17 <= 0 and var_87_13 or var_87_13 * (var_87_18 / var_87_17)

				if var_87_19 > 0 and var_87_13 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19

					if var_87_19 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_12
					end
				end

				arg_84_1.text_.text = var_87_16
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011021", "story_v_out_303011.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011021", "story_v_out_303011.awb") / 1000

					if var_87_20 + var_87_12 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_12
					end

					if var_87_15.prefab_name ~= "" and arg_84_1.actors_[var_87_15.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_15.prefab_name].transform, "story_v_out_303011", "303011021", "story_v_out_303011.awb")

						arg_84_1:RecordAudio("303011021", var_87_21)
						arg_84_1:RecordAudio("303011021", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_303011", "303011021", "story_v_out_303011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_303011", "303011021", "story_v_out_303011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_13, arg_84_1.talkMaxDuration)

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_12) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_12 + var_87_22 and arg_84_1.time_ < var_87_12 + var_87_22 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play303011022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 303011022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play303011023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1166ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1166ui_story = var_91_0.localPosition

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end
			end

			local var_91_3 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_3 then
				local var_91_4 = (arg_88_1.time_ - var_91_1) / var_91_3
				local var_91_5 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1166ui_story, var_91_5, var_91_4)

				local var_91_6 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_6.x, var_91_6.y, var_91_6.z)

				local var_91_7 = var_91_0.localEulerAngles

				var_91_7.z = 0
				var_91_7.x = 0
				var_91_0.localEulerAngles = var_91_7
			end

			if arg_88_1.time_ >= var_91_1 + var_91_3 and arg_88_1.time_ < var_91_1 + var_91_3 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_8 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_8.x, var_91_8.y, var_91_8.z)

				local var_91_9 = var_91_0.localEulerAngles

				var_91_9.z = 0
				var_91_9.x = 0
				var_91_0.localEulerAngles = var_91_9

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_11.localPosition
			end

			local var_91_13 = 0.001

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13
				local var_91_15 = Vector3.New(0, 100, 0)

				var_91_11.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_15, var_91_14)

				local var_91_16 = manager.ui.mainCamera.transform.position - var_91_11.position

				var_91_11.forward = Vector3.New(var_91_16.x, var_91_16.y, var_91_16.z)

				local var_91_17 = var_91_11.localEulerAngles

				var_91_17.z = 0
				var_91_17.x = 0
				var_91_11.localEulerAngles = var_91_17
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 then
				var_91_11.localPosition = Vector3.New(0, 100, 0)

				local var_91_18 = manager.ui.mainCamera.transform.position - var_91_11.position

				var_91_11.forward = Vector3.New(var_91_18.x, var_91_18.y, var_91_18.z)

				local var_91_19 = var_91_11.localEulerAngles

				var_91_19.z = 0
				var_91_19.x = 0
				var_91_11.localEulerAngles = var_91_19
			end

			local var_91_20 = 0
			local var_91_21 = 0.95

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_22 = arg_88_1:GetWordFromCfg(303011022)
				local var_91_23 = arg_88_1:FormatText(var_91_22.content)

				arg_88_1.text_.text = var_91_23

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_24 = 38
				local var_91_25 = utf8.len(var_91_23)
				local var_91_26 = var_91_24 <= 0 and var_91_21 or var_91_21 * (var_91_25 / var_91_24)

				if var_91_26 > 0 and var_91_21 < var_91_26 then
					arg_88_1.talkMaxDuration = var_91_26

					if var_91_26 + var_91_20 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_26 + var_91_20
					end
				end

				arg_88_1.text_.text = var_91_23
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_27 = math.max(var_91_21, arg_88_1.talkMaxDuration)

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_27 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_20) / var_91_27

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_20 + var_91_27 and arg_88_1.time_ < var_91_20 + var_91_27 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_88_1:InitPlayNodeList()
	end,
	Play303011023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 303011023
		arg_92_1.duration_ = 7.87

		local var_92_0 = {
			zh = 7.866,
			ja = 1.333
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play303011024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1166ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1166ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0, -0.75, -6.25)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1166ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, -0.75, -6.25)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["1166ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1166ui_story == nil then
				arg_92_1.var_.characterEffect1166ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.200000002980232

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect1166ui_story and not isNil(var_95_11) then
					arg_92_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1166ui_story then
				arg_92_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_17 = 0
			local var_95_18 = 0.975

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_19 = arg_92_1:FormatText(StoryNameCfg[32].name)

				arg_92_1.leftNameTxt_.text = var_95_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_20 = arg_92_1:GetWordFromCfg(303011023)
				local var_95_21 = arg_92_1:FormatText(var_95_20.content)

				arg_92_1.text_.text = var_95_21

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_22 = 39
				local var_95_23 = utf8.len(var_95_21)
				local var_95_24 = var_95_22 <= 0 and var_95_18 or var_95_18 * (var_95_23 / var_95_22)

				if var_95_24 > 0 and var_95_18 < var_95_24 then
					arg_92_1.talkMaxDuration = var_95_24

					if var_95_24 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_17
					end
				end

				arg_92_1.text_.text = var_95_21
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011023", "story_v_out_303011.awb") ~= 0 then
					local var_95_25 = manager.audio:GetVoiceLength("story_v_out_303011", "303011023", "story_v_out_303011.awb") / 1000

					if var_95_25 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_25 + var_95_17
					end

					if var_95_20.prefab_name ~= "" and arg_92_1.actors_[var_95_20.prefab_name] ~= nil then
						local var_95_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_20.prefab_name].transform, "story_v_out_303011", "303011023", "story_v_out_303011.awb")

						arg_92_1:RecordAudio("303011023", var_95_26)
						arg_92_1:RecordAudio("303011023", var_95_26)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_303011", "303011023", "story_v_out_303011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_303011", "303011023", "story_v_out_303011.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_27 = math.max(var_95_18, arg_92_1.talkMaxDuration)

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_27 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_17) / var_95_27

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_17 + var_95_27 and arg_92_1.time_ < var_95_17 + var_95_27 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play303011024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 303011024
		arg_96_1.duration_ = 6.77

		local var_96_0 = {
			zh = 6.766,
			ja = 1.999999999999
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play303011025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_2 = 0
			local var_99_3 = 0.8

			if var_99_2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_4 = arg_96_1:FormatText(StoryNameCfg[32].name)

				arg_96_1.leftNameTxt_.text = var_99_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_5 = arg_96_1:GetWordFromCfg(303011024)
				local var_99_6 = arg_96_1:FormatText(var_99_5.content)

				arg_96_1.text_.text = var_99_6

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 32
				local var_99_8 = utf8.len(var_99_6)
				local var_99_9 = var_99_7 <= 0 and var_99_3 or var_99_3 * (var_99_8 / var_99_7)

				if var_99_9 > 0 and var_99_3 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_6
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011024", "story_v_out_303011.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_303011", "303011024", "story_v_out_303011.awb") / 1000

					if var_99_10 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_2
					end

					if var_99_5.prefab_name ~= "" and arg_96_1.actors_[var_99_5.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_5.prefab_name].transform, "story_v_out_303011", "303011024", "story_v_out_303011.awb")

						arg_96_1:RecordAudio("303011024", var_99_11)
						arg_96_1:RecordAudio("303011024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_303011", "303011024", "story_v_out_303011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_303011", "303011024", "story_v_out_303011.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_12 and arg_96_1.time_ < var_99_2 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play303011025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 303011025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play303011026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1166ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1166ui_story == nil then
				arg_100_1.var_.characterEffect1166ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1166ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1166ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1166ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1166ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.425

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(303011025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 17
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play303011026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 303011026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play303011027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.775

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_2

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

				local var_107_3 = arg_104_1:GetWordFromCfg(303011026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 31
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play303011027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 303011027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play303011028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1166ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1166ui_story = var_111_0.localPosition

				local var_111_2 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(false)
				end
			end

			local var_111_3 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_3 then
				local var_111_4 = (arg_108_1.time_ - var_111_1) / var_111_3
				local var_111_5 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1166ui_story, var_111_5, var_111_4)

				local var_111_6 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_6.x, var_111_6.y, var_111_6.z)

				local var_111_7 = var_111_0.localEulerAngles

				var_111_7.z = 0
				var_111_7.x = 0
				var_111_0.localEulerAngles = var_111_7
			end

			if arg_108_1.time_ >= var_111_1 + var_111_3 and arg_108_1.time_ < var_111_1 + var_111_3 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_8 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_8.x, var_111_8.y, var_111_8.z)

				local var_111_9 = var_111_0.localEulerAngles

				var_111_9.z = 0
				var_111_9.x = 0
				var_111_0.localEulerAngles = var_111_9

				local var_111_10 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_10 then
					var_111_10:EnableDynamicBone(true)
				end
			end

			local var_111_11 = 0
			local var_111_12 = 0.525

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_13 = arg_108_1:GetWordFromCfg(303011027)
				local var_111_14 = arg_108_1:FormatText(var_111_13.content)

				arg_108_1.text_.text = var_111_14

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_15 = 21
				local var_111_16 = utf8.len(var_111_14)
				local var_111_17 = var_111_15 <= 0 and var_111_12 or var_111_12 * (var_111_16 / var_111_15)

				if var_111_17 > 0 and var_111_12 < var_111_17 then
					arg_108_1.talkMaxDuration = var_111_17

					if var_111_17 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_17 + var_111_11
					end
				end

				arg_108_1.text_.text = var_111_14
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_12, arg_108_1.talkMaxDuration)

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_18 and arg_108_1.time_ < var_111_11 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play303011028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 303011028
		arg_112_1.duration_ = 1.87

		local var_112_0 = {
			zh = 1.866,
			ja = 1.233
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play303011029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.15

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[55].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_112_1.callingController_:SetSelectedState("calling")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(303011028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 6
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011028", "story_v_out_303011.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011028", "story_v_out_303011.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_303011", "303011028", "story_v_out_303011.awb")

						arg_112_1:RecordAudio("303011028", var_115_9)
						arg_112_1:RecordAudio("303011028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_303011", "303011028", "story_v_out_303011.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_303011", "303011028", "story_v_out_303011.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play303011029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 303011029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play303011030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = "1080ui_story"

			if arg_116_1.actors_[var_119_0] == nil then
				local var_119_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_119_1) then
					local var_119_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_116_1.stage_.transform)

					var_119_2.name = var_119_0
					var_119_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_116_1.actors_[var_119_0] = var_119_2

					local var_119_3 = var_119_2:GetComponentInChildren(typeof(CharacterEffect))

					var_119_3.enabled = true

					local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_2, typeof(DynamicBoneHelper))

					if var_119_4 then
						var_119_4:EnableDynamicBone(false)
					end

					arg_116_1:ShowWeapon(var_119_3.transform, false)

					arg_116_1.var_[var_119_0 .. "Animator"] = var_119_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_116_1.var_[var_119_0 .. "Animator"].applyRootMotion = true
					arg_116_1.var_[var_119_0 .. "LipSync"] = var_119_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_119_5 = arg_116_1.actors_["1080ui_story"]
			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1080ui_story == nil then
				arg_116_1.var_.characterEffect1080ui_story = var_119_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_7 = 0.200000002980232

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_7 and not isNil(var_119_5) then
				local var_119_8 = (arg_116_1.time_ - var_119_6) / var_119_7

				if arg_116_1.var_.characterEffect1080ui_story and not isNil(var_119_5) then
					local var_119_9 = Mathf.Lerp(0, 0.5, var_119_8)

					arg_116_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1080ui_story.fillRatio = var_119_9
				end
			end

			if arg_116_1.time_ >= var_119_6 + var_119_7 and arg_116_1.time_ < var_119_6 + var_119_7 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1080ui_story then
				local var_119_10 = 0.5

				arg_116_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1080ui_story.fillRatio = var_119_10
			end

			local var_119_11 = 0
			local var_119_12 = 0.475

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_13 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_14 = arg_116_1:GetWordFromCfg(303011029)
				local var_119_15 = arg_116_1:FormatText(var_119_14.content)

				arg_116_1.text_.text = var_119_15

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_16 = 19
				local var_119_17 = utf8.len(var_119_15)
				local var_119_18 = var_119_16 <= 0 and var_119_12 or var_119_12 * (var_119_17 / var_119_16)

				if var_119_18 > 0 and var_119_12 < var_119_18 then
					arg_116_1.talkMaxDuration = var_119_18

					if var_119_18 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_18 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_15
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_19 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_19 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_19

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_19 and arg_116_1.time_ < var_119_11 + var_119_19 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play303011030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 303011030
		arg_120_1.duration_ = 5.3

		local var_120_0 = {
			zh = 3.8,
			ja = 5.3
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
				arg_120_0:Play303011031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.35

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[55].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_120_1.callingController_:SetSelectedState("calling")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(303011030)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 14
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011030", "story_v_out_303011.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011030", "story_v_out_303011.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_303011", "303011030", "story_v_out_303011.awb")

						arg_120_1:RecordAudio("303011030", var_123_9)
						arg_120_1:RecordAudio("303011030", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_303011", "303011030", "story_v_out_303011.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_303011", "303011030", "story_v_out_303011.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play303011031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 303011031
		arg_124_1.duration_ = 3.73

		local var_124_0 = {
			zh = 3.733,
			ja = 1.666
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play303011032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.325

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[55].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_124_1.callingController_:SetSelectedState("calling")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(303011031)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 13
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011031", "story_v_out_303011.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011031", "story_v_out_303011.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_303011", "303011031", "story_v_out_303011.awb")

						arg_124_1:RecordAudio("303011031", var_127_9)
						arg_124_1:RecordAudio("303011031", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_303011", "303011031", "story_v_out_303011.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_303011", "303011031", "story_v_out_303011.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play303011032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 303011032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play303011033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1080ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1080ui_story == nil then
				arg_128_1.var_.characterEffect1080ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1080ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1080ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1080ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1080ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0
			local var_131_7 = 0.6

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_9 = arg_128_1:GetWordFromCfg(303011032)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 24
				local var_131_12 = utf8.len(var_131_10)
				local var_131_13 = var_131_11 <= 0 and var_131_7 or var_131_7 * (var_131_12 / var_131_11)

				if var_131_13 > 0 and var_131_7 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play303011033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 303011033
		arg_132_1.duration_ = 3.47

		local var_132_0 = {
			zh = 3.466,
			ja = 3.266
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play303011034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.35

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[55].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_132_1.callingController_:SetSelectedState("calling")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(303011033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 14
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011033", "story_v_out_303011.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011033", "story_v_out_303011.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_303011", "303011033", "story_v_out_303011.awb")

						arg_132_1:RecordAudio("303011033", var_135_9)
						arg_132_1:RecordAudio("303011033", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_303011", "303011033", "story_v_out_303011.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_303011", "303011033", "story_v_out_303011.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play303011034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 303011034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play303011035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1080ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1080ui_story == nil then
				arg_136_1.var_.characterEffect1080ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1080ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1080ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1080ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1080ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.2

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(303011034)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 8
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play303011035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 303011035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play303011036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1080ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1080ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1080ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 1.075

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(303011035)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 43
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play303011036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 303011036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play303011037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.475

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(303011036)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 19
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play303011037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 303011037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play303011038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.55

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(303011037)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 22
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play303011038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 303011038
		arg_152_1.duration_ = 5.13

		local var_152_0 = {
			zh = 4.766,
			ja = 5.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play303011039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1084ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1084ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.97, -6)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1084ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1084ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_155_15 = 0
			local var_155_16 = 0.625

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[6].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(303011038)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 25
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011038", "story_v_out_303011.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_303011", "303011038", "story_v_out_303011.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_303011", "303011038", "story_v_out_303011.awb")

						arg_152_1:RecordAudio("303011038", var_155_24)
						arg_152_1:RecordAudio("303011038", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_303011", "303011038", "story_v_out_303011.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_303011", "303011038", "story_v_out_303011.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play303011039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 303011039
		arg_156_1.duration_ = 8.8

		local var_156_0 = {
			zh = 5.6,
			ja = 8.8
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play303011040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4128")
			end

			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_2 = 0
			local var_159_3 = 0.675

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_4 = arg_156_1:FormatText(StoryNameCfg[6].name)

				arg_156_1.leftNameTxt_.text = var_159_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(303011039)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 27
				local var_159_8 = utf8.len(var_159_6)
				local var_159_9 = var_159_7 <= 0 and var_159_3 or var_159_3 * (var_159_8 / var_159_7)

				if var_159_9 > 0 and var_159_3 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011039", "story_v_out_303011.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_303011", "303011039", "story_v_out_303011.awb") / 1000

					if var_159_10 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_2
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_303011", "303011039", "story_v_out_303011.awb")

						arg_156_1:RecordAudio("303011039", var_159_11)
						arg_156_1:RecordAudio("303011039", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_303011", "303011039", "story_v_out_303011.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_303011", "303011039", "story_v_out_303011.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_12 and arg_156_1.time_ < var_159_2 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play303011040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 303011040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play303011041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1084ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1084ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1084ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.35

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[7].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(303011040)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 14
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play303011041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 303011041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play303011042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.625

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(303011041)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 25
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play303011042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 303011042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play303011043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.75

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:GetWordFromCfg(303011042)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 30
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_8 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_8 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_8

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_8 and arg_168_1.time_ < var_171_0 + var_171_8 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play303011043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 303011043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play303011044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1084ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1084ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, 100, 0)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1084ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, 100, 0)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = 0
			local var_175_10 = 1

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_11 = arg_172_1:GetWordFromCfg(303011043)
				local var_175_12 = arg_172_1:FormatText(var_175_11.content)

				arg_172_1.text_.text = var_175_12

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_13 = 40
				local var_175_14 = utf8.len(var_175_12)
				local var_175_15 = var_175_13 <= 0 and var_175_10 or var_175_10 * (var_175_14 / var_175_13)

				if var_175_15 > 0 and var_175_10 < var_175_15 then
					arg_172_1.talkMaxDuration = var_175_15

					if var_175_15 + var_175_9 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_15 + var_175_9
					end
				end

				arg_172_1.text_.text = var_175_12
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_16 = math.max(var_175_10, arg_172_1.talkMaxDuration)

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_16 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_9) / var_175_16

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_9 + var_175_16 and arg_172_1.time_ < var_175_9 + var_175_16 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play303011044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 303011044
		arg_176_1.duration_ = 2.4

		local var_176_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play303011045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1084ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0, -0.97, -6)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = arg_176_1.actors_["1084ui_story"]
			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_11 = 0.200000002980232

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_11 and not isNil(var_179_9) then
				local var_179_12 = (arg_176_1.time_ - var_179_10) / var_179_11

				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_9) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_10 + var_179_11 and arg_176_1.time_ < var_179_10 + var_179_11 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_179_13 = 0

			if var_179_13 < arg_176_1.time_ and arg_176_1.time_ <= var_179_13 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_15 = 0
			local var_179_16 = 0.25

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[6].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(303011044)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 10
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011044", "story_v_out_303011.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_303011", "303011044", "story_v_out_303011.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_303011", "303011044", "story_v_out_303011.awb")

						arg_176_1:RecordAudio("303011044", var_179_24)
						arg_176_1:RecordAudio("303011044", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_303011", "303011044", "story_v_out_303011.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_303011", "303011044", "story_v_out_303011.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play303011045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 303011045
		arg_180_1.duration_ = 12.97

		local var_180_0 = {
			zh = 9.5,
			ja = 12.966
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play303011046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_183_2 = 0
			local var_183_3 = 0.925

			if var_183_2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_4 = arg_180_1:FormatText(StoryNameCfg[6].name)

				arg_180_1.leftNameTxt_.text = var_183_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(303011045)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 37
				local var_183_8 = utf8.len(var_183_6)
				local var_183_9 = var_183_7 <= 0 and var_183_3 or var_183_3 * (var_183_8 / var_183_7)

				if var_183_9 > 0 and var_183_3 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011045", "story_v_out_303011.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_out_303011", "303011045", "story_v_out_303011.awb") / 1000

					if var_183_10 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_2
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_303011", "303011045", "story_v_out_303011.awb")

						arg_180_1:RecordAudio("303011045", var_183_11)
						arg_180_1:RecordAudio("303011045", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_303011", "303011045", "story_v_out_303011.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_303011", "303011045", "story_v_out_303011.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_12 and arg_180_1.time_ < var_183_2 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play303011046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 303011046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play303011047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1084ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story == nil then
				arg_184_1.var_.characterEffect1084ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1084ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1084ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1084ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.925

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(303011046)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 37
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_14 and arg_184_1.time_ < var_187_6 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play303011047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 303011047
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play303011048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.95

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(303011047)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 38
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play303011048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 303011048
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play303011049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.125

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(303011048)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 45
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_8 and arg_192_1.time_ < var_195_0 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play303011049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 303011049
		arg_196_1.duration_ = 6.57

		local var_196_0 = {
			zh = 4.233,
			ja = 6.566
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play303011050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1084ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1084ui_story == nil then
				arg_196_1.var_.characterEffect1084ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1084ui_story and not isNil(var_199_0) then
					arg_196_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1084ui_story then
				arg_196_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_199_4 = 0

			if var_199_4 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_199_5 = 0

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_199_6 = 0
			local var_199_7 = 0.5

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_8 = arg_196_1:FormatText(StoryNameCfg[6].name)

				arg_196_1.leftNameTxt_.text = var_199_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_9 = arg_196_1:GetWordFromCfg(303011049)
				local var_199_10 = arg_196_1:FormatText(var_199_9.content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 20
				local var_199_12 = utf8.len(var_199_10)
				local var_199_13 = var_199_11 <= 0 and var_199_7 or var_199_7 * (var_199_12 / var_199_11)

				if var_199_13 > 0 and var_199_7 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011049", "story_v_out_303011.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011049", "story_v_out_303011.awb") / 1000

					if var_199_14 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_6
					end

					if var_199_9.prefab_name ~= "" and arg_196_1.actors_[var_199_9.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_9.prefab_name].transform, "story_v_out_303011", "303011049", "story_v_out_303011.awb")

						arg_196_1:RecordAudio("303011049", var_199_15)
						arg_196_1:RecordAudio("303011049", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_303011", "303011049", "story_v_out_303011.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_303011", "303011049", "story_v_out_303011.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_16 and arg_196_1.time_ < var_199_6 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play303011050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 303011050
		arg_200_1.duration_ = 3.63

		local var_200_0 = {
			zh = 3.633,
			ja = 1.999999999999
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play303011051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1166ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1166ui_story = var_203_0.localPosition

				local var_203_2 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_2 then
					var_203_2:EnableDynamicBone(false)
				end
			end

			local var_203_3 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_3 then
				local var_203_4 = (arg_200_1.time_ - var_203_1) / var_203_3
				local var_203_5 = Vector3.New(0.7, -0.75, -6.25)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1166ui_story, var_203_5, var_203_4)

				local var_203_6 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_6.x, var_203_6.y, var_203_6.z)

				local var_203_7 = var_203_0.localEulerAngles

				var_203_7.z = 0
				var_203_7.x = 0
				var_203_0.localEulerAngles = var_203_7
			end

			if arg_200_1.time_ >= var_203_1 + var_203_3 and arg_200_1.time_ < var_203_1 + var_203_3 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0.7, -0.75, -6.25)

				local var_203_8 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_8.x, var_203_8.y, var_203_8.z)

				local var_203_9 = var_203_0.localEulerAngles

				var_203_9.z = 0
				var_203_9.x = 0
				var_203_0.localEulerAngles = var_203_9

				local var_203_10 = GameObjectTools.GetOrAddComponent(var_203_0.gameObject, typeof(DynamicBoneHelper))

				if var_203_10 then
					var_203_10:EnableDynamicBone(true)
				end
			end

			local var_203_11 = arg_200_1.actors_["1084ui_story"].transform
			local var_203_12 = 0

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.var_.moveOldPos1084ui_story = var_203_11.localPosition
			end

			local var_203_13 = 0.001

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_13 then
				local var_203_14 = (arg_200_1.time_ - var_203_12) / var_203_13
				local var_203_15 = Vector3.New(-0.7, -0.97, -6)

				var_203_11.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1084ui_story, var_203_15, var_203_14)

				local var_203_16 = manager.ui.mainCamera.transform.position - var_203_11.position

				var_203_11.forward = Vector3.New(var_203_16.x, var_203_16.y, var_203_16.z)

				local var_203_17 = var_203_11.localEulerAngles

				var_203_17.z = 0
				var_203_17.x = 0
				var_203_11.localEulerAngles = var_203_17
			end

			if arg_200_1.time_ >= var_203_12 + var_203_13 and arg_200_1.time_ < var_203_12 + var_203_13 + arg_203_0 then
				var_203_11.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_203_18 = manager.ui.mainCamera.transform.position - var_203_11.position

				var_203_11.forward = Vector3.New(var_203_18.x, var_203_18.y, var_203_18.z)

				local var_203_19 = var_203_11.localEulerAngles

				var_203_19.z = 0
				var_203_19.x = 0
				var_203_11.localEulerAngles = var_203_19
			end

			local var_203_20 = arg_200_1.actors_["1166ui_story"]
			local var_203_21 = 0

			if var_203_21 < arg_200_1.time_ and arg_200_1.time_ <= var_203_21 + arg_203_0 and not isNil(var_203_20) and arg_200_1.var_.characterEffect1166ui_story == nil then
				arg_200_1.var_.characterEffect1166ui_story = var_203_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_22 = 0.200000002980232

			if var_203_21 <= arg_200_1.time_ and arg_200_1.time_ < var_203_21 + var_203_22 and not isNil(var_203_20) then
				local var_203_23 = (arg_200_1.time_ - var_203_21) / var_203_22

				if arg_200_1.var_.characterEffect1166ui_story and not isNil(var_203_20) then
					arg_200_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_21 + var_203_22 and arg_200_1.time_ < var_203_21 + var_203_22 + arg_203_0 and not isNil(var_203_20) and arg_200_1.var_.characterEffect1166ui_story then
				arg_200_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_203_24 = arg_200_1.actors_["1084ui_story"]
			local var_203_25 = 0

			if var_203_25 < arg_200_1.time_ and arg_200_1.time_ <= var_203_25 + arg_203_0 and not isNil(var_203_24) and arg_200_1.var_.characterEffect1084ui_story == nil then
				arg_200_1.var_.characterEffect1084ui_story = var_203_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_26 = 0.200000002980232

			if var_203_25 <= arg_200_1.time_ and arg_200_1.time_ < var_203_25 + var_203_26 and not isNil(var_203_24) then
				local var_203_27 = (arg_200_1.time_ - var_203_25) / var_203_26

				if arg_200_1.var_.characterEffect1084ui_story and not isNil(var_203_24) then
					local var_203_28 = Mathf.Lerp(0, 0.5, var_203_27)

					arg_200_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1084ui_story.fillRatio = var_203_28
				end
			end

			if arg_200_1.time_ >= var_203_25 + var_203_26 and arg_200_1.time_ < var_203_25 + var_203_26 + arg_203_0 and not isNil(var_203_24) and arg_200_1.var_.characterEffect1084ui_story then
				local var_203_29 = 0.5

				arg_200_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1084ui_story.fillRatio = var_203_29
			end

			local var_203_30 = 0

			if var_203_30 < arg_200_1.time_ and arg_200_1.time_ <= var_203_30 + arg_203_0 then
				arg_200_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			local var_203_31 = 0

			if var_203_31 < arg_200_1.time_ and arg_200_1.time_ <= var_203_31 + arg_203_0 then
				arg_200_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_203_32 = 0
			local var_203_33 = 0.4

			if var_203_32 < arg_200_1.time_ and arg_200_1.time_ <= var_203_32 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_34 = arg_200_1:FormatText(StoryNameCfg[32].name)

				arg_200_1.leftNameTxt_.text = var_203_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_35 = arg_200_1:GetWordFromCfg(303011050)
				local var_203_36 = arg_200_1:FormatText(var_203_35.content)

				arg_200_1.text_.text = var_203_36

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_37 = 16
				local var_203_38 = utf8.len(var_203_36)
				local var_203_39 = var_203_37 <= 0 and var_203_33 or var_203_33 * (var_203_38 / var_203_37)

				if var_203_39 > 0 and var_203_33 < var_203_39 then
					arg_200_1.talkMaxDuration = var_203_39

					if var_203_39 + var_203_32 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_39 + var_203_32
					end
				end

				arg_200_1.text_.text = var_203_36
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011050", "story_v_out_303011.awb") ~= 0 then
					local var_203_40 = manager.audio:GetVoiceLength("story_v_out_303011", "303011050", "story_v_out_303011.awb") / 1000

					if var_203_40 + var_203_32 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_40 + var_203_32
					end

					if var_203_35.prefab_name ~= "" and arg_200_1.actors_[var_203_35.prefab_name] ~= nil then
						local var_203_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_35.prefab_name].transform, "story_v_out_303011", "303011050", "story_v_out_303011.awb")

						arg_200_1:RecordAudio("303011050", var_203_41)
						arg_200_1:RecordAudio("303011050", var_203_41)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_303011", "303011050", "story_v_out_303011.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_303011", "303011050", "story_v_out_303011.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_42 = math.max(var_203_33, arg_200_1.talkMaxDuration)

			if var_203_32 <= arg_200_1.time_ and arg_200_1.time_ < var_203_32 + var_203_42 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_32) / var_203_42

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_32 + var_203_42 and arg_200_1.time_ < var_203_32 + var_203_42 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_200_1:InitPlayNodeList()
	end,
	Play303011051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 303011051
		arg_204_1.duration_ = 5.53

		local var_204_0 = {
			zh = 3.9,
			ja = 5.533
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play303011052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1084ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1084ui_story == nil then
				arg_204_1.var_.characterEffect1084ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1084ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1084ui_story then
				arg_204_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_207_4 = arg_204_1.actors_["1166ui_story"]
			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1166ui_story == nil then
				arg_204_1.var_.characterEffect1166ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.200000002980232

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 and not isNil(var_207_4) then
				local var_207_7 = (arg_204_1.time_ - var_207_5) / var_207_6

				if arg_204_1.var_.characterEffect1166ui_story and not isNil(var_207_4) then
					local var_207_8 = Mathf.Lerp(0, 0.5, var_207_7)

					arg_204_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1166ui_story.fillRatio = var_207_8
				end
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1166ui_story then
				local var_207_9 = 0.5

				arg_204_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1166ui_story.fillRatio = var_207_9
			end

			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_207_11 = 0

			if var_207_11 < arg_204_1.time_ and arg_204_1.time_ <= var_207_11 + arg_207_0 then
				arg_204_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_12 = 0
			local var_207_13 = 0.4

			if var_207_12 < arg_204_1.time_ and arg_204_1.time_ <= var_207_12 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_14 = arg_204_1:FormatText(StoryNameCfg[6].name)

				arg_204_1.leftNameTxt_.text = var_207_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_15 = arg_204_1:GetWordFromCfg(303011051)
				local var_207_16 = arg_204_1:FormatText(var_207_15.content)

				arg_204_1.text_.text = var_207_16

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_17 = 16
				local var_207_18 = utf8.len(var_207_16)
				local var_207_19 = var_207_17 <= 0 and var_207_13 or var_207_13 * (var_207_18 / var_207_17)

				if var_207_19 > 0 and var_207_13 < var_207_19 then
					arg_204_1.talkMaxDuration = var_207_19

					if var_207_19 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_19 + var_207_12
					end
				end

				arg_204_1.text_.text = var_207_16
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011051", "story_v_out_303011.awb") ~= 0 then
					local var_207_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011051", "story_v_out_303011.awb") / 1000

					if var_207_20 + var_207_12 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_20 + var_207_12
					end

					if var_207_15.prefab_name ~= "" and arg_204_1.actors_[var_207_15.prefab_name] ~= nil then
						local var_207_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_15.prefab_name].transform, "story_v_out_303011", "303011051", "story_v_out_303011.awb")

						arg_204_1:RecordAudio("303011051", var_207_21)
						arg_204_1:RecordAudio("303011051", var_207_21)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_303011", "303011051", "story_v_out_303011.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_303011", "303011051", "story_v_out_303011.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_22 = math.max(var_207_13, arg_204_1.talkMaxDuration)

			if var_207_12 <= arg_204_1.time_ and arg_204_1.time_ < var_207_12 + var_207_22 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_12) / var_207_22

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_12 + var_207_22 and arg_204_1.time_ < var_207_12 + var_207_22 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play303011052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 303011052
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play303011053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1084ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1084ui_story == nil then
				arg_208_1.var_.characterEffect1084ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1084ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1084ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1084ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1084ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.325

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(303011052)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 13
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play303011053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 303011053
		arg_212_1.duration_ = 4.6

		local var_212_0 = {
			zh = 4.6,
			ja = 1.999999999999
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play303011054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1166ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1166ui_story == nil then
				arg_212_1.var_.characterEffect1166ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1166ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1166ui_story then
				arg_212_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_215_4 = 0

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166actionlink/1166action424")
			end

			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_215_6 = 0
			local var_215_7 = 0.7

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[32].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:GetWordFromCfg(303011053)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 28
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011053", "story_v_out_303011.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011053", "story_v_out_303011.awb") / 1000

					if var_215_14 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_6
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_303011", "303011053", "story_v_out_303011.awb")

						arg_212_1:RecordAudio("303011053", var_215_15)
						arg_212_1:RecordAudio("303011053", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_303011", "303011053", "story_v_out_303011.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_303011", "303011053", "story_v_out_303011.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_16 and arg_212_1.time_ < var_215_6 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play303011054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 303011054
		arg_216_1.duration_ = 1.93

		local var_216_0 = {
			zh = 1.933,
			ja = 1.333
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play303011055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 0.125

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[32].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:GetWordFromCfg(303011054)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 5
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011054", "story_v_out_303011.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011054", "story_v_out_303011.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_303011", "303011054", "story_v_out_303011.awb")

						arg_216_1:RecordAudio("303011054", var_219_9)
						arg_216_1:RecordAudio("303011054", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_303011", "303011054", "story_v_out_303011.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_303011", "303011054", "story_v_out_303011.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_10 and arg_216_1.time_ < var_219_0 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play303011055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 303011055
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play303011056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1166ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1166ui_story = var_223_0.localPosition

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end
			end

			local var_223_3 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_3 then
				local var_223_4 = (arg_220_1.time_ - var_223_1) / var_223_3
				local var_223_5 = Vector3.New(0, 100, 0)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1166ui_story, var_223_5, var_223_4)

				local var_223_6 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_6.x, var_223_6.y, var_223_6.z)

				local var_223_7 = var_223_0.localEulerAngles

				var_223_7.z = 0
				var_223_7.x = 0
				var_223_0.localEulerAngles = var_223_7
			end

			if arg_220_1.time_ >= var_223_1 + var_223_3 and arg_220_1.time_ < var_223_1 + var_223_3 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, 100, 0)

				local var_223_8 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_8.x, var_223_8.y, var_223_8.z)

				local var_223_9 = var_223_0.localEulerAngles

				var_223_9.z = 0
				var_223_9.x = 0
				var_223_0.localEulerAngles = var_223_9

				local var_223_10 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_10 then
					var_223_10:EnableDynamicBone(true)
				end
			end

			local var_223_11 = arg_220_1.actors_["1084ui_story"].transform
			local var_223_12 = 0

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.var_.moveOldPos1084ui_story = var_223_11.localPosition
			end

			local var_223_13 = 0.001

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_13 then
				local var_223_14 = (arg_220_1.time_ - var_223_12) / var_223_13
				local var_223_15 = Vector3.New(0, 100, 0)

				var_223_11.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1084ui_story, var_223_15, var_223_14)

				local var_223_16 = manager.ui.mainCamera.transform.position - var_223_11.position

				var_223_11.forward = Vector3.New(var_223_16.x, var_223_16.y, var_223_16.z)

				local var_223_17 = var_223_11.localEulerAngles

				var_223_17.z = 0
				var_223_17.x = 0
				var_223_11.localEulerAngles = var_223_17
			end

			if arg_220_1.time_ >= var_223_12 + var_223_13 and arg_220_1.time_ < var_223_12 + var_223_13 + arg_223_0 then
				var_223_11.localPosition = Vector3.New(0, 100, 0)

				local var_223_18 = manager.ui.mainCamera.transform.position - var_223_11.position

				var_223_11.forward = Vector3.New(var_223_18.x, var_223_18.y, var_223_18.z)

				local var_223_19 = var_223_11.localEulerAngles

				var_223_19.z = 0
				var_223_19.x = 0
				var_223_11.localEulerAngles = var_223_19
			end

			local var_223_20 = arg_220_1.actors_["1166ui_story"]
			local var_223_21 = 0

			if var_223_21 < arg_220_1.time_ and arg_220_1.time_ <= var_223_21 + arg_223_0 and not isNil(var_223_20) and arg_220_1.var_.characterEffect1166ui_story == nil then
				arg_220_1.var_.characterEffect1166ui_story = var_223_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_22 = 0.200000002980232

			if var_223_21 <= arg_220_1.time_ and arg_220_1.time_ < var_223_21 + var_223_22 and not isNil(var_223_20) then
				local var_223_23 = (arg_220_1.time_ - var_223_21) / var_223_22

				if arg_220_1.var_.characterEffect1166ui_story and not isNil(var_223_20) then
					local var_223_24 = Mathf.Lerp(0, 0.5, var_223_23)

					arg_220_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1166ui_story.fillRatio = var_223_24
				end
			end

			if arg_220_1.time_ >= var_223_21 + var_223_22 and arg_220_1.time_ < var_223_21 + var_223_22 + arg_223_0 and not isNil(var_223_20) and arg_220_1.var_.characterEffect1166ui_story then
				local var_223_25 = 0.5

				arg_220_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1166ui_story.fillRatio = var_223_25
			end

			local var_223_26 = 0
			local var_223_27 = 0.925

			if var_223_26 < arg_220_1.time_ and arg_220_1.time_ <= var_223_26 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_28 = arg_220_1:GetWordFromCfg(303011055)
				local var_223_29 = arg_220_1:FormatText(var_223_28.content)

				arg_220_1.text_.text = var_223_29

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_30 = 37
				local var_223_31 = utf8.len(var_223_29)
				local var_223_32 = var_223_30 <= 0 and var_223_27 or var_223_27 * (var_223_31 / var_223_30)

				if var_223_32 > 0 and var_223_27 < var_223_32 then
					arg_220_1.talkMaxDuration = var_223_32

					if var_223_32 + var_223_26 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_32 + var_223_26
					end
				end

				arg_220_1.text_.text = var_223_29
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_33 = math.max(var_223_27, arg_220_1.talkMaxDuration)

			if var_223_26 <= arg_220_1.time_ and arg_220_1.time_ < var_223_26 + var_223_33 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_26) / var_223_33

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_26 + var_223_33 and arg_220_1.time_ < var_223_26 + var_223_33 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
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

		arg_220_1:InitPlayNodeList()
	end,
	Play303011056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 303011056
		arg_224_1.duration_ = 3.97

		local var_224_0 = {
			zh = 2.033,
			ja = 3.966
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play303011057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1019ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos1019ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1019ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = arg_224_1.actors_["1019ui_story"]
			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect1019ui_story == nil then
				arg_224_1.var_.characterEffect1019ui_story = var_227_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_11 and not isNil(var_227_9) then
				local var_227_12 = (arg_224_1.time_ - var_227_10) / var_227_11

				if arg_224_1.var_.characterEffect1019ui_story and not isNil(var_227_9) then
					arg_224_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_10 + var_227_11 and arg_224_1.time_ < var_227_10 + var_227_11 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect1019ui_story then
				arg_224_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_227_13 = 0

			if var_227_13 < arg_224_1.time_ and arg_224_1.time_ <= var_227_13 + arg_227_0 then
				arg_224_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_227_14 = 0

			if var_227_14 < arg_224_1.time_ and arg_224_1.time_ <= var_227_14 + arg_227_0 then
				arg_224_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_227_15 = 0
			local var_227_16 = 0.275

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_17 = arg_224_1:FormatText(StoryNameCfg[13].name)

				arg_224_1.leftNameTxt_.text = var_227_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_18 = arg_224_1:GetWordFromCfg(303011056)
				local var_227_19 = arg_224_1:FormatText(var_227_18.content)

				arg_224_1.text_.text = var_227_19

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_20 = 11
				local var_227_21 = utf8.len(var_227_19)
				local var_227_22 = var_227_20 <= 0 and var_227_16 or var_227_16 * (var_227_21 / var_227_20)

				if var_227_22 > 0 and var_227_16 < var_227_22 then
					arg_224_1.talkMaxDuration = var_227_22

					if var_227_22 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_22 + var_227_15
					end
				end

				arg_224_1.text_.text = var_227_19
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011056", "story_v_out_303011.awb") ~= 0 then
					local var_227_23 = manager.audio:GetVoiceLength("story_v_out_303011", "303011056", "story_v_out_303011.awb") / 1000

					if var_227_23 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_23 + var_227_15
					end

					if var_227_18.prefab_name ~= "" and arg_224_1.actors_[var_227_18.prefab_name] ~= nil then
						local var_227_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_18.prefab_name].transform, "story_v_out_303011", "303011056", "story_v_out_303011.awb")

						arg_224_1:RecordAudio("303011056", var_227_24)
						arg_224_1:RecordAudio("303011056", var_227_24)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_303011", "303011056", "story_v_out_303011.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_303011", "303011056", "story_v_out_303011.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_25 = math.max(var_227_16, arg_224_1.talkMaxDuration)

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_25 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_15) / var_227_25

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_15 + var_227_25 and arg_224_1.time_ < var_227_15 + var_227_25 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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

		arg_224_1:InitPlayNodeList()
	end,
	Play303011057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 303011057
		arg_228_1.duration_ = 5.6

		local var_228_0 = {
			zh = 5.6,
			ja = 1.333
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play303011058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1166ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1166ui_story = var_231_0.localPosition

				local var_231_2 = GameObjectTools.GetOrAddComponent(var_231_0.gameObject, typeof(DynamicBoneHelper))

				if var_231_2 then
					var_231_2:EnableDynamicBone(false)
				end
			end

			local var_231_3 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_3 then
				local var_231_4 = (arg_228_1.time_ - var_231_1) / var_231_3
				local var_231_5 = Vector3.New(0.7, -0.75, -6.25)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1166ui_story, var_231_5, var_231_4)

				local var_231_6 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_6.x, var_231_6.y, var_231_6.z)

				local var_231_7 = var_231_0.localEulerAngles

				var_231_7.z = 0
				var_231_7.x = 0
				var_231_0.localEulerAngles = var_231_7
			end

			if arg_228_1.time_ >= var_231_1 + var_231_3 and arg_228_1.time_ < var_231_1 + var_231_3 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0.7, -0.75, -6.25)

				local var_231_8 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_8.x, var_231_8.y, var_231_8.z)

				local var_231_9 = var_231_0.localEulerAngles

				var_231_9.z = 0
				var_231_9.x = 0
				var_231_0.localEulerAngles = var_231_9

				local var_231_10 = GameObjectTools.GetOrAddComponent(var_231_0.gameObject, typeof(DynamicBoneHelper))

				if var_231_10 then
					var_231_10:EnableDynamicBone(true)
				end
			end

			local var_231_11 = arg_228_1.actors_["1166ui_story"]
			local var_231_12 = 0

			if var_231_12 < arg_228_1.time_ and arg_228_1.time_ <= var_231_12 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.characterEffect1166ui_story == nil then
				arg_228_1.var_.characterEffect1166ui_story = var_231_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_13 = 0.200000002980232

			if var_231_12 <= arg_228_1.time_ and arg_228_1.time_ < var_231_12 + var_231_13 and not isNil(var_231_11) then
				local var_231_14 = (arg_228_1.time_ - var_231_12) / var_231_13

				if arg_228_1.var_.characterEffect1166ui_story and not isNil(var_231_11) then
					arg_228_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_12 + var_231_13 and arg_228_1.time_ < var_231_12 + var_231_13 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.characterEffect1166ui_story then
				arg_228_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_231_15 = arg_228_1.actors_["1019ui_story"]
			local var_231_16 = 0

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.characterEffect1019ui_story == nil then
				arg_228_1.var_.characterEffect1019ui_story = var_231_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_17 = 0.200000002980232

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_17 and not isNil(var_231_15) then
				local var_231_18 = (arg_228_1.time_ - var_231_16) / var_231_17

				if arg_228_1.var_.characterEffect1019ui_story and not isNil(var_231_15) then
					local var_231_19 = Mathf.Lerp(0, 0.5, var_231_18)

					arg_228_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1019ui_story.fillRatio = var_231_19
				end
			end

			if arg_228_1.time_ >= var_231_16 + var_231_17 and arg_228_1.time_ < var_231_16 + var_231_17 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.characterEffect1019ui_story then
				local var_231_20 = 0.5

				arg_228_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1019ui_story.fillRatio = var_231_20
			end

			local var_231_21 = 0

			if var_231_21 < arg_228_1.time_ and arg_228_1.time_ <= var_231_21 + arg_231_0 then
				arg_228_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			local var_231_22 = 0

			if var_231_22 < arg_228_1.time_ and arg_228_1.time_ <= var_231_22 + arg_231_0 then
				arg_228_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_231_23 = 0
			local var_231_24 = 0.675

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_25 = arg_228_1:FormatText(StoryNameCfg[32].name)

				arg_228_1.leftNameTxt_.text = var_231_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_26 = arg_228_1:GetWordFromCfg(303011057)
				local var_231_27 = arg_228_1:FormatText(var_231_26.content)

				arg_228_1.text_.text = var_231_27

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_28 = 27
				local var_231_29 = utf8.len(var_231_27)
				local var_231_30 = var_231_28 <= 0 and var_231_24 or var_231_24 * (var_231_29 / var_231_28)

				if var_231_30 > 0 and var_231_24 < var_231_30 then
					arg_228_1.talkMaxDuration = var_231_30

					if var_231_30 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_30 + var_231_23
					end
				end

				arg_228_1.text_.text = var_231_27
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011057", "story_v_out_303011.awb") ~= 0 then
					local var_231_31 = manager.audio:GetVoiceLength("story_v_out_303011", "303011057", "story_v_out_303011.awb") / 1000

					if var_231_31 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_31 + var_231_23
					end

					if var_231_26.prefab_name ~= "" and arg_228_1.actors_[var_231_26.prefab_name] ~= nil then
						local var_231_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_26.prefab_name].transform, "story_v_out_303011", "303011057", "story_v_out_303011.awb")

						arg_228_1:RecordAudio("303011057", var_231_32)
						arg_228_1:RecordAudio("303011057", var_231_32)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_303011", "303011057", "story_v_out_303011.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_303011", "303011057", "story_v_out_303011.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_33 = math.max(var_231_24, arg_228_1.talkMaxDuration)

			if var_231_23 <= arg_228_1.time_ and arg_228_1.time_ < var_231_23 + var_231_33 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_23) / var_231_33

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_23 + var_231_33 and arg_228_1.time_ < var_231_23 + var_231_33 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play303011058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 303011058
		arg_232_1.duration_ = 2.27

		local var_232_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play303011059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1019ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1019ui_story == nil then
				arg_232_1.var_.characterEffect1019ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1019ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1019ui_story then
				arg_232_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_235_4 = arg_232_1.actors_["1166ui_story"]
			local var_235_5 = 0

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 and not isNil(var_235_4) and arg_232_1.var_.characterEffect1166ui_story == nil then
				arg_232_1.var_.characterEffect1166ui_story = var_235_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_6 = 0.200000002980232

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_6 and not isNil(var_235_4) then
				local var_235_7 = (arg_232_1.time_ - var_235_5) / var_235_6

				if arg_232_1.var_.characterEffect1166ui_story and not isNil(var_235_4) then
					local var_235_8 = Mathf.Lerp(0, 0.5, var_235_7)

					arg_232_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1166ui_story.fillRatio = var_235_8
				end
			end

			if arg_232_1.time_ >= var_235_5 + var_235_6 and arg_232_1.time_ < var_235_5 + var_235_6 + arg_235_0 and not isNil(var_235_4) and arg_232_1.var_.characterEffect1166ui_story then
				local var_235_9 = 0.5

				arg_232_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1166ui_story.fillRatio = var_235_9
			end

			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_235_11 = 0

			if var_235_11 < arg_232_1.time_ and arg_232_1.time_ <= var_235_11 + arg_235_0 then
				arg_232_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_12 = 0
			local var_235_13 = 0.125

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_14 = arg_232_1:FormatText(StoryNameCfg[13].name)

				arg_232_1.leftNameTxt_.text = var_235_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_15 = arg_232_1:GetWordFromCfg(303011058)
				local var_235_16 = arg_232_1:FormatText(var_235_15.content)

				arg_232_1.text_.text = var_235_16

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_17 = 5
				local var_235_18 = utf8.len(var_235_16)
				local var_235_19 = var_235_17 <= 0 and var_235_13 or var_235_13 * (var_235_18 / var_235_17)

				if var_235_19 > 0 and var_235_13 < var_235_19 then
					arg_232_1.talkMaxDuration = var_235_19

					if var_235_19 + var_235_12 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_19 + var_235_12
					end
				end

				arg_232_1.text_.text = var_235_16
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011058", "story_v_out_303011.awb") ~= 0 then
					local var_235_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011058", "story_v_out_303011.awb") / 1000

					if var_235_20 + var_235_12 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_20 + var_235_12
					end

					if var_235_15.prefab_name ~= "" and arg_232_1.actors_[var_235_15.prefab_name] ~= nil then
						local var_235_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_15.prefab_name].transform, "story_v_out_303011", "303011058", "story_v_out_303011.awb")

						arg_232_1:RecordAudio("303011058", var_235_21)
						arg_232_1:RecordAudio("303011058", var_235_21)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_303011", "303011058", "story_v_out_303011.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_303011", "303011058", "story_v_out_303011.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_22 = math.max(var_235_13, arg_232_1.talkMaxDuration)

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_22 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_12) / var_235_22

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_12 + var_235_22 and arg_232_1.time_ < var_235_12 + var_235_22 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play303011059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 303011059
		arg_236_1.duration_ = 4.17

		local var_236_0 = {
			zh = 4.166,
			ja = 1.999999999999
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play303011060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1166ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1166ui_story == nil then
				arg_236_1.var_.characterEffect1166ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1166ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1166ui_story then
				arg_236_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_239_4 = arg_236_1.actors_["1019ui_story"]
			local var_239_5 = 0

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect1019ui_story == nil then
				arg_236_1.var_.characterEffect1019ui_story = var_239_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_6 = 0.200000002980232

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_6 and not isNil(var_239_4) then
				local var_239_7 = (arg_236_1.time_ - var_239_5) / var_239_6

				if arg_236_1.var_.characterEffect1019ui_story and not isNil(var_239_4) then
					local var_239_8 = Mathf.Lerp(0, 0.5, var_239_7)

					arg_236_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1019ui_story.fillRatio = var_239_8
				end
			end

			if arg_236_1.time_ >= var_239_5 + var_239_6 and arg_236_1.time_ < var_239_5 + var_239_6 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect1019ui_story then
				local var_239_9 = 0.5

				arg_236_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1019ui_story.fillRatio = var_239_9
			end

			local var_239_10 = 0

			if var_239_10 < arg_236_1.time_ and arg_236_1.time_ <= var_239_10 + arg_239_0 then
				arg_236_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			local var_239_11 = 0

			if var_239_11 < arg_236_1.time_ and arg_236_1.time_ <= var_239_11 + arg_239_0 then
				arg_236_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganB", "EmotionTimelineAnimator")
			end

			local var_239_12 = 0
			local var_239_13 = 0.4

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_14 = arg_236_1:FormatText(StoryNameCfg[32].name)

				arg_236_1.leftNameTxt_.text = var_239_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_15 = arg_236_1:GetWordFromCfg(303011059)
				local var_239_16 = arg_236_1:FormatText(var_239_15.content)

				arg_236_1.text_.text = var_239_16

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_17 = 16
				local var_239_18 = utf8.len(var_239_16)
				local var_239_19 = var_239_17 <= 0 and var_239_13 or var_239_13 * (var_239_18 / var_239_17)

				if var_239_19 > 0 and var_239_13 < var_239_19 then
					arg_236_1.talkMaxDuration = var_239_19

					if var_239_19 + var_239_12 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_19 + var_239_12
					end
				end

				arg_236_1.text_.text = var_239_16
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011059", "story_v_out_303011.awb") ~= 0 then
					local var_239_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011059", "story_v_out_303011.awb") / 1000

					if var_239_20 + var_239_12 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_20 + var_239_12
					end

					if var_239_15.prefab_name ~= "" and arg_236_1.actors_[var_239_15.prefab_name] ~= nil then
						local var_239_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_15.prefab_name].transform, "story_v_out_303011", "303011059", "story_v_out_303011.awb")

						arg_236_1:RecordAudio("303011059", var_239_21)
						arg_236_1:RecordAudio("303011059", var_239_21)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_303011", "303011059", "story_v_out_303011.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_303011", "303011059", "story_v_out_303011.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_22 = math.max(var_239_13, arg_236_1.talkMaxDuration)

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_22 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_12) / var_239_22

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_12 + var_239_22 and arg_236_1.time_ < var_239_12 + var_239_22 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play303011060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 303011060
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play303011061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1166ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1166ui_story == nil then
				arg_240_1.var_.characterEffect1166ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1166ui_story and not isNil(var_243_0) then
					local var_243_4 = Mathf.Lerp(0, 0.5, var_243_3)

					arg_240_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1166ui_story.fillRatio = var_243_4
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1166ui_story then
				local var_243_5 = 0.5

				arg_240_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1166ui_story.fillRatio = var_243_5
			end

			local var_243_6 = 0
			local var_243_7 = 0.525

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_8 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_9 = arg_240_1:GetWordFromCfg(303011060)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 21
				local var_243_12 = utf8.len(var_243_10)
				local var_243_13 = var_243_11 <= 0 and var_243_7 or var_243_7 * (var_243_12 / var_243_11)

				if var_243_13 > 0 and var_243_7 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_14 and arg_240_1.time_ < var_243_6 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play303011061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 303011061
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play303011062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.825

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(303011061)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 33
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_8 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_8 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_8

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_8 and arg_244_1.time_ < var_247_0 + var_247_8 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play303011062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 303011062
		arg_248_1.duration_ = 4.4

		local var_248_0 = {
			zh = 4.4,
			ja = 1.999999999999
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play303011063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1166ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1166ui_story == nil then
				arg_248_1.var_.characterEffect1166ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect1166ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1166ui_story then
				arg_248_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_251_4 = 0

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166actionlink/1166action423")
			end

			local var_251_5 = 0

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_251_6 = 0
			local var_251_7 = 0.35

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_8 = arg_248_1:FormatText(StoryNameCfg[32].name)

				arg_248_1.leftNameTxt_.text = var_251_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:GetWordFromCfg(303011062)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 14
				local var_251_12 = utf8.len(var_251_10)
				local var_251_13 = var_251_11 <= 0 and var_251_7 or var_251_7 * (var_251_12 / var_251_11)

				if var_251_13 > 0 and var_251_7 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011062", "story_v_out_303011.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011062", "story_v_out_303011.awb") / 1000

					if var_251_14 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_6
					end

					if var_251_9.prefab_name ~= "" and arg_248_1.actors_[var_251_9.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_9.prefab_name].transform, "story_v_out_303011", "303011062", "story_v_out_303011.awb")

						arg_248_1:RecordAudio("303011062", var_251_15)
						arg_248_1:RecordAudio("303011062", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_303011", "303011062", "story_v_out_303011.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_303011", "303011062", "story_v_out_303011.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_16 and arg_248_1.time_ < var_251_6 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play303011063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 303011063
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play303011064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1166ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1166ui_story == nil then
				arg_252_1.var_.characterEffect1166ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1166ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1166ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1166ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1166ui_story.fillRatio = var_255_5
			end

			local var_255_6 = 0
			local var_255_7 = 0.275

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(303011063)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 11
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play303011064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 303011064
		arg_256_1.duration_ = 3.67

		local var_256_0 = {
			zh = 3.666,
			ja = 1.333
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play303011065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1166ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1166ui_story == nil then
				arg_256_1.var_.characterEffect1166ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1166ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1166ui_story then
				arg_256_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_259_4 = 0
			local var_259_5 = 0.4

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_6 = arg_256_1:FormatText(StoryNameCfg[32].name)

				arg_256_1.leftNameTxt_.text = var_259_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_7 = arg_256_1:GetWordFromCfg(303011064)
				local var_259_8 = arg_256_1:FormatText(var_259_7.content)

				arg_256_1.text_.text = var_259_8

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 16
				local var_259_10 = utf8.len(var_259_8)
				local var_259_11 = var_259_9 <= 0 and var_259_5 or var_259_5 * (var_259_10 / var_259_9)

				if var_259_11 > 0 and var_259_5 < var_259_11 then
					arg_256_1.talkMaxDuration = var_259_11

					if var_259_11 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_11 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_8
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011064", "story_v_out_303011.awb") ~= 0 then
					local var_259_12 = manager.audio:GetVoiceLength("story_v_out_303011", "303011064", "story_v_out_303011.awb") / 1000

					if var_259_12 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_12 + var_259_4
					end

					if var_259_7.prefab_name ~= "" and arg_256_1.actors_[var_259_7.prefab_name] ~= nil then
						local var_259_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_7.prefab_name].transform, "story_v_out_303011", "303011064", "story_v_out_303011.awb")

						arg_256_1:RecordAudio("303011064", var_259_13)
						arg_256_1:RecordAudio("303011064", var_259_13)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_303011", "303011064", "story_v_out_303011.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_303011", "303011064", "story_v_out_303011.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_14 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_14

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_14 and arg_256_1.time_ < var_259_4 + var_259_14 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play303011065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 303011065
		arg_260_1.duration_ = 5.63

		local var_260_0 = {
			zh = 4.333,
			ja = 5.633
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play303011066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1019ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1019ui_story == nil then
				arg_260_1.var_.characterEffect1019ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1019ui_story and not isNil(var_263_0) then
					arg_260_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1019ui_story then
				arg_260_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_263_4 = arg_260_1.actors_["1166ui_story"]
			local var_263_5 = 0

			if var_263_5 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 and not isNil(var_263_4) and arg_260_1.var_.characterEffect1166ui_story == nil then
				arg_260_1.var_.characterEffect1166ui_story = var_263_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_6 = 0.200000002980232

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_6 and not isNil(var_263_4) then
				local var_263_7 = (arg_260_1.time_ - var_263_5) / var_263_6

				if arg_260_1.var_.characterEffect1166ui_story and not isNil(var_263_4) then
					local var_263_8 = Mathf.Lerp(0, 0.5, var_263_7)

					arg_260_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1166ui_story.fillRatio = var_263_8
				end
			end

			if arg_260_1.time_ >= var_263_5 + var_263_6 and arg_260_1.time_ < var_263_5 + var_263_6 + arg_263_0 and not isNil(var_263_4) and arg_260_1.var_.characterEffect1166ui_story then
				local var_263_9 = 0.5

				arg_260_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1166ui_story.fillRatio = var_263_9
			end

			local var_263_10 = 0

			if var_263_10 < arg_260_1.time_ and arg_260_1.time_ <= var_263_10 + arg_263_0 then
				arg_260_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_263_11 = 0

			if var_263_11 < arg_260_1.time_ and arg_260_1.time_ <= var_263_11 + arg_263_0 then
				arg_260_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_263_12 = 0
			local var_263_13 = 0.525

			if var_263_12 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_14 = arg_260_1:FormatText(StoryNameCfg[13].name)

				arg_260_1.leftNameTxt_.text = var_263_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_15 = arg_260_1:GetWordFromCfg(303011065)
				local var_263_16 = arg_260_1:FormatText(var_263_15.content)

				arg_260_1.text_.text = var_263_16

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_17 = 21
				local var_263_18 = utf8.len(var_263_16)
				local var_263_19 = var_263_17 <= 0 and var_263_13 or var_263_13 * (var_263_18 / var_263_17)

				if var_263_19 > 0 and var_263_13 < var_263_19 then
					arg_260_1.talkMaxDuration = var_263_19

					if var_263_19 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_19 + var_263_12
					end
				end

				arg_260_1.text_.text = var_263_16
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011065", "story_v_out_303011.awb") ~= 0 then
					local var_263_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011065", "story_v_out_303011.awb") / 1000

					if var_263_20 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_20 + var_263_12
					end

					if var_263_15.prefab_name ~= "" and arg_260_1.actors_[var_263_15.prefab_name] ~= nil then
						local var_263_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_15.prefab_name].transform, "story_v_out_303011", "303011065", "story_v_out_303011.awb")

						arg_260_1:RecordAudio("303011065", var_263_21)
						arg_260_1:RecordAudio("303011065", var_263_21)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_303011", "303011065", "story_v_out_303011.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_303011", "303011065", "story_v_out_303011.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_22 = math.max(var_263_13, arg_260_1.talkMaxDuration)

			if var_263_12 <= arg_260_1.time_ and arg_260_1.time_ < var_263_12 + var_263_22 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_12) / var_263_22

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_12 + var_263_22 and arg_260_1.time_ < var_263_12 + var_263_22 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play303011066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 303011066
		arg_264_1.duration_ = 1

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"

			SetActive(arg_264_1.choicesGo_, true)

			for iter_265_0, iter_265_1 in ipairs(arg_264_1.choices_) do
				local var_265_0 = iter_265_0 <= 2

				SetActive(iter_265_1.go, var_265_0)
			end

			arg_264_1.choices_[1].txt.text = arg_264_1:FormatText(StoryChoiceCfg[1736].name)
			arg_264_1.choices_[2].txt.text = arg_264_1:FormatText(StoryChoiceCfg[1737].name)
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play303011067(arg_264_1)
			end

			if arg_266_0 == 2 then
				arg_264_0:Play303011067(arg_264_1)
			end

			arg_264_1:RecordChoiceLog(303011066, 1736, 1737)
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1019ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1019ui_story == nil then
				arg_264_1.var_.characterEffect1019ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1019ui_story and not isNil(var_267_0) then
					local var_267_4 = Mathf.Lerp(0, 0.5, var_267_3)

					arg_264_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1019ui_story.fillRatio = var_267_4
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1019ui_story then
				local var_267_5 = 0.5

				arg_264_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1019ui_story.fillRatio = var_267_5
			end

			local var_267_6 = 0

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_7 = 0.7

			if arg_264_1.time_ >= var_267_6 + var_267_7 and arg_264_1.time_ < var_267_6 + var_267_7 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play303011067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 303011067
		arg_268_1.duration_ = 7.47

		local var_268_0 = {
			zh = 7.466,
			ja = 6.233
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play303011068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1019ui_story"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1019ui_story == nil then
				arg_268_1.var_.characterEffect1019ui_story = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect1019ui_story and not isNil(var_271_0) then
					arg_268_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1019ui_story then
				arg_268_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_271_4 = "1019ui_story"

			if arg_268_1.actors_[var_271_4] == nil then
				local var_271_5 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_271_5) then
					local var_271_6 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_268_1.stage_.transform)

					var_271_6.name = var_271_4
					var_271_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_268_1.actors_[var_271_4] = var_271_6

					local var_271_7 = var_271_6:GetComponentInChildren(typeof(CharacterEffect))

					var_271_7.enabled = true

					local var_271_8 = GameObjectTools.GetOrAddComponent(var_271_6, typeof(DynamicBoneHelper))

					if var_271_8 then
						var_271_8:EnableDynamicBone(false)
					end

					arg_268_1:ShowWeapon(var_271_7.transform, false)

					arg_268_1.var_[var_271_4 .. "Animator"] = var_271_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_268_1.var_[var_271_4 .. "Animator"].applyRootMotion = true
					arg_268_1.var_[var_271_4 .. "LipSync"] = var_271_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_271_9 = 0

			if var_271_9 < arg_268_1.time_ and arg_268_1.time_ <= var_271_9 + arg_271_0 then
				arg_268_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_271_10 = "1019ui_story"

			if arg_268_1.actors_[var_271_10] == nil then
				local var_271_11 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_271_11) then
					local var_271_12 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_268_1.stage_.transform)

					var_271_12.name = var_271_10
					var_271_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_268_1.actors_[var_271_10] = var_271_12

					local var_271_13 = var_271_12:GetComponentInChildren(typeof(CharacterEffect))

					var_271_13.enabled = true

					local var_271_14 = GameObjectTools.GetOrAddComponent(var_271_12, typeof(DynamicBoneHelper))

					if var_271_14 then
						var_271_14:EnableDynamicBone(false)
					end

					arg_268_1:ShowWeapon(var_271_13.transform, false)

					arg_268_1.var_[var_271_10 .. "Animator"] = var_271_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_268_1.var_[var_271_10 .. "Animator"].applyRootMotion = true
					arg_268_1.var_[var_271_10 .. "LipSync"] = var_271_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_271_15 = 0

			if var_271_15 < arg_268_1.time_ and arg_268_1.time_ <= var_271_15 + arg_271_0 then
				arg_268_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_271_16 = 0
			local var_271_17 = 0.675

			if var_271_16 < arg_268_1.time_ and arg_268_1.time_ <= var_271_16 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_18 = arg_268_1:FormatText(StoryNameCfg[13].name)

				arg_268_1.leftNameTxt_.text = var_271_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_19 = arg_268_1:GetWordFromCfg(303011067)
				local var_271_20 = arg_268_1:FormatText(var_271_19.content)

				arg_268_1.text_.text = var_271_20

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_21 = 27
				local var_271_22 = utf8.len(var_271_20)
				local var_271_23 = var_271_21 <= 0 and var_271_17 or var_271_17 * (var_271_22 / var_271_21)

				if var_271_23 > 0 and var_271_17 < var_271_23 then
					arg_268_1.talkMaxDuration = var_271_23

					if var_271_23 + var_271_16 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_23 + var_271_16
					end
				end

				arg_268_1.text_.text = var_271_20
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011067", "story_v_out_303011.awb") ~= 0 then
					local var_271_24 = manager.audio:GetVoiceLength("story_v_out_303011", "303011067", "story_v_out_303011.awb") / 1000

					if var_271_24 + var_271_16 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_24 + var_271_16
					end

					if var_271_19.prefab_name ~= "" and arg_268_1.actors_[var_271_19.prefab_name] ~= nil then
						local var_271_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_19.prefab_name].transform, "story_v_out_303011", "303011067", "story_v_out_303011.awb")

						arg_268_1:RecordAudio("303011067", var_271_25)
						arg_268_1:RecordAudio("303011067", var_271_25)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_303011", "303011067", "story_v_out_303011.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_303011", "303011067", "story_v_out_303011.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_26 = math.max(var_271_17, arg_268_1.talkMaxDuration)

			if var_271_16 <= arg_268_1.time_ and arg_268_1.time_ < var_271_16 + var_271_26 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_16) / var_271_26

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_16 + var_271_26 and arg_268_1.time_ < var_271_16 + var_271_26 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play303011068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 303011068
		arg_272_1.duration_ = 4.7

		local var_272_0 = {
			zh = 4.7,
			ja = 1.999999999999
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play303011069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1166ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1166ui_story == nil then
				arg_272_1.var_.characterEffect1166ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1166ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1166ui_story then
				arg_272_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_275_4 = arg_272_1.actors_["1019ui_story"]
			local var_275_5 = 0

			if var_275_5 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 and not isNil(var_275_4) and arg_272_1.var_.characterEffect1019ui_story == nil then
				arg_272_1.var_.characterEffect1019ui_story = var_275_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_6 = 0.200000002980232

			if var_275_5 <= arg_272_1.time_ and arg_272_1.time_ < var_275_5 + var_275_6 and not isNil(var_275_4) then
				local var_275_7 = (arg_272_1.time_ - var_275_5) / var_275_6

				if arg_272_1.var_.characterEffect1019ui_story and not isNil(var_275_4) then
					local var_275_8 = Mathf.Lerp(0, 0.5, var_275_7)

					arg_272_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1019ui_story.fillRatio = var_275_8
				end
			end

			if arg_272_1.time_ >= var_275_5 + var_275_6 and arg_272_1.time_ < var_275_5 + var_275_6 + arg_275_0 and not isNil(var_275_4) and arg_272_1.var_.characterEffect1019ui_story then
				local var_275_9 = 0.5

				arg_272_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1019ui_story.fillRatio = var_275_9
			end

			local var_275_10 = 0

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 then
				arg_272_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_2")
			end

			local var_275_11 = 0

			if var_275_11 < arg_272_1.time_ and arg_272_1.time_ <= var_275_11 + arg_275_0 then
				arg_272_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_275_12 = 0
			local var_275_13 = 0.575

			if var_275_12 < arg_272_1.time_ and arg_272_1.time_ <= var_275_12 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_14 = arg_272_1:FormatText(StoryNameCfg[32].name)

				arg_272_1.leftNameTxt_.text = var_275_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_15 = arg_272_1:GetWordFromCfg(303011068)
				local var_275_16 = arg_272_1:FormatText(var_275_15.content)

				arg_272_1.text_.text = var_275_16

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_17 = 23
				local var_275_18 = utf8.len(var_275_16)
				local var_275_19 = var_275_17 <= 0 and var_275_13 or var_275_13 * (var_275_18 / var_275_17)

				if var_275_19 > 0 and var_275_13 < var_275_19 then
					arg_272_1.talkMaxDuration = var_275_19

					if var_275_19 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_19 + var_275_12
					end
				end

				arg_272_1.text_.text = var_275_16
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011068", "story_v_out_303011.awb") ~= 0 then
					local var_275_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011068", "story_v_out_303011.awb") / 1000

					if var_275_20 + var_275_12 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_20 + var_275_12
					end

					if var_275_15.prefab_name ~= "" and arg_272_1.actors_[var_275_15.prefab_name] ~= nil then
						local var_275_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_15.prefab_name].transform, "story_v_out_303011", "303011068", "story_v_out_303011.awb")

						arg_272_1:RecordAudio("303011068", var_275_21)
						arg_272_1:RecordAudio("303011068", var_275_21)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_303011", "303011068", "story_v_out_303011.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_303011", "303011068", "story_v_out_303011.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_22 = math.max(var_275_13, arg_272_1.talkMaxDuration)

			if var_275_12 <= arg_272_1.time_ and arg_272_1.time_ < var_275_12 + var_275_22 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_12) / var_275_22

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_12 + var_275_22 and arg_272_1.time_ < var_275_12 + var_275_22 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play303011069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 303011069
		arg_276_1.duration_ = 10.73

		local var_276_0 = {
			zh = 10.733,
			ja = 1.333
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play303011070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 1.3

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[32].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_3 = arg_276_1:GetWordFromCfg(303011069)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 52
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011069", "story_v_out_303011.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_303011", "303011069", "story_v_out_303011.awb") / 1000

					if var_279_8 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_0
					end

					if var_279_3.prefab_name ~= "" and arg_276_1.actors_[var_279_3.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_3.prefab_name].transform, "story_v_out_303011", "303011069", "story_v_out_303011.awb")

						arg_276_1:RecordAudio("303011069", var_279_9)
						arg_276_1:RecordAudio("303011069", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_303011", "303011069", "story_v_out_303011.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_303011", "303011069", "story_v_out_303011.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_10 and arg_276_1.time_ < var_279_0 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play303011070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 303011070
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play303011071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1166ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1166ui_story == nil then
				arg_280_1.var_.characterEffect1166ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1166ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1166ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1166ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1166ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 0.5

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_9 = arg_280_1:GetWordFromCfg(303011070)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 20
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_14 and arg_280_1.time_ < var_283_6 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play303011071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 303011071
		arg_284_1.duration_ = 6.77

		local var_284_0 = {
			zh = 6.766,
			ja = 1.999999999999
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play303011072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1166ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1166ui_story == nil then
				arg_284_1.var_.characterEffect1166ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1166ui_story and not isNil(var_287_0) then
					arg_284_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1166ui_story then
				arg_284_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_287_4 = 0

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action3_1")
			end

			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_287_6 = 0
			local var_287_7 = 0.825

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[32].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_9 = arg_284_1:GetWordFromCfg(303011071)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 33
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011071", "story_v_out_303011.awb") ~= 0 then
					local var_287_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011071", "story_v_out_303011.awb") / 1000

					if var_287_14 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_6
					end

					if var_287_9.prefab_name ~= "" and arg_284_1.actors_[var_287_9.prefab_name] ~= nil then
						local var_287_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_9.prefab_name].transform, "story_v_out_303011", "303011071", "story_v_out_303011.awb")

						arg_284_1:RecordAudio("303011071", var_287_15)
						arg_284_1:RecordAudio("303011071", var_287_15)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_303011", "303011071", "story_v_out_303011.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_303011", "303011071", "story_v_out_303011.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_16 and arg_284_1.time_ < var_287_6 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play303011072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 303011072
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play303011073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1166ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1166ui_story == nil then
				arg_288_1.var_.characterEffect1166ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1166ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1166ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1166ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1166ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.225

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_9 = arg_288_1:GetWordFromCfg(303011072)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 9
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play303011073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 303011073
		arg_292_1.duration_ = 6.6

		local var_292_0 = {
			zh = 4.133,
			ja = 6.6
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play303011074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1019ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1019ui_story == nil then
				arg_292_1.var_.characterEffect1019ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1019ui_story and not isNil(var_295_0) then
					arg_292_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1019ui_story then
				arg_292_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_295_4 = 0

			if var_295_4 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_295_5 = 0

			if var_295_5 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_295_6 = 0
			local var_295_7 = 0.525

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_8 = arg_292_1:FormatText(StoryNameCfg[13].name)

				arg_292_1.leftNameTxt_.text = var_295_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:GetWordFromCfg(303011073)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 21
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_7 or var_295_7 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_7 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011073", "story_v_out_303011.awb") ~= 0 then
					local var_295_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011073", "story_v_out_303011.awb") / 1000

					if var_295_14 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_14 + var_295_6
					end

					if var_295_9.prefab_name ~= "" and arg_292_1.actors_[var_295_9.prefab_name] ~= nil then
						local var_295_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_9.prefab_name].transform, "story_v_out_303011", "303011073", "story_v_out_303011.awb")

						arg_292_1:RecordAudio("303011073", var_295_15)
						arg_292_1:RecordAudio("303011073", var_295_15)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_303011", "303011073", "story_v_out_303011.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_303011", "303011073", "story_v_out_303011.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_16 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_16 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_16

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_16 and arg_292_1.time_ < var_295_6 + var_295_16 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play303011074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 303011074
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play303011075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1019ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1019ui_story == nil then
				arg_296_1.var_.characterEffect1019ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect1019ui_story and not isNil(var_299_0) then
					local var_299_4 = Mathf.Lerp(0, 0.5, var_299_3)

					arg_296_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1019ui_story.fillRatio = var_299_4
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1019ui_story then
				local var_299_5 = 0.5

				arg_296_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1019ui_story.fillRatio = var_299_5
			end

			local var_299_6 = 0
			local var_299_7 = 0.05

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_8 = arg_296_1:FormatText(StoryNameCfg[7].name)

				arg_296_1.leftNameTxt_.text = var_299_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_9 = arg_296_1:GetWordFromCfg(303011074)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 2
				local var_299_12 = utf8.len(var_299_10)
				local var_299_13 = var_299_11 <= 0 and var_299_7 or var_299_7 * (var_299_12 / var_299_11)

				if var_299_13 > 0 and var_299_7 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_14 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_14 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_14

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_14 and arg_296_1.time_ < var_299_6 + var_299_14 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play303011075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 303011075
		arg_300_1.duration_ = 10.1

		local var_300_0 = {
			zh = 6.366,
			ja = 10.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play303011076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1019ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1019ui_story == nil then
				arg_300_1.var_.characterEffect1019ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect1019ui_story and not isNil(var_303_0) then
					arg_300_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1019ui_story then
				arg_300_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_303_4 = 0

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_303_5 = 0

			if var_303_5 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_303_6 = 0
			local var_303_7 = 0.825

			if var_303_6 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_8 = arg_300_1:FormatText(StoryNameCfg[13].name)

				arg_300_1.leftNameTxt_.text = var_303_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_9 = arg_300_1:GetWordFromCfg(303011075)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 33
				local var_303_12 = utf8.len(var_303_10)
				local var_303_13 = var_303_11 <= 0 and var_303_7 or var_303_7 * (var_303_12 / var_303_11)

				if var_303_13 > 0 and var_303_7 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_10
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011075", "story_v_out_303011.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011075", "story_v_out_303011.awb") / 1000

					if var_303_14 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_6
					end

					if var_303_9.prefab_name ~= "" and arg_300_1.actors_[var_303_9.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_9.prefab_name].transform, "story_v_out_303011", "303011075", "story_v_out_303011.awb")

						arg_300_1:RecordAudio("303011075", var_303_15)
						arg_300_1:RecordAudio("303011075", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_303011", "303011075", "story_v_out_303011.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_303011", "303011075", "story_v_out_303011.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_16 and arg_300_1.time_ < var_303_6 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play303011076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 303011076
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play303011077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1019ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1019ui_story == nil then
				arg_304_1.var_.characterEffect1019ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1019ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1019ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1019ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1019ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.4

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_8 = arg_304_1:FormatText(StoryNameCfg[7].name)

				arg_304_1.leftNameTxt_.text = var_307_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_9 = arg_304_1:GetWordFromCfg(303011076)
				local var_307_10 = arg_304_1:FormatText(var_307_9.content)

				arg_304_1.text_.text = var_307_10

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 16
				local var_307_12 = utf8.len(var_307_10)
				local var_307_13 = var_307_11 <= 0 and var_307_7 or var_307_7 * (var_307_12 / var_307_11)

				if var_307_13 > 0 and var_307_7 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_10
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_14 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_14 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_14

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_14 and arg_304_1.time_ < var_307_6 + var_307_14 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play303011077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 303011077
		arg_308_1.duration_ = 6.2

		local var_308_0 = {
			zh = 6.2,
			ja = 1.999999999999
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play303011078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1166ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1166ui_story == nil then
				arg_308_1.var_.characterEffect1166ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect1166ui_story and not isNil(var_311_0) then
					arg_308_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1166ui_story then
				arg_308_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_311_4 = 0

			if var_311_4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166actionlink/1166action434")
			end

			local var_311_5 = 0

			if var_311_5 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_311_6 = 0
			local var_311_7 = 0.75

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_8 = arg_308_1:FormatText(StoryNameCfg[32].name)

				arg_308_1.leftNameTxt_.text = var_311_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_9 = arg_308_1:GetWordFromCfg(303011077)
				local var_311_10 = arg_308_1:FormatText(var_311_9.content)

				arg_308_1.text_.text = var_311_10

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 30
				local var_311_12 = utf8.len(var_311_10)
				local var_311_13 = var_311_11 <= 0 and var_311_7 or var_311_7 * (var_311_12 / var_311_11)

				if var_311_13 > 0 and var_311_7 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_10
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011077", "story_v_out_303011.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011077", "story_v_out_303011.awb") / 1000

					if var_311_14 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_6
					end

					if var_311_9.prefab_name ~= "" and arg_308_1.actors_[var_311_9.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_9.prefab_name].transform, "story_v_out_303011", "303011077", "story_v_out_303011.awb")

						arg_308_1:RecordAudio("303011077", var_311_15)
						arg_308_1:RecordAudio("303011077", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_303011", "303011077", "story_v_out_303011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_303011", "303011077", "story_v_out_303011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_16 and arg_308_1.time_ < var_311_6 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play303011078 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 303011078
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play303011079(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1166ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1166ui_story == nil then
				arg_312_1.var_.characterEffect1166ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect1166ui_story and not isNil(var_315_0) then
					local var_315_4 = Mathf.Lerp(0, 0.5, var_315_3)

					arg_312_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1166ui_story.fillRatio = var_315_4
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1166ui_story then
				local var_315_5 = 0.5

				arg_312_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1166ui_story.fillRatio = var_315_5
			end

			local var_315_6 = 0
			local var_315_7 = 0.175

			if var_315_6 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_8 = arg_312_1:FormatText(StoryNameCfg[7].name)

				arg_312_1.leftNameTxt_.text = var_315_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_9 = arg_312_1:GetWordFromCfg(303011078)
				local var_315_10 = arg_312_1:FormatText(var_315_9.content)

				arg_312_1.text_.text = var_315_10

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 7
				local var_315_12 = utf8.len(var_315_10)
				local var_315_13 = var_315_11 <= 0 and var_315_7 or var_315_7 * (var_315_12 / var_315_11)

				if var_315_13 > 0 and var_315_7 < var_315_13 then
					arg_312_1.talkMaxDuration = var_315_13

					if var_315_13 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_6
					end
				end

				arg_312_1.text_.text = var_315_10
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_14 = math.max(var_315_7, arg_312_1.talkMaxDuration)

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_14 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_14

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_14 and arg_312_1.time_ < var_315_6 + var_315_14 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play303011079 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 303011079
		arg_316_1.duration_ = 4.23

		local var_316_0 = {
			zh = 4.233,
			ja = 1.999999999999
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play303011080(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1166ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1166ui_story == nil then
				arg_316_1.var_.characterEffect1166ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect1166ui_story and not isNil(var_319_0) then
					arg_316_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect1166ui_story then
				arg_316_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_319_4 = 0

			if var_319_4 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_2")
			end

			local var_319_5 = 0

			if var_319_5 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_319_6 = 0
			local var_319_7 = 0.55

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[32].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:GetWordFromCfg(303011079)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 22
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011079", "story_v_out_303011.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011079", "story_v_out_303011.awb") / 1000

					if var_319_14 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_6
					end

					if var_319_9.prefab_name ~= "" and arg_316_1.actors_[var_319_9.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_9.prefab_name].transform, "story_v_out_303011", "303011079", "story_v_out_303011.awb")

						arg_316_1:RecordAudio("303011079", var_319_15)
						arg_316_1:RecordAudio("303011079", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_303011", "303011079", "story_v_out_303011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_303011", "303011079", "story_v_out_303011.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_16 and arg_316_1.time_ < var_319_6 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play303011080 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 303011080
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play303011081(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1166ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1166ui_story == nil then
				arg_320_1.var_.characterEffect1166ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect1166ui_story and not isNil(var_323_0) then
					local var_323_4 = Mathf.Lerp(0, 0.5, var_323_3)

					arg_320_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1166ui_story.fillRatio = var_323_4
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1166ui_story then
				local var_323_5 = 0.5

				arg_320_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1166ui_story.fillRatio = var_323_5
			end

			local var_323_6 = 0
			local var_323_7 = 0.075

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_8 = arg_320_1:FormatText(StoryNameCfg[7].name)

				arg_320_1.leftNameTxt_.text = var_323_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_9 = arg_320_1:GetWordFromCfg(303011080)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 3
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_14 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_14 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_14

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_14 and arg_320_1.time_ < var_323_6 + var_323_14 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play303011081 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 303011081
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play303011082(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.5

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(303011081)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 20
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_8 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_8 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_8

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_8 and arg_324_1.time_ < var_327_0 + var_327_8 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play303011082 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 303011082
		arg_328_1.duration_ = 4.23

		local var_328_0 = {
			zh = 4.233,
			ja = 1.999999999999
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play303011083(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1166ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1166ui_story == nil then
				arg_328_1.var_.characterEffect1166ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1166ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1166ui_story then
				arg_328_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_331_4 = 0

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			local var_331_5 = 0

			if var_331_5 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_331_6 = 0
			local var_331_7 = 0.425

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[32].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_9 = arg_328_1:GetWordFromCfg(303011082)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 17
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011082", "story_v_out_303011.awb") ~= 0 then
					local var_331_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011082", "story_v_out_303011.awb") / 1000

					if var_331_14 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_14 + var_331_6
					end

					if var_331_9.prefab_name ~= "" and arg_328_1.actors_[var_331_9.prefab_name] ~= nil then
						local var_331_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_9.prefab_name].transform, "story_v_out_303011", "303011082", "story_v_out_303011.awb")

						arg_328_1:RecordAudio("303011082", var_331_15)
						arg_328_1:RecordAudio("303011082", var_331_15)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_303011", "303011082", "story_v_out_303011.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_303011", "303011082", "story_v_out_303011.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_16 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_16 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_16

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_16 and arg_328_1.time_ < var_331_6 + var_331_16 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play303011083 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 303011083
		arg_332_1.duration_ = 2

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play303011084(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1166ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1166ui_story == nil then
				arg_332_1.var_.characterEffect1166ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1166ui_story and not isNil(var_335_0) then
					local var_335_4 = Mathf.Lerp(0, 0.5, var_335_3)

					arg_332_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1166ui_story.fillRatio = var_335_4
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1166ui_story then
				local var_335_5 = 0.5

				arg_332_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1166ui_story.fillRatio = var_335_5
			end

			local var_335_6 = 0

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_335_7 = 0

			if var_335_7 < arg_332_1.time_ and arg_332_1.time_ <= var_335_7 + arg_335_0 then
				arg_332_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_335_8 = arg_332_1.actors_["1019ui_story"]
			local var_335_9 = 0

			if var_335_9 < arg_332_1.time_ and arg_332_1.time_ <= var_335_9 + arg_335_0 and not isNil(var_335_8) and arg_332_1.var_.characterEffect1019ui_story == nil then
				arg_332_1.var_.characterEffect1019ui_story = var_335_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_10 = 0.200000002980232

			if var_335_9 <= arg_332_1.time_ and arg_332_1.time_ < var_335_9 + var_335_10 and not isNil(var_335_8) then
				local var_335_11 = (arg_332_1.time_ - var_335_9) / var_335_10

				if arg_332_1.var_.characterEffect1019ui_story and not isNil(var_335_8) then
					arg_332_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_9 + var_335_10 and arg_332_1.time_ < var_335_9 + var_335_10 + arg_335_0 and not isNil(var_335_8) and arg_332_1.var_.characterEffect1019ui_story then
				arg_332_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_335_12 = 0
			local var_335_13 = 0.05

			if var_335_12 < arg_332_1.time_ and arg_332_1.time_ <= var_335_12 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_14 = arg_332_1:FormatText(StoryNameCfg[1554].name)

				arg_332_1.leftNameTxt_.text = var_335_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_15 = arg_332_1:GetWordFromCfg(303011083)
				local var_335_16 = arg_332_1:FormatText(var_335_15.content)

				arg_332_1.text_.text = var_335_16

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_17 = 2
				local var_335_18 = utf8.len(var_335_16)
				local var_335_19 = var_335_17 <= 0 and var_335_13 or var_335_13 * (var_335_18 / var_335_17)

				if var_335_19 > 0 and var_335_13 < var_335_19 then
					arg_332_1.talkMaxDuration = var_335_19

					if var_335_19 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_19 + var_335_12
					end
				end

				arg_332_1.text_.text = var_335_16
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011083", "story_v_out_303011.awb") ~= 0 then
					local var_335_20 = manager.audio:GetVoiceLength("story_v_out_303011", "303011083", "story_v_out_303011.awb") / 1000

					if var_335_20 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_20 + var_335_12
					end

					if var_335_15.prefab_name ~= "" and arg_332_1.actors_[var_335_15.prefab_name] ~= nil then
						local var_335_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_15.prefab_name].transform, "story_v_out_303011", "303011083", "story_v_out_303011.awb")

						arg_332_1:RecordAudio("303011083", var_335_21)
						arg_332_1:RecordAudio("303011083", var_335_21)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_303011", "303011083", "story_v_out_303011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_303011", "303011083", "story_v_out_303011.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_22 = math.max(var_335_13, arg_332_1.talkMaxDuration)

			if var_335_12 <= arg_332_1.time_ and arg_332_1.time_ < var_335_12 + var_335_22 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_12) / var_335_22

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_12 + var_335_22 and arg_332_1.time_ < var_335_12 + var_335_22 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play303011084 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 303011084
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play303011085(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1019ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1019ui_story == nil then
				arg_336_1.var_.characterEffect1019ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1019ui_story and not isNil(var_339_0) then
					local var_339_4 = Mathf.Lerp(0, 0.5, var_339_3)

					arg_336_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1019ui_story.fillRatio = var_339_4
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1019ui_story then
				local var_339_5 = 0.5

				arg_336_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1019ui_story.fillRatio = var_339_5
			end

			local var_339_6 = 0
			local var_339_7 = 0.325

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[7].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_9 = arg_336_1:GetWordFromCfg(303011084)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 13
				local var_339_12 = utf8.len(var_339_10)
				local var_339_13 = var_339_11 <= 0 and var_339_7 or var_339_7 * (var_339_12 / var_339_11)

				if var_339_13 > 0 and var_339_7 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_14 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_14 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_14

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_14 and arg_336_1.time_ < var_339_6 + var_339_14 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play303011085 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 303011085
		arg_340_1.duration_ = 4

		local var_340_0 = {
			zh = 4,
			ja = 1.999999999999
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play303011086(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1166ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1166ui_story == nil then
				arg_340_1.var_.characterEffect1166ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect1166ui_story and not isNil(var_343_0) then
					arg_340_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1166ui_story then
				arg_340_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_343_4 = 0

			if var_343_4 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166actionlink/1166action423")
			end

			local var_343_5 = 0

			if var_343_5 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_343_6 = 0
			local var_343_7 = 0.475

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_8 = arg_340_1:FormatText(StoryNameCfg[32].name)

				arg_340_1.leftNameTxt_.text = var_343_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_9 = arg_340_1:GetWordFromCfg(303011085)
				local var_343_10 = arg_340_1:FormatText(var_343_9.content)

				arg_340_1.text_.text = var_343_10

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 19
				local var_343_12 = utf8.len(var_343_10)
				local var_343_13 = var_343_11 <= 0 and var_343_7 or var_343_7 * (var_343_12 / var_343_11)

				if var_343_13 > 0 and var_343_7 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_10
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303011", "303011085", "story_v_out_303011.awb") ~= 0 then
					local var_343_14 = manager.audio:GetVoiceLength("story_v_out_303011", "303011085", "story_v_out_303011.awb") / 1000

					if var_343_14 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_14 + var_343_6
					end

					if var_343_9.prefab_name ~= "" and arg_340_1.actors_[var_343_9.prefab_name] ~= nil then
						local var_343_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_9.prefab_name].transform, "story_v_out_303011", "303011085", "story_v_out_303011.awb")

						arg_340_1:RecordAudio("303011085", var_343_15)
						arg_340_1:RecordAudio("303011085", var_343_15)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_303011", "303011085", "story_v_out_303011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_303011", "303011085", "story_v_out_303011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_16 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_16 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_16

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_16 and arg_340_1.time_ < var_343_6 + var_343_16 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play303011086 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 303011086
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play303011087(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1166ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1166ui_story == nil then
				arg_344_1.var_.characterEffect1166ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1166ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1166ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1166ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1166ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0
			local var_347_7 = 0.55

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[7].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_9 = arg_344_1:GetWordFromCfg(303011086)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 22
				local var_347_12 = utf8.len(var_347_10)
				local var_347_13 = var_347_11 <= 0 and var_347_7 or var_347_7 * (var_347_12 / var_347_11)

				if var_347_13 > 0 and var_347_7 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_10
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_14 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_14 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_14

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_14 and arg_344_1.time_ < var_347_6 + var_347_14 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play303011087 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 303011087
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
			arg_348_1.auto_ = false
		end

		function arg_348_1.playNext_(arg_350_0)
			arg_348_1.onStoryFinished_()
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.425

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(303011087)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 17
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_303011.awb"
	}
}
