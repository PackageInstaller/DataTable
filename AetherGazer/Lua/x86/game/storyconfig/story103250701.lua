return {
	Play325071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325071001
		arg_1_1.duration_ = 6.53

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J23h"

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
				local var_4_5 = arg_1_1.bgs_.J23h

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
					if iter_4_0 ~= "J23h" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_4_28 = 0.6
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_148", "se_story_148_footstep02", "")
			end

			local var_4_32 = 0
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_4_8_story_jianchi", "bgm_activity_4_8_story_jianchi", "bgm_activity_4_8_story_jianchi.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_4_8_story_jianchi", "bgm_activity_4_8_story_jianchi")

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

			local var_4_38 = 1.53333333333333
			local var_4_39 = 1.175

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

				local var_4_41 = arg_1_1:GetWordFromCfg(325071001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 47
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
	Play325071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.5

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

				local var_11_2 = arg_8_1:GetWordFromCfg(325071002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 60
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
	Play325071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325071003
		arg_12_1.duration_ = 8.13

		local var_12_0 = {
			zh = 6.433,
			ja = 8.133
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
				arg_12_0:Play325071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1077ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1077ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1077ui_story = var_15_5.localPosition

				local var_15_7 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_7 then
					var_15_7:EnableDynamicBone(false)
				end
			end

			local var_15_8 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_6) / var_15_8
				local var_15_10 = Vector3.New(-0.03, -1.02, -5.92)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1077ui_story, var_15_10, var_15_9)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_5.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_5.localEulerAngles = var_15_12
			end

			if arg_12_1.time_ >= var_15_6 + var_15_8 and arg_12_1.time_ < var_15_6 + var_15_8 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_15_13 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_13.x, var_15_13.y, var_15_13.z)

				local var_15_14 = var_15_5.localEulerAngles

				var_15_14.z = 0
				var_15_14.x = 0
				var_15_5.localEulerAngles = var_15_14

				local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_15 then
					var_15_15:EnableDynamicBone(true)
				end
			end

			local var_15_16 = arg_12_1.actors_["1077ui_story"]
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect1077ui_story == nil then
				arg_12_1.var_.characterEffect1077ui_story = var_15_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_18 = 0.200000002980232

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 and not isNil(var_15_16) then
				local var_15_19 = (arg_12_1.time_ - var_15_17) / var_15_18

				if arg_12_1.var_.characterEffect1077ui_story and not isNil(var_15_16) then
					arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect1077ui_story then
				arg_12_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_15_22 = 0
			local var_15_23 = 0.6

			if var_15_22 < arg_12_1.time_ and arg_12_1.time_ <= var_15_22 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_24 = arg_12_1:FormatText(StoryNameCfg[1467].name)

				arg_12_1.leftNameTxt_.text = var_15_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_25 = arg_12_1:GetWordFromCfg(325071003)
				local var_15_26 = arg_12_1:FormatText(var_15_25.content)

				arg_12_1.text_.text = var_15_26

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_27 = 24
				local var_15_28 = utf8.len(var_15_26)
				local var_15_29 = var_15_27 <= 0 and var_15_23 or var_15_23 * (var_15_28 / var_15_27)

				if var_15_29 > 0 and var_15_23 < var_15_29 then
					arg_12_1.talkMaxDuration = var_15_29

					if var_15_29 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_22
					end
				end

				arg_12_1.text_.text = var_15_26
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071003", "story_v_out_325071.awb") ~= 0 then
					local var_15_30 = manager.audio:GetVoiceLength("story_v_out_325071", "325071003", "story_v_out_325071.awb") / 1000

					if var_15_30 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_30 + var_15_22
					end

					if var_15_25.prefab_name ~= "" and arg_12_1.actors_[var_15_25.prefab_name] ~= nil then
						local var_15_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_25.prefab_name].transform, "story_v_out_325071", "325071003", "story_v_out_325071.awb")

						arg_12_1:RecordAudio("325071003", var_15_31)
						arg_12_1:RecordAudio("325071003", var_15_31)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325071", "325071003", "story_v_out_325071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325071", "325071003", "story_v_out_325071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_32 = math.max(var_15_23, arg_12_1.talkMaxDuration)

			if var_15_22 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_32 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_22) / var_15_32

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_22 + var_15_32 and arg_12_1.time_ < var_15_22 + var_15_32 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325071004
		arg_16_1.duration_ = 5.63

		local var_16_0 = {
			zh = 5.633,
			ja = 5.566
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
				arg_16_0:Play325071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.6

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1467].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(325071004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071004", "story_v_out_325071.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_325071", "325071004", "story_v_out_325071.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_325071", "325071004", "story_v_out_325071.awb")

						arg_16_1:RecordAudio("325071004", var_19_9)
						arg_16_1:RecordAudio("325071004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325071", "325071004", "story_v_out_325071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325071", "325071004", "story_v_out_325071.awb")
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
	Play325071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325071005
		arg_20_1.duration_ = 8.34

		local var_20_0 = {
			zh = 6.441666666666,
			ja = 8.341666666666
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
				arg_20_0:Play325071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.93333333333333

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				local var_23_1 = manager.ui.mainCamera.transform.localPosition
				local var_23_2 = Vector3.New(0, 0, 10) + Vector3.New(var_23_1.x, var_23_1.y, 0)
				local var_23_3 = arg_20_1.bgs_.J23h

				var_23_3.transform.localPosition = var_23_2
				var_23_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_4 = var_23_3:GetComponent("SpriteRenderer")

				if var_23_4 and var_23_4.sprite then
					local var_23_5 = (var_23_3.transform.localPosition - var_23_1).z
					local var_23_6 = manager.ui.mainCameraCom_
					local var_23_7 = 2 * var_23_5 * Mathf.Tan(var_23_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_8 = var_23_7 * var_23_6.aspect
					local var_23_9 = var_23_4.sprite.bounds.size.x
					local var_23_10 = var_23_4.sprite.bounds.size.y
					local var_23_11 = var_23_8 / var_23_9
					local var_23_12 = var_23_7 / var_23_10
					local var_23_13 = var_23_12 < var_23_11 and var_23_11 or var_23_12

					var_23_3.transform.localScale = Vector3.New(var_23_13, var_23_13, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "J23h" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_14 = 1.93333333333333

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_15 = 0.3

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_17 = 1.93333333333333

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Color.New(0, 0, 0)

				var_23_19.a = Mathf.Lerp(0, 1, var_23_18)
				arg_20_1.mask_.color = var_23_19
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				local var_23_20 = Color.New(0, 0, 0)

				var_23_20.a = 1
				arg_20_1.mask_.color = var_23_20
			end

			local var_23_21 = 1.93333333333333

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_22 = 2

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22
				local var_23_24 = Color.New(0, 0, 0)

				var_23_24.a = Mathf.Lerp(1, 0, var_23_23)
				arg_20_1.mask_.color = var_23_24
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 then
				local var_23_25 = Color.New(0, 0, 0)
				local var_23_26 = 0

				arg_20_1.mask_.enabled = false
				var_23_25.a = var_23_26
				arg_20_1.mask_.color = var_23_25
			end

			local var_23_27 = arg_20_1.actors_["1077ui_story"].transform
			local var_23_28 = 1.93333333333333

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = var_23_27.localPosition

				local var_23_29 = GameObjectTools.GetOrAddComponent(var_23_27.gameObject, typeof(DynamicBoneHelper))

				if var_23_29 then
					var_23_29:EnableDynamicBone(false)
				end
			end

			local var_23_30 = 0.001

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_30 then
				local var_23_31 = (arg_20_1.time_ - var_23_28) / var_23_30
				local var_23_32 = Vector3.New(0, 100, 0)

				var_23_27.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, var_23_32, var_23_31)

				local var_23_33 = manager.ui.mainCamera.transform.position - var_23_27.position

				var_23_27.forward = Vector3.New(var_23_33.x, var_23_33.y, var_23_33.z)

				local var_23_34 = var_23_27.localEulerAngles

				var_23_34.z = 0
				var_23_34.x = 0
				var_23_27.localEulerAngles = var_23_34
			end

			if arg_20_1.time_ >= var_23_28 + var_23_30 and arg_20_1.time_ < var_23_28 + var_23_30 + arg_23_0 then
				var_23_27.localPosition = Vector3.New(0, 100, 0)

				local var_23_35 = manager.ui.mainCamera.transform.position - var_23_27.position

				var_23_27.forward = Vector3.New(var_23_35.x, var_23_35.y, var_23_35.z)

				local var_23_36 = var_23_27.localEulerAngles

				var_23_36.z = 0
				var_23_36.x = 0
				var_23_27.localEulerAngles = var_23_36

				local var_23_37 = GameObjectTools.GetOrAddComponent(var_23_27.gameObject, typeof(DynamicBoneHelper))

				if var_23_37 then
					var_23_37:EnableDynamicBone(true)
				end
			end

			local var_23_38 = arg_20_1.actors_["1077ui_story"]
			local var_23_39 = 1.93333333333333

			if var_23_39 < arg_20_1.time_ and arg_20_1.time_ <= var_23_39 + arg_23_0 and not isNil(var_23_38) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_40 = 0.200000002980232

			if var_23_39 <= arg_20_1.time_ and arg_20_1.time_ < var_23_39 + var_23_40 and not isNil(var_23_38) then
				local var_23_41 = (arg_20_1.time_ - var_23_39) / var_23_40

				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_38) then
					local var_23_42 = Mathf.Lerp(0, 0.5, var_23_41)

					arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_42
				end
			end

			if arg_20_1.time_ >= var_23_39 + var_23_40 and arg_20_1.time_ < var_23_39 + var_23_40 + arg_23_0 and not isNil(var_23_38) and arg_20_1.var_.characterEffect1077ui_story then
				local var_23_43 = 0.5

				arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_43
			end

			local var_23_44 = 1.93333333333333

			arg_20_1.isInRecall_ = false

			if var_23_44 < arg_20_1.time_ and arg_20_1.time_ <= var_23_44 + arg_23_0 then
				arg_20_1.screenFilterGo_:SetActive(true)

				arg_20_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_23_2, iter_23_3 in pairs(arg_20_1.actors_) do
					local var_23_45 = iter_23_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_23_4, iter_23_5 in ipairs(var_23_45) do
						if iter_23_5.color.r > 0.51 then
							iter_23_5.color = Color.New(1, 1, 1)
						else
							iter_23_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_23_46 = 0.034000001847744

			if var_23_44 <= arg_20_1.time_ and arg_20_1.time_ < var_23_44 + var_23_46 then
				local var_23_47 = (arg_20_1.time_ - var_23_44) / var_23_46

				arg_20_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_23_47)
			end

			if arg_20_1.time_ >= var_23_44 + var_23_46 and arg_20_1.time_ < var_23_44 + var_23_46 + arg_23_0 then
				arg_20_1.screenFilterEffect_.weight = 1
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_48 = 3.241666666666
			local var_23_49 = 0.325

			if var_23_48 < arg_20_1.time_ and arg_20_1.time_ <= var_23_48 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_50 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_50:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_51 = arg_20_1:FormatText(StoryNameCfg[1454].name)

				arg_20_1.leftNameTxt_.text = var_23_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_20_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_23_52 = arg_20_1:GetWordFromCfg(325071005)
				local var_23_53 = arg_20_1:FormatText(var_23_52.content)

				arg_20_1.text_.text = var_23_53

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_54 = 13
				local var_23_55 = utf8.len(var_23_53)
				local var_23_56 = var_23_54 <= 0 and var_23_49 or var_23_49 * (var_23_55 / var_23_54)

				if var_23_56 > 0 and var_23_49 < var_23_56 then
					arg_20_1.talkMaxDuration = var_23_56
					var_23_48 = var_23_48 + 0.3

					if var_23_56 + var_23_48 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_56 + var_23_48
					end
				end

				arg_20_1.text_.text = var_23_53
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071005", "story_v_out_325071.awb") ~= 0 then
					local var_23_57 = manager.audio:GetVoiceLength("story_v_out_325071", "325071005", "story_v_out_325071.awb") / 1000

					if var_23_57 + var_23_48 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_57 + var_23_48
					end

					if var_23_52.prefab_name ~= "" and arg_20_1.actors_[var_23_52.prefab_name] ~= nil then
						local var_23_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_52.prefab_name].transform, "story_v_out_325071", "325071005", "story_v_out_325071.awb")

						arg_20_1:RecordAudio("325071005", var_23_58)
						arg_20_1:RecordAudio("325071005", var_23_58)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325071", "325071005", "story_v_out_325071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325071", "325071005", "story_v_out_325071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_59 = var_23_48 + 0.3
			local var_23_60 = math.max(var_23_49, arg_20_1.talkMaxDuration)

			if var_23_59 <= arg_20_1.time_ and arg_20_1.time_ < var_23_59 + var_23_60 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_59) / var_23_60

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_59 + var_23_60 and arg_20_1.time_ < var_23_59 + var_23_60 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325071006
		arg_26_1.duration_ = 6.07

		local var_26_0 = {
			zh = 6.066,
			ja = 5.666
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1077ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos1077ui_story = var_29_0.localPosition

				local var_29_2 = GameObjectTools.GetOrAddComponent(var_29_0.gameObject, typeof(DynamicBoneHelper))

				if var_29_2 then
					var_29_2:EnableDynamicBone(false)
				end
			end

			local var_29_3 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_3 then
				local var_29_4 = (arg_26_1.time_ - var_29_1) / var_29_3
				local var_29_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1077ui_story, var_29_5, var_29_4)

				local var_29_6 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_6.x, var_29_6.y, var_29_6.z)

				local var_29_7 = var_29_0.localEulerAngles

				var_29_7.z = 0
				var_29_7.x = 0
				var_29_0.localEulerAngles = var_29_7
			end

			if arg_26_1.time_ >= var_29_1 + var_29_3 and arg_26_1.time_ < var_29_1 + var_29_3 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_29_8 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_8.x, var_29_8.y, var_29_8.z)

				local var_29_9 = var_29_0.localEulerAngles

				var_29_9.z = 0
				var_29_9.x = 0
				var_29_0.localEulerAngles = var_29_9

				local var_29_10 = GameObjectTools.GetOrAddComponent(var_29_0.gameObject, typeof(DynamicBoneHelper))

				if var_29_10 then
					var_29_10:EnableDynamicBone(true)
				end
			end

			local var_29_11 = arg_26_1.actors_["1077ui_story"]
			local var_29_12 = 0

			if var_29_12 < arg_26_1.time_ and arg_26_1.time_ <= var_29_12 + arg_29_0 and not isNil(var_29_11) and arg_26_1.var_.characterEffect1077ui_story == nil then
				arg_26_1.var_.characterEffect1077ui_story = var_29_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_13 = 0.200000002980232

			if var_29_12 <= arg_26_1.time_ and arg_26_1.time_ < var_29_12 + var_29_13 and not isNil(var_29_11) then
				local var_29_14 = (arg_26_1.time_ - var_29_12) / var_29_13

				if arg_26_1.var_.characterEffect1077ui_story and not isNil(var_29_11) then
					arg_26_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_12 + var_29_13 and arg_26_1.time_ < var_29_12 + var_29_13 + arg_29_0 and not isNil(var_29_11) and arg_26_1.var_.characterEffect1077ui_story then
				arg_26_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_29_15 = 0

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_29_16 = 0

			if var_29_16 < arg_26_1.time_ and arg_26_1.time_ <= var_29_16 + arg_29_0 then
				arg_26_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_29_17 = 0
			local var_29_18 = 0.625

			if var_29_17 < arg_26_1.time_ and arg_26_1.time_ <= var_29_17 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_19 = arg_26_1:FormatText(StoryNameCfg[1467].name)

				arg_26_1.leftNameTxt_.text = var_29_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_20 = arg_26_1:GetWordFromCfg(325071006)
				local var_29_21 = arg_26_1:FormatText(var_29_20.content)

				arg_26_1.text_.text = var_29_21

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_22 = 25
				local var_29_23 = utf8.len(var_29_21)
				local var_29_24 = var_29_22 <= 0 and var_29_18 or var_29_18 * (var_29_23 / var_29_22)

				if var_29_24 > 0 and var_29_18 < var_29_24 then
					arg_26_1.talkMaxDuration = var_29_24

					if var_29_24 + var_29_17 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_24 + var_29_17
					end
				end

				arg_26_1.text_.text = var_29_21
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071006", "story_v_out_325071.awb") ~= 0 then
					local var_29_25 = manager.audio:GetVoiceLength("story_v_out_325071", "325071006", "story_v_out_325071.awb") / 1000

					if var_29_25 + var_29_17 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_25 + var_29_17
					end

					if var_29_20.prefab_name ~= "" and arg_26_1.actors_[var_29_20.prefab_name] ~= nil then
						local var_29_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_20.prefab_name].transform, "story_v_out_325071", "325071006", "story_v_out_325071.awb")

						arg_26_1:RecordAudio("325071006", var_29_26)
						arg_26_1:RecordAudio("325071006", var_29_26)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_325071", "325071006", "story_v_out_325071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_325071", "325071006", "story_v_out_325071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_27 = math.max(var_29_18, arg_26_1.talkMaxDuration)

			if var_29_17 <= arg_26_1.time_ and arg_26_1.time_ < var_29_17 + var_29_27 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_17) / var_29_27

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_17 + var_29_27 and arg_26_1.time_ < var_29_17 + var_29_27 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play325071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325071007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play325071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1077ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1077ui_story == nil then
				arg_30_1.var_.characterEffect1077ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect1077ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1077ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1077ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1077ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 1.075

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_8 = arg_30_1:GetWordFromCfg(325071007)
				local var_33_9 = arg_30_1:FormatText(var_33_8.content)

				arg_30_1.text_.text = var_33_9

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 43
				local var_33_11 = utf8.len(var_33_9)
				local var_33_12 = var_33_10 <= 0 and var_33_7 or var_33_7 * (var_33_11 / var_33_10)

				if var_33_12 > 0 and var_33_7 < var_33_12 then
					arg_30_1.talkMaxDuration = var_33_12

					if var_33_12 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_12 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_9
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_13 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_13 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_13

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_13 and arg_30_1.time_ < var_33_6 + var_33_13 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play325071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325071008
		arg_34_1.duration_ = 6.13

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play325071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1077ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1077ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_37_4 = 0
			local var_37_5 = 0.65

			if var_37_4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_6 = arg_34_1:FormatText(StoryNameCfg[1467].name)

				arg_34_1.leftNameTxt_.text = var_37_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_7 = arg_34_1:GetWordFromCfg(325071008)
				local var_37_8 = arg_34_1:FormatText(var_37_7.content)

				arg_34_1.text_.text = var_37_8

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 26
				local var_37_10 = utf8.len(var_37_8)
				local var_37_11 = var_37_9 <= 0 and var_37_5 or var_37_5 * (var_37_10 / var_37_9)

				if var_37_11 > 0 and var_37_5 < var_37_11 then
					arg_34_1.talkMaxDuration = var_37_11

					if var_37_11 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_8
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071008", "story_v_out_325071.awb") ~= 0 then
					local var_37_12 = manager.audio:GetVoiceLength("story_v_out_325071", "325071008", "story_v_out_325071.awb") / 1000

					if var_37_12 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_12 + var_37_4
					end

					if var_37_7.prefab_name ~= "" and arg_34_1.actors_[var_37_7.prefab_name] ~= nil then
						local var_37_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_7.prefab_name].transform, "story_v_out_325071", "325071008", "story_v_out_325071.awb")

						arg_34_1:RecordAudio("325071008", var_37_13)
						arg_34_1:RecordAudio("325071008", var_37_13)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_325071", "325071008", "story_v_out_325071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_325071", "325071008", "story_v_out_325071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_14 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_14 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_14

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_14 and arg_34_1.time_ < var_37_4 + var_37_14 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play325071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 325071009
		arg_38_1.duration_ = 12.77

		local var_38_0 = {
			zh = 9.766,
			ja = 12.766
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play325071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1077ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1077ui_story == nil then
				arg_38_1.var_.characterEffect1077ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1077ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1077ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1077ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1077ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.975

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[1454].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_38_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_41_9 = arg_38_1:GetWordFromCfg(325071009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 39
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071009", "story_v_out_325071.awb") ~= 0 then
					local var_41_14 = manager.audio:GetVoiceLength("story_v_out_325071", "325071009", "story_v_out_325071.awb") / 1000

					if var_41_14 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_6
					end

					if var_41_9.prefab_name ~= "" and arg_38_1.actors_[var_41_9.prefab_name] ~= nil then
						local var_41_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_9.prefab_name].transform, "story_v_out_325071", "325071009", "story_v_out_325071.awb")

						arg_38_1:RecordAudio("325071009", var_41_15)
						arg_38_1:RecordAudio("325071009", var_41_15)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_325071", "325071009", "story_v_out_325071.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_325071", "325071009", "story_v_out_325071.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_16 and arg_38_1.time_ < var_41_6 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play325071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325071010
		arg_42_1.duration_ = 14.3

		local var_42_0 = {
			zh = 6.4,
			ja = 14.3
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1077ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1077ui_story == nil then
				arg_42_1.var_.characterEffect1077ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1077ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1077ui_story then
				arg_42_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_45_4 = 0

			if var_45_4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_45_6 = 0
			local var_45_7 = 0.775

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[1467].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_9 = arg_42_1:GetWordFromCfg(325071010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 31
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071010", "story_v_out_325071.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_325071", "325071010", "story_v_out_325071.awb") / 1000

					if var_45_14 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_6
					end

					if var_45_9.prefab_name ~= "" and arg_42_1.actors_[var_45_9.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_9.prefab_name].transform, "story_v_out_325071", "325071010", "story_v_out_325071.awb")

						arg_42_1:RecordAudio("325071010", var_45_15)
						arg_42_1:RecordAudio("325071010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_325071", "325071010", "story_v_out_325071.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_325071", "325071010", "story_v_out_325071.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_16 and arg_42_1.time_ < var_45_6 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325071011
		arg_46_1.duration_ = 12.3

		local var_46_0 = {
			zh = 6.533,
			ja = 12.3
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1077ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1077ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1077ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1077ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1077ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.75

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[1454].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_46_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_49_9 = arg_46_1:GetWordFromCfg(325071011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 30
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_7 or var_49_7 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_7 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071011", "story_v_out_325071.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_325071", "325071011", "story_v_out_325071.awb") / 1000

					if var_49_14 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_6
					end

					if var_49_9.prefab_name ~= "" and arg_46_1.actors_[var_49_9.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_9.prefab_name].transform, "story_v_out_325071", "325071011", "story_v_out_325071.awb")

						arg_46_1:RecordAudio("325071011", var_49_15)
						arg_46_1:RecordAudio("325071011", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325071", "325071011", "story_v_out_325071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325071", "325071011", "story_v_out_325071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_16 and arg_46_1.time_ < var_49_6 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play325071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325071012
		arg_50_1.duration_ = 9.5

		local var_50_0 = {
			zh = 3.4,
			ja = 9.5
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.35

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[1454].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_50_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_53_3 = arg_50_1:GetWordFromCfg(325071012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 14
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071012", "story_v_out_325071.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_325071", "325071012", "story_v_out_325071.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_325071", "325071012", "story_v_out_325071.awb")

						arg_50_1:RecordAudio("325071012", var_53_9)
						arg_50_1:RecordAudio("325071012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325071", "325071012", "story_v_out_325071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325071", "325071012", "story_v_out_325071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325071013
		arg_54_1.duration_ = 9.3

		local var_54_0 = {
			zh = 6.866,
			ja = 9.3
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1077ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1077ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_57_4 = 0
			local var_57_5 = 0.7

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_6 = arg_54_1:FormatText(StoryNameCfg[1467].name)

				arg_54_1.leftNameTxt_.text = var_57_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_7 = arg_54_1:GetWordFromCfg(325071013)
				local var_57_8 = arg_54_1:FormatText(var_57_7.content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 28
				local var_57_10 = utf8.len(var_57_8)
				local var_57_11 = var_57_9 <= 0 and var_57_5 or var_57_5 * (var_57_10 / var_57_9)

				if var_57_11 > 0 and var_57_5 < var_57_11 then
					arg_54_1.talkMaxDuration = var_57_11

					if var_57_11 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071013", "story_v_out_325071.awb") ~= 0 then
					local var_57_12 = manager.audio:GetVoiceLength("story_v_out_325071", "325071013", "story_v_out_325071.awb") / 1000

					if var_57_12 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_4
					end

					if var_57_7.prefab_name ~= "" and arg_54_1.actors_[var_57_7.prefab_name] ~= nil then
						local var_57_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_7.prefab_name].transform, "story_v_out_325071", "325071013", "story_v_out_325071.awb")

						arg_54_1:RecordAudio("325071013", var_57_13)
						arg_54_1:RecordAudio("325071013", var_57_13)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325071", "325071013", "story_v_out_325071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325071", "325071013", "story_v_out_325071.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_14 and arg_54_1.time_ < var_57_4 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325071014
		arg_58_1.duration_ = 7.47

		local var_58_0 = {
			zh = 5.3,
			ja = 7.466
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_61_2 = 0
			local var_61_3 = 0.725

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_4 = arg_58_1:FormatText(StoryNameCfg[1467].name)

				arg_58_1.leftNameTxt_.text = var_61_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:GetWordFromCfg(325071014)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 29
				local var_61_8 = utf8.len(var_61_6)
				local var_61_9 = var_61_7 <= 0 and var_61_3 or var_61_3 * (var_61_8 / var_61_7)

				if var_61_9 > 0 and var_61_3 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071014", "story_v_out_325071.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_325071", "325071014", "story_v_out_325071.awb") / 1000

					if var_61_10 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_2
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_325071", "325071014", "story_v_out_325071.awb")

						arg_58_1:RecordAudio("325071014", var_61_11)
						arg_58_1:RecordAudio("325071014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325071", "325071014", "story_v_out_325071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325071", "325071014", "story_v_out_325071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_12 and arg_58_1.time_ < var_61_2 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325071015
		arg_62_1.duration_ = 8.23

		local var_62_0 = {
			zh = 5.866,
			ja = 8.233
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1077ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1077ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1077ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1077ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1077ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.475

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[1454].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_62_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_65_9 = arg_62_1:GetWordFromCfg(325071015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 19
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071015", "story_v_out_325071.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_325071", "325071015", "story_v_out_325071.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_325071", "325071015", "story_v_out_325071.awb")

						arg_62_1:RecordAudio("325071015", var_65_15)
						arg_62_1:RecordAudio("325071015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325071", "325071015", "story_v_out_325071.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325071", "325071015", "story_v_out_325071.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play325071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325071016
		arg_66_1.duration_ = 11.1

		local var_66_0 = {
			zh = 8.89933333333333,
			ja = 11.0993333333333
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
				arg_66_0:Play325071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1077ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_69_4 = 1.1

			arg_66_1.isInRecall_ = false

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.screenFilterGo_:SetActive(false)

				for iter_69_0, iter_69_1 in pairs(arg_66_1.actors_) do
					local var_69_5 = iter_69_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_69_2, iter_69_3 in ipairs(var_69_5) do
						if iter_69_3.color.r > 0.51 then
							iter_69_3.color = Color.New(1, 1, 1)
						else
							iter_69_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_69_6 = 0.034000001847744

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_6 then
				local var_69_7 = (arg_66_1.time_ - var_69_4) / var_69_6

				arg_66_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_69_7)
			end

			if arg_66_1.time_ >= var_69_4 + var_69_6 and arg_66_1.time_ < var_69_4 + var_69_6 + arg_69_0 then
				arg_66_1.screenFilterEffect_.weight = 0
			end

			local var_69_8 = 1.1

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				local var_69_9 = manager.ui.mainCamera.transform.localPosition
				local var_69_10 = Vector3.New(0, 0, 10) + Vector3.New(var_69_9.x, var_69_9.y, 0)
				local var_69_11 = arg_66_1.bgs_.J23h

				var_69_11.transform.localPosition = var_69_10
				var_69_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_12 = var_69_11:GetComponent("SpriteRenderer")

				if var_69_12 and var_69_12.sprite then
					local var_69_13 = (var_69_11.transform.localPosition - var_69_9).z
					local var_69_14 = manager.ui.mainCameraCom_
					local var_69_15 = 2 * var_69_13 * Mathf.Tan(var_69_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_16 = var_69_15 * var_69_14.aspect
					local var_69_17 = var_69_12.sprite.bounds.size.x
					local var_69_18 = var_69_12.sprite.bounds.size.y
					local var_69_19 = var_69_16 / var_69_17
					local var_69_20 = var_69_15 / var_69_18
					local var_69_21 = var_69_20 < var_69_19 and var_69_19 or var_69_20

					var_69_11.transform.localScale = Vector3.New(var_69_21, var_69_21, 0)
				end

				for iter_69_4, iter_69_5 in pairs(arg_66_1.bgs_) do
					if iter_69_4 ~= "J23h" then
						iter_69_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_22 = 1.1

			if var_69_22 < arg_66_1.time_ and arg_66_1.time_ <= var_69_22 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_23 = 0.3

			if arg_66_1.time_ >= var_69_22 + var_69_23 and arg_66_1.time_ < var_69_22 + var_69_23 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_24 = 0

			if var_69_24 < arg_66_1.time_ and arg_66_1.time_ <= var_69_24 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_25 = 1.1

			if var_69_24 <= arg_66_1.time_ and arg_66_1.time_ < var_69_24 + var_69_25 then
				local var_69_26 = (arg_66_1.time_ - var_69_24) / var_69_25
				local var_69_27 = Color.New(0, 0, 0)

				var_69_27.a = Mathf.Lerp(0, 1, var_69_26)
				arg_66_1.mask_.color = var_69_27
			end

			if arg_66_1.time_ >= var_69_24 + var_69_25 and arg_66_1.time_ < var_69_24 + var_69_25 + arg_69_0 then
				local var_69_28 = Color.New(0, 0, 0)

				var_69_28.a = 1
				arg_66_1.mask_.color = var_69_28
			end

			local var_69_29 = 1.1

			if var_69_29 < arg_66_1.time_ and arg_66_1.time_ <= var_69_29 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_30 = 2

			if var_69_29 <= arg_66_1.time_ and arg_66_1.time_ < var_69_29 + var_69_30 then
				local var_69_31 = (arg_66_1.time_ - var_69_29) / var_69_30
				local var_69_32 = Color.New(0, 0, 0)

				var_69_32.a = Mathf.Lerp(1, 0, var_69_31)
				arg_66_1.mask_.color = var_69_32
			end

			if arg_66_1.time_ >= var_69_29 + var_69_30 and arg_66_1.time_ < var_69_29 + var_69_30 + arg_69_0 then
				local var_69_33 = Color.New(0, 0, 0)
				local var_69_34 = 0

				arg_66_1.mask_.enabled = false
				var_69_33.a = var_69_34
				arg_66_1.mask_.color = var_69_33
			end

			local var_69_35 = arg_66_1.actors_["1077ui_story"].transform
			local var_69_36 = 1.1

			if var_69_36 < arg_66_1.time_ and arg_66_1.time_ <= var_69_36 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_35.localPosition

				local var_69_37 = GameObjectTools.GetOrAddComponent(var_69_35.gameObject, typeof(DynamicBoneHelper))

				if var_69_37 then
					var_69_37:EnableDynamicBone(false)
				end
			end

			local var_69_38 = 0.001

			if var_69_36 <= arg_66_1.time_ and arg_66_1.time_ < var_69_36 + var_69_38 then
				local var_69_39 = (arg_66_1.time_ - var_69_36) / var_69_38
				local var_69_40 = Vector3.New(0, 100, 0)

				var_69_35.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, var_69_40, var_69_39)

				local var_69_41 = manager.ui.mainCamera.transform.position - var_69_35.position

				var_69_35.forward = Vector3.New(var_69_41.x, var_69_41.y, var_69_41.z)

				local var_69_42 = var_69_35.localEulerAngles

				var_69_42.z = 0
				var_69_42.x = 0
				var_69_35.localEulerAngles = var_69_42
			end

			if arg_66_1.time_ >= var_69_36 + var_69_38 and arg_66_1.time_ < var_69_36 + var_69_38 + arg_69_0 then
				var_69_35.localPosition = Vector3.New(0, 100, 0)

				local var_69_43 = manager.ui.mainCamera.transform.position - var_69_35.position

				var_69_35.forward = Vector3.New(var_69_43.x, var_69_43.y, var_69_43.z)

				local var_69_44 = var_69_35.localEulerAngles

				var_69_44.z = 0
				var_69_44.x = 0
				var_69_35.localEulerAngles = var_69_44

				local var_69_45 = GameObjectTools.GetOrAddComponent(var_69_35.gameObject, typeof(DynamicBoneHelper))

				if var_69_45 then
					var_69_45:EnableDynamicBone(true)
				end
			end

			local var_69_46 = arg_66_1.actors_["1077ui_story"].transform
			local var_69_47 = 2.73333333333333

			if var_69_47 < arg_66_1.time_ and arg_66_1.time_ <= var_69_47 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_46.localPosition

				local var_69_48 = GameObjectTools.GetOrAddComponent(var_69_46.gameObject, typeof(DynamicBoneHelper))

				if var_69_48 then
					var_69_48:EnableDynamicBone(false)
				end
			end

			local var_69_49 = 0.001

			if var_69_47 <= arg_66_1.time_ and arg_66_1.time_ < var_69_47 + var_69_49 then
				local var_69_50 = (arg_66_1.time_ - var_69_47) / var_69_49
				local var_69_51 = Vector3.New(-0.03, -1.02, -5.92)

				var_69_46.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, var_69_51, var_69_50)

				local var_69_52 = manager.ui.mainCamera.transform.position - var_69_46.position

				var_69_46.forward = Vector3.New(var_69_52.x, var_69_52.y, var_69_52.z)

				local var_69_53 = var_69_46.localEulerAngles

				var_69_53.z = 0
				var_69_53.x = 0
				var_69_46.localEulerAngles = var_69_53
			end

			if arg_66_1.time_ >= var_69_47 + var_69_49 and arg_66_1.time_ < var_69_47 + var_69_49 + arg_69_0 then
				var_69_46.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_69_54 = manager.ui.mainCamera.transform.position - var_69_46.position

				var_69_46.forward = Vector3.New(var_69_54.x, var_69_54.y, var_69_54.z)

				local var_69_55 = var_69_46.localEulerAngles

				var_69_55.z = 0
				var_69_55.x = 0
				var_69_46.localEulerAngles = var_69_55

				local var_69_56 = GameObjectTools.GetOrAddComponent(var_69_46.gameObject, typeof(DynamicBoneHelper))

				if var_69_56 then
					var_69_56:EnableDynamicBone(true)
				end
			end

			local var_69_57 = arg_66_1.actors_["1077ui_story"]
			local var_69_58 = 2.73333333333333

			if var_69_58 < arg_66_1.time_ and arg_66_1.time_ <= var_69_58 + arg_69_0 and not isNil(var_69_57) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_57:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_59 = 0.200000002980232

			if var_69_58 <= arg_66_1.time_ and arg_66_1.time_ < var_69_58 + var_69_59 and not isNil(var_69_57) then
				local var_69_60 = (arg_66_1.time_ - var_69_58) / var_69_59

				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_57) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_58 + var_69_59 and arg_66_1.time_ < var_69_58 + var_69_59 + arg_69_0 and not isNil(var_69_57) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_69_61 = 2.73333333333333

			if var_69_61 < arg_66_1.time_ and arg_66_1.time_ <= var_69_61 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_69_62 = 2.73333333333333

			if var_69_62 < arg_66_1.time_ and arg_66_1.time_ <= var_69_62 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_63 = 2.73333333333333
			local var_69_64 = 0.8

			if var_69_63 < arg_66_1.time_ and arg_66_1.time_ <= var_69_63 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_65 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_65:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_66 = arg_66_1:FormatText(StoryNameCfg[1467].name)

				arg_66_1.leftNameTxt_.text = var_69_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_67 = arg_66_1:GetWordFromCfg(325071016)
				local var_69_68 = arg_66_1:FormatText(var_69_67.content)

				arg_66_1.text_.text = var_69_68

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_69 = 32
				local var_69_70 = utf8.len(var_69_68)
				local var_69_71 = var_69_69 <= 0 and var_69_64 or var_69_64 * (var_69_70 / var_69_69)

				if var_69_71 > 0 and var_69_64 < var_69_71 then
					arg_66_1.talkMaxDuration = var_69_71
					var_69_63 = var_69_63 + 0.3

					if var_69_71 + var_69_63 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_71 + var_69_63
					end
				end

				arg_66_1.text_.text = var_69_68
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071016", "story_v_out_325071.awb") ~= 0 then
					local var_69_72 = manager.audio:GetVoiceLength("story_v_out_325071", "325071016", "story_v_out_325071.awb") / 1000

					if var_69_72 + var_69_63 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_72 + var_69_63
					end

					if var_69_67.prefab_name ~= "" and arg_66_1.actors_[var_69_67.prefab_name] ~= nil then
						local var_69_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_67.prefab_name].transform, "story_v_out_325071", "325071016", "story_v_out_325071.awb")

						arg_66_1:RecordAudio("325071016", var_69_73)
						arg_66_1:RecordAudio("325071016", var_69_73)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325071", "325071016", "story_v_out_325071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325071", "325071016", "story_v_out_325071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_74 = var_69_63 + 0.3
			local var_69_75 = math.max(var_69_64, arg_66_1.talkMaxDuration)

			if var_69_74 <= arg_66_1.time_ and arg_66_1.time_ < var_69_74 + var_69_75 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_74) / var_69_75

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_74 + var_69_75 and arg_66_1.time_ < var_69_74 + var_69_75 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play325071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325071017
		arg_72_1.duration_ = 4.4

		local var_72_0 = {
			zh = 3.1,
			ja = 4.4
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
				arg_72_0:Play325071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.4

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_4 = arg_72_1:FormatText(StoryNameCfg[1467].name)

				arg_72_1.leftNameTxt_.text = var_75_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(325071017)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 16
				local var_75_8 = utf8.len(var_75_6)
				local var_75_9 = var_75_7 <= 0 and var_75_3 or var_75_3 * (var_75_8 / var_75_7)

				if var_75_9 > 0 and var_75_3 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071017", "story_v_out_325071.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_325071", "325071017", "story_v_out_325071.awb") / 1000

					if var_75_10 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_2
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_out_325071", "325071017", "story_v_out_325071.awb")

						arg_72_1:RecordAudio("325071017", var_75_11)
						arg_72_1:RecordAudio("325071017", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325071", "325071017", "story_v_out_325071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325071", "325071017", "story_v_out_325071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_12 and arg_72_1.time_ < var_75_2 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325071018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325071018
		arg_76_1.duration_ = 8

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325071019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "ST2010"

			if arg_76_1.bgs_[var_79_0] == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			local var_79_2 = 1.56666666666667

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				local var_79_3 = manager.ui.mainCamera.transform.localPosition
				local var_79_4 = Vector3.New(0, 0, 10) + Vector3.New(var_79_3.x, var_79_3.y, 0)
				local var_79_5 = arg_76_1.bgs_.ST2010

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
					if iter_79_0 ~= "ST2010" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_16 = 1.56666666666667

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

			local var_79_19 = 1.56666666666667

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

			local var_79_23 = 1.56666666666667

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_24 = 2

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

			local var_79_29 = arg_76_1.actors_["1077ui_story"].transform
			local var_79_30 = 1.56666666666667

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 then
				arg_76_1.var_.moveOldPos1077ui_story = var_79_29.localPosition

				local var_79_31 = GameObjectTools.GetOrAddComponent(var_79_29.gameObject, typeof(DynamicBoneHelper))

				if var_79_31 then
					var_79_31:EnableDynamicBone(false)
				end
			end

			local var_79_32 = 0.001

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_32 then
				local var_79_33 = (arg_76_1.time_ - var_79_30) / var_79_32
				local var_79_34 = Vector3.New(0, 100, 0)

				var_79_29.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1077ui_story, var_79_34, var_79_33)

				local var_79_35 = manager.ui.mainCamera.transform.position - var_79_29.position

				var_79_29.forward = Vector3.New(var_79_35.x, var_79_35.y, var_79_35.z)

				local var_79_36 = var_79_29.localEulerAngles

				var_79_36.z = 0
				var_79_36.x = 0
				var_79_29.localEulerAngles = var_79_36
			end

			if arg_76_1.time_ >= var_79_30 + var_79_32 and arg_76_1.time_ < var_79_30 + var_79_32 + arg_79_0 then
				var_79_29.localPosition = Vector3.New(0, 100, 0)

				local var_79_37 = manager.ui.mainCamera.transform.position - var_79_29.position

				var_79_29.forward = Vector3.New(var_79_37.x, var_79_37.y, var_79_37.z)

				local var_79_38 = var_79_29.localEulerAngles

				var_79_38.z = 0
				var_79_38.x = 0
				var_79_29.localEulerAngles = var_79_38

				local var_79_39 = GameObjectTools.GetOrAddComponent(var_79_29.gameObject, typeof(DynamicBoneHelper))

				if var_79_39 then
					var_79_39:EnableDynamicBone(true)
				end
			end

			local var_79_40 = arg_76_1.actors_["1077ui_story"]
			local var_79_41 = 1.56666666666667

			if var_79_41 < arg_76_1.time_ and arg_76_1.time_ <= var_79_41 + arg_79_0 and not isNil(var_79_40) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = var_79_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_42 = 0.200000002980232

			if var_79_41 <= arg_76_1.time_ and arg_76_1.time_ < var_79_41 + var_79_42 and not isNil(var_79_40) then
				local var_79_43 = (arg_76_1.time_ - var_79_41) / var_79_42

				if arg_76_1.var_.characterEffect1077ui_story and not isNil(var_79_40) then
					local var_79_44 = Mathf.Lerp(0, 0.5, var_79_43)

					arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1077ui_story.fillRatio = var_79_44
				end
			end

			if arg_76_1.time_ >= var_79_41 + var_79_42 and arg_76_1.time_ < var_79_41 + var_79_42 + arg_79_0 and not isNil(var_79_40) and arg_76_1.var_.characterEffect1077ui_story then
				local var_79_45 = 0.5

				arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1077ui_story.fillRatio = var_79_45
			end

			local var_79_46 = 1.56666666666667

			arg_76_1.isInRecall_ = false

			if var_79_46 < arg_76_1.time_ and arg_76_1.time_ <= var_79_46 + arg_79_0 then
				arg_76_1.screenFilterGo_:SetActive(false)

				for iter_79_2, iter_79_3 in pairs(arg_76_1.actors_) do
					local var_79_47 = iter_79_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_79_4, iter_79_5 in ipairs(var_79_47) do
						if iter_79_5.color.r > 0.51 then
							iter_79_5.color = Color.New(1, 1, 1)
						else
							iter_79_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_79_48 = 0.034000001847744

			if var_79_46 <= arg_76_1.time_ and arg_76_1.time_ < var_79_46 + var_79_48 then
				local var_79_49 = (arg_76_1.time_ - var_79_46) / var_79_48

				arg_76_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_79_49)
			end

			if arg_76_1.time_ >= var_79_46 + var_79_48 and arg_76_1.time_ < var_79_46 + var_79_48 + arg_79_0 then
				arg_76_1.screenFilterEffect_.weight = 0
			end

			local var_79_50 = 0.1
			local var_79_51 = 1

			if var_79_50 < arg_76_1.time_ and arg_76_1.time_ <= var_79_50 + arg_79_0 then
				local var_79_52 = "play"
				local var_79_53 = "effect"

				arg_76_1:AudioAction(var_79_52, var_79_53, "se_story_140", "se_story_140_metal", "")
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_54 = 3
			local var_79_55 = 0.925

			if var_79_54 < arg_76_1.time_ and arg_76_1.time_ <= var_79_54 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_56 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_56:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_57 = arg_76_1:GetWordFromCfg(325071018)
				local var_79_58 = arg_76_1:FormatText(var_79_57.content)

				arg_76_1.text_.text = var_79_58

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_59 = 37
				local var_79_60 = utf8.len(var_79_58)
				local var_79_61 = var_79_59 <= 0 and var_79_55 or var_79_55 * (var_79_60 / var_79_59)

				if var_79_61 > 0 and var_79_55 < var_79_61 then
					arg_76_1.talkMaxDuration = var_79_61
					var_79_54 = var_79_54 + 0.3

					if var_79_61 + var_79_54 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_61 + var_79_54
					end
				end

				arg_76_1.text_.text = var_79_58
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_62 = var_79_54 + 0.3
			local var_79_63 = math.max(var_79_55, arg_76_1.talkMaxDuration)

			if var_79_62 <= arg_76_1.time_ and arg_76_1.time_ < var_79_62 + var_79_63 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_62) / var_79_63

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_62 + var_79_63 and arg_76_1.time_ < var_79_62 + var_79_63 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play325071019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325071019
		arg_82_1.duration_ = 6.7

		local var_82_0 = {
			zh = 5.3,
			ja = 6.7
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
				arg_82_0:Play325071020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1077ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1077ui_story = var_85_0.localPosition

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end
			end

			local var_85_3 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_3 then
				local var_85_4 = (arg_82_1.time_ - var_85_1) / var_85_3
				local var_85_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1077ui_story, var_85_5, var_85_4)

				local var_85_6 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_6.x, var_85_6.y, var_85_6.z)

				local var_85_7 = var_85_0.localEulerAngles

				var_85_7.z = 0
				var_85_7.x = 0
				var_85_0.localEulerAngles = var_85_7
			end

			if arg_82_1.time_ >= var_85_1 + var_85_3 and arg_82_1.time_ < var_85_1 + var_85_3 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_85_8 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_8.x, var_85_8.y, var_85_8.z)

				local var_85_9 = var_85_0.localEulerAngles

				var_85_9.z = 0
				var_85_9.x = 0
				var_85_0.localEulerAngles = var_85_9

				local var_85_10 = GameObjectTools.GetOrAddComponent(var_85_0.gameObject, typeof(DynamicBoneHelper))

				if var_85_10 then
					var_85_10:EnableDynamicBone(true)
				end
			end

			local var_85_11 = arg_82_1.actors_["1077ui_story"]
			local var_85_12 = 0

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1077ui_story == nil then
				arg_82_1.var_.characterEffect1077ui_story = var_85_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_13 = 0.200000002980232

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_13 and not isNil(var_85_11) then
				local var_85_14 = (arg_82_1.time_ - var_85_12) / var_85_13

				if arg_82_1.var_.characterEffect1077ui_story and not isNil(var_85_11) then
					arg_82_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_12 + var_85_13 and arg_82_1.time_ < var_85_12 + var_85_13 + arg_85_0 and not isNil(var_85_11) and arg_82_1.var_.characterEffect1077ui_story then
				arg_82_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_85_15 = 0
			local var_85_16 = 0.5

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[1467].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(325071019)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 20
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071019", "story_v_out_325071.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_325071", "325071019", "story_v_out_325071.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_325071", "325071019", "story_v_out_325071.awb")

						arg_82_1:RecordAudio("325071019", var_85_24)
						arg_82_1:RecordAudio("325071019", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325071", "325071019", "story_v_out_325071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325071", "325071019", "story_v_out_325071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325071020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325071020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325071021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1077ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1077ui_story = var_89_0.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_3 then
				local var_89_4 = (arg_86_1.time_ - var_89_1) / var_89_3
				local var_89_5 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1077ui_story, var_89_5, var_89_4)

				local var_89_6 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_6.x, var_89_6.y, var_89_6.z)

				local var_89_7 = var_89_0.localEulerAngles

				var_89_7.z = 0
				var_89_7.x = 0
				var_89_0.localEulerAngles = var_89_7
			end

			if arg_86_1.time_ >= var_89_1 + var_89_3 and arg_86_1.time_ < var_89_1 + var_89_3 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_8 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_8.x, var_89_8.y, var_89_8.z)

				local var_89_9 = var_89_0.localEulerAngles

				var_89_9.z = 0
				var_89_9.x = 0
				var_89_0.localEulerAngles = var_89_9

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["1077ui_story"]
			local var_89_12 = 0

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect1077ui_story == nil then
				arg_86_1.var_.characterEffect1077ui_story = var_89_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_13 = 0.200000002980232

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_13 and not isNil(var_89_11) then
				local var_89_14 = (arg_86_1.time_ - var_89_12) / var_89_13

				if arg_86_1.var_.characterEffect1077ui_story and not isNil(var_89_11) then
					local var_89_15 = Mathf.Lerp(0, 0.5, var_89_14)

					arg_86_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1077ui_story.fillRatio = var_89_15
				end
			end

			if arg_86_1.time_ >= var_89_12 + var_89_13 and arg_86_1.time_ < var_89_12 + var_89_13 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect1077ui_story then
				local var_89_16 = 0.5

				arg_86_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1077ui_story.fillRatio = var_89_16
			end

			local var_89_17 = 0.2
			local var_89_18 = 1

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				local var_89_19 = "play"
				local var_89_20 = "effect"

				arg_86_1:AudioAction(var_89_19, var_89_20, "se_story_123_01", "se_story_123_01_map", "")
			end

			local var_89_21 = 0
			local var_89_22 = 1

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_23 = arg_86_1:GetWordFromCfg(325071020)
				local var_89_24 = arg_86_1:FormatText(var_89_23.content)

				arg_86_1.text_.text = var_89_24

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_25 = 40
				local var_89_26 = utf8.len(var_89_24)
				local var_89_27 = var_89_25 <= 0 and var_89_22 or var_89_22 * (var_89_26 / var_89_25)

				if var_89_27 > 0 and var_89_22 < var_89_27 then
					arg_86_1.talkMaxDuration = var_89_27

					if var_89_27 + var_89_21 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_27 + var_89_21
					end
				end

				arg_86_1.text_.text = var_89_24
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_28 = math.max(var_89_22, arg_86_1.talkMaxDuration)

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_28 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_21) / var_89_28

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_21 + var_89_28 and arg_86_1.time_ < var_89_21 + var_89_28 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325071021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325071021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325071022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.825

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(325071021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 33
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325071022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325071022
		arg_94_1.duration_ = 3.37

		local var_94_0 = {
			zh = 3,
			ja = 3.366
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
			arg_94_1.auto_ = false
		end

		function arg_94_1.playNext_(arg_96_0)
			arg_94_1.onStoryFinished_()
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1077ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1077ui_story = var_97_0.localPosition

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end
			end

			local var_97_3 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_3 then
				local var_97_4 = (arg_94_1.time_ - var_97_1) / var_97_3
				local var_97_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1077ui_story, var_97_5, var_97_4)

				local var_97_6 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_6.x, var_97_6.y, var_97_6.z)

				local var_97_7 = var_97_0.localEulerAngles

				var_97_7.z = 0
				var_97_7.x = 0
				var_97_0.localEulerAngles = var_97_7
			end

			if arg_94_1.time_ >= var_97_1 + var_97_3 and arg_94_1.time_ < var_97_1 + var_97_3 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

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

			local var_97_11 = arg_94_1.actors_["1077ui_story"]
			local var_97_12 = 0

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_13 = 0.200000002980232

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_13 and not isNil(var_97_11) then
				local var_97_14 = (arg_94_1.time_ - var_97_12) / var_97_13

				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_11) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_12 + var_97_13 and arg_94_1.time_ < var_97_12 + var_97_13 + arg_97_0 and not isNil(var_97_11) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_97_17 = 0
			local var_97_18 = 1

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				local var_97_19 = "play"
				local var_97_20 = "effect"

				arg_94_1:AudioAction(var_97_19, var_97_20, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_97_21 = 0
			local var_97_22 = 0.2

			if var_97_21 < arg_94_1.time_ and arg_94_1.time_ <= var_97_21 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_23 = arg_94_1:FormatText(StoryNameCfg[1467].name)

				arg_94_1.leftNameTxt_.text = var_97_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_24 = arg_94_1:GetWordFromCfg(325071022)
				local var_97_25 = arg_94_1:FormatText(var_97_24.content)

				arg_94_1.text_.text = var_97_25

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_26 = 8
				local var_97_27 = utf8.len(var_97_25)
				local var_97_28 = var_97_26 <= 0 and var_97_22 or var_97_22 * (var_97_27 / var_97_26)

				if var_97_28 > 0 and var_97_22 < var_97_28 then
					arg_94_1.talkMaxDuration = var_97_28

					if var_97_28 + var_97_21 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_28 + var_97_21
					end
				end

				arg_94_1.text_.text = var_97_25
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325071", "325071022", "story_v_out_325071.awb") ~= 0 then
					local var_97_29 = manager.audio:GetVoiceLength("story_v_out_325071", "325071022", "story_v_out_325071.awb") / 1000

					if var_97_29 + var_97_21 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_29 + var_97_21
					end

					if var_97_24.prefab_name ~= "" and arg_94_1.actors_[var_97_24.prefab_name] ~= nil then
						local var_97_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_24.prefab_name].transform, "story_v_out_325071", "325071022", "story_v_out_325071.awb")

						arg_94_1:RecordAudio("325071022", var_97_30)
						arg_94_1:RecordAudio("325071022", var_97_30)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325071", "325071022", "story_v_out_325071.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325071", "325071022", "story_v_out_325071.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_31 = math.max(var_97_22, arg_94_1.talkMaxDuration)

			if var_97_21 <= arg_94_1.time_ and arg_94_1.time_ < var_97_21 + var_97_31 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_21) / var_97_31

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_21 + var_97_31 and arg_94_1.time_ < var_97_21 + var_97_31 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	assets = {
		"TextureConfig/Background/J23h",
		"TextureConfig/Background/ST2010"
	},
	voices = {
		"story_v_out_325071.awb"
	}
}
