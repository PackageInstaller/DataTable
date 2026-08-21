return {
	Play319611001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319611001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319611002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I10g"

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
				local var_4_5 = arg_1_1.bgs_.I10g

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
					if iter_4_0 ~= "I10g" then
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
			local var_4_23 = 0.0666666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "", "", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("", "")

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

			local var_4_28 = 0.1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

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
			local var_4_35 = 1

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

				local var_4_37 = arg_1_1:GetWordFromCfg(319611001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 40
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
	Play319611002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319611002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319611003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.025

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

				local var_12_2 = arg_9_1:GetWordFromCfg(319611002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 41
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
	Play319611003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319611003
		arg_13_1.duration_ = 3.93

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_13_0:Play319611004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10079ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10079ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10079ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.95, -6.05)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10079ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10079ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.175

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(319611003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 7
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611003", "story_v_out_319611.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_319611", "319611003", "story_v_out_319611.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_319611", "319611003", "story_v_out_319611.awb")

						arg_13_1:RecordAudio("319611003", var_16_29)
						arg_13_1:RecordAudio("319611003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319611", "319611003", "story_v_out_319611.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319611", "319611003", "story_v_out_319611.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319611004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319611004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319611005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10079ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10079ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10079ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10079ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.825

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:GetWordFromCfg(319611004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 33
				local var_20_11 = utf8.len(var_20_9)
				local var_20_12 = var_20_10 <= 0 and var_20_7 or var_20_7 * (var_20_11 / var_20_10)

				if var_20_12 > 0 and var_20_7 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_9
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_13 and arg_17_1.time_ < var_20_6 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319611005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319611005
		arg_21_1.duration_ = 6.37

		local var_21_0 = {
			zh = 4.9,
			ja = 6.366
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
				arg_21_0:Play319611006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10079ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10079ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10079ui_story then
				arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.65

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_6 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(319611005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 26
				local var_24_10 = utf8.len(var_24_8)
				local var_24_11 = var_24_9 <= 0 and var_24_5 or var_24_5 * (var_24_10 / var_24_9)

				if var_24_11 > 0 and var_24_5 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611005", "story_v_out_319611.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_319611", "319611005", "story_v_out_319611.awb") / 1000

					if var_24_12 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_4
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_319611", "319611005", "story_v_out_319611.awb")

						arg_21_1:RecordAudio("319611005", var_24_13)
						arg_21_1:RecordAudio("319611005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319611", "319611005", "story_v_out_319611.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319611", "319611005", "story_v_out_319611.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_14 and arg_21_1.time_ < var_24_4 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319611006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319611006
		arg_25_1.duration_ = 10.43

		local var_25_0 = {
			zh = 5.3,
			ja = 10.433
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
				arg_25_0:Play319611007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.7

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(319611006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611006", "story_v_out_319611.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611006", "story_v_out_319611.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_319611", "319611006", "story_v_out_319611.awb")

						arg_25_1:RecordAudio("319611006", var_28_9)
						arg_25_1:RecordAudio("319611006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319611", "319611006", "story_v_out_319611.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319611", "319611006", "story_v_out_319611.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319611007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319611007
		arg_29_1.duration_ = 4.3

		local var_29_0 = {
			zh = 3.3,
			ja = 4.3
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
				arg_29_0:Play319611008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "4040ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["4040ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos4040ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0.7, -1.55, -5.5)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos4040ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = arg_29_1.actors_["4040ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.200000002980232

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect4040ui_story then
				arg_29_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_20 = arg_29_1.actors_["10079ui_story"].transform
			local var_32_21 = 0

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.var_.moveOldPos10079ui_story = var_32_20.localPosition
			end

			local var_32_22 = 0.001

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_22 then
				local var_32_23 = (arg_29_1.time_ - var_32_21) / var_32_22
				local var_32_24 = Vector3.New(-0.7, -0.95, -6.05)

				var_32_20.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10079ui_story, var_32_24, var_32_23)

				local var_32_25 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_25.x, var_32_25.y, var_32_25.z)

				local var_32_26 = var_32_20.localEulerAngles

				var_32_26.z = 0
				var_32_26.x = 0
				var_32_20.localEulerAngles = var_32_26
			end

			if arg_29_1.time_ >= var_32_21 + var_32_22 and arg_29_1.time_ < var_32_21 + var_32_22 + arg_32_0 then
				var_32_20.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_32_27 = manager.ui.mainCamera.transform.position - var_32_20.position

				var_32_20.forward = Vector3.New(var_32_27.x, var_32_27.y, var_32_27.z)

				local var_32_28 = var_32_20.localEulerAngles

				var_32_28.z = 0
				var_32_28.x = 0
				var_32_20.localEulerAngles = var_32_28
			end

			local var_32_29 = arg_29_1.actors_["10079ui_story"]
			local var_32_30 = 0

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect10079ui_story == nil then
				arg_29_1.var_.characterEffect10079ui_story = var_32_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_31 = 0.200000002980232

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_31 and not isNil(var_32_29) then
				local var_32_32 = (arg_29_1.time_ - var_32_30) / var_32_31

				if arg_29_1.var_.characterEffect10079ui_story and not isNil(var_32_29) then
					local var_32_33 = Mathf.Lerp(0, 0.5, var_32_32)

					arg_29_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10079ui_story.fillRatio = var_32_33
				end
			end

			if arg_29_1.time_ >= var_32_30 + var_32_31 and arg_29_1.time_ < var_32_30 + var_32_31 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect10079ui_story then
				local var_32_34 = 0.5

				arg_29_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10079ui_story.fillRatio = var_32_34
			end

			local var_32_35 = 0
			local var_32_36 = 0.225

			if var_32_35 < arg_29_1.time_ and arg_29_1.time_ <= var_32_35 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_37 = arg_29_1:FormatText(StoryNameCfg[668].name)

				arg_29_1.leftNameTxt_.text = var_32_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_38 = arg_29_1:GetWordFromCfg(319611007)
				local var_32_39 = arg_29_1:FormatText(var_32_38.content)

				arg_29_1.text_.text = var_32_39

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_40 = 9
				local var_32_41 = utf8.len(var_32_39)
				local var_32_42 = var_32_40 <= 0 and var_32_36 or var_32_36 * (var_32_41 / var_32_40)

				if var_32_42 > 0 and var_32_36 < var_32_42 then
					arg_29_1.talkMaxDuration = var_32_42

					if var_32_42 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_42 + var_32_35
					end
				end

				arg_29_1.text_.text = var_32_39
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611007", "story_v_out_319611.awb") ~= 0 then
					local var_32_43 = manager.audio:GetVoiceLength("story_v_out_319611", "319611007", "story_v_out_319611.awb") / 1000

					if var_32_43 + var_32_35 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_43 + var_32_35
					end

					if var_32_38.prefab_name ~= "" and arg_29_1.actors_[var_32_38.prefab_name] ~= nil then
						local var_32_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_38.prefab_name].transform, "story_v_out_319611", "319611007", "story_v_out_319611.awb")

						arg_29_1:RecordAudio("319611007", var_32_44)
						arg_29_1:RecordAudio("319611007", var_32_44)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319611", "319611007", "story_v_out_319611.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319611", "319611007", "story_v_out_319611.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_45 = math.max(var_32_36, arg_29_1.talkMaxDuration)

			if var_32_35 <= arg_29_1.time_ and arg_29_1.time_ < var_32_35 + var_32_45 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_35) / var_32_45

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_35 + var_32_45 and arg_29_1.time_ < var_32_35 + var_32_45 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play319611008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319611008
		arg_33_1.duration_ = 3.7

		local var_33_0 = {
			zh = 2.333,
			ja = 3.7
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
				arg_33_0:Play319611009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["4040ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect4040ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4040ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect4040ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4040ui_story.fillRatio = var_36_5
			end

			local var_36_6 = arg_33_1.actors_["10079ui_story"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10079ui_story == nil then
				arg_33_1.var_.characterEffect10079ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 and not isNil(var_36_6) then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8

				if arg_33_1.var_.characterEffect10079ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10079ui_story then
				arg_33_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_36_10 = 0
			local var_36_11 = 0.2

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_12 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:GetWordFromCfg(319611008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 8
				local var_36_16 = utf8.len(var_36_14)
				local var_36_17 = var_36_15 <= 0 and var_36_11 or var_36_11 * (var_36_16 / var_36_15)

				if var_36_17 > 0 and var_36_11 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611008", "story_v_out_319611.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_319611", "319611008", "story_v_out_319611.awb") / 1000

					if var_36_18 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_10
					end

					if var_36_13.prefab_name ~= "" and arg_33_1.actors_[var_36_13.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_13.prefab_name].transform, "story_v_out_319611", "319611008", "story_v_out_319611.awb")

						arg_33_1:RecordAudio("319611008", var_36_19)
						arg_33_1:RecordAudio("319611008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319611", "319611008", "story_v_out_319611.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319611", "319611008", "story_v_out_319611.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_20 and arg_33_1.time_ < var_36_10 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319611009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319611009
		arg_37_1.duration_ = 8.4

		local var_37_0 = {
			zh = 3.5,
			ja = 8.4
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
				arg_37_0:Play319611010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["4040ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["10079ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10079ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10079ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10079ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0
			local var_40_11 = 0.35

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_12 = arg_37_1:FormatText(StoryNameCfg[668].name)

				arg_37_1.leftNameTxt_.text = var_40_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(319611009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 14
				local var_40_16 = utf8.len(var_40_14)
				local var_40_17 = var_40_15 <= 0 and var_40_11 or var_40_11 * (var_40_16 / var_40_15)

				if var_40_17 > 0 and var_40_11 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611009", "story_v_out_319611.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_319611", "319611009", "story_v_out_319611.awb") / 1000

					if var_40_18 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_10
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_319611", "319611009", "story_v_out_319611.awb")

						arg_37_1:RecordAudio("319611009", var_40_19)
						arg_37_1:RecordAudio("319611009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319611", "319611009", "story_v_out_319611.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319611", "319611009", "story_v_out_319611.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_10) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_10 + var_40_20 and arg_37_1.time_ < var_40_10 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319611010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319611010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319611011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["4040ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect4040ui_story == nil then
				arg_41_1.var_.characterEffect4040ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect4040ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_41_1.var_.characterEffect4040ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect4040ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_41_1.var_.characterEffect4040ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.5

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

				local var_44_8 = arg_41_1:GetWordFromCfg(319611010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 20
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
	Play319611011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319611011
		arg_45_1.duration_ = 13.03

		local var_45_0 = {
			zh = 2.266,
			ja = 13.033
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
				arg_45_0:Play319611012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["4040ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.7, -1.55, -5.5)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["4040ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_15 = 0
			local var_48_16 = 0.25

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[668].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(319611011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611011", "story_v_out_319611.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_319611", "319611011", "story_v_out_319611.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_319611", "319611011", "story_v_out_319611.awb")

						arg_45_1:RecordAudio("319611011", var_48_24)
						arg_45_1:RecordAudio("319611011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319611", "319611011", "story_v_out_319611.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319611", "319611011", "story_v_out_319611.awb")
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
				actorName = "4040ui_story",
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
	Play319611012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319611012
		arg_49_1.duration_ = 4.87

		local var_49_0 = {
			zh = 3.1,
			ja = 4.866
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
				arg_49_0:Play319611013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10079ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10079ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10079ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10079ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10079ui_story == nil then
				arg_49_1.var_.characterEffect10079ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect10079ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10079ui_story then
				arg_49_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = arg_49_1.actors_["4040ui_story"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect4040ui_story == nil then
				arg_49_1.var_.characterEffect4040ui_story = var_52_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_17 = 0.200000002980232

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.characterEffect4040ui_story and not isNil(var_52_15) then
					local var_52_19 = Mathf.Lerp(0, 0.5, var_52_18)

					arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_49_1.var_.characterEffect4040ui_story.fillRatio = var_52_19
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect4040ui_story then
				local var_52_20 = 0.5

				arg_49_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_49_1.var_.characterEffect4040ui_story.fillRatio = var_52_20
			end

			local var_52_21 = 0
			local var_52_22 = 0.3

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_23 = arg_49_1:FormatText(StoryNameCfg[6].name)

				arg_49_1.leftNameTxt_.text = var_52_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(319611012)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_26 = 12
				local var_52_27 = utf8.len(var_52_25)
				local var_52_28 = var_52_26 <= 0 and var_52_22 or var_52_22 * (var_52_27 / var_52_26)

				if var_52_28 > 0 and var_52_22 < var_52_28 then
					arg_49_1.talkMaxDuration = var_52_28

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611012", "story_v_out_319611.awb") ~= 0 then
					local var_52_29 = manager.audio:GetVoiceLength("story_v_out_319611", "319611012", "story_v_out_319611.awb") / 1000

					if var_52_29 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_29 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_319611", "319611012", "story_v_out_319611.awb")

						arg_49_1:RecordAudio("319611012", var_52_30)
						arg_49_1:RecordAudio("319611012", var_52_30)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319611", "319611012", "story_v_out_319611.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319611", "319611012", "story_v_out_319611.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_21) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_21 + var_52_31 and arg_49_1.time_ < var_52_21 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319611013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319611013
		arg_53_1.duration_ = 4.03

		local var_53_0 = {
			zh = 2.066,
			ja = 4.033
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
				arg_53_0:Play319611014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10079ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10079ui_story == nil then
				arg_53_1.var_.characterEffect10079ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10079ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10079ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10079ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10079ui_story.fillRatio = var_56_5
			end

			local var_56_6 = arg_53_1.actors_["4040ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect4040ui_story then
				arg_53_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_56_10 = 0
			local var_56_11 = 0.225

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_12 = arg_53_1:FormatText(StoryNameCfg[668].name)

				arg_53_1.leftNameTxt_.text = var_56_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_13 = arg_53_1:GetWordFromCfg(319611013)
				local var_56_14 = arg_53_1:FormatText(var_56_13.content)

				arg_53_1.text_.text = var_56_14

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_15 = 9
				local var_56_16 = utf8.len(var_56_14)
				local var_56_17 = var_56_15 <= 0 and var_56_11 or var_56_11 * (var_56_16 / var_56_15)

				if var_56_17 > 0 and var_56_11 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_10
					end
				end

				arg_53_1.text_.text = var_56_14
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611013", "story_v_out_319611.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_319611", "319611013", "story_v_out_319611.awb") / 1000

					if var_56_18 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_10
					end

					if var_56_13.prefab_name ~= "" and arg_53_1.actors_[var_56_13.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_13.prefab_name].transform, "story_v_out_319611", "319611013", "story_v_out_319611.awb")

						arg_53_1:RecordAudio("319611013", var_56_19)
						arg_53_1:RecordAudio("319611013", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319611", "319611013", "story_v_out_319611.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319611", "319611013", "story_v_out_319611.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = math.max(var_56_11, arg_53_1.talkMaxDuration)

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_20 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_10) / var_56_20

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_10 + var_56_20 and arg_53_1.time_ < var_56_10 + var_56_20 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319611014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319611014
		arg_57_1.duration_ = 2.97

		local var_57_0 = {
			zh = 2.966,
			ja = 1.999999999999
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
				arg_57_0:Play319611015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["4040ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect4040ui_story == nil then
				arg_57_1.var_.characterEffect4040ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect4040ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_57_1.var_.characterEffect4040ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect4040ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_57_1.var_.characterEffect4040ui_story.fillRatio = var_60_5
			end

			local var_60_6 = arg_57_1.actors_["10079ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect10079ui_story == nil then
				arg_57_1.var_.characterEffect10079ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect10079ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect10079ui_story then
				arg_57_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_60_12 = 0
			local var_60_13 = 0.325

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(319611014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 13
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_13 or var_60_13 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_13 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611014", "story_v_out_319611.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_319611", "319611014", "story_v_out_319611.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_319611", "319611014", "story_v_out_319611.awb")

						arg_57_1:RecordAudio("319611014", var_60_21)
						arg_57_1:RecordAudio("319611014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319611", "319611014", "story_v_out_319611.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319611", "319611014", "story_v_out_319611.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_22 and arg_57_1.time_ < var_60_12 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319611015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319611015
		arg_61_1.duration_ = 10.47

		local var_61_0 = {
			zh = 3.8,
			ja = 10.466
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
				arg_61_0:Play319611016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["4040ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos4040ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.7, -1.55, -5.5)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos4040ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["4040ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect4040ui_story == nil then
				arg_61_1.var_.characterEffect4040ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect4040ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect4040ui_story then
				arg_61_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_15 = arg_61_1.actors_["10079ui_story"]
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_17 = 0.200000002980232

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 and not isNil(var_64_15) then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17

				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_15) then
					local var_64_19 = Mathf.Lerp(0, 0.5, var_64_18)

					arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10079ui_story.fillRatio = var_64_19
				end
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.characterEffect10079ui_story then
				local var_64_20 = 0.5

				arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10079ui_story.fillRatio = var_64_20
			end

			local var_64_21 = 0
			local var_64_22 = 0.35

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_23 = arg_61_1:FormatText(StoryNameCfg[668].name)

				arg_61_1.leftNameTxt_.text = var_64_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_24 = arg_61_1:GetWordFromCfg(319611015)
				local var_64_25 = arg_61_1:FormatText(var_64_24.content)

				arg_61_1.text_.text = var_64_25

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_26 = 14
				local var_64_27 = utf8.len(var_64_25)
				local var_64_28 = var_64_26 <= 0 and var_64_22 or var_64_22 * (var_64_27 / var_64_26)

				if var_64_28 > 0 and var_64_22 < var_64_28 then
					arg_61_1.talkMaxDuration = var_64_28

					if var_64_28 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_21
					end
				end

				arg_61_1.text_.text = var_64_25
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611015", "story_v_out_319611.awb") ~= 0 then
					local var_64_29 = manager.audio:GetVoiceLength("story_v_out_319611", "319611015", "story_v_out_319611.awb") / 1000

					if var_64_29 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_21
					end

					if var_64_24.prefab_name ~= "" and arg_61_1.actors_[var_64_24.prefab_name] ~= nil then
						local var_64_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_24.prefab_name].transform, "story_v_out_319611", "319611015", "story_v_out_319611.awb")

						arg_61_1:RecordAudio("319611015", var_64_30)
						arg_61_1:RecordAudio("319611015", var_64_30)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319611", "319611015", "story_v_out_319611.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319611", "319611015", "story_v_out_319611.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_31 = math.max(var_64_22, arg_61_1.talkMaxDuration)

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_31 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_21) / var_64_31

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_21 + var_64_31 and arg_61_1.time_ < var_64_21 + var_64_31 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play319611016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319611016
		arg_65_1.duration_ = 14.37

		local var_65_0 = {
			zh = 8.1,
			ja = 14.366
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
				arg_65_0:Play319611017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.7

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[668].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(319611016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611016", "story_v_out_319611.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611016", "story_v_out_319611.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_319611", "319611016", "story_v_out_319611.awb")

						arg_65_1:RecordAudio("319611016", var_68_9)
						arg_65_1:RecordAudio("319611016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319611", "319611016", "story_v_out_319611.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319611", "319611016", "story_v_out_319611.awb")
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
	Play319611017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319611017
		arg_69_1.duration_ = 13.07

		local var_69_0 = {
			zh = 7.633,
			ja = 13.066
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
				arg_69_0:Play319611018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.725

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[668].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(319611017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611017", "story_v_out_319611.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611017", "story_v_out_319611.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_319611", "319611017", "story_v_out_319611.awb")

						arg_69_1:RecordAudio("319611017", var_72_9)
						arg_69_1:RecordAudio("319611017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319611", "319611017", "story_v_out_319611.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319611", "319611017", "story_v_out_319611.awb")
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
	Play319611018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319611018
		arg_73_1.duration_ = 8.4

		local var_73_0 = {
			zh = 6.733,
			ja = 8.4
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
				arg_73_0:Play319611019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10079ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10079ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10079ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["10079ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10079ui_story == nil then
				arg_73_1.var_.characterEffect10079ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect10079ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10079ui_story then
				arg_73_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4413")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_15 = arg_73_1.actors_["4040ui_story"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect4040ui_story == nil then
				arg_73_1.var_.characterEffect4040ui_story = var_76_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_17 = 0.200000002980232

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.characterEffect4040ui_story and not isNil(var_76_15) then
					local var_76_19 = Mathf.Lerp(0, 0.5, var_76_18)

					arg_73_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_73_1.var_.characterEffect4040ui_story.fillRatio = var_76_19
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect4040ui_story then
				local var_76_20 = 0.5

				arg_73_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_73_1.var_.characterEffect4040ui_story.fillRatio = var_76_20
			end

			local var_76_21 = 0
			local var_76_22 = 0.85

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_23 = arg_73_1:FormatText(StoryNameCfg[6].name)

				arg_73_1.leftNameTxt_.text = var_76_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:GetWordFromCfg(319611018)
				local var_76_25 = arg_73_1:FormatText(var_76_24.content)

				arg_73_1.text_.text = var_76_25

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 34
				local var_76_27 = utf8.len(var_76_25)
				local var_76_28 = var_76_26 <= 0 and var_76_22 or var_76_22 * (var_76_27 / var_76_26)

				if var_76_28 > 0 and var_76_22 < var_76_28 then
					arg_73_1.talkMaxDuration = var_76_28

					if var_76_28 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_28 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_25
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611018", "story_v_out_319611.awb") ~= 0 then
					local var_76_29 = manager.audio:GetVoiceLength("story_v_out_319611", "319611018", "story_v_out_319611.awb") / 1000

					if var_76_29 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_21
					end

					if var_76_24.prefab_name ~= "" and arg_73_1.actors_[var_76_24.prefab_name] ~= nil then
						local var_76_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_24.prefab_name].transform, "story_v_out_319611", "319611018", "story_v_out_319611.awb")

						arg_73_1:RecordAudio("319611018", var_76_30)
						arg_73_1:RecordAudio("319611018", var_76_30)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319611", "319611018", "story_v_out_319611.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319611", "319611018", "story_v_out_319611.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_21) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_21 + var_76_31 and arg_73_1.time_ < var_76_21 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319611019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319611019
		arg_77_1.duration_ = 10.27

		local var_77_0 = {
			zh = 4.3,
			ja = 10.266
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
				arg_77_0:Play319611020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.6

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(319611019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611019", "story_v_out_319611.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611019", "story_v_out_319611.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_319611", "319611019", "story_v_out_319611.awb")

						arg_77_1:RecordAudio("319611019", var_80_9)
						arg_77_1:RecordAudio("319611019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319611", "319611019", "story_v_out_319611.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319611", "319611019", "story_v_out_319611.awb")
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
	Play319611020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319611020
		arg_81_1.duration_ = 5.13

		local var_81_0 = {
			zh = 2.866,
			ja = 5.133
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
				arg_81_0:Play319611021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["4040ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos4040ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0.7, -1.55, -5.5)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos4040ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["4040ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect4040ui_story == nil then
				arg_81_1.var_.characterEffect4040ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect4040ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect4040ui_story then
				arg_81_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_84_15 = arg_81_1.actors_["10079ui_story"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect10079ui_story == nil then
				arg_81_1.var_.characterEffect10079ui_story = var_84_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_17 = 0.200000002980232

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.characterEffect10079ui_story and not isNil(var_84_15) then
					local var_84_19 = Mathf.Lerp(0, 0.5, var_84_18)

					arg_81_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10079ui_story.fillRatio = var_84_19
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.characterEffect10079ui_story then
				local var_84_20 = 0.5

				arg_81_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10079ui_story.fillRatio = var_84_20
			end

			local var_84_21 = 0
			local var_84_22 = 0.4

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_23 = arg_81_1:FormatText(StoryNameCfg[668].name)

				arg_81_1.leftNameTxt_.text = var_84_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(319611020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 16
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_22 or var_84_22 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_22 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_21
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611020", "story_v_out_319611.awb") ~= 0 then
					local var_84_29 = manager.audio:GetVoiceLength("story_v_out_319611", "319611020", "story_v_out_319611.awb") / 1000

					if var_84_29 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_21
					end

					if var_84_24.prefab_name ~= "" and arg_81_1.actors_[var_84_24.prefab_name] ~= nil then
						local var_84_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_24.prefab_name].transform, "story_v_out_319611", "319611020", "story_v_out_319611.awb")

						arg_81_1:RecordAudio("319611020", var_84_30)
						arg_81_1:RecordAudio("319611020", var_84_30)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319611", "319611020", "story_v_out_319611.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319611", "319611020", "story_v_out_319611.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = math.max(var_84_22, arg_81_1.talkMaxDuration)

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_31 and arg_81_1.time_ < var_84_21 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play319611021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319611021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319611022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["4040ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4040ui_story == nil then
				arg_85_1.var_.characterEffect4040ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect4040ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_85_1.var_.characterEffect4040ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect4040ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_85_1.var_.characterEffect4040ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 1

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(319611021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 40
				local var_88_11 = utf8.len(var_88_9)
				local var_88_12 = var_88_10 <= 0 and var_88_7 or var_88_7 * (var_88_11 / var_88_10)

				if var_88_12 > 0 and var_88_7 < var_88_12 then
					arg_85_1.talkMaxDuration = var_88_12

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_13 and arg_85_1.time_ < var_88_6 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319611022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319611022
		arg_89_1.duration_ = 16.27

		local var_89_0 = {
			zh = 11.566,
			ja = 16.266
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
				arg_89_0:Play319611023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["4040ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect4040ui_story == nil then
				arg_89_1.var_.characterEffect4040ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect4040ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect4040ui_story then
				arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_92_5 = 0
			local var_92_6 = 1.225

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_7 = arg_89_1:FormatText(StoryNameCfg[668].name)

				arg_89_1.leftNameTxt_.text = var_92_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(319611022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 49
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_6 or var_92_6 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_6 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611022", "story_v_out_319611.awb") ~= 0 then
					local var_92_13 = manager.audio:GetVoiceLength("story_v_out_319611", "319611022", "story_v_out_319611.awb") / 1000

					if var_92_13 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_5
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_319611", "319611022", "story_v_out_319611.awb")

						arg_89_1:RecordAudio("319611022", var_92_14)
						arg_89_1:RecordAudio("319611022", var_92_14)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319611", "319611022", "story_v_out_319611.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319611", "319611022", "story_v_out_319611.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_15 and arg_89_1.time_ < var_92_5 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319611023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319611023
		arg_93_1.duration_ = 16.57

		local var_93_0 = {
			zh = 14.233,
			ja = 16.566
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
				arg_93_0:Play319611024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.275

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[668].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(319611023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611023", "story_v_out_319611.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611023", "story_v_out_319611.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_319611", "319611023", "story_v_out_319611.awb")

						arg_93_1:RecordAudio("319611023", var_96_9)
						arg_93_1:RecordAudio("319611023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319611", "319611023", "story_v_out_319611.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319611", "319611023", "story_v_out_319611.awb")
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
	Play319611024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319611024
		arg_97_1.duration_ = 7.2

		local var_97_0 = {
			zh = 2.866,
			ja = 7.2
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
				arg_97_0:Play319611025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10079ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10079ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10079ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10079ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10079ui_story == nil then
				arg_97_1.var_.characterEffect10079ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10079ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10079ui_story then
				arg_97_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_100_15 = arg_97_1.actors_["4040ui_story"]
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect4040ui_story == nil then
				arg_97_1.var_.characterEffect4040ui_story = var_100_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_17 = 0.200000002980232

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 and not isNil(var_100_15) then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17

				if arg_97_1.var_.characterEffect4040ui_story and not isNil(var_100_15) then
					local var_100_19 = Mathf.Lerp(0, 0.5, var_100_18)

					arg_97_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_97_1.var_.characterEffect4040ui_story.fillRatio = var_100_19
				end
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect4040ui_story then
				local var_100_20 = 0.5

				arg_97_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_97_1.var_.characterEffect4040ui_story.fillRatio = var_100_20
			end

			local var_100_21 = 0
			local var_100_22 = 0.3

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_23 = arg_97_1:FormatText(StoryNameCfg[6].name)

				arg_97_1.leftNameTxt_.text = var_100_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_24 = arg_97_1:GetWordFromCfg(319611024)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 12
				local var_100_27 = utf8.len(var_100_25)
				local var_100_28 = var_100_26 <= 0 and var_100_22 or var_100_22 * (var_100_27 / var_100_26)

				if var_100_28 > 0 and var_100_22 < var_100_28 then
					arg_97_1.talkMaxDuration = var_100_28

					if var_100_28 + var_100_21 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_28 + var_100_21
					end
				end

				arg_97_1.text_.text = var_100_25
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611024", "story_v_out_319611.awb") ~= 0 then
					local var_100_29 = manager.audio:GetVoiceLength("story_v_out_319611", "319611024", "story_v_out_319611.awb") / 1000

					if var_100_29 + var_100_21 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_29 + var_100_21
					end

					if var_100_24.prefab_name ~= "" and arg_97_1.actors_[var_100_24.prefab_name] ~= nil then
						local var_100_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_24.prefab_name].transform, "story_v_out_319611", "319611024", "story_v_out_319611.awb")

						arg_97_1:RecordAudio("319611024", var_100_30)
						arg_97_1:RecordAudio("319611024", var_100_30)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319611", "319611024", "story_v_out_319611.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319611", "319611024", "story_v_out_319611.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_31 = math.max(var_100_22, arg_97_1.talkMaxDuration)

			if var_100_21 <= arg_97_1.time_ and arg_97_1.time_ < var_100_21 + var_100_31 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_21) / var_100_31

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_21 + var_100_31 and arg_97_1.time_ < var_100_21 + var_100_31 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319611025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319611025
		arg_101_1.duration_ = 16.73

		local var_101_0 = {
			zh = 13.266,
			ja = 16.733
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
				arg_101_0:Play319611026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["4040ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos4040ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0.7, -1.55, -5.5)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos4040ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["4040ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect4040ui_story == nil then
				arg_101_1.var_.characterEffect4040ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect4040ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect4040ui_story then
				arg_101_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_104_15 = arg_101_1.actors_["10079ui_story"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.characterEffect10079ui_story == nil then
				arg_101_1.var_.characterEffect10079ui_story = var_104_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_17 = 0.200000002980232

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.characterEffect10079ui_story and not isNil(var_104_15) then
					local var_104_19 = Mathf.Lerp(0, 0.5, var_104_18)

					arg_101_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10079ui_story.fillRatio = var_104_19
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.characterEffect10079ui_story then
				local var_104_20 = 0.5

				arg_101_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10079ui_story.fillRatio = var_104_20
			end

			local var_104_21 = 0
			local var_104_22 = 1.2

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_23 = arg_101_1:FormatText(StoryNameCfg[668].name)

				arg_101_1.leftNameTxt_.text = var_104_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:GetWordFromCfg(319611025)
				local var_104_25 = arg_101_1:FormatText(var_104_24.content)

				arg_101_1.text_.text = var_104_25

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_26 = 48
				local var_104_27 = utf8.len(var_104_25)
				local var_104_28 = var_104_26 <= 0 and var_104_22 or var_104_22 * (var_104_27 / var_104_26)

				if var_104_28 > 0 and var_104_22 < var_104_28 then
					arg_101_1.talkMaxDuration = var_104_28

					if var_104_28 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_21
					end
				end

				arg_101_1.text_.text = var_104_25
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611025", "story_v_out_319611.awb") ~= 0 then
					local var_104_29 = manager.audio:GetVoiceLength("story_v_out_319611", "319611025", "story_v_out_319611.awb") / 1000

					if var_104_29 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_29 + var_104_21
					end

					if var_104_24.prefab_name ~= "" and arg_101_1.actors_[var_104_24.prefab_name] ~= nil then
						local var_104_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_24.prefab_name].transform, "story_v_out_319611", "319611025", "story_v_out_319611.awb")

						arg_101_1:RecordAudio("319611025", var_104_30)
						arg_101_1:RecordAudio("319611025", var_104_30)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319611", "319611025", "story_v_out_319611.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319611", "319611025", "story_v_out_319611.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_31 = math.max(var_104_22, arg_101_1.talkMaxDuration)

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_31 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_21) / var_104_31

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_21 + var_104_31 and arg_101_1.time_ < var_104_21 + var_104_31 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319611026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319611026
		arg_105_1.duration_ = 15.43

		local var_105_0 = {
			zh = 10,
			ja = 15.433
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
				arg_105_0:Play319611027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.075

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[668].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(319611026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611026", "story_v_out_319611.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611026", "story_v_out_319611.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_319611", "319611026", "story_v_out_319611.awb")

						arg_105_1:RecordAudio("319611026", var_108_9)
						arg_105_1:RecordAudio("319611026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319611", "319611026", "story_v_out_319611.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319611", "319611026", "story_v_out_319611.awb")
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
	Play319611027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319611027
		arg_109_1.duration_ = 12.83

		local var_109_0 = {
			zh = 5.733,
			ja = 12.833
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
				arg_109_0:Play319611028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040actionlink/4040action434")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.525

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_4 = arg_109_1:FormatText(StoryNameCfg[668].name)

				arg_109_1.leftNameTxt_.text = var_112_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(319611027)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 21
				local var_112_8 = utf8.len(var_112_6)
				local var_112_9 = var_112_7 <= 0 and var_112_3 or var_112_3 * (var_112_8 / var_112_7)

				if var_112_9 > 0 and var_112_3 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611027", "story_v_out_319611.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_319611", "319611027", "story_v_out_319611.awb") / 1000

					if var_112_10 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_2
					end

					if var_112_5.prefab_name ~= "" and arg_109_1.actors_[var_112_5.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_5.prefab_name].transform, "story_v_out_319611", "319611027", "story_v_out_319611.awb")

						arg_109_1:RecordAudio("319611027", var_112_11)
						arg_109_1:RecordAudio("319611027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319611", "319611027", "story_v_out_319611.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319611", "319611027", "story_v_out_319611.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_12 and arg_109_1.time_ < var_112_2 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319611028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319611028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319611029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["4040ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect4040ui_story == nil then
				arg_113_1.var_.characterEffect4040ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect4040ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_113_1.var_.characterEffect4040ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect4040ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_113_1.var_.characterEffect4040ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 1.225

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(319611028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 49
				local var_116_11 = utf8.len(var_116_9)
				local var_116_12 = var_116_10 <= 0 and var_116_7 or var_116_7 * (var_116_11 / var_116_10)

				if var_116_12 > 0 and var_116_7 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_13 and arg_113_1.time_ < var_116_6 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319611029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319611029
		arg_117_1.duration_ = 3.47

		local var_117_0 = {
			zh = 1.999999999999,
			ja = 3.466
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
				arg_117_0:Play319611030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10079ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10079ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10079ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["10079ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10079ui_story == nil then
				arg_117_1.var_.characterEffect10079ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect10079ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10079ui_story then
				arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_120_15 = 0
			local var_120_16 = 1

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				local var_120_17 = "play"
				local var_120_18 = "effect"

				arg_117_1:AudioAction(var_120_17, var_120_18, "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_120_19 = 0
			local var_120_20 = 0.2

			if var_120_19 < arg_117_1.time_ and arg_117_1.time_ <= var_120_19 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_21 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_22 = arg_117_1:GetWordFromCfg(319611029)
				local var_120_23 = arg_117_1:FormatText(var_120_22.content)

				arg_117_1.text_.text = var_120_23

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_24 = 8
				local var_120_25 = utf8.len(var_120_23)
				local var_120_26 = var_120_24 <= 0 and var_120_20 or var_120_20 * (var_120_25 / var_120_24)

				if var_120_26 > 0 and var_120_20 < var_120_26 then
					arg_117_1.talkMaxDuration = var_120_26

					if var_120_26 + var_120_19 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_26 + var_120_19
					end
				end

				arg_117_1.text_.text = var_120_23
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611029", "story_v_out_319611.awb") ~= 0 then
					local var_120_27 = manager.audio:GetVoiceLength("story_v_out_319611", "319611029", "story_v_out_319611.awb") / 1000

					if var_120_27 + var_120_19 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_27 + var_120_19
					end

					if var_120_22.prefab_name ~= "" and arg_117_1.actors_[var_120_22.prefab_name] ~= nil then
						local var_120_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_22.prefab_name].transform, "story_v_out_319611", "319611029", "story_v_out_319611.awb")

						arg_117_1:RecordAudio("319611029", var_120_28)
						arg_117_1:RecordAudio("319611029", var_120_28)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319611", "319611029", "story_v_out_319611.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319611", "319611029", "story_v_out_319611.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_29 = math.max(var_120_20, arg_117_1.talkMaxDuration)

			if var_120_19 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_29 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_19) / var_120_29

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_19 + var_120_29 and arg_117_1.time_ < var_120_19 + var_120_29 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319611030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319611030
		arg_121_1.duration_ = 16.4

		local var_121_0 = {
			zh = 11.866,
			ja = 16.4
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
				arg_121_0:Play319611031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10079ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10079ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10079ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10079ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10079ui_story.fillRatio = var_124_5
			end

			local var_124_6 = arg_121_1.actors_["4040ui_story"]
			local var_124_7 = 0

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect4040ui_story == nil then
				arg_121_1.var_.characterEffect4040ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.200000002980232

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 and not isNil(var_124_6) then
				local var_124_9 = (arg_121_1.time_ - var_124_7) / var_124_8

				if arg_121_1.var_.characterEffect4040ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect4040ui_story then
				arg_121_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_124_11 = 0

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_124_12 = 0
			local var_124_13 = 1.225

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_14 = arg_121_1:FormatText(StoryNameCfg[668].name)

				arg_121_1.leftNameTxt_.text = var_124_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(319611030)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 49
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611030", "story_v_out_319611.awb") ~= 0 then
					local var_124_20 = manager.audio:GetVoiceLength("story_v_out_319611", "319611030", "story_v_out_319611.awb") / 1000

					if var_124_20 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_20 + var_124_12
					end

					if var_124_15.prefab_name ~= "" and arg_121_1.actors_[var_124_15.prefab_name] ~= nil then
						local var_124_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_15.prefab_name].transform, "story_v_out_319611", "319611030", "story_v_out_319611.awb")

						arg_121_1:RecordAudio("319611030", var_124_21)
						arg_121_1:RecordAudio("319611030", var_124_21)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319611", "319611030", "story_v_out_319611.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319611", "319611030", "story_v_out_319611.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_22 and arg_121_1.time_ < var_124_12 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319611031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319611031
		arg_125_1.duration_ = 19.73

		local var_125_0 = {
			zh = 11.3,
			ja = 19.733
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
				arg_125_0:Play319611032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.075

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[668].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(319611031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611031", "story_v_out_319611.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611031", "story_v_out_319611.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_319611", "319611031", "story_v_out_319611.awb")

						arg_125_1:RecordAudio("319611031", var_128_9)
						arg_125_1:RecordAudio("319611031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319611", "319611031", "story_v_out_319611.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319611", "319611031", "story_v_out_319611.awb")
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
	Play319611032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319611032
		arg_129_1.duration_ = 9.2

		local var_129_0 = {
			zh = 9.2,
			ja = 8
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
				arg_129_0:Play319611033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.775

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[668].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(319611032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611032", "story_v_out_319611.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_319611", "319611032", "story_v_out_319611.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_319611", "319611032", "story_v_out_319611.awb")

						arg_129_1:RecordAudio("319611032", var_132_9)
						arg_129_1:RecordAudio("319611032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319611", "319611032", "story_v_out_319611.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319611", "319611032", "story_v_out_319611.awb")
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
	Play319611033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319611033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play319611034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["4040ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect4040ui_story == nil then
				arg_133_1.var_.characterEffect4040ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect4040ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_133_1.var_.characterEffect4040ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect4040ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_133_1.var_.characterEffect4040ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_136_7 = 0
			local var_136_8 = 0.7

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(319611033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 28
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_8 or var_136_8 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_8 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_7 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_7
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_8, arg_133_1.talkMaxDuration)

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_7) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_7 + var_136_14 and arg_133_1.time_ < var_136_7 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play319611034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319611034
		arg_137_1.duration_ = 9.5

		local var_137_0 = {
			zh = 9.5,
			ja = 8.466
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
			arg_137_1.auto_ = false
		end

		function arg_137_1.playNext_(arg_139_0)
			arg_137_1.onStoryFinished_()
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["4040ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect4040ui_story == nil then
				arg_137_1.var_.characterEffect4040ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect4040ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect4040ui_story then
				arg_137_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_140_5 = 0
			local var_140_6 = 0.7

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_7 = arg_137_1:FormatText(StoryNameCfg[668].name)

				arg_137_1.leftNameTxt_.text = var_140_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(319611034)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 28
				local var_140_11 = utf8.len(var_140_9)
				local var_140_12 = var_140_10 <= 0 and var_140_6 or var_140_6 * (var_140_11 / var_140_10)

				if var_140_12 > 0 and var_140_6 < var_140_12 then
					arg_137_1.talkMaxDuration = var_140_12

					if var_140_12 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319611", "319611034", "story_v_out_319611.awb") ~= 0 then
					local var_140_13 = manager.audio:GetVoiceLength("story_v_out_319611", "319611034", "story_v_out_319611.awb") / 1000

					if var_140_13 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_5
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_319611", "319611034", "story_v_out_319611.awb")

						arg_137_1:RecordAudio("319611034", var_140_14)
						arg_137_1:RecordAudio("319611034", var_140_14)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319611", "319611034", "story_v_out_319611.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319611", "319611034", "story_v_out_319611.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_15 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_15 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_15

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_15 and arg_137_1.time_ < var_140_5 + var_140_15 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I10g"
	},
	voices = {
		"story_v_out_319611.awb"
	}
}
