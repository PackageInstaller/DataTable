return {
	Play318031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K01f"

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
				local var_4_5 = arg_1_1.bgs_.K01f

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
					if iter_4_0 ~= "K01f" then
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
			local var_4_23 = 0.433333333333333

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

			local var_4_28 = 1.26666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest")

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

				local var_4_37 = arg_1_1:GetWordFromCfg(318031001)
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
	Play318031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318031002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318031003(arg_9_1)
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

				local var_12_2 = arg_9_1:GetWordFromCfg(318031002)
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
	Play318031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318031003
		arg_13_1.duration_ = 2.77

		local var_13_0 = {
			zh = 2.766,
			ja = 1.999999999999
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
				arg_13_0:Play318031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10053ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10053ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10053ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.12, -5.99)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10053ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10053ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10053ui_story == nil then
				arg_13_1.var_.characterEffect10053ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10053ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10053ui_story then
				arg_13_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.1

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[477].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(318031003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031003", "story_v_out_318031.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_318031", "318031003", "story_v_out_318031.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_318031", "318031003", "story_v_out_318031.awb")

						arg_13_1:RecordAudio("318031003", var_16_29)
						arg_13_1:RecordAudio("318031003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318031", "318031003", "story_v_out_318031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318031", "318031003", "story_v_out_318031.awb")
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
				actorName = "10053ui_story",
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
	Play318031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318031004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1049ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1049ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1049ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -1.2, -6)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1049ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1049ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1049ui_story == nil then
				arg_17_1.var_.characterEffect1049ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1049ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1049ui_story then
				arg_17_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_20_20 = arg_17_1.actors_["10053ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos10053ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(-0.7, -1.12, -5.99)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10053ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = arg_17_1.actors_["10053ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect10053ui_story == nil then
				arg_17_1.var_.characterEffect10053ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.200000002980232

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect10053ui_story and not isNil(var_20_29) then
					local var_20_33 = Mathf.Lerp(0, 0.5, var_20_32)

					arg_17_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10053ui_story.fillRatio = var_20_33
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect10053ui_story then
				local var_20_34 = 0.5

				arg_17_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10053ui_story.fillRatio = var_20_34
			end

			local var_20_35 = 0
			local var_20_36 = 0.075

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[562].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(318031004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 3
				local var_20_41 = utf8.len(var_20_39)
				local var_20_42 = var_20_40 <= 0 and var_20_36 or var_20_36 * (var_20_41 / var_20_40)

				if var_20_42 > 0 and var_20_36 < var_20_42 then
					arg_17_1.talkMaxDuration = var_20_42

					if var_20_42 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_35
					end
				end

				arg_17_1.text_.text = var_20_39
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031004", "story_v_out_318031.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_318031", "318031004", "story_v_out_318031.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_318031", "318031004", "story_v_out_318031.awb")

						arg_17_1:RecordAudio("318031004", var_20_44)
						arg_17_1:RecordAudio("318031004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318031", "318031004", "story_v_out_318031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318031", "318031004", "story_v_out_318031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_45 = math.max(var_20_36, arg_17_1.talkMaxDuration)

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_45 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_35) / var_20_45

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_35 + var_20_45 and arg_17_1.time_ < var_20_35 + var_20_45 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play318031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318031005
		arg_21_1.duration_ = 3.53

		local var_21_0 = {
			zh = 3.533,
			ja = 2.533
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
				arg_21_0:Play318031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10053ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10053ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10053ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["10053ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10053ui_story == nil then
				arg_21_1.var_.characterEffect10053ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect10053ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10053ui_story then
				arg_21_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_15 = arg_21_1.actors_["1049ui_story"]
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.characterEffect1049ui_story == nil then
				arg_21_1.var_.characterEffect1049ui_story = var_24_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_17 = 0.200000002980232

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 and not isNil(var_24_15) then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17

				if arg_21_1.var_.characterEffect1049ui_story and not isNil(var_24_15) then
					local var_24_19 = Mathf.Lerp(0, 0.5, var_24_18)

					arg_21_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1049ui_story.fillRatio = var_24_19
				end
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.characterEffect1049ui_story then
				local var_24_20 = 0.5

				arg_21_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1049ui_story.fillRatio = var_24_20
			end

			local var_24_21 = 0
			local var_24_22 = 0.3

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_23 = arg_21_1:FormatText(StoryNameCfg[477].name)

				arg_21_1.leftNameTxt_.text = var_24_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_24 = arg_21_1:GetWordFromCfg(318031005)
				local var_24_25 = arg_21_1:FormatText(var_24_24.content)

				arg_21_1.text_.text = var_24_25

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_26 = 12
				local var_24_27 = utf8.len(var_24_25)
				local var_24_28 = var_24_26 <= 0 and var_24_22 or var_24_22 * (var_24_27 / var_24_26)

				if var_24_28 > 0 and var_24_22 < var_24_28 then
					arg_21_1.talkMaxDuration = var_24_28

					if var_24_28 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_21
					end
				end

				arg_21_1.text_.text = var_24_25
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031005", "story_v_out_318031.awb") ~= 0 then
					local var_24_29 = manager.audio:GetVoiceLength("story_v_out_318031", "318031005", "story_v_out_318031.awb") / 1000

					if var_24_29 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_29 + var_24_21
					end

					if var_24_24.prefab_name ~= "" and arg_21_1.actors_[var_24_24.prefab_name] ~= nil then
						local var_24_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_24.prefab_name].transform, "story_v_out_318031", "318031005", "story_v_out_318031.awb")

						arg_21_1:RecordAudio("318031005", var_24_30)
						arg_21_1:RecordAudio("318031005", var_24_30)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318031", "318031005", "story_v_out_318031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318031", "318031005", "story_v_out_318031.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_31 = math.max(var_24_22, arg_21_1.talkMaxDuration)

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_31 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_21) / var_24_31

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_21 + var_24_31 and arg_21_1.time_ < var_24_21 + var_24_31 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play318031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318031006
		arg_25_1.duration_ = 7.1

		local var_25_0 = {
			zh = 4.6,
			ja = 7.1
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
				arg_25_0:Play318031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1049ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1049ui_story == nil then
				arg_25_1.var_.characterEffect1049ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1049ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1049ui_story then
				arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_6 = arg_25_1.actors_["10053ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10053ui_story == nil then
				arg_25_1.var_.characterEffect10053ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect10053ui_story and not isNil(var_28_6) then
					local var_28_10 = Mathf.Lerp(0, 0.5, var_28_9)

					arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_10
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10053ui_story then
				local var_28_11 = 0.5

				arg_25_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10053ui_story.fillRatio = var_28_11
			end

			local var_28_12 = 0
			local var_28_13 = 0.525

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_14 = arg_25_1:FormatText(StoryNameCfg[562].name)

				arg_25_1.leftNameTxt_.text = var_28_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(318031006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 21
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_13 or var_28_13 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_13 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031006", "story_v_out_318031.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031006", "story_v_out_318031.awb") / 1000

					if var_28_20 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_12
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_318031", "318031006", "story_v_out_318031.awb")

						arg_25_1:RecordAudio("318031006", var_28_21)
						arg_25_1:RecordAudio("318031006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_318031", "318031006", "story_v_out_318031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_318031", "318031006", "story_v_out_318031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_22 and arg_25_1.time_ < var_28_12 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318031007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play318031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1049ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1049ui_story == nil then
				arg_29_1.var_.characterEffect1049ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1049ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1049ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1049ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1049ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 1.05

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(318031007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 42
				local var_32_11 = utf8.len(var_32_9)
				local var_32_12 = var_32_10 <= 0 and var_32_7 or var_32_7 * (var_32_11 / var_32_10)

				if var_32_12 > 0 and var_32_7 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_13 and arg_29_1.time_ < var_32_6 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318031008
		arg_33_1.duration_ = 3.63

		local var_33_0 = {
			zh = 2.5,
			ja = 3.633
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
				arg_33_0:Play318031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10053ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10053ui_story == nil then
				arg_33_1.var_.characterEffect10053ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10053ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10053ui_story then
				arg_33_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_36_4 = 0
			local var_36_5 = 0.275

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_6 = arg_33_1:FormatText(StoryNameCfg[477].name)

				arg_33_1.leftNameTxt_.text = var_36_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(318031008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 11
				local var_36_10 = utf8.len(var_36_8)
				local var_36_11 = var_36_9 <= 0 and var_36_5 or var_36_5 * (var_36_10 / var_36_9)

				if var_36_11 > 0 and var_36_5 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031008", "story_v_out_318031.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_318031", "318031008", "story_v_out_318031.awb") / 1000

					if var_36_12 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_4
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_318031", "318031008", "story_v_out_318031.awb")

						arg_33_1:RecordAudio("318031008", var_36_13)
						arg_33_1:RecordAudio("318031008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318031", "318031008", "story_v_out_318031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318031", "318031008", "story_v_out_318031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_14 and arg_33_1.time_ < var_36_4 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318031009
		arg_37_1.duration_ = 7.5

		local var_37_0 = {
			zh = 4.333,
			ja = 7.5
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
				arg_37_0:Play318031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1049ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1049ui_story == nil then
				arg_37_1.var_.characterEffect1049ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1049ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1049ui_story then
				arg_37_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_40_5 = arg_37_1.actors_["10053ui_story"]
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10053ui_story == nil then
				arg_37_1.var_.characterEffect10053ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.200000002980232

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 and not isNil(var_40_5) then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7

				if arg_37_1.var_.characterEffect10053ui_story and not isNil(var_40_5) then
					local var_40_9 = Mathf.Lerp(0, 0.5, var_40_8)

					arg_37_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10053ui_story.fillRatio = var_40_9
				end
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10053ui_story then
				local var_40_10 = 0.5

				arg_37_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10053ui_story.fillRatio = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 0.425

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[562].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(318031009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 17
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031009", "story_v_out_318031.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_318031", "318031009", "story_v_out_318031.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_318031", "318031009", "story_v_out_318031.awb")

						arg_37_1:RecordAudio("318031009", var_40_20)
						arg_37_1:RecordAudio("318031009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_318031", "318031009", "story_v_out_318031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_318031", "318031009", "story_v_out_318031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play318031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318031010
		arg_41_1.duration_ = 8.97

		local var_41_0 = {
			zh = 8.633,
			ja = 8.966
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10053ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10053ui_story == nil then
				arg_41_1.var_.characterEffect10053ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10053ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10053ui_story then
				arg_41_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action30_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_44_6 = arg_41_1.actors_["1049ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1049ui_story == nil then
				arg_41_1.var_.characterEffect1049ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1049ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1049ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1049ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1049ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 0.525

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[477].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(318031010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 21
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031010", "story_v_out_318031.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031010", "story_v_out_318031.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_318031", "318031010", "story_v_out_318031.awb")

						arg_41_1:RecordAudio("318031010", var_44_21)
						arg_41_1:RecordAudio("318031010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318031", "318031010", "story_v_out_318031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318031", "318031010", "story_v_out_318031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318031011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play318031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10053ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10053ui_story == nil then
				arg_45_1.var_.characterEffect10053ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10053ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10053ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10053ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10053ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 1.25

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(318031011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 50
				local var_48_11 = utf8.len(var_48_9)
				local var_48_12 = var_48_10 <= 0 and var_48_7 or var_48_7 * (var_48_11 / var_48_10)

				if var_48_12 > 0 and var_48_7 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_13 and arg_45_1.time_ < var_48_6 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318031012
		arg_49_1.duration_ = 7.53

		local var_49_0 = {
			zh = 7.533,
			ja = 7.466
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
				arg_49_0:Play318031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1049ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1049ui_story == nil then
				arg_49_1.var_.characterEffect1049ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1049ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1049ui_story then
				arg_49_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			local var_52_5 = 0
			local var_52_6 = 0.7

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_7 = arg_49_1:FormatText(StoryNameCfg[562].name)

				arg_49_1.leftNameTxt_.text = var_52_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(318031012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 28
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_6 or var_52_6 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_6 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031012", "story_v_out_318031.awb") ~= 0 then
					local var_52_13 = manager.audio:GetVoiceLength("story_v_out_318031", "318031012", "story_v_out_318031.awb") / 1000

					if var_52_13 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_5
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_318031", "318031012", "story_v_out_318031.awb")

						arg_49_1:RecordAudio("318031012", var_52_14)
						arg_49_1:RecordAudio("318031012", var_52_14)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318031", "318031012", "story_v_out_318031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318031", "318031012", "story_v_out_318031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_15 and arg_49_1.time_ < var_52_5 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play318031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318031013
		arg_53_1.duration_ = 11.2

		local var_53_0 = {
			zh = 8.3,
			ja = 11.2
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
				arg_53_0:Play318031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.925

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[562].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(318031013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 37
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031013", "story_v_out_318031.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031013", "story_v_out_318031.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_318031", "318031013", "story_v_out_318031.awb")

						arg_53_1:RecordAudio("318031013", var_56_9)
						arg_53_1:RecordAudio("318031013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318031", "318031013", "story_v_out_318031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318031", "318031013", "story_v_out_318031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play318031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318031014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play318031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1049ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1049ui_story == nil then
				arg_57_1.var_.characterEffect1049ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1049ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1049ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1049ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1049ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 1.1

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(318031014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 44
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_7 or var_60_7 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_13 and arg_57_1.time_ < var_60_6 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318031015
		arg_61_1.duration_ = 5.97

		local var_61_0 = {
			zh = 5.066,
			ja = 5.966
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
				arg_61_0:Play318031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10053ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10053ui_story == nil then
				arg_61_1.var_.characterEffect10053ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10053ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10053ui_story then
				arg_61_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action43024")
			end

			local var_64_5 = 0
			local var_64_6 = 0.4

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_7 = arg_61_1:FormatText(StoryNameCfg[477].name)

				arg_61_1.leftNameTxt_.text = var_64_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(318031015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 16
				local var_64_11 = utf8.len(var_64_9)
				local var_64_12 = var_64_10 <= 0 and var_64_6 or var_64_6 * (var_64_11 / var_64_10)

				if var_64_12 > 0 and var_64_6 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031015", "story_v_out_318031.awb") ~= 0 then
					local var_64_13 = manager.audio:GetVoiceLength("story_v_out_318031", "318031015", "story_v_out_318031.awb") / 1000

					if var_64_13 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_5
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_318031", "318031015", "story_v_out_318031.awb")

						arg_61_1:RecordAudio("318031015", var_64_14)
						arg_61_1:RecordAudio("318031015", var_64_14)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_318031", "318031015", "story_v_out_318031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_318031", "318031015", "story_v_out_318031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_15 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_15

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_15 and arg_61_1.time_ < var_64_5 + var_64_15 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play318031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318031016
		arg_65_1.duration_ = 10.3

		local var_65_0 = {
			zh = 10.3,
			ja = 8.366
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
				arg_65_0:Play318031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10053ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10053ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10053ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = 0
			local var_68_10 = 0.925

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_11 = arg_65_1:FormatText(StoryNameCfg[477].name)

				arg_65_1.leftNameTxt_.text = var_68_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_12 = arg_65_1:GetWordFromCfg(318031016)
				local var_68_13 = arg_65_1:FormatText(var_68_12.content)

				arg_65_1.text_.text = var_68_13

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_14 = 37
				local var_68_15 = utf8.len(var_68_13)
				local var_68_16 = var_68_14 <= 0 and var_68_10 or var_68_10 * (var_68_15 / var_68_14)

				if var_68_16 > 0 and var_68_10 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16

					if var_68_16 + var_68_9 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_9
					end
				end

				arg_65_1.text_.text = var_68_13
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031016", "story_v_out_318031.awb") ~= 0 then
					local var_68_17 = manager.audio:GetVoiceLength("story_v_out_318031", "318031016", "story_v_out_318031.awb") / 1000

					if var_68_17 + var_68_9 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_9
					end

					if var_68_12.prefab_name ~= "" and arg_65_1.actors_[var_68_12.prefab_name] ~= nil then
						local var_68_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_12.prefab_name].transform, "story_v_out_318031", "318031016", "story_v_out_318031.awb")

						arg_65_1:RecordAudio("318031016", var_68_18)
						arg_65_1:RecordAudio("318031016", var_68_18)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318031", "318031016", "story_v_out_318031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318031", "318031016", "story_v_out_318031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_19 = math.max(var_68_10, arg_65_1.talkMaxDuration)

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_9) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_9 + var_68_19 and arg_65_1.time_ < var_68_9 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play318031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318031017
		arg_69_1.duration_ = 12.3

		local var_69_0 = {
			zh = 7.133,
			ja = 12.3
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
				arg_69_0:Play318031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10053ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10053ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10053ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = 0
			local var_72_10 = 0.65

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_11 = arg_69_1:FormatText(StoryNameCfg[477].name)

				arg_69_1.leftNameTxt_.text = var_72_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_12 = arg_69_1:GetWordFromCfg(318031017)
				local var_72_13 = arg_69_1:FormatText(var_72_12.content)

				arg_69_1.text_.text = var_72_13

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_14 = 26
				local var_72_15 = utf8.len(var_72_13)
				local var_72_16 = var_72_14 <= 0 and var_72_10 or var_72_10 * (var_72_15 / var_72_14)

				if var_72_16 > 0 and var_72_10 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_9
					end
				end

				arg_69_1.text_.text = var_72_13
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031017", "story_v_out_318031.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_318031", "318031017", "story_v_out_318031.awb") / 1000

					if var_72_17 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_9
					end

					if var_72_12.prefab_name ~= "" and arg_69_1.actors_[var_72_12.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_12.prefab_name].transform, "story_v_out_318031", "318031017", "story_v_out_318031.awb")

						arg_69_1:RecordAudio("318031017", var_72_18)
						arg_69_1:RecordAudio("318031017", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_318031", "318031017", "story_v_out_318031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_318031", "318031017", "story_v_out_318031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_19 = math.max(var_72_10, arg_69_1.talkMaxDuration)

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_19 and arg_69_1.time_ < var_72_9 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play318031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318031018
		arg_73_1.duration_ = 3.5

		local var_73_0 = {
			zh = 1.366,
			ja = 3.5
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
				arg_73_0:Play318031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1049ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1049ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1049ui_story then
				arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["10053ui_story"]
			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10053ui_story == nil then
				arg_73_1.var_.characterEffect10053ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_6 and not isNil(var_76_4) then
				local var_76_7 = (arg_73_1.time_ - var_76_5) / var_76_6

				if arg_73_1.var_.characterEffect10053ui_story and not isNil(var_76_4) then
					local var_76_8 = Mathf.Lerp(0, 0.5, var_76_7)

					arg_73_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10053ui_story.fillRatio = var_76_8
				end
			end

			if arg_73_1.time_ >= var_76_5 + var_76_6 and arg_73_1.time_ < var_76_5 + var_76_6 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10053ui_story then
				local var_76_9 = 0.5

				arg_73_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10053ui_story.fillRatio = var_76_9
			end

			local var_76_10 = 0
			local var_76_11 = 0.175

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_12 = arg_73_1:FormatText(StoryNameCfg[562].name)

				arg_73_1.leftNameTxt_.text = var_76_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(318031018)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_15 = 7
				local var_76_16 = utf8.len(var_76_14)
				local var_76_17 = var_76_15 <= 0 and var_76_11 or var_76_11 * (var_76_16 / var_76_15)

				if var_76_17 > 0 and var_76_11 < var_76_17 then
					arg_73_1.talkMaxDuration = var_76_17

					if var_76_17 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031018", "story_v_out_318031.awb") ~= 0 then
					local var_76_18 = manager.audio:GetVoiceLength("story_v_out_318031", "318031018", "story_v_out_318031.awb") / 1000

					if var_76_18 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_10
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_318031", "318031018", "story_v_out_318031.awb")

						arg_73_1:RecordAudio("318031018", var_76_19)
						arg_73_1:RecordAudio("318031018", var_76_19)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_318031", "318031018", "story_v_out_318031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_318031", "318031018", "story_v_out_318031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_20 and arg_73_1.time_ < var_76_10 + var_76_20 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play318031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318031019
		arg_77_1.duration_ = 9.9

		local var_77_0 = {
			zh = 7.866,
			ja = 9.9
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
				arg_77_0:Play318031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.725

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[562].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(318031019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031019", "story_v_out_318031.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031019", "story_v_out_318031.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_318031", "318031019", "story_v_out_318031.awb")

						arg_77_1:RecordAudio("318031019", var_80_9)
						arg_77_1:RecordAudio("318031019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318031", "318031019", "story_v_out_318031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318031", "318031019", "story_v_out_318031.awb")
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
	Play318031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318031020
		arg_81_1.duration_ = 4.17

		local var_81_0 = {
			zh = 4.166,
			ja = 2.133
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
				arg_81_0:Play318031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10053ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10053ui_story == nil then
				arg_81_1.var_.characterEffect10053ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10053ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10053ui_story then
				arg_81_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action42415")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_6 = arg_81_1.actors_["1049ui_story"]
			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1049ui_story == nil then
				arg_81_1.var_.characterEffect1049ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_8 = 0.200000002980232

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 and not isNil(var_84_6) then
				local var_84_9 = (arg_81_1.time_ - var_84_7) / var_84_8

				if arg_81_1.var_.characterEffect1049ui_story and not isNil(var_84_6) then
					local var_84_10 = Mathf.Lerp(0, 0.5, var_84_9)

					arg_81_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1049ui_story.fillRatio = var_84_10
				end
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1049ui_story then
				local var_84_11 = 0.5

				arg_81_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1049ui_story.fillRatio = var_84_11
			end

			local var_84_12 = 0
			local var_84_13 = 0.425

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_14 = arg_81_1:FormatText(StoryNameCfg[477].name)

				arg_81_1.leftNameTxt_.text = var_84_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_15 = arg_81_1:GetWordFromCfg(318031020)
				local var_84_16 = arg_81_1:FormatText(var_84_15.content)

				arg_81_1.text_.text = var_84_16

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_17 = 17
				local var_84_18 = utf8.len(var_84_16)
				local var_84_19 = var_84_17 <= 0 and var_84_13 or var_84_13 * (var_84_18 / var_84_17)

				if var_84_19 > 0 and var_84_13 < var_84_19 then
					arg_81_1.talkMaxDuration = var_84_19

					if var_84_19 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_16
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031020", "story_v_out_318031.awb") ~= 0 then
					local var_84_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031020", "story_v_out_318031.awb") / 1000

					if var_84_20 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_20 + var_84_12
					end

					if var_84_15.prefab_name ~= "" and arg_81_1.actors_[var_84_15.prefab_name] ~= nil then
						local var_84_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_15.prefab_name].transform, "story_v_out_318031", "318031020", "story_v_out_318031.awb")

						arg_81_1:RecordAudio("318031020", var_84_21)
						arg_81_1:RecordAudio("318031020", var_84_21)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318031", "318031020", "story_v_out_318031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318031", "318031020", "story_v_out_318031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_12) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_12 + var_84_22 and arg_81_1.time_ < var_84_12 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play318031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318031021
		arg_85_1.duration_ = 13.83

		local var_85_0 = {
			zh = 13.833,
			ja = 12.533
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
				arg_85_0:Play318031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1.4

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[477].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(318031021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031021", "story_v_out_318031.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031021", "story_v_out_318031.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_318031", "318031021", "story_v_out_318031.awb")

						arg_85_1:RecordAudio("318031021", var_88_9)
						arg_85_1:RecordAudio("318031021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_318031", "318031021", "story_v_out_318031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_318031", "318031021", "story_v_out_318031.awb")
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
	Play318031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318031022
		arg_89_1.duration_ = 12.4

		local var_89_0 = {
			zh = 4.6,
			ja = 12.4
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
				arg_89_0:Play318031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.475

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[477].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(318031022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031022", "story_v_out_318031.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031022", "story_v_out_318031.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_318031", "318031022", "story_v_out_318031.awb")

						arg_89_1:RecordAudio("318031022", var_92_9)
						arg_89_1:RecordAudio("318031022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318031", "318031022", "story_v_out_318031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318031", "318031022", "story_v_out_318031.awb")
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
	Play318031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318031023
		arg_93_1.duration_ = 1.23

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play318031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1049ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1049ui_story == nil then
				arg_93_1.var_.characterEffect1049ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1049ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1049ui_story then
				arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["10053ui_story"]
			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10053ui_story == nil then
				arg_93_1.var_.characterEffect10053ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 and not isNil(var_96_4) then
				local var_96_7 = (arg_93_1.time_ - var_96_5) / var_96_6

				if arg_93_1.var_.characterEffect10053ui_story and not isNil(var_96_4) then
					local var_96_8 = Mathf.Lerp(0, 0.5, var_96_7)

					arg_93_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10053ui_story.fillRatio = var_96_8
				end
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10053ui_story then
				local var_96_9 = 0.5

				arg_93_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10053ui_story.fillRatio = var_96_9
			end

			local var_96_10 = 0
			local var_96_11 = 0.05

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_12 = arg_93_1:FormatText(StoryNameCfg[562].name)

				arg_93_1.leftNameTxt_.text = var_96_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(318031023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 2
				local var_96_16 = utf8.len(var_96_14)
				local var_96_17 = var_96_15 <= 0 and var_96_11 or var_96_11 * (var_96_16 / var_96_15)

				if var_96_17 > 0 and var_96_11 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031023", "story_v_out_318031.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_318031", "318031023", "story_v_out_318031.awb") / 1000

					if var_96_18 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_10
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_318031", "318031023", "story_v_out_318031.awb")

						arg_93_1:RecordAudio("318031023", var_96_19)
						arg_93_1:RecordAudio("318031023", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318031", "318031023", "story_v_out_318031.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318031", "318031023", "story_v_out_318031.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_20 and arg_93_1.time_ < var_96_10 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play318031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318031024
		arg_97_1.duration_ = 3.5

		local var_97_0 = {
			zh = 2.3,
			ja = 3.5
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
				arg_97_0:Play318031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1049ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1049ui_story == nil then
				arg_97_1.var_.characterEffect1049ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1049ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1049ui_story then
				arg_97_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_100_6 = 0
			local var_100_7 = 0.225

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[562].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(318031024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 9
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031024", "story_v_out_318031.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_318031", "318031024", "story_v_out_318031.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_out_318031", "318031024", "story_v_out_318031.awb")

						arg_97_1:RecordAudio("318031024", var_100_15)
						arg_97_1:RecordAudio("318031024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318031", "318031024", "story_v_out_318031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318031", "318031024", "story_v_out_318031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play318031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318031025
		arg_101_1.duration_ = 3.03

		local var_101_0 = {
			zh = 3.033,
			ja = 2.466
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
				arg_101_0:Play318031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10053ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10053ui_story == nil then
				arg_101_1.var_.characterEffect10053ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10053ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10053ui_story then
				arg_101_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action15_2")
			end

			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_104_6 = arg_101_1.actors_["1049ui_story"]
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1049ui_story == nil then
				arg_101_1.var_.characterEffect1049ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_8 = 0.200000002980232

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 and not isNil(var_104_6) then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8

				if arg_101_1.var_.characterEffect1049ui_story and not isNil(var_104_6) then
					local var_104_10 = Mathf.Lerp(0, 0.5, var_104_9)

					arg_101_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1049ui_story.fillRatio = var_104_10
				end
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1049ui_story then
				local var_104_11 = 0.5

				arg_101_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1049ui_story.fillRatio = var_104_11
			end

			local var_104_12 = 0
			local var_104_13 = 0.125

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[477].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(318031025)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 5
				local var_104_18 = utf8.len(var_104_16)
				local var_104_19 = var_104_17 <= 0 and var_104_13 or var_104_13 * (var_104_18 / var_104_17)

				if var_104_19 > 0 and var_104_13 < var_104_19 then
					arg_101_1.talkMaxDuration = var_104_19

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031025", "story_v_out_318031.awb") ~= 0 then
					local var_104_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031025", "story_v_out_318031.awb") / 1000

					if var_104_20 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_318031", "318031025", "story_v_out_318031.awb")

						arg_101_1:RecordAudio("318031025", var_104_21)
						arg_101_1:RecordAudio("318031025", var_104_21)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318031", "318031025", "story_v_out_318031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318031", "318031025", "story_v_out_318031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_22 and arg_101_1.time_ < var_104_12 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play318031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318031026
		arg_105_1.duration_ = 13.4

		local var_105_0 = {
			zh = 4.8,
			ja = 13.4
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
				arg_105_0:Play318031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1049ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1049ui_story == nil then
				arg_105_1.var_.characterEffect1049ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1049ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1049ui_story then
				arg_105_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["10053ui_story"]
			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect10053ui_story == nil then
				arg_105_1.var_.characterEffect10053ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 and not isNil(var_108_4) then
				local var_108_7 = (arg_105_1.time_ - var_108_5) / var_108_6

				if arg_105_1.var_.characterEffect10053ui_story and not isNil(var_108_4) then
					local var_108_8 = Mathf.Lerp(0, 0.5, var_108_7)

					arg_105_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10053ui_story.fillRatio = var_108_8
				end
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect10053ui_story then
				local var_108_9 = 0.5

				arg_105_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10053ui_story.fillRatio = var_108_9
			end

			local var_108_10 = 0
			local var_108_11 = 0.45

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_12 = arg_105_1:FormatText(StoryNameCfg[562].name)

				arg_105_1.leftNameTxt_.text = var_108_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_13 = arg_105_1:GetWordFromCfg(318031026)
				local var_108_14 = arg_105_1:FormatText(var_108_13.content)

				arg_105_1.text_.text = var_108_14

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_15 = 18
				local var_108_16 = utf8.len(var_108_14)
				local var_108_17 = var_108_15 <= 0 and var_108_11 or var_108_11 * (var_108_16 / var_108_15)

				if var_108_17 > 0 and var_108_11 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17

					if var_108_17 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_10
					end
				end

				arg_105_1.text_.text = var_108_14
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031026", "story_v_out_318031.awb") ~= 0 then
					local var_108_18 = manager.audio:GetVoiceLength("story_v_out_318031", "318031026", "story_v_out_318031.awb") / 1000

					if var_108_18 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_10
					end

					if var_108_13.prefab_name ~= "" and arg_105_1.actors_[var_108_13.prefab_name] ~= nil then
						local var_108_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_13.prefab_name].transform, "story_v_out_318031", "318031026", "story_v_out_318031.awb")

						arg_105_1:RecordAudio("318031026", var_108_19)
						arg_105_1:RecordAudio("318031026", var_108_19)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_318031", "318031026", "story_v_out_318031.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_318031", "318031026", "story_v_out_318031.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_11, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_20 and arg_105_1.time_ < var_108_10 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play318031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318031027
		arg_109_1.duration_ = 3.5

		local var_109_0 = {
			zh = 3.5,
			ja = 3.433
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
				arg_109_0:Play318031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1049ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1049ui_story == nil then
				arg_109_1.var_.characterEffect1049ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1049ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1049ui_story then
				arg_109_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_112_5 = 0
			local var_112_6 = 0.275

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_7 = arg_109_1:FormatText(StoryNameCfg[562].name)

				arg_109_1.leftNameTxt_.text = var_112_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(318031027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 11
				local var_112_11 = utf8.len(var_112_9)
				local var_112_12 = var_112_10 <= 0 and var_112_6 or var_112_6 * (var_112_11 / var_112_10)

				if var_112_12 > 0 and var_112_6 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031027", "story_v_out_318031.awb") ~= 0 then
					local var_112_13 = manager.audio:GetVoiceLength("story_v_out_318031", "318031027", "story_v_out_318031.awb") / 1000

					if var_112_13 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_5
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_318031", "318031027", "story_v_out_318031.awb")

						arg_109_1:RecordAudio("318031027", var_112_14)
						arg_109_1:RecordAudio("318031027", var_112_14)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318031", "318031027", "story_v_out_318031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318031", "318031027", "story_v_out_318031.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_15 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_15 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_15

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_15 and arg_109_1.time_ < var_112_5 + var_112_15 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play318031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318031028
		arg_113_1.duration_ = 11.1

		local var_113_0 = {
			zh = 11.1,
			ja = 10.9
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
				arg_113_0:Play318031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 2

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				local var_116_1 = manager.ui.mainCamera.transform.localPosition
				local var_116_2 = Vector3.New(0, 0, 10) + Vector3.New(var_116_1.x, var_116_1.y, 0)
				local var_116_3 = arg_113_1.bgs_.K01f

				var_116_3.transform.localPosition = var_116_2
				var_116_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_4 = var_116_3:GetComponent("SpriteRenderer")

				if var_116_4 and var_116_4.sprite then
					local var_116_5 = (var_116_3.transform.localPosition - var_116_1).z
					local var_116_6 = manager.ui.mainCameraCom_
					local var_116_7 = 2 * var_116_5 * Mathf.Tan(var_116_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_8 = var_116_7 * var_116_6.aspect
					local var_116_9 = var_116_4.sprite.bounds.size.x
					local var_116_10 = var_116_4.sprite.bounds.size.y
					local var_116_11 = var_116_8 / var_116_9
					local var_116_12 = var_116_7 / var_116_10
					local var_116_13 = var_116_12 < var_116_11 and var_116_11 or var_116_12

					var_116_3.transform.localScale = Vector3.New(var_116_13, var_116_13, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "K01f" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_15 = 2

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_15 then
				local var_116_16 = (arg_113_1.time_ - var_116_14) / var_116_15
				local var_116_17 = Color.New(0, 0, 0)

				var_116_17.a = Mathf.Lerp(0, 1, var_116_16)
				arg_113_1.mask_.color = var_116_17
			end

			if arg_113_1.time_ >= var_116_14 + var_116_15 and arg_113_1.time_ < var_116_14 + var_116_15 + arg_116_0 then
				local var_116_18 = Color.New(0, 0, 0)

				var_116_18.a = 1
				arg_113_1.mask_.color = var_116_18
			end

			local var_116_19 = 2

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_20 = 2

			if var_116_19 <= arg_113_1.time_ and arg_113_1.time_ < var_116_19 + var_116_20 then
				local var_116_21 = (arg_113_1.time_ - var_116_19) / var_116_20
				local var_116_22 = Color.New(0, 0, 0)

				var_116_22.a = Mathf.Lerp(1, 0, var_116_21)
				arg_113_1.mask_.color = var_116_22
			end

			if arg_113_1.time_ >= var_116_19 + var_116_20 and arg_113_1.time_ < var_116_19 + var_116_20 + arg_116_0 then
				local var_116_23 = Color.New(0, 0, 0)
				local var_116_24 = 0

				arg_113_1.mask_.enabled = false
				var_116_23.a = var_116_24
				arg_113_1.mask_.color = var_116_23
			end

			local var_116_25 = "1093ui_story"

			if arg_113_1.actors_[var_116_25] == nil then
				local var_116_26 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_116_26) then
					local var_116_27 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_113_1.stage_.transform)

					var_116_27.name = var_116_25
					var_116_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_113_1.actors_[var_116_25] = var_116_27

					local var_116_28 = var_116_27:GetComponentInChildren(typeof(CharacterEffect))

					var_116_28.enabled = true

					local var_116_29 = GameObjectTools.GetOrAddComponent(var_116_27, typeof(DynamicBoneHelper))

					if var_116_29 then
						var_116_29:EnableDynamicBone(false)
					end

					arg_113_1:ShowWeapon(var_116_28.transform, false)

					arg_113_1.var_[var_116_25 .. "Animator"] = var_116_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_113_1.var_[var_116_25 .. "Animator"].applyRootMotion = true
					arg_113_1.var_[var_116_25 .. "LipSync"] = var_116_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_116_30 = arg_113_1.actors_["1093ui_story"].transform
			local var_116_31 = 4

			if var_116_31 < arg_113_1.time_ and arg_113_1.time_ <= var_116_31 + arg_116_0 then
				arg_113_1.var_.moveOldPos1093ui_story = var_116_30.localPosition
			end

			local var_116_32 = 0.001

			if var_116_31 <= arg_113_1.time_ and arg_113_1.time_ < var_116_31 + var_116_32 then
				local var_116_33 = (arg_113_1.time_ - var_116_31) / var_116_32
				local var_116_34 = Vector3.New(0, -1.11, -5.88)

				var_116_30.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1093ui_story, var_116_34, var_116_33)

				local var_116_35 = manager.ui.mainCamera.transform.position - var_116_30.position

				var_116_30.forward = Vector3.New(var_116_35.x, var_116_35.y, var_116_35.z)

				local var_116_36 = var_116_30.localEulerAngles

				var_116_36.z = 0
				var_116_36.x = 0
				var_116_30.localEulerAngles = var_116_36
			end

			if arg_113_1.time_ >= var_116_31 + var_116_32 and arg_113_1.time_ < var_116_31 + var_116_32 + arg_116_0 then
				var_116_30.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_116_37 = manager.ui.mainCamera.transform.position - var_116_30.position

				var_116_30.forward = Vector3.New(var_116_37.x, var_116_37.y, var_116_37.z)

				local var_116_38 = var_116_30.localEulerAngles

				var_116_38.z = 0
				var_116_38.x = 0
				var_116_30.localEulerAngles = var_116_38
			end

			local var_116_39 = arg_113_1.actors_["1093ui_story"]
			local var_116_40 = 4

			if var_116_40 < arg_113_1.time_ and arg_113_1.time_ <= var_116_40 + arg_116_0 and not isNil(var_116_39) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = var_116_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_41 = 0.200000002980232

			if var_116_40 <= arg_113_1.time_ and arg_113_1.time_ < var_116_40 + var_116_41 and not isNil(var_116_39) then
				local var_116_42 = (arg_113_1.time_ - var_116_40) / var_116_41

				if arg_113_1.var_.characterEffect1093ui_story and not isNil(var_116_39) then
					arg_113_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_40 + var_116_41 and arg_113_1.time_ < var_116_40 + var_116_41 + arg_116_0 and not isNil(var_116_39) and arg_113_1.var_.characterEffect1093ui_story then
				arg_113_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_116_43 = 4

			if var_116_43 < arg_113_1.time_ and arg_113_1.time_ <= var_116_43 + arg_116_0 then
				arg_113_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			local var_116_44 = 4

			if var_116_44 < arg_113_1.time_ and arg_113_1.time_ <= var_116_44 + arg_116_0 then
				arg_113_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_116_45 = arg_113_1.actors_["1049ui_story"].transform
			local var_116_46 = 2

			if var_116_46 < arg_113_1.time_ and arg_113_1.time_ <= var_116_46 + arg_116_0 then
				arg_113_1.var_.moveOldPos1049ui_story = var_116_45.localPosition
			end

			local var_116_47 = 0.001

			if var_116_46 <= arg_113_1.time_ and arg_113_1.time_ < var_116_46 + var_116_47 then
				local var_116_48 = (arg_113_1.time_ - var_116_46) / var_116_47
				local var_116_49 = Vector3.New(0, 100, 0)

				var_116_45.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1049ui_story, var_116_49, var_116_48)

				local var_116_50 = manager.ui.mainCamera.transform.position - var_116_45.position

				var_116_45.forward = Vector3.New(var_116_50.x, var_116_50.y, var_116_50.z)

				local var_116_51 = var_116_45.localEulerAngles

				var_116_51.z = 0
				var_116_51.x = 0
				var_116_45.localEulerAngles = var_116_51
			end

			if arg_113_1.time_ >= var_116_46 + var_116_47 and arg_113_1.time_ < var_116_46 + var_116_47 + arg_116_0 then
				var_116_45.localPosition = Vector3.New(0, 100, 0)

				local var_116_52 = manager.ui.mainCamera.transform.position - var_116_45.position

				var_116_45.forward = Vector3.New(var_116_52.x, var_116_52.y, var_116_52.z)

				local var_116_53 = var_116_45.localEulerAngles

				var_116_53.z = 0
				var_116_53.x = 0
				var_116_45.localEulerAngles = var_116_53
			end

			local var_116_54 = arg_113_1.actors_["1049ui_story"]
			local var_116_55 = 2

			if var_116_55 < arg_113_1.time_ and arg_113_1.time_ <= var_116_55 + arg_116_0 and not isNil(var_116_54) and arg_113_1.var_.characterEffect1049ui_story == nil then
				arg_113_1.var_.characterEffect1049ui_story = var_116_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_56 = 0.200000002980232

			if var_116_55 <= arg_113_1.time_ and arg_113_1.time_ < var_116_55 + var_116_56 and not isNil(var_116_54) then
				local var_116_57 = (arg_113_1.time_ - var_116_55) / var_116_56

				if arg_113_1.var_.characterEffect1049ui_story and not isNil(var_116_54) then
					local var_116_58 = Mathf.Lerp(0, 0.5, var_116_57)

					arg_113_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1049ui_story.fillRatio = var_116_58
				end
			end

			if arg_113_1.time_ >= var_116_55 + var_116_56 and arg_113_1.time_ < var_116_55 + var_116_56 + arg_116_0 and not isNil(var_116_54) and arg_113_1.var_.characterEffect1049ui_story then
				local var_116_59 = 0.5

				arg_113_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1049ui_story.fillRatio = var_116_59
			end

			local var_116_60 = arg_113_1.actors_["10053ui_story"].transform
			local var_116_61 = 2

			if var_116_61 < arg_113_1.time_ and arg_113_1.time_ <= var_116_61 + arg_116_0 then
				arg_113_1.var_.moveOldPos10053ui_story = var_116_60.localPosition
			end

			local var_116_62 = 0.001

			if var_116_61 <= arg_113_1.time_ and arg_113_1.time_ < var_116_61 + var_116_62 then
				local var_116_63 = (arg_113_1.time_ - var_116_61) / var_116_62
				local var_116_64 = Vector3.New(0, 100, 0)

				var_116_60.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10053ui_story, var_116_64, var_116_63)

				local var_116_65 = manager.ui.mainCamera.transform.position - var_116_60.position

				var_116_60.forward = Vector3.New(var_116_65.x, var_116_65.y, var_116_65.z)

				local var_116_66 = var_116_60.localEulerAngles

				var_116_66.z = 0
				var_116_66.x = 0
				var_116_60.localEulerAngles = var_116_66
			end

			if arg_113_1.time_ >= var_116_61 + var_116_62 and arg_113_1.time_ < var_116_61 + var_116_62 + arg_116_0 then
				var_116_60.localPosition = Vector3.New(0, 100, 0)

				local var_116_67 = manager.ui.mainCamera.transform.position - var_116_60.position

				var_116_60.forward = Vector3.New(var_116_67.x, var_116_67.y, var_116_67.z)

				local var_116_68 = var_116_60.localEulerAngles

				var_116_68.z = 0
				var_116_68.x = 0
				var_116_60.localEulerAngles = var_116_68
			end

			local var_116_69 = arg_113_1.actors_["10053ui_story"]
			local var_116_70 = 2

			if var_116_70 < arg_113_1.time_ and arg_113_1.time_ <= var_116_70 + arg_116_0 and not isNil(var_116_69) and arg_113_1.var_.characterEffect10053ui_story == nil then
				arg_113_1.var_.characterEffect10053ui_story = var_116_69:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_71 = 0.200000002980232

			if var_116_70 <= arg_113_1.time_ and arg_113_1.time_ < var_116_70 + var_116_71 and not isNil(var_116_69) then
				local var_116_72 = (arg_113_1.time_ - var_116_70) / var_116_71

				if arg_113_1.var_.characterEffect10053ui_story and not isNil(var_116_69) then
					local var_116_73 = Mathf.Lerp(0, 0.5, var_116_72)

					arg_113_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10053ui_story.fillRatio = var_116_73
				end
			end

			if arg_113_1.time_ >= var_116_70 + var_116_71 and arg_113_1.time_ < var_116_70 + var_116_71 + arg_116_0 and not isNil(var_116_69) and arg_113_1.var_.characterEffect10053ui_story then
				local var_116_74 = 0.5

				arg_113_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10053ui_story.fillRatio = var_116_74
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_75 = 4
			local var_116_76 = 0.725

			if var_116_75 < arg_113_1.time_ and arg_113_1.time_ <= var_116_75 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_77 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_77:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_78 = arg_113_1:FormatText(StoryNameCfg[73].name)

				arg_113_1.leftNameTxt_.text = var_116_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_79 = arg_113_1:GetWordFromCfg(318031028)
				local var_116_80 = arg_113_1:FormatText(var_116_79.content)

				arg_113_1.text_.text = var_116_80

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_81 = 29
				local var_116_82 = utf8.len(var_116_80)
				local var_116_83 = var_116_81 <= 0 and var_116_76 or var_116_76 * (var_116_82 / var_116_81)

				if var_116_83 > 0 and var_116_76 < var_116_83 then
					arg_113_1.talkMaxDuration = var_116_83
					var_116_75 = var_116_75 + 0.3

					if var_116_83 + var_116_75 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_83 + var_116_75
					end
				end

				arg_113_1.text_.text = var_116_80
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031028", "story_v_out_318031.awb") ~= 0 then
					local var_116_84 = manager.audio:GetVoiceLength("story_v_out_318031", "318031028", "story_v_out_318031.awb") / 1000

					if var_116_84 + var_116_75 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_84 + var_116_75
					end

					if var_116_79.prefab_name ~= "" and arg_113_1.actors_[var_116_79.prefab_name] ~= nil then
						local var_116_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_79.prefab_name].transform, "story_v_out_318031", "318031028", "story_v_out_318031.awb")

						arg_113_1:RecordAudio("318031028", var_116_85)
						arg_113_1:RecordAudio("318031028", var_116_85)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_318031", "318031028", "story_v_out_318031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_318031", "318031028", "story_v_out_318031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_86 = var_116_75 + 0.3
			local var_116_87 = math.max(var_116_76, arg_113_1.talkMaxDuration)

			if var_116_86 <= arg_113_1.time_ and arg_113_1.time_ < var_116_86 + var_116_87 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_86) / var_116_87

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_86 + var_116_87 and arg_113_1.time_ < var_116_86 + var_116_87 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play318031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 318031029
		arg_119_1.duration_ = 3.73

		local var_119_0 = {
			zh = 2.866,
			ja = 3.733
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
				arg_119_0:Play318031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "1015ui_story"

			if arg_119_1.actors_[var_122_0] == nil then
				local var_122_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_122_1) then
					local var_122_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_119_1.stage_.transform)

					var_122_2.name = var_122_0
					var_122_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_119_1.actors_[var_122_0] = var_122_2

					local var_122_3 = var_122_2:GetComponentInChildren(typeof(CharacterEffect))

					var_122_3.enabled = true

					local var_122_4 = GameObjectTools.GetOrAddComponent(var_122_2, typeof(DynamicBoneHelper))

					if var_122_4 then
						var_122_4:EnableDynamicBone(false)
					end

					arg_119_1:ShowWeapon(var_122_3.transform, false)

					arg_119_1.var_[var_122_0 .. "Animator"] = var_122_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_119_1.var_[var_122_0 .. "Animator"].applyRootMotion = true
					arg_119_1.var_[var_122_0 .. "LipSync"] = var_122_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_122_5 = arg_119_1.actors_["1015ui_story"].transform
			local var_122_6 = 0

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.var_.moveOldPos1015ui_story = var_122_5.localPosition
			end

			local var_122_7 = 0.001

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_7 then
				local var_122_8 = (arg_119_1.time_ - var_122_6) / var_122_7
				local var_122_9 = Vector3.New(0.7, -1.15, -6.2)

				var_122_5.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1015ui_story, var_122_9, var_122_8)

				local var_122_10 = manager.ui.mainCamera.transform.position - var_122_5.position

				var_122_5.forward = Vector3.New(var_122_10.x, var_122_10.y, var_122_10.z)

				local var_122_11 = var_122_5.localEulerAngles

				var_122_11.z = 0
				var_122_11.x = 0
				var_122_5.localEulerAngles = var_122_11
			end

			if arg_119_1.time_ >= var_122_6 + var_122_7 and arg_119_1.time_ < var_122_6 + var_122_7 + arg_122_0 then
				var_122_5.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_122_12 = manager.ui.mainCamera.transform.position - var_122_5.position

				var_122_5.forward = Vector3.New(var_122_12.x, var_122_12.y, var_122_12.z)

				local var_122_13 = var_122_5.localEulerAngles

				var_122_13.z = 0
				var_122_13.x = 0
				var_122_5.localEulerAngles = var_122_13
			end

			local var_122_14 = arg_119_1.actors_["1015ui_story"]
			local var_122_15 = 0

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 and not isNil(var_122_14) and arg_119_1.var_.characterEffect1015ui_story == nil then
				arg_119_1.var_.characterEffect1015ui_story = var_122_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_16 = 0.200000002980232

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_16 and not isNil(var_122_14) then
				local var_122_17 = (arg_119_1.time_ - var_122_15) / var_122_16

				if arg_119_1.var_.characterEffect1015ui_story and not isNil(var_122_14) then
					arg_119_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_15 + var_122_16 and arg_119_1.time_ < var_122_15 + var_122_16 + arg_122_0 and not isNil(var_122_14) and arg_119_1.var_.characterEffect1015ui_story then
				arg_119_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_122_18 = 0

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_122_19 = arg_119_1.actors_["1093ui_story"].transform
			local var_122_20 = 0

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1.var_.moveOldPos1093ui_story = var_122_19.localPosition
			end

			local var_122_21 = 0.001

			if var_122_20 <= arg_119_1.time_ and arg_119_1.time_ < var_122_20 + var_122_21 then
				local var_122_22 = (arg_119_1.time_ - var_122_20) / var_122_21
				local var_122_23 = Vector3.New(-0.7, -1.11, -5.88)

				var_122_19.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1093ui_story, var_122_23, var_122_22)

				local var_122_24 = manager.ui.mainCamera.transform.position - var_122_19.position

				var_122_19.forward = Vector3.New(var_122_24.x, var_122_24.y, var_122_24.z)

				local var_122_25 = var_122_19.localEulerAngles

				var_122_25.z = 0
				var_122_25.x = 0
				var_122_19.localEulerAngles = var_122_25
			end

			if arg_119_1.time_ >= var_122_20 + var_122_21 and arg_119_1.time_ < var_122_20 + var_122_21 + arg_122_0 then
				var_122_19.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_122_26 = manager.ui.mainCamera.transform.position - var_122_19.position

				var_122_19.forward = Vector3.New(var_122_26.x, var_122_26.y, var_122_26.z)

				local var_122_27 = var_122_19.localEulerAngles

				var_122_27.z = 0
				var_122_27.x = 0
				var_122_19.localEulerAngles = var_122_27
			end

			local var_122_28 = arg_119_1.actors_["1093ui_story"]
			local var_122_29 = 0

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 and not isNil(var_122_28) and arg_119_1.var_.characterEffect1093ui_story == nil then
				arg_119_1.var_.characterEffect1093ui_story = var_122_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_30 = 0.200000002980232

			if var_122_29 <= arg_119_1.time_ and arg_119_1.time_ < var_122_29 + var_122_30 and not isNil(var_122_28) then
				local var_122_31 = (arg_119_1.time_ - var_122_29) / var_122_30

				if arg_119_1.var_.characterEffect1093ui_story and not isNil(var_122_28) then
					local var_122_32 = Mathf.Lerp(0, 0.5, var_122_31)

					arg_119_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1093ui_story.fillRatio = var_122_32
				end
			end

			if arg_119_1.time_ >= var_122_29 + var_122_30 and arg_119_1.time_ < var_122_29 + var_122_30 + arg_122_0 and not isNil(var_122_28) and arg_119_1.var_.characterEffect1093ui_story then
				local var_122_33 = 0.5

				arg_119_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1093ui_story.fillRatio = var_122_33
			end

			local var_122_34 = 0

			if var_122_34 < arg_119_1.time_ and arg_119_1.time_ <= var_122_34 + arg_122_0 then
				arg_119_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_122_35 = 0

			if var_122_35 < arg_119_1.time_ and arg_119_1.time_ <= var_122_35 + arg_122_0 then
				arg_119_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_122_36 = 0
			local var_122_37 = 0.35

			if var_122_36 < arg_119_1.time_ and arg_119_1.time_ <= var_122_36 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_38 = arg_119_1:FormatText(StoryNameCfg[479].name)

				arg_119_1.leftNameTxt_.text = var_122_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_39 = arg_119_1:GetWordFromCfg(318031029)
				local var_122_40 = arg_119_1:FormatText(var_122_39.content)

				arg_119_1.text_.text = var_122_40

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_41 = 14
				local var_122_42 = utf8.len(var_122_40)
				local var_122_43 = var_122_41 <= 0 and var_122_37 or var_122_37 * (var_122_42 / var_122_41)

				if var_122_43 > 0 and var_122_37 < var_122_43 then
					arg_119_1.talkMaxDuration = var_122_43

					if var_122_43 + var_122_36 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_43 + var_122_36
					end
				end

				arg_119_1.text_.text = var_122_40
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031029", "story_v_out_318031.awb") ~= 0 then
					local var_122_44 = manager.audio:GetVoiceLength("story_v_out_318031", "318031029", "story_v_out_318031.awb") / 1000

					if var_122_44 + var_122_36 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_44 + var_122_36
					end

					if var_122_39.prefab_name ~= "" and arg_119_1.actors_[var_122_39.prefab_name] ~= nil then
						local var_122_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_39.prefab_name].transform, "story_v_out_318031", "318031029", "story_v_out_318031.awb")

						arg_119_1:RecordAudio("318031029", var_122_45)
						arg_119_1:RecordAudio("318031029", var_122_45)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_318031", "318031029", "story_v_out_318031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_318031", "318031029", "story_v_out_318031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_46 = math.max(var_122_37, arg_119_1.talkMaxDuration)

			if var_122_36 <= arg_119_1.time_ and arg_119_1.time_ < var_122_36 + var_122_46 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_36) / var_122_46

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_36 + var_122_46 and arg_119_1.time_ < var_122_36 + var_122_46 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play318031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 318031030
		arg_123_1.duration_ = 6.37

		local var_123_0 = {
			zh = 6.366,
			ja = 4.633
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
				arg_123_0:Play318031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_1 = 0
			local var_126_2 = 0.675

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_3 = arg_123_1:FormatText(StoryNameCfg[479].name)

				arg_123_1.leftNameTxt_.text = var_126_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(318031030)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 27
				local var_126_7 = utf8.len(var_126_5)
				local var_126_8 = var_126_6 <= 0 and var_126_2 or var_126_2 * (var_126_7 / var_126_6)

				if var_126_8 > 0 and var_126_2 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031030", "story_v_out_318031.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_out_318031", "318031030", "story_v_out_318031.awb") / 1000

					if var_126_9 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_1
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_318031", "318031030", "story_v_out_318031.awb")

						arg_123_1:RecordAudio("318031030", var_126_10)
						arg_123_1:RecordAudio("318031030", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_318031", "318031030", "story_v_out_318031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_318031", "318031030", "story_v_out_318031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_11 and arg_123_1.time_ < var_126_1 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play318031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 318031031
		arg_127_1.duration_ = 10.37

		local var_127_0 = {
			zh = 5.433,
			ja = 10.366
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
				arg_127_0:Play318031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.65

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[479].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(318031031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 26
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031031", "story_v_out_318031.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031031", "story_v_out_318031.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_318031", "318031031", "story_v_out_318031.awb")

						arg_127_1:RecordAudio("318031031", var_130_9)
						arg_127_1:RecordAudio("318031031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_318031", "318031031", "story_v_out_318031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_318031", "318031031", "story_v_out_318031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play318031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 318031032
		arg_131_1.duration_ = 4.97

		local var_131_0 = {
			zh = 4.966,
			ja = 4.833
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play318031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1093ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1093ui_story == nil then
				arg_131_1.var_.characterEffect1093ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1093ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1093ui_story then
				arg_131_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_134_4 = 0

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action479")
			end

			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_134_6 = arg_131_1.actors_["1015ui_story"]
			local var_134_7 = 0

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1015ui_story == nil then
				arg_131_1.var_.characterEffect1015ui_story = var_134_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_8 = 0.200000002980232

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 and not isNil(var_134_6) then
				local var_134_9 = (arg_131_1.time_ - var_134_7) / var_134_8

				if arg_131_1.var_.characterEffect1015ui_story and not isNil(var_134_6) then
					local var_134_10 = Mathf.Lerp(0, 0.5, var_134_9)

					arg_131_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1015ui_story.fillRatio = var_134_10
				end
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1015ui_story then
				local var_134_11 = 0.5

				arg_131_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1015ui_story.fillRatio = var_134_11
			end

			local var_134_12 = 0
			local var_134_13 = 0.45

			if var_134_12 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_14 = arg_131_1:FormatText(StoryNameCfg[73].name)

				arg_131_1.leftNameTxt_.text = var_134_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_15 = arg_131_1:GetWordFromCfg(318031032)
				local var_134_16 = arg_131_1:FormatText(var_134_15.content)

				arg_131_1.text_.text = var_134_16

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 18
				local var_134_18 = utf8.len(var_134_16)
				local var_134_19 = var_134_17 <= 0 and var_134_13 or var_134_13 * (var_134_18 / var_134_17)

				if var_134_19 > 0 and var_134_13 < var_134_19 then
					arg_131_1.talkMaxDuration = var_134_19

					if var_134_19 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_16
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031032", "story_v_out_318031.awb") ~= 0 then
					local var_134_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031032", "story_v_out_318031.awb") / 1000

					if var_134_20 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_20 + var_134_12
					end

					if var_134_15.prefab_name ~= "" and arg_131_1.actors_[var_134_15.prefab_name] ~= nil then
						local var_134_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_15.prefab_name].transform, "story_v_out_318031", "318031032", "story_v_out_318031.awb")

						arg_131_1:RecordAudio("318031032", var_134_21)
						arg_131_1:RecordAudio("318031032", var_134_21)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_318031", "318031032", "story_v_out_318031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_318031", "318031032", "story_v_out_318031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_12) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_12 + var_134_22 and arg_131_1.time_ < var_134_12 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play318031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 318031033
		arg_135_1.duration_ = 6.53

		local var_135_0 = {
			zh = 4.266,
			ja = 6.533
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
				arg_135_0:Play318031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1015ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1015ui_story == nil then
				arg_135_1.var_.characterEffect1015ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1015ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1015ui_story then
				arg_135_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015actionlink/1015action426")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_138_6 = arg_135_1.actors_["1093ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1093ui_story == nil then
				arg_135_1.var_.characterEffect1093ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect1093ui_story and not isNil(var_138_6) then
					local var_138_10 = Mathf.Lerp(0, 0.5, var_138_9)

					arg_135_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1093ui_story.fillRatio = var_138_10
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1093ui_story then
				local var_138_11 = 0.5

				arg_135_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1093ui_story.fillRatio = var_138_11
			end

			local var_138_12 = 0
			local var_138_13 = 0.625

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[479].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(318031033)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 25
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031033", "story_v_out_318031.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031033", "story_v_out_318031.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_318031", "318031033", "story_v_out_318031.awb")

						arg_135_1:RecordAudio("318031033", var_138_21)
						arg_135_1:RecordAudio("318031033", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_318031", "318031033", "story_v_out_318031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_318031", "318031033", "story_v_out_318031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play318031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 318031034
		arg_139_1.duration_ = 8.5

		local var_139_0 = {
			zh = 5.633,
			ja = 8.5
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
				arg_139_0:Play318031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1093ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1093ui_story == nil then
				arg_139_1.var_.characterEffect1093ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1093ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1093ui_story then
				arg_139_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action495")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_142_6 = arg_139_1.actors_["1015ui_story"]
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1015ui_story == nil then
				arg_139_1.var_.characterEffect1015ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 and not isNil(var_142_6) then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8

				if arg_139_1.var_.characterEffect1015ui_story and not isNil(var_142_6) then
					local var_142_10 = Mathf.Lerp(0, 0.5, var_142_9)

					arg_139_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1015ui_story.fillRatio = var_142_10
				end
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1015ui_story then
				local var_142_11 = 0.5

				arg_139_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1015ui_story.fillRatio = var_142_11
			end

			local var_142_12 = 0
			local var_142_13 = 0.575

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_14 = arg_139_1:FormatText(StoryNameCfg[73].name)

				arg_139_1.leftNameTxt_.text = var_142_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_15 = arg_139_1:GetWordFromCfg(318031034)
				local var_142_16 = arg_139_1:FormatText(var_142_15.content)

				arg_139_1.text_.text = var_142_16

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 23
				local var_142_18 = utf8.len(var_142_16)
				local var_142_19 = var_142_17 <= 0 and var_142_13 or var_142_13 * (var_142_18 / var_142_17)

				if var_142_19 > 0 and var_142_13 < var_142_19 then
					arg_139_1.talkMaxDuration = var_142_19

					if var_142_19 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_16
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031034", "story_v_out_318031.awb") ~= 0 then
					local var_142_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031034", "story_v_out_318031.awb") / 1000

					if var_142_20 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_20 + var_142_12
					end

					if var_142_15.prefab_name ~= "" and arg_139_1.actors_[var_142_15.prefab_name] ~= nil then
						local var_142_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_15.prefab_name].transform, "story_v_out_318031", "318031034", "story_v_out_318031.awb")

						arg_139_1:RecordAudio("318031034", var_142_21)
						arg_139_1:RecordAudio("318031034", var_142_21)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_318031", "318031034", "story_v_out_318031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_318031", "318031034", "story_v_out_318031.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_22 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_22 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_22

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_22 and arg_139_1.time_ < var_142_12 + var_142_22 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play318031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 318031035
		arg_143_1.duration_ = 6.87

		local var_143_0 = {
			zh = 3.2,
			ja = 6.866
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
				arg_143_0:Play318031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = "1199ui_story"

			if arg_143_1.actors_[var_146_0] == nil then
				local var_146_1 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_146_1) then
					local var_146_2 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_143_1.stage_.transform)

					var_146_2.name = var_146_0
					var_146_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_143_1.actors_[var_146_0] = var_146_2

					local var_146_3 = var_146_2:GetComponentInChildren(typeof(CharacterEffect))

					var_146_3.enabled = true

					local var_146_4 = GameObjectTools.GetOrAddComponent(var_146_2, typeof(DynamicBoneHelper))

					if var_146_4 then
						var_146_4:EnableDynamicBone(false)
					end

					arg_143_1:ShowWeapon(var_146_3.transform, false)

					arg_143_1.var_[var_146_0 .. "Animator"] = var_146_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_143_1.var_[var_146_0 .. "Animator"].applyRootMotion = true
					arg_143_1.var_[var_146_0 .. "LipSync"] = var_146_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_146_5 = arg_143_1.actors_["1199ui_story"].transform
			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.var_.moveOldPos1199ui_story = var_146_5.localPosition
			end

			local var_146_7 = 0.001

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_7 then
				local var_146_8 = (arg_143_1.time_ - var_146_6) / var_146_7
				local var_146_9 = Vector3.New(0, -1.08, -5.9)

				var_146_5.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1199ui_story, var_146_9, var_146_8)

				local var_146_10 = manager.ui.mainCamera.transform.position - var_146_5.position

				var_146_5.forward = Vector3.New(var_146_10.x, var_146_10.y, var_146_10.z)

				local var_146_11 = var_146_5.localEulerAngles

				var_146_11.z = 0
				var_146_11.x = 0
				var_146_5.localEulerAngles = var_146_11
			end

			if arg_143_1.time_ >= var_146_6 + var_146_7 and arg_143_1.time_ < var_146_6 + var_146_7 + arg_146_0 then
				var_146_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_146_12 = manager.ui.mainCamera.transform.position - var_146_5.position

				var_146_5.forward = Vector3.New(var_146_12.x, var_146_12.y, var_146_12.z)

				local var_146_13 = var_146_5.localEulerAngles

				var_146_13.z = 0
				var_146_13.x = 0
				var_146_5.localEulerAngles = var_146_13
			end

			local var_146_14 = arg_143_1.actors_["1199ui_story"]
			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.characterEffect1199ui_story == nil then
				arg_143_1.var_.characterEffect1199ui_story = var_146_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_16 = 0.200000002980232

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_16 and not isNil(var_146_14) then
				local var_146_17 = (arg_143_1.time_ - var_146_15) / var_146_16

				if arg_143_1.var_.characterEffect1199ui_story and not isNil(var_146_14) then
					arg_143_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_15 + var_146_16 and arg_143_1.time_ < var_146_15 + var_146_16 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.characterEffect1199ui_story then
				arg_143_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_146_18 = 0

			if var_146_18 < arg_143_1.time_ and arg_143_1.time_ <= var_146_18 + arg_146_0 then
				arg_143_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_146_19 = 0

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_146_20 = arg_143_1.actors_["1093ui_story"].transform
			local var_146_21 = 0

			if var_146_21 < arg_143_1.time_ and arg_143_1.time_ <= var_146_21 + arg_146_0 then
				arg_143_1.var_.moveOldPos1093ui_story = var_146_20.localPosition
			end

			local var_146_22 = 0.001

			if var_146_21 <= arg_143_1.time_ and arg_143_1.time_ < var_146_21 + var_146_22 then
				local var_146_23 = (arg_143_1.time_ - var_146_21) / var_146_22
				local var_146_24 = Vector3.New(0, 100, 0)

				var_146_20.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1093ui_story, var_146_24, var_146_23)

				local var_146_25 = manager.ui.mainCamera.transform.position - var_146_20.position

				var_146_20.forward = Vector3.New(var_146_25.x, var_146_25.y, var_146_25.z)

				local var_146_26 = var_146_20.localEulerAngles

				var_146_26.z = 0
				var_146_26.x = 0
				var_146_20.localEulerAngles = var_146_26
			end

			if arg_143_1.time_ >= var_146_21 + var_146_22 and arg_143_1.time_ < var_146_21 + var_146_22 + arg_146_0 then
				var_146_20.localPosition = Vector3.New(0, 100, 0)

				local var_146_27 = manager.ui.mainCamera.transform.position - var_146_20.position

				var_146_20.forward = Vector3.New(var_146_27.x, var_146_27.y, var_146_27.z)

				local var_146_28 = var_146_20.localEulerAngles

				var_146_28.z = 0
				var_146_28.x = 0
				var_146_20.localEulerAngles = var_146_28
			end

			local var_146_29 = arg_143_1.actors_["1093ui_story"]
			local var_146_30 = 0

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 and not isNil(var_146_29) and arg_143_1.var_.characterEffect1093ui_story == nil then
				arg_143_1.var_.characterEffect1093ui_story = var_146_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_31 = 0.200000002980232

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_31 and not isNil(var_146_29) then
				local var_146_32 = (arg_143_1.time_ - var_146_30) / var_146_31

				if arg_143_1.var_.characterEffect1093ui_story and not isNil(var_146_29) then
					local var_146_33 = Mathf.Lerp(0, 0.5, var_146_32)

					arg_143_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1093ui_story.fillRatio = var_146_33
				end
			end

			if arg_143_1.time_ >= var_146_30 + var_146_31 and arg_143_1.time_ < var_146_30 + var_146_31 + arg_146_0 and not isNil(var_146_29) and arg_143_1.var_.characterEffect1093ui_story then
				local var_146_34 = 0.5

				arg_143_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1093ui_story.fillRatio = var_146_34
			end

			local var_146_35 = arg_143_1.actors_["1015ui_story"].transform
			local var_146_36 = 0

			if var_146_36 < arg_143_1.time_ and arg_143_1.time_ <= var_146_36 + arg_146_0 then
				arg_143_1.var_.moveOldPos1015ui_story = var_146_35.localPosition
			end

			local var_146_37 = 0.001

			if var_146_36 <= arg_143_1.time_ and arg_143_1.time_ < var_146_36 + var_146_37 then
				local var_146_38 = (arg_143_1.time_ - var_146_36) / var_146_37
				local var_146_39 = Vector3.New(0, 100, 0)

				var_146_35.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1015ui_story, var_146_39, var_146_38)

				local var_146_40 = manager.ui.mainCamera.transform.position - var_146_35.position

				var_146_35.forward = Vector3.New(var_146_40.x, var_146_40.y, var_146_40.z)

				local var_146_41 = var_146_35.localEulerAngles

				var_146_41.z = 0
				var_146_41.x = 0
				var_146_35.localEulerAngles = var_146_41
			end

			if arg_143_1.time_ >= var_146_36 + var_146_37 and arg_143_1.time_ < var_146_36 + var_146_37 + arg_146_0 then
				var_146_35.localPosition = Vector3.New(0, 100, 0)

				local var_146_42 = manager.ui.mainCamera.transform.position - var_146_35.position

				var_146_35.forward = Vector3.New(var_146_42.x, var_146_42.y, var_146_42.z)

				local var_146_43 = var_146_35.localEulerAngles

				var_146_43.z = 0
				var_146_43.x = 0
				var_146_35.localEulerAngles = var_146_43
			end

			local var_146_44 = 0
			local var_146_45 = 0.375

			if var_146_44 < arg_143_1.time_ and arg_143_1.time_ <= var_146_44 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_46 = arg_143_1:FormatText(StoryNameCfg[84].name)

				arg_143_1.leftNameTxt_.text = var_146_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_47 = arg_143_1:GetWordFromCfg(318031035)
				local var_146_48 = arg_143_1:FormatText(var_146_47.content)

				arg_143_1.text_.text = var_146_48

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_49 = 15
				local var_146_50 = utf8.len(var_146_48)
				local var_146_51 = var_146_49 <= 0 and var_146_45 or var_146_45 * (var_146_50 / var_146_49)

				if var_146_51 > 0 and var_146_45 < var_146_51 then
					arg_143_1.talkMaxDuration = var_146_51

					if var_146_51 + var_146_44 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_51 + var_146_44
					end
				end

				arg_143_1.text_.text = var_146_48
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031035", "story_v_out_318031.awb") ~= 0 then
					local var_146_52 = manager.audio:GetVoiceLength("story_v_out_318031", "318031035", "story_v_out_318031.awb") / 1000

					if var_146_52 + var_146_44 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_52 + var_146_44
					end

					if var_146_47.prefab_name ~= "" and arg_143_1.actors_[var_146_47.prefab_name] ~= nil then
						local var_146_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_47.prefab_name].transform, "story_v_out_318031", "318031035", "story_v_out_318031.awb")

						arg_143_1:RecordAudio("318031035", var_146_53)
						arg_143_1:RecordAudio("318031035", var_146_53)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_318031", "318031035", "story_v_out_318031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_318031", "318031035", "story_v_out_318031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_54 = math.max(var_146_45, arg_143_1.talkMaxDuration)

			if var_146_44 <= arg_143_1.time_ and arg_143_1.time_ < var_146_44 + var_146_54 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_44) / var_146_54

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_44 + var_146_54 and arg_143_1.time_ < var_146_44 + var_146_54 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play318031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 318031036
		arg_147_1.duration_ = 4.03

		local var_147_0 = {
			zh = 4,
			ja = 4.033
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play318031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1093ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1093ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(-0.7, -1.11, -5.88)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1093ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1093ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1093ui_story == nil then
				arg_147_1.var_.characterEffect1093ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1093ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1093ui_story then
				arg_147_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action459")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_150_15 = arg_147_1.actors_["1199ui_story"].transform
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.var_.moveOldPos1199ui_story = var_150_15.localPosition
			end

			local var_150_17 = 0.001

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Vector3.New(0, 100, 0)

				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1199ui_story, var_150_19, var_150_18)

				local var_150_20 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_20.x, var_150_20.y, var_150_20.z)

				local var_150_21 = var_150_15.localEulerAngles

				var_150_21.z = 0
				var_150_21.x = 0
				var_150_15.localEulerAngles = var_150_21
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(0, 100, 0)

				local var_150_22 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_22.x, var_150_22.y, var_150_22.z)

				local var_150_23 = var_150_15.localEulerAngles

				var_150_23.z = 0
				var_150_23.x = 0
				var_150_15.localEulerAngles = var_150_23
			end

			local var_150_24 = arg_147_1.actors_["1199ui_story"]
			local var_150_25 = 0

			if var_150_25 < arg_147_1.time_ and arg_147_1.time_ <= var_150_25 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect1199ui_story == nil then
				arg_147_1.var_.characterEffect1199ui_story = var_150_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_26 = 0.200000002980232

			if var_150_25 <= arg_147_1.time_ and arg_147_1.time_ < var_150_25 + var_150_26 and not isNil(var_150_24) then
				local var_150_27 = (arg_147_1.time_ - var_150_25) / var_150_26

				if arg_147_1.var_.characterEffect1199ui_story and not isNil(var_150_24) then
					local var_150_28 = Mathf.Lerp(0, 0.5, var_150_27)

					arg_147_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1199ui_story.fillRatio = var_150_28
				end
			end

			if arg_147_1.time_ >= var_150_25 + var_150_26 and arg_147_1.time_ < var_150_25 + var_150_26 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect1199ui_story then
				local var_150_29 = 0.5

				arg_147_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1199ui_story.fillRatio = var_150_29
			end

			local var_150_30 = arg_147_1.actors_["1015ui_story"].transform
			local var_150_31 = 0

			if var_150_31 < arg_147_1.time_ and arg_147_1.time_ <= var_150_31 + arg_150_0 then
				arg_147_1.var_.moveOldPos1015ui_story = var_150_30.localPosition
			end

			local var_150_32 = 0.001

			if var_150_31 <= arg_147_1.time_ and arg_147_1.time_ < var_150_31 + var_150_32 then
				local var_150_33 = (arg_147_1.time_ - var_150_31) / var_150_32
				local var_150_34 = Vector3.New(0.7, -1.15, -6.2)

				var_150_30.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1015ui_story, var_150_34, var_150_33)

				local var_150_35 = manager.ui.mainCamera.transform.position - var_150_30.position

				var_150_30.forward = Vector3.New(var_150_35.x, var_150_35.y, var_150_35.z)

				local var_150_36 = var_150_30.localEulerAngles

				var_150_36.z = 0
				var_150_36.x = 0
				var_150_30.localEulerAngles = var_150_36
			end

			if arg_147_1.time_ >= var_150_31 + var_150_32 and arg_147_1.time_ < var_150_31 + var_150_32 + arg_150_0 then
				var_150_30.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_150_37 = manager.ui.mainCamera.transform.position - var_150_30.position

				var_150_30.forward = Vector3.New(var_150_37.x, var_150_37.y, var_150_37.z)

				local var_150_38 = var_150_30.localEulerAngles

				var_150_38.z = 0
				var_150_38.x = 0
				var_150_30.localEulerAngles = var_150_38
			end

			local var_150_39 = 0

			if var_150_39 < arg_147_1.time_ and arg_147_1.time_ <= var_150_39 + arg_150_0 then
				arg_147_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action6_2")
			end

			local var_150_40 = 0

			if var_150_40 < arg_147_1.time_ and arg_147_1.time_ <= var_150_40 + arg_150_0 then
				arg_147_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_150_41 = arg_147_1.actors_["1015ui_story"]
			local var_150_42 = 0

			if var_150_42 < arg_147_1.time_ and arg_147_1.time_ <= var_150_42 + arg_150_0 and not isNil(var_150_41) and arg_147_1.var_.characterEffect1015ui_story == nil then
				arg_147_1.var_.characterEffect1015ui_story = var_150_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_43 = 0.200000002980232

			if var_150_42 <= arg_147_1.time_ and arg_147_1.time_ < var_150_42 + var_150_43 and not isNil(var_150_41) then
				local var_150_44 = (arg_147_1.time_ - var_150_42) / var_150_43

				if arg_147_1.var_.characterEffect1015ui_story and not isNil(var_150_41) then
					local var_150_45 = Mathf.Lerp(0, 0.5, var_150_44)

					arg_147_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1015ui_story.fillRatio = var_150_45
				end
			end

			if arg_147_1.time_ >= var_150_42 + var_150_43 and arg_147_1.time_ < var_150_42 + var_150_43 + arg_150_0 and not isNil(var_150_41) and arg_147_1.var_.characterEffect1015ui_story then
				local var_150_46 = 0.5

				arg_147_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1015ui_story.fillRatio = var_150_46
			end

			local var_150_47 = 0
			local var_150_48 = 0.45

			if var_150_47 < arg_147_1.time_ and arg_147_1.time_ <= var_150_47 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_49 = arg_147_1:FormatText(StoryNameCfg[73].name)

				arg_147_1.leftNameTxt_.text = var_150_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_50 = arg_147_1:GetWordFromCfg(318031036)
				local var_150_51 = arg_147_1:FormatText(var_150_50.content)

				arg_147_1.text_.text = var_150_51

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_52 = 18
				local var_150_53 = utf8.len(var_150_51)
				local var_150_54 = var_150_52 <= 0 and var_150_48 or var_150_48 * (var_150_53 / var_150_52)

				if var_150_54 > 0 and var_150_48 < var_150_54 then
					arg_147_1.talkMaxDuration = var_150_54

					if var_150_54 + var_150_47 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_54 + var_150_47
					end
				end

				arg_147_1.text_.text = var_150_51
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031036", "story_v_out_318031.awb") ~= 0 then
					local var_150_55 = manager.audio:GetVoiceLength("story_v_out_318031", "318031036", "story_v_out_318031.awb") / 1000

					if var_150_55 + var_150_47 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_55 + var_150_47
					end

					if var_150_50.prefab_name ~= "" and arg_147_1.actors_[var_150_50.prefab_name] ~= nil then
						local var_150_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_50.prefab_name].transform, "story_v_out_318031", "318031036", "story_v_out_318031.awb")

						arg_147_1:RecordAudio("318031036", var_150_56)
						arg_147_1:RecordAudio("318031036", var_150_56)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_318031", "318031036", "story_v_out_318031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_318031", "318031036", "story_v_out_318031.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_57 = math.max(var_150_48, arg_147_1.talkMaxDuration)

			if var_150_47 <= arg_147_1.time_ and arg_147_1.time_ < var_150_47 + var_150_57 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_47) / var_150_57

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_47 + var_150_57 and arg_147_1.time_ < var_150_47 + var_150_57 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318031037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 318031037
		arg_151_1.duration_ = 7.7

		local var_151_0 = {
			zh = 4.633,
			ja = 7.7
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
				arg_151_0:Play318031038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1015ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1015ui_story == nil then
				arg_151_1.var_.characterEffect1015ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1015ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1015ui_story then
				arg_151_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_6 = arg_151_1.actors_["1093ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1093ui_story == nil then
				arg_151_1.var_.characterEffect1093ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect1093ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1093ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1093ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1093ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.625

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[479].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(318031037)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 25
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031037", "story_v_out_318031.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031037", "story_v_out_318031.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_318031", "318031037", "story_v_out_318031.awb")

						arg_151_1:RecordAudio("318031037", var_154_21)
						arg_151_1:RecordAudio("318031037", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_318031", "318031037", "story_v_out_318031.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_318031", "318031037", "story_v_out_318031.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play318031038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 318031038
		arg_155_1.duration_ = 7.67

		local var_155_0 = {
			zh = 7,
			ja = 7.666
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
				arg_155_0:Play318031039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 2

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				local var_158_1 = manager.ui.mainCamera.transform.localPosition
				local var_158_2 = Vector3.New(0, 0, 10) + Vector3.New(var_158_1.x, var_158_1.y, 0)
				local var_158_3 = arg_155_1.bgs_.K01f

				var_158_3.transform.localPosition = var_158_2
				var_158_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_4 = var_158_3:GetComponent("SpriteRenderer")

				if var_158_4 and var_158_4.sprite then
					local var_158_5 = (var_158_3.transform.localPosition - var_158_1).z
					local var_158_6 = manager.ui.mainCameraCom_
					local var_158_7 = 2 * var_158_5 * Mathf.Tan(var_158_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_8 = var_158_7 * var_158_6.aspect
					local var_158_9 = var_158_4.sprite.bounds.size.x
					local var_158_10 = var_158_4.sprite.bounds.size.y
					local var_158_11 = var_158_8 / var_158_9
					local var_158_12 = var_158_7 / var_158_10
					local var_158_13 = var_158_12 < var_158_11 and var_158_11 or var_158_12

					var_158_3.transform.localScale = Vector3.New(var_158_13, var_158_13, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "K01f" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_15 = 2

			if var_158_14 <= arg_155_1.time_ and arg_155_1.time_ < var_158_14 + var_158_15 then
				local var_158_16 = (arg_155_1.time_ - var_158_14) / var_158_15
				local var_158_17 = Color.New(0, 0, 0)

				var_158_17.a = Mathf.Lerp(0, 1, var_158_16)
				arg_155_1.mask_.color = var_158_17
			end

			if arg_155_1.time_ >= var_158_14 + var_158_15 and arg_155_1.time_ < var_158_14 + var_158_15 + arg_158_0 then
				local var_158_18 = Color.New(0, 0, 0)

				var_158_18.a = 1
				arg_155_1.mask_.color = var_158_18
			end

			local var_158_19 = 2

			if var_158_19 < arg_155_1.time_ and arg_155_1.time_ <= var_158_19 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_20 = 2

			if var_158_19 <= arg_155_1.time_ and arg_155_1.time_ < var_158_19 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_19) / var_158_20
				local var_158_22 = Color.New(0, 0, 0)

				var_158_22.a = Mathf.Lerp(1, 0, var_158_21)
				arg_155_1.mask_.color = var_158_22
			end

			if arg_155_1.time_ >= var_158_19 + var_158_20 and arg_155_1.time_ < var_158_19 + var_158_20 + arg_158_0 then
				local var_158_23 = Color.New(0, 0, 0)
				local var_158_24 = 0

				arg_155_1.mask_.enabled = false
				var_158_23.a = var_158_24
				arg_155_1.mask_.color = var_158_23
			end

			local var_158_25 = arg_155_1.actors_["1015ui_story"].transform
			local var_158_26 = 1.96599999815226

			if var_158_26 < arg_155_1.time_ and arg_155_1.time_ <= var_158_26 + arg_158_0 then
				arg_155_1.var_.moveOldPos1015ui_story = var_158_25.localPosition
			end

			local var_158_27 = 0.001

			if var_158_26 <= arg_155_1.time_ and arg_155_1.time_ < var_158_26 + var_158_27 then
				local var_158_28 = (arg_155_1.time_ - var_158_26) / var_158_27
				local var_158_29 = Vector3.New(0, 100, 0)

				var_158_25.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1015ui_story, var_158_29, var_158_28)

				local var_158_30 = manager.ui.mainCamera.transform.position - var_158_25.position

				var_158_25.forward = Vector3.New(var_158_30.x, var_158_30.y, var_158_30.z)

				local var_158_31 = var_158_25.localEulerAngles

				var_158_31.z = 0
				var_158_31.x = 0
				var_158_25.localEulerAngles = var_158_31
			end

			if arg_155_1.time_ >= var_158_26 + var_158_27 and arg_155_1.time_ < var_158_26 + var_158_27 + arg_158_0 then
				var_158_25.localPosition = Vector3.New(0, 100, 0)

				local var_158_32 = manager.ui.mainCamera.transform.position - var_158_25.position

				var_158_25.forward = Vector3.New(var_158_32.x, var_158_32.y, var_158_32.z)

				local var_158_33 = var_158_25.localEulerAngles

				var_158_33.z = 0
				var_158_33.x = 0
				var_158_25.localEulerAngles = var_158_33
			end

			local var_158_34 = arg_155_1.actors_["1015ui_story"].transform
			local var_158_35 = 4

			if var_158_35 < arg_155_1.time_ and arg_155_1.time_ <= var_158_35 + arg_158_0 then
				arg_155_1.var_.moveOldPos1015ui_story = var_158_34.localPosition
			end

			local var_158_36 = 0.001

			if var_158_35 <= arg_155_1.time_ and arg_155_1.time_ < var_158_35 + var_158_36 then
				local var_158_37 = (arg_155_1.time_ - var_158_35) / var_158_36
				local var_158_38 = Vector3.New(0, -1.15, -6.2)

				var_158_34.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1015ui_story, var_158_38, var_158_37)

				local var_158_39 = manager.ui.mainCamera.transform.position - var_158_34.position

				var_158_34.forward = Vector3.New(var_158_39.x, var_158_39.y, var_158_39.z)

				local var_158_40 = var_158_34.localEulerAngles

				var_158_40.z = 0
				var_158_40.x = 0
				var_158_34.localEulerAngles = var_158_40
			end

			if arg_155_1.time_ >= var_158_35 + var_158_36 and arg_155_1.time_ < var_158_35 + var_158_36 + arg_158_0 then
				var_158_34.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_158_41 = manager.ui.mainCamera.transform.position - var_158_34.position

				var_158_34.forward = Vector3.New(var_158_41.x, var_158_41.y, var_158_41.z)

				local var_158_42 = var_158_34.localEulerAngles

				var_158_42.z = 0
				var_158_42.x = 0
				var_158_34.localEulerAngles = var_158_42
			end

			local var_158_43 = arg_155_1.actors_["1015ui_story"]
			local var_158_44 = 4

			if var_158_44 < arg_155_1.time_ and arg_155_1.time_ <= var_158_44 + arg_158_0 and not isNil(var_158_43) and arg_155_1.var_.characterEffect1015ui_story == nil then
				arg_155_1.var_.characterEffect1015ui_story = var_158_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_45 = 0.200000002980232

			if var_158_44 <= arg_155_1.time_ and arg_155_1.time_ < var_158_44 + var_158_45 and not isNil(var_158_43) then
				local var_158_46 = (arg_155_1.time_ - var_158_44) / var_158_45

				if arg_155_1.var_.characterEffect1015ui_story and not isNil(var_158_43) then
					arg_155_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_44 + var_158_45 and arg_155_1.time_ < var_158_44 + var_158_45 + arg_158_0 and not isNil(var_158_43) and arg_155_1.var_.characterEffect1015ui_story then
				arg_155_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_158_47 = 4

			if var_158_47 < arg_155_1.time_ and arg_155_1.time_ <= var_158_47 + arg_158_0 then
				arg_155_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_158_48 = 4

			if var_158_48 < arg_155_1.time_ and arg_155_1.time_ <= var_158_48 + arg_158_0 then
				arg_155_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_49 = arg_155_1.actors_["1093ui_story"].transform
			local var_158_50 = 2

			if var_158_50 < arg_155_1.time_ and arg_155_1.time_ <= var_158_50 + arg_158_0 then
				arg_155_1.var_.moveOldPos1093ui_story = var_158_49.localPosition
			end

			local var_158_51 = 0.001

			if var_158_50 <= arg_155_1.time_ and arg_155_1.time_ < var_158_50 + var_158_51 then
				local var_158_52 = (arg_155_1.time_ - var_158_50) / var_158_51
				local var_158_53 = Vector3.New(0, 100, 0)

				var_158_49.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1093ui_story, var_158_53, var_158_52)

				local var_158_54 = manager.ui.mainCamera.transform.position - var_158_49.position

				var_158_49.forward = Vector3.New(var_158_54.x, var_158_54.y, var_158_54.z)

				local var_158_55 = var_158_49.localEulerAngles

				var_158_55.z = 0
				var_158_55.x = 0
				var_158_49.localEulerAngles = var_158_55
			end

			if arg_155_1.time_ >= var_158_50 + var_158_51 and arg_155_1.time_ < var_158_50 + var_158_51 + arg_158_0 then
				var_158_49.localPosition = Vector3.New(0, 100, 0)

				local var_158_56 = manager.ui.mainCamera.transform.position - var_158_49.position

				var_158_49.forward = Vector3.New(var_158_56.x, var_158_56.y, var_158_56.z)

				local var_158_57 = var_158_49.localEulerAngles

				var_158_57.z = 0
				var_158_57.x = 0
				var_158_49.localEulerAngles = var_158_57
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_58 = 4
			local var_158_59 = 0.375

			if var_158_58 < arg_155_1.time_ and arg_155_1.time_ <= var_158_58 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_60 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_60:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_61 = arg_155_1:FormatText(StoryNameCfg[479].name)

				arg_155_1.leftNameTxt_.text = var_158_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_62 = arg_155_1:GetWordFromCfg(318031038)
				local var_158_63 = arg_155_1:FormatText(var_158_62.content)

				arg_155_1.text_.text = var_158_63

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_64 = 15
				local var_158_65 = utf8.len(var_158_63)
				local var_158_66 = var_158_64 <= 0 and var_158_59 or var_158_59 * (var_158_65 / var_158_64)

				if var_158_66 > 0 and var_158_59 < var_158_66 then
					arg_155_1.talkMaxDuration = var_158_66
					var_158_58 = var_158_58 + 0.3

					if var_158_66 + var_158_58 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_66 + var_158_58
					end
				end

				arg_155_1.text_.text = var_158_63
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031038", "story_v_out_318031.awb") ~= 0 then
					local var_158_67 = manager.audio:GetVoiceLength("story_v_out_318031", "318031038", "story_v_out_318031.awb") / 1000

					if var_158_67 + var_158_58 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_67 + var_158_58
					end

					if var_158_62.prefab_name ~= "" and arg_155_1.actors_[var_158_62.prefab_name] ~= nil then
						local var_158_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_62.prefab_name].transform, "story_v_out_318031", "318031038", "story_v_out_318031.awb")

						arg_155_1:RecordAudio("318031038", var_158_68)
						arg_155_1:RecordAudio("318031038", var_158_68)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_318031", "318031038", "story_v_out_318031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_318031", "318031038", "story_v_out_318031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_69 = var_158_58 + 0.3
			local var_158_70 = math.max(var_158_59, arg_155_1.talkMaxDuration)

			if var_158_69 <= arg_155_1.time_ and arg_155_1.time_ < var_158_69 + var_158_70 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_69) / var_158_70

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_69 + var_158_70 and arg_155_1.time_ < var_158_69 + var_158_70 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play318031039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318031039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318031040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1015ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1015ui_story == nil then
				arg_161_1.var_.characterEffect1015ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1015ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1015ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1015ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1015ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.7

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(318031039)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 28
				local var_164_11 = utf8.len(var_164_9)
				local var_164_12 = var_164_10 <= 0 and var_164_7 or var_164_7 * (var_164_11 / var_164_10)

				if var_164_12 > 0 and var_164_7 < var_164_12 then
					arg_161_1.talkMaxDuration = var_164_12

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_13 and arg_161_1.time_ < var_164_6 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318031040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318031040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318031041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.375

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(318031040)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 55
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play318031041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318031041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318031042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.6

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

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(318031041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 24
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
	Play318031042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 318031042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play318031043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.175

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(318031042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 47
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
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play318031043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 318031043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play318031044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 1.075

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[7].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(318031043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 43
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_8 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_8 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_8

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_8 and arg_177_1.time_ < var_180_0 + var_180_8 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play318031044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 318031044
		arg_181_1.duration_ = 5.43

		local var_181_0 = {
			zh = 5.066,
			ja = 5.433
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
				arg_181_0:Play318031045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1015ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1015ui_story == nil then
				arg_181_1.var_.characterEffect1015ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1015ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1015ui_story then
				arg_181_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_184_4 = 0

			if var_184_4 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_6 = 0
			local var_184_7 = 0.55

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[479].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_9 = arg_181_1:GetWordFromCfg(318031044)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 22
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031044", "story_v_out_318031.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_318031", "318031044", "story_v_out_318031.awb") / 1000

					if var_184_14 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_6
					end

					if var_184_9.prefab_name ~= "" and arg_181_1.actors_[var_184_9.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_9.prefab_name].transform, "story_v_out_318031", "318031044", "story_v_out_318031.awb")

						arg_181_1:RecordAudio("318031044", var_184_15)
						arg_181_1:RecordAudio("318031044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_318031", "318031044", "story_v_out_318031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_318031", "318031044", "story_v_out_318031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_16 and arg_181_1.time_ < var_184_6 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play318031045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 318031045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play318031046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1015ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1015ui_story == nil then
				arg_185_1.var_.characterEffect1015ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1015ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1015ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1015ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1015ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 0.4

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_8 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_9 = arg_185_1:GetWordFromCfg(318031045)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 16
				local var_188_12 = utf8.len(var_188_10)
				local var_188_13 = var_188_11 <= 0 and var_188_7 or var_188_7 * (var_188_12 / var_188_11)

				if var_188_13 > 0 and var_188_7 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_14 and arg_185_1.time_ < var_188_6 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play318031046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 318031046
		arg_189_1.duration_ = 7.1

		local var_189_0 = {
			zh = 5.133,
			ja = 7.1
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
				arg_189_0:Play318031047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1199ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1199ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.7, -1.08, -5.9)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1199ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1199ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1199ui_story == nil then
				arg_189_1.var_.characterEffect1199ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1199ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1199ui_story then
				arg_189_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_15 = arg_189_1.actors_["1015ui_story"].transform
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.var_.moveOldPos1015ui_story = var_192_15.localPosition
			end

			local var_192_17 = 0.001

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17
				local var_192_19 = Vector3.New(-0.7, -1.15, -6.2)

				var_192_15.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1015ui_story, var_192_19, var_192_18)

				local var_192_20 = manager.ui.mainCamera.transform.position - var_192_15.position

				var_192_15.forward = Vector3.New(var_192_20.x, var_192_20.y, var_192_20.z)

				local var_192_21 = var_192_15.localEulerAngles

				var_192_21.z = 0
				var_192_21.x = 0
				var_192_15.localEulerAngles = var_192_21
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				var_192_15.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_192_22 = manager.ui.mainCamera.transform.position - var_192_15.position

				var_192_15.forward = Vector3.New(var_192_22.x, var_192_22.y, var_192_22.z)

				local var_192_23 = var_192_15.localEulerAngles

				var_192_23.z = 0
				var_192_23.x = 0
				var_192_15.localEulerAngles = var_192_23
			end

			local var_192_24 = 0

			if var_192_24 < arg_189_1.time_ and arg_189_1.time_ <= var_192_24 + arg_192_0 then
				arg_189_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_192_25 = 0
			local var_192_26 = 0.65

			if var_192_25 < arg_189_1.time_ and arg_189_1.time_ <= var_192_25 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_27 = arg_189_1:FormatText(StoryNameCfg[84].name)

				arg_189_1.leftNameTxt_.text = var_192_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_28 = arg_189_1:GetWordFromCfg(318031046)
				local var_192_29 = arg_189_1:FormatText(var_192_28.content)

				arg_189_1.text_.text = var_192_29

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_30 = 26
				local var_192_31 = utf8.len(var_192_29)
				local var_192_32 = var_192_30 <= 0 and var_192_26 or var_192_26 * (var_192_31 / var_192_30)

				if var_192_32 > 0 and var_192_26 < var_192_32 then
					arg_189_1.talkMaxDuration = var_192_32

					if var_192_32 + var_192_25 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_32 + var_192_25
					end
				end

				arg_189_1.text_.text = var_192_29
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031046", "story_v_out_318031.awb") ~= 0 then
					local var_192_33 = manager.audio:GetVoiceLength("story_v_out_318031", "318031046", "story_v_out_318031.awb") / 1000

					if var_192_33 + var_192_25 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_33 + var_192_25
					end

					if var_192_28.prefab_name ~= "" and arg_189_1.actors_[var_192_28.prefab_name] ~= nil then
						local var_192_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_28.prefab_name].transform, "story_v_out_318031", "318031046", "story_v_out_318031.awb")

						arg_189_1:RecordAudio("318031046", var_192_34)
						arg_189_1:RecordAudio("318031046", var_192_34)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_318031", "318031046", "story_v_out_318031.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_318031", "318031046", "story_v_out_318031.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_35 = math.max(var_192_26, arg_189_1.talkMaxDuration)

			if var_192_25 <= arg_189_1.time_ and arg_189_1.time_ < var_192_25 + var_192_35 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_25) / var_192_35

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_25 + var_192_35 and arg_189_1.time_ < var_192_25 + var_192_35 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play318031047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 318031047
		arg_193_1.duration_ = 13.4

		local var_193_0 = {
			zh = 7.2,
			ja = 13.4
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
				arg_193_0:Play318031048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.875

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[84].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(318031047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031047", "story_v_out_318031.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031047", "story_v_out_318031.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_318031", "318031047", "story_v_out_318031.awb")

						arg_193_1:RecordAudio("318031047", var_196_9)
						arg_193_1:RecordAudio("318031047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_318031", "318031047", "story_v_out_318031.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_318031", "318031047", "story_v_out_318031.awb")
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
	Play318031048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 318031048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play318031049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1199ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1199ui_story == nil then
				arg_197_1.var_.characterEffect1199ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1199ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1199ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1199ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1199ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.85

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

				local var_200_9 = arg_197_1:GetWordFromCfg(318031048)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 34
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
	Play318031049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 318031049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play318031050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.8

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

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(318031049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 32
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
	Play318031050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 318031050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play318031051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.475

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(318031050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 59
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
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play318031051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 318031051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play318031052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.3

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

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(318031051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 51
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
	Play318031052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 318031052
		arg_213_1.duration_ = 7.77

		local var_213_0 = {
			zh = 7.1,
			ja = 7.766
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
				arg_213_0:Play318031053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1015ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1015ui_story == nil then
				arg_213_1.var_.characterEffect1015ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1015ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1015ui_story then
				arg_213_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_216_4 = 0
			local var_216_5 = 0.65

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_6 = arg_213_1:FormatText(StoryNameCfg[479].name)

				arg_213_1.leftNameTxt_.text = var_216_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(318031052)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 26
				local var_216_10 = utf8.len(var_216_8)
				local var_216_11 = var_216_9 <= 0 and var_216_5 or var_216_5 * (var_216_10 / var_216_9)

				if var_216_11 > 0 and var_216_5 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031052", "story_v_out_318031.awb") ~= 0 then
					local var_216_12 = manager.audio:GetVoiceLength("story_v_out_318031", "318031052", "story_v_out_318031.awb") / 1000

					if var_216_12 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_4
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_318031", "318031052", "story_v_out_318031.awb")

						arg_213_1:RecordAudio("318031052", var_216_13)
						arg_213_1:RecordAudio("318031052", var_216_13)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_318031", "318031052", "story_v_out_318031.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_318031", "318031052", "story_v_out_318031.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_14 and arg_213_1.time_ < var_216_4 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play318031053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 318031053
		arg_217_1.duration_ = 8.77

		local var_217_0 = {
			zh = 6,
			ja = 8.766
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
				arg_217_0:Play318031054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1015ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1015ui_story == nil then
				arg_217_1.var_.characterEffect1015ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1015ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1015ui_story then
				arg_217_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_220_4 = 0
			local var_220_5 = 0.775

			if var_220_4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_6 = arg_217_1:FormatText(StoryNameCfg[479].name)

				arg_217_1.leftNameTxt_.text = var_220_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(318031053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 31
				local var_220_10 = utf8.len(var_220_8)
				local var_220_11 = var_220_9 <= 0 and var_220_5 or var_220_5 * (var_220_10 / var_220_9)

				if var_220_11 > 0 and var_220_5 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031053", "story_v_out_318031.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_318031", "318031053", "story_v_out_318031.awb") / 1000

					if var_220_12 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_4
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_318031", "318031053", "story_v_out_318031.awb")

						arg_217_1:RecordAudio("318031053", var_220_13)
						arg_217_1:RecordAudio("318031053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_318031", "318031053", "story_v_out_318031.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_318031", "318031053", "story_v_out_318031.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_14 and arg_217_1.time_ < var_220_4 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play318031054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 318031054
		arg_221_1.duration_ = 8.1

		local var_221_0 = {
			zh = 7.433,
			ja = 8.1
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
				arg_221_0:Play318031055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.825

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[479].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(318031054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031054", "story_v_out_318031.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031054", "story_v_out_318031.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_318031", "318031054", "story_v_out_318031.awb")

						arg_221_1:RecordAudio("318031054", var_224_9)
						arg_221_1:RecordAudio("318031054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_318031", "318031054", "story_v_out_318031.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_318031", "318031054", "story_v_out_318031.awb")
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
	Play318031055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 318031055
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

			arg_225_1.choices_[1].txt.text = arg_225_1:FormatText(StoryChoiceCfg[640].name)
			arg_225_1.choices_[2].txt.text = arg_225_1:FormatText(StoryChoiceCfg[641].name)
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play318031056(arg_225_1)
			end

			if arg_227_0 == 2 then
				arg_225_0:Play318031057(arg_225_1)
			end

			arg_225_1:RecordChoiceLog(318031055, 640, 641)
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1015ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1015ui_story == nil then
				arg_225_1.var_.characterEffect1015ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1015ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1015ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1015ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1015ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			local var_228_7 = 0.5

			if arg_225_1.time_ >= var_228_6 + var_228_7 and arg_225_1.time_ < var_228_6 + var_228_7 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play318031056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 318031056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play318031058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.65

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

				local var_232_3 = arg_229_1:GetWordFromCfg(318031056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 26
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
	Play318031058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 318031058
		arg_233_1.duration_ = 2.37

		local var_233_0 = {
			zh = 1.833,
			ja = 2.366
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
				arg_233_0:Play318031059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1015ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1015ui_story == nil then
				arg_233_1.var_.characterEffect1015ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1015ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1015ui_story then
				arg_233_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_236_4 = 0
			local var_236_5 = 0.2

			if var_236_4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_6 = arg_233_1:FormatText(StoryNameCfg[479].name)

				arg_233_1.leftNameTxt_.text = var_236_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_7 = arg_233_1:GetWordFromCfg(318031058)
				local var_236_8 = arg_233_1:FormatText(var_236_7.content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 8
				local var_236_10 = utf8.len(var_236_8)
				local var_236_11 = var_236_9 <= 0 and var_236_5 or var_236_5 * (var_236_10 / var_236_9)

				if var_236_11 > 0 and var_236_5 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031058", "story_v_out_318031.awb") ~= 0 then
					local var_236_12 = manager.audio:GetVoiceLength("story_v_out_318031", "318031058", "story_v_out_318031.awb") / 1000

					if var_236_12 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_4
					end

					if var_236_7.prefab_name ~= "" and arg_233_1.actors_[var_236_7.prefab_name] ~= nil then
						local var_236_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_7.prefab_name].transform, "story_v_out_318031", "318031058", "story_v_out_318031.awb")

						arg_233_1:RecordAudio("318031058", var_236_13)
						arg_233_1:RecordAudio("318031058", var_236_13)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_318031", "318031058", "story_v_out_318031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_318031", "318031058", "story_v_out_318031.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_14 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_14 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_14

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_14 and arg_233_1.time_ < var_236_4 + var_236_14 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play318031059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 318031059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play318031060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1015ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1015ui_story == nil then
				arg_237_1.var_.characterEffect1015ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1015ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1015ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1015ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1015ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 1.025

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(318031059)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 41
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play318031060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 318031060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play318031061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.475

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

				local var_244_3 = arg_241_1:GetWordFromCfg(318031060)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 19
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
	Play318031061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 318031061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play318031062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.5

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(318031061)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 20
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
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play318031062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 318031062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play318031063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.75

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(318031062)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 30
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play318031063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 318031063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play318031064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.425

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(318031063)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 57
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play318031064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 318031064
		arg_257_1.duration_ = 6.4

		local var_257_0 = {
			zh = 6.4,
			ja = 4.733
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
				arg_257_0:Play318031065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1015ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1015ui_story == nil then
				arg_257_1.var_.characterEffect1015ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1015ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1015ui_story then
				arg_257_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_260_4 = 0

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_260_5 = 0
			local var_260_6 = 0.775

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_7 = arg_257_1:FormatText(StoryNameCfg[479].name)

				arg_257_1.leftNameTxt_.text = var_260_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:GetWordFromCfg(318031064)
				local var_260_9 = arg_257_1:FormatText(var_260_8.content)

				arg_257_1.text_.text = var_260_9

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 31
				local var_260_11 = utf8.len(var_260_9)
				local var_260_12 = var_260_10 <= 0 and var_260_6 or var_260_6 * (var_260_11 / var_260_10)

				if var_260_12 > 0 and var_260_6 < var_260_12 then
					arg_257_1.talkMaxDuration = var_260_12

					if var_260_12 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_9
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031064", "story_v_out_318031.awb") ~= 0 then
					local var_260_13 = manager.audio:GetVoiceLength("story_v_out_318031", "318031064", "story_v_out_318031.awb") / 1000

					if var_260_13 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_5
					end

					if var_260_8.prefab_name ~= "" and arg_257_1.actors_[var_260_8.prefab_name] ~= nil then
						local var_260_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_8.prefab_name].transform, "story_v_out_318031", "318031064", "story_v_out_318031.awb")

						arg_257_1:RecordAudio("318031064", var_260_14)
						arg_257_1:RecordAudio("318031064", var_260_14)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_318031", "318031064", "story_v_out_318031.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_318031", "318031064", "story_v_out_318031.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_15 = math.max(var_260_6, arg_257_1.talkMaxDuration)

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_15 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_5) / var_260_15

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_5 + var_260_15 and arg_257_1.time_ < var_260_5 + var_260_15 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play318031065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 318031065
		arg_261_1.duration_ = 2.67

		local var_261_0 = {
			zh = 2.4,
			ja = 2.666
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
				arg_261_0:Play318031066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1199ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1199ui_story == nil then
				arg_261_1.var_.characterEffect1199ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1199ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1199ui_story then
				arg_261_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_264_4 = 0

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199actionlink/1199action436")
			end

			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_264_6 = arg_261_1.actors_["1015ui_story"]
			local var_264_7 = 0

			if var_264_7 < arg_261_1.time_ and arg_261_1.time_ <= var_264_7 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1015ui_story == nil then
				arg_261_1.var_.characterEffect1015ui_story = var_264_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_8 = 0.200000002980232

			if var_264_7 <= arg_261_1.time_ and arg_261_1.time_ < var_264_7 + var_264_8 and not isNil(var_264_6) then
				local var_264_9 = (arg_261_1.time_ - var_264_7) / var_264_8

				if arg_261_1.var_.characterEffect1015ui_story and not isNil(var_264_6) then
					local var_264_10 = Mathf.Lerp(0, 0.5, var_264_9)

					arg_261_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1015ui_story.fillRatio = var_264_10
				end
			end

			if arg_261_1.time_ >= var_264_7 + var_264_8 and arg_261_1.time_ < var_264_7 + var_264_8 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1015ui_story then
				local var_264_11 = 0.5

				arg_261_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1015ui_story.fillRatio = var_264_11
			end

			local var_264_12 = 0
			local var_264_13 = 0.3

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_14 = arg_261_1:FormatText(StoryNameCfg[84].name)

				arg_261_1.leftNameTxt_.text = var_264_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(318031065)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 12
				local var_264_18 = utf8.len(var_264_16)
				local var_264_19 = var_264_17 <= 0 and var_264_13 or var_264_13 * (var_264_18 / var_264_17)

				if var_264_19 > 0 and var_264_13 < var_264_19 then
					arg_261_1.talkMaxDuration = var_264_19

					if var_264_19 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_16
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031065", "story_v_out_318031.awb") ~= 0 then
					local var_264_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031065", "story_v_out_318031.awb") / 1000

					if var_264_20 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_20 + var_264_12
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_out_318031", "318031065", "story_v_out_318031.awb")

						arg_261_1:RecordAudio("318031065", var_264_21)
						arg_261_1:RecordAudio("318031065", var_264_21)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_318031", "318031065", "story_v_out_318031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_318031", "318031065", "story_v_out_318031.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_22 and arg_261_1.time_ < var_264_12 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play318031066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 318031066
		arg_265_1.duration_ = 5.83

		local var_265_0 = {
			zh = 4.6,
			ja = 5.833
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
				arg_265_0:Play318031067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1049ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1049ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(0, -1.2, -6)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1049ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1049ui_story"]
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1049ui_story == nil then
				arg_265_1.var_.characterEffect1049ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 and not isNil(var_268_9) then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11

				if arg_265_1.var_.characterEffect1049ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1049ui_story then
				arg_265_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_268_13 = 0

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action7_1")
			end

			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_268_15 = arg_265_1.actors_["1199ui_story"].transform
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.var_.moveOldPos1199ui_story = var_268_15.localPosition
			end

			local var_268_17 = 0.001

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17
				local var_268_19 = Vector3.New(0, 100, 0)

				var_268_15.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1199ui_story, var_268_19, var_268_18)

				local var_268_20 = manager.ui.mainCamera.transform.position - var_268_15.position

				var_268_15.forward = Vector3.New(var_268_20.x, var_268_20.y, var_268_20.z)

				local var_268_21 = var_268_15.localEulerAngles

				var_268_21.z = 0
				var_268_21.x = 0
				var_268_15.localEulerAngles = var_268_21
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				var_268_15.localPosition = Vector3.New(0, 100, 0)

				local var_268_22 = manager.ui.mainCamera.transform.position - var_268_15.position

				var_268_15.forward = Vector3.New(var_268_22.x, var_268_22.y, var_268_22.z)

				local var_268_23 = var_268_15.localEulerAngles

				var_268_23.z = 0
				var_268_23.x = 0
				var_268_15.localEulerAngles = var_268_23
			end

			local var_268_24 = arg_265_1.actors_["1199ui_story"]
			local var_268_25 = 0

			if var_268_25 < arg_265_1.time_ and arg_265_1.time_ <= var_268_25 + arg_268_0 and not isNil(var_268_24) and arg_265_1.var_.characterEffect1199ui_story == nil then
				arg_265_1.var_.characterEffect1199ui_story = var_268_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_26 = 0.200000002980232

			if var_268_25 <= arg_265_1.time_ and arg_265_1.time_ < var_268_25 + var_268_26 and not isNil(var_268_24) then
				local var_268_27 = (arg_265_1.time_ - var_268_25) / var_268_26

				if arg_265_1.var_.characterEffect1199ui_story and not isNil(var_268_24) then
					local var_268_28 = Mathf.Lerp(0, 0.5, var_268_27)

					arg_265_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1199ui_story.fillRatio = var_268_28
				end
			end

			if arg_265_1.time_ >= var_268_25 + var_268_26 and arg_265_1.time_ < var_268_25 + var_268_26 + arg_268_0 and not isNil(var_268_24) and arg_265_1.var_.characterEffect1199ui_story then
				local var_268_29 = 0.5

				arg_265_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1199ui_story.fillRatio = var_268_29
			end

			local var_268_30 = arg_265_1.actors_["1015ui_story"].transform
			local var_268_31 = 0

			if var_268_31 < arg_265_1.time_ and arg_265_1.time_ <= var_268_31 + arg_268_0 then
				arg_265_1.var_.moveOldPos1015ui_story = var_268_30.localPosition
			end

			local var_268_32 = 0.001

			if var_268_31 <= arg_265_1.time_ and arg_265_1.time_ < var_268_31 + var_268_32 then
				local var_268_33 = (arg_265_1.time_ - var_268_31) / var_268_32
				local var_268_34 = Vector3.New(0, 100, 0)

				var_268_30.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1015ui_story, var_268_34, var_268_33)

				local var_268_35 = manager.ui.mainCamera.transform.position - var_268_30.position

				var_268_30.forward = Vector3.New(var_268_35.x, var_268_35.y, var_268_35.z)

				local var_268_36 = var_268_30.localEulerAngles

				var_268_36.z = 0
				var_268_36.x = 0
				var_268_30.localEulerAngles = var_268_36
			end

			if arg_265_1.time_ >= var_268_31 + var_268_32 and arg_265_1.time_ < var_268_31 + var_268_32 + arg_268_0 then
				var_268_30.localPosition = Vector3.New(0, 100, 0)

				local var_268_37 = manager.ui.mainCamera.transform.position - var_268_30.position

				var_268_30.forward = Vector3.New(var_268_37.x, var_268_37.y, var_268_37.z)

				local var_268_38 = var_268_30.localEulerAngles

				var_268_38.z = 0
				var_268_38.x = 0
				var_268_30.localEulerAngles = var_268_38
			end

			local var_268_39 = 0
			local var_268_40 = 0.45

			if var_268_39 < arg_265_1.time_ and arg_265_1.time_ <= var_268_39 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_41 = arg_265_1:FormatText(StoryNameCfg[562].name)

				arg_265_1.leftNameTxt_.text = var_268_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_42 = arg_265_1:GetWordFromCfg(318031066)
				local var_268_43 = arg_265_1:FormatText(var_268_42.content)

				arg_265_1.text_.text = var_268_43

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_44 = 18
				local var_268_45 = utf8.len(var_268_43)
				local var_268_46 = var_268_44 <= 0 and var_268_40 or var_268_40 * (var_268_45 / var_268_44)

				if var_268_46 > 0 and var_268_40 < var_268_46 then
					arg_265_1.talkMaxDuration = var_268_46

					if var_268_46 + var_268_39 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_46 + var_268_39
					end
				end

				arg_265_1.text_.text = var_268_43
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031066", "story_v_out_318031.awb") ~= 0 then
					local var_268_47 = manager.audio:GetVoiceLength("story_v_out_318031", "318031066", "story_v_out_318031.awb") / 1000

					if var_268_47 + var_268_39 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_47 + var_268_39
					end

					if var_268_42.prefab_name ~= "" and arg_265_1.actors_[var_268_42.prefab_name] ~= nil then
						local var_268_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_42.prefab_name].transform, "story_v_out_318031", "318031066", "story_v_out_318031.awb")

						arg_265_1:RecordAudio("318031066", var_268_48)
						arg_265_1:RecordAudio("318031066", var_268_48)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_318031", "318031066", "story_v_out_318031.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_318031", "318031066", "story_v_out_318031.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_49 = math.max(var_268_40, arg_265_1.talkMaxDuration)

			if var_268_39 <= arg_265_1.time_ and arg_265_1.time_ < var_268_39 + var_268_49 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_39) / var_268_49

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_39 + var_268_49 and arg_265_1.time_ < var_268_39 + var_268_49 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318031067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 318031067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play318031068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1049ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1049ui_story == nil then
				arg_269_1.var_.characterEffect1049ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1049ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1049ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1049ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1049ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0
			local var_272_7 = 0.225

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_8 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_9 = arg_269_1:GetWordFromCfg(318031067)
				local var_272_10 = arg_269_1:FormatText(var_272_9.content)

				arg_269_1.text_.text = var_272_10

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 9
				local var_272_12 = utf8.len(var_272_10)
				local var_272_13 = var_272_11 <= 0 and var_272_7 or var_272_7 * (var_272_12 / var_272_11)

				if var_272_13 > 0 and var_272_7 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_10
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play318031068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 318031068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play318031069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 1.375

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_2

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

				local var_276_3 = arg_273_1:GetWordFromCfg(318031068)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 55
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_8 and arg_273_1.time_ < var_276_0 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play318031069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 318031069
		arg_277_1.duration_ = 3.07

		local var_277_0 = {
			zh = 2.7,
			ja = 3.066
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
				arg_277_0:Play318031070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1199ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1199ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, -1.08, -5.9)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1199ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1199ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1199ui_story == nil then
				arg_277_1.var_.characterEffect1199ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect1199ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1199ui_story then
				arg_277_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_280_13 = arg_277_1.actors_["1049ui_story"].transform
			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1.var_.moveOldPos1049ui_story = var_280_13.localPosition
			end

			local var_280_15 = 0.001

			if var_280_14 <= arg_277_1.time_ and arg_277_1.time_ < var_280_14 + var_280_15 then
				local var_280_16 = (arg_277_1.time_ - var_280_14) / var_280_15
				local var_280_17 = Vector3.New(0, 100, 0)

				var_280_13.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1049ui_story, var_280_17, var_280_16)

				local var_280_18 = manager.ui.mainCamera.transform.position - var_280_13.position

				var_280_13.forward = Vector3.New(var_280_18.x, var_280_18.y, var_280_18.z)

				local var_280_19 = var_280_13.localEulerAngles

				var_280_19.z = 0
				var_280_19.x = 0
				var_280_13.localEulerAngles = var_280_19
			end

			if arg_277_1.time_ >= var_280_14 + var_280_15 and arg_277_1.time_ < var_280_14 + var_280_15 + arg_280_0 then
				var_280_13.localPosition = Vector3.New(0, 100, 0)

				local var_280_20 = manager.ui.mainCamera.transform.position - var_280_13.position

				var_280_13.forward = Vector3.New(var_280_20.x, var_280_20.y, var_280_20.z)

				local var_280_21 = var_280_13.localEulerAngles

				var_280_21.z = 0
				var_280_21.x = 0
				var_280_13.localEulerAngles = var_280_21
			end

			local var_280_22 = 0
			local var_280_23 = 0.3

			if var_280_22 < arg_277_1.time_ and arg_277_1.time_ <= var_280_22 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_24 = arg_277_1:FormatText(StoryNameCfg[84].name)

				arg_277_1.leftNameTxt_.text = var_280_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_25 = arg_277_1:GetWordFromCfg(318031069)
				local var_280_26 = arg_277_1:FormatText(var_280_25.content)

				arg_277_1.text_.text = var_280_26

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_27 = 12
				local var_280_28 = utf8.len(var_280_26)
				local var_280_29 = var_280_27 <= 0 and var_280_23 or var_280_23 * (var_280_28 / var_280_27)

				if var_280_29 > 0 and var_280_23 < var_280_29 then
					arg_277_1.talkMaxDuration = var_280_29

					if var_280_29 + var_280_22 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_29 + var_280_22
					end
				end

				arg_277_1.text_.text = var_280_26
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031069", "story_v_out_318031.awb") ~= 0 then
					local var_280_30 = manager.audio:GetVoiceLength("story_v_out_318031", "318031069", "story_v_out_318031.awb") / 1000

					if var_280_30 + var_280_22 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_30 + var_280_22
					end

					if var_280_25.prefab_name ~= "" and arg_277_1.actors_[var_280_25.prefab_name] ~= nil then
						local var_280_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_25.prefab_name].transform, "story_v_out_318031", "318031069", "story_v_out_318031.awb")

						arg_277_1:RecordAudio("318031069", var_280_31)
						arg_277_1:RecordAudio("318031069", var_280_31)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_318031", "318031069", "story_v_out_318031.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_318031", "318031069", "story_v_out_318031.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_32 = math.max(var_280_23, arg_277_1.talkMaxDuration)

			if var_280_22 <= arg_277_1.time_ and arg_277_1.time_ < var_280_22 + var_280_32 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_22) / var_280_32

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_22 + var_280_32 and arg_277_1.time_ < var_280_22 + var_280_32 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play318031070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 318031070
		arg_281_1.duration_ = 2.1

		local var_281_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_281_0:Play318031071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1093ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1093ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0.7, -1.11, -5.88)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1093ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1093ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1093ui_story == nil then
				arg_281_1.var_.characterEffect1093ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect1093ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect1093ui_story then
				arg_281_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_284_13 = arg_281_1.actors_["1199ui_story"].transform
			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1.var_.moveOldPos1199ui_story = var_284_13.localPosition
			end

			local var_284_15 = 0.001

			if var_284_14 <= arg_281_1.time_ and arg_281_1.time_ < var_284_14 + var_284_15 then
				local var_284_16 = (arg_281_1.time_ - var_284_14) / var_284_15
				local var_284_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_284_13.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1199ui_story, var_284_17, var_284_16)

				local var_284_18 = manager.ui.mainCamera.transform.position - var_284_13.position

				var_284_13.forward = Vector3.New(var_284_18.x, var_284_18.y, var_284_18.z)

				local var_284_19 = var_284_13.localEulerAngles

				var_284_19.z = 0
				var_284_19.x = 0
				var_284_13.localEulerAngles = var_284_19
			end

			if arg_281_1.time_ >= var_284_14 + var_284_15 and arg_281_1.time_ < var_284_14 + var_284_15 + arg_284_0 then
				var_284_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_284_20 = manager.ui.mainCamera.transform.position - var_284_13.position

				var_284_13.forward = Vector3.New(var_284_20.x, var_284_20.y, var_284_20.z)

				local var_284_21 = var_284_13.localEulerAngles

				var_284_21.z = 0
				var_284_21.x = 0
				var_284_13.localEulerAngles = var_284_21
			end

			local var_284_22 = arg_281_1.actors_["1199ui_story"]
			local var_284_23 = 0

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 and not isNil(var_284_22) and arg_281_1.var_.characterEffect1199ui_story == nil then
				arg_281_1.var_.characterEffect1199ui_story = var_284_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_24 = 0.200000002980232

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_24 and not isNil(var_284_22) then
				local var_284_25 = (arg_281_1.time_ - var_284_23) / var_284_24

				if arg_281_1.var_.characterEffect1199ui_story and not isNil(var_284_22) then
					local var_284_26 = Mathf.Lerp(0, 0.5, var_284_25)

					arg_281_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1199ui_story.fillRatio = var_284_26
				end
			end

			if arg_281_1.time_ >= var_284_23 + var_284_24 and arg_281_1.time_ < var_284_23 + var_284_24 + arg_284_0 and not isNil(var_284_22) and arg_281_1.var_.characterEffect1199ui_story then
				local var_284_27 = 0.5

				arg_281_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1199ui_story.fillRatio = var_284_27
			end

			local var_284_28 = 0

			if var_284_28 < arg_281_1.time_ and arg_281_1.time_ <= var_284_28 + arg_284_0 then
				arg_281_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_284_29 = 0
			local var_284_30 = 0.175

			if var_284_29 < arg_281_1.time_ and arg_281_1.time_ <= var_284_29 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_31 = arg_281_1:FormatText(StoryNameCfg[73].name)

				arg_281_1.leftNameTxt_.text = var_284_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_32 = arg_281_1:GetWordFromCfg(318031070)
				local var_284_33 = arg_281_1:FormatText(var_284_32.content)

				arg_281_1.text_.text = var_284_33

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_34 = 7
				local var_284_35 = utf8.len(var_284_33)
				local var_284_36 = var_284_34 <= 0 and var_284_30 or var_284_30 * (var_284_35 / var_284_34)

				if var_284_36 > 0 and var_284_30 < var_284_36 then
					arg_281_1.talkMaxDuration = var_284_36

					if var_284_36 + var_284_29 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_36 + var_284_29
					end
				end

				arg_281_1.text_.text = var_284_33
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031070", "story_v_out_318031.awb") ~= 0 then
					local var_284_37 = manager.audio:GetVoiceLength("story_v_out_318031", "318031070", "story_v_out_318031.awb") / 1000

					if var_284_37 + var_284_29 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_37 + var_284_29
					end

					if var_284_32.prefab_name ~= "" and arg_281_1.actors_[var_284_32.prefab_name] ~= nil then
						local var_284_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_32.prefab_name].transform, "story_v_out_318031", "318031070", "story_v_out_318031.awb")

						arg_281_1:RecordAudio("318031070", var_284_38)
						arg_281_1:RecordAudio("318031070", var_284_38)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_318031", "318031070", "story_v_out_318031.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_318031", "318031070", "story_v_out_318031.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_39 = math.max(var_284_30, arg_281_1.talkMaxDuration)

			if var_284_29 <= arg_281_1.time_ and arg_281_1.time_ < var_284_29 + var_284_39 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_29) / var_284_39

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_29 + var_284_39 and arg_281_1.time_ < var_284_29 + var_284_39 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318031071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 318031071
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play318031072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1093ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1093ui_story == nil then
				arg_285_1.var_.characterEffect1093ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1093ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1093ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1093ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1093ui_story.fillRatio = var_288_5
			end

			local var_288_6 = arg_285_1.actors_["1093ui_story"].transform
			local var_288_7 = 0

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 then
				arg_285_1.var_.moveOldPos1093ui_story = var_288_6.localPosition
			end

			local var_288_8 = 0.001

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_8 then
				local var_288_9 = (arg_285_1.time_ - var_288_7) / var_288_8
				local var_288_10 = Vector3.New(0, 100, 0)

				var_288_6.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1093ui_story, var_288_10, var_288_9)

				local var_288_11 = manager.ui.mainCamera.transform.position - var_288_6.position

				var_288_6.forward = Vector3.New(var_288_11.x, var_288_11.y, var_288_11.z)

				local var_288_12 = var_288_6.localEulerAngles

				var_288_12.z = 0
				var_288_12.x = 0
				var_288_6.localEulerAngles = var_288_12
			end

			if arg_285_1.time_ >= var_288_7 + var_288_8 and arg_285_1.time_ < var_288_7 + var_288_8 + arg_288_0 then
				var_288_6.localPosition = Vector3.New(0, 100, 0)

				local var_288_13 = manager.ui.mainCamera.transform.position - var_288_6.position

				var_288_6.forward = Vector3.New(var_288_13.x, var_288_13.y, var_288_13.z)

				local var_288_14 = var_288_6.localEulerAngles

				var_288_14.z = 0
				var_288_14.x = 0
				var_288_6.localEulerAngles = var_288_14
			end

			local var_288_15 = arg_285_1.actors_["1199ui_story"].transform
			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.var_.moveOldPos1199ui_story = var_288_15.localPosition
			end

			local var_288_17 = 0.001

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17
				local var_288_19 = Vector3.New(0, 100, 0)

				var_288_15.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1199ui_story, var_288_19, var_288_18)

				local var_288_20 = manager.ui.mainCamera.transform.position - var_288_15.position

				var_288_15.forward = Vector3.New(var_288_20.x, var_288_20.y, var_288_20.z)

				local var_288_21 = var_288_15.localEulerAngles

				var_288_21.z = 0
				var_288_21.x = 0
				var_288_15.localEulerAngles = var_288_21
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 then
				var_288_15.localPosition = Vector3.New(0, 100, 0)

				local var_288_22 = manager.ui.mainCamera.transform.position - var_288_15.position

				var_288_15.forward = Vector3.New(var_288_22.x, var_288_22.y, var_288_22.z)

				local var_288_23 = var_288_15.localEulerAngles

				var_288_23.z = 0
				var_288_23.x = 0
				var_288_15.localEulerAngles = var_288_23
			end

			local var_288_24 = arg_285_1.actors_["10053ui_story"].transform
			local var_288_25 = 0

			if var_288_25 < arg_285_1.time_ and arg_285_1.time_ <= var_288_25 + arg_288_0 then
				arg_285_1.var_.moveOldPos10053ui_story = var_288_24.localPosition
			end

			local var_288_26 = 0.001

			if var_288_25 <= arg_285_1.time_ and arg_285_1.time_ < var_288_25 + var_288_26 then
				local var_288_27 = (arg_285_1.time_ - var_288_25) / var_288_26
				local var_288_28 = Vector3.New(0, -1.12, -5.99)

				var_288_24.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10053ui_story, var_288_28, var_288_27)

				local var_288_29 = manager.ui.mainCamera.transform.position - var_288_24.position

				var_288_24.forward = Vector3.New(var_288_29.x, var_288_29.y, var_288_29.z)

				local var_288_30 = var_288_24.localEulerAngles

				var_288_30.z = 0
				var_288_30.x = 0
				var_288_24.localEulerAngles = var_288_30
			end

			if arg_285_1.time_ >= var_288_25 + var_288_26 and arg_285_1.time_ < var_288_25 + var_288_26 + arg_288_0 then
				var_288_24.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_288_31 = manager.ui.mainCamera.transform.position - var_288_24.position

				var_288_24.forward = Vector3.New(var_288_31.x, var_288_31.y, var_288_31.z)

				local var_288_32 = var_288_24.localEulerAngles

				var_288_32.z = 0
				var_288_32.x = 0
				var_288_24.localEulerAngles = var_288_32
			end

			local var_288_33 = 0

			if var_288_33 < arg_285_1.time_ and arg_285_1.time_ <= var_288_33 + arg_288_0 then
				arg_285_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_288_34 = 0

			if var_288_34 < arg_285_1.time_ and arg_285_1.time_ <= var_288_34 + arg_288_0 then
				arg_285_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_288_35 = 0
			local var_288_36 = 1.125

			if var_288_35 < arg_285_1.time_ and arg_285_1.time_ <= var_288_35 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_37 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_37

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

				local var_288_38 = arg_285_1:GetWordFromCfg(318031071)
				local var_288_39 = arg_285_1:FormatText(var_288_38.content)

				arg_285_1.text_.text = var_288_39

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_40 = 45
				local var_288_41 = utf8.len(var_288_39)
				local var_288_42 = var_288_40 <= 0 and var_288_36 or var_288_36 * (var_288_41 / var_288_40)

				if var_288_42 > 0 and var_288_36 < var_288_42 then
					arg_285_1.talkMaxDuration = var_288_42

					if var_288_42 + var_288_35 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_42 + var_288_35
					end
				end

				arg_285_1.text_.text = var_288_39
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_43 = math.max(var_288_36, arg_285_1.talkMaxDuration)

			if var_288_35 <= arg_285_1.time_ and arg_285_1.time_ < var_288_35 + var_288_43 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_35) / var_288_43

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_35 + var_288_43 and arg_285_1.time_ < var_288_35 + var_288_43 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play318031072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 318031072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play318031073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10053ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10053ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, 100, 0)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10053ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, 100, 0)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = "1058ui_story"

			if arg_289_1.actors_[var_292_9] == nil then
				local var_292_10 = Asset.Load("Char/" .. "1058ui_story")

				if not isNil(var_292_10) then
					local var_292_11 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_289_1.stage_.transform)

					var_292_11.name = var_292_9
					var_292_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_289_1.actors_[var_292_9] = var_292_11

					local var_292_12 = var_292_11:GetComponentInChildren(typeof(CharacterEffect))

					var_292_12.enabled = true

					local var_292_13 = GameObjectTools.GetOrAddComponent(var_292_11, typeof(DynamicBoneHelper))

					if var_292_13 then
						var_292_13:EnableDynamicBone(false)
					end

					arg_289_1:ShowWeapon(var_292_12.transform, false)

					arg_289_1.var_[var_292_9 .. "Animator"] = var_292_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_289_1.var_[var_292_9 .. "Animator"].applyRootMotion = true
					arg_289_1.var_[var_292_9 .. "LipSync"] = var_292_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			local var_292_15 = 0

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_292_16 = arg_289_1.actors_["1058ui_story"].transform
			local var_292_17 = 0

			if var_292_17 < arg_289_1.time_ and arg_289_1.time_ <= var_292_17 + arg_292_0 then
				arg_289_1.var_.moveOldPos1058ui_story = var_292_16.localPosition
			end

			local var_292_18 = 0.001

			if var_292_17 <= arg_289_1.time_ and arg_289_1.time_ < var_292_17 + var_292_18 then
				local var_292_19 = (arg_289_1.time_ - var_292_17) / var_292_18
				local var_292_20 = Vector3.New(-0.7, -0.95, -5.88)

				var_292_16.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1058ui_story, var_292_20, var_292_19)

				local var_292_21 = manager.ui.mainCamera.transform.position - var_292_16.position

				var_292_16.forward = Vector3.New(var_292_21.x, var_292_21.y, var_292_21.z)

				local var_292_22 = var_292_16.localEulerAngles

				var_292_22.z = 0
				var_292_22.x = 0
				var_292_16.localEulerAngles = var_292_22
			end

			if arg_289_1.time_ >= var_292_17 + var_292_18 and arg_289_1.time_ < var_292_17 + var_292_18 + arg_292_0 then
				var_292_16.localPosition = Vector3.New(-0.7, -0.95, -5.88)

				local var_292_23 = manager.ui.mainCamera.transform.position - var_292_16.position

				var_292_16.forward = Vector3.New(var_292_23.x, var_292_23.y, var_292_23.z)

				local var_292_24 = var_292_16.localEulerAngles

				var_292_24.z = 0
				var_292_24.x = 0
				var_292_16.localEulerAngles = var_292_24
			end

			local var_292_25 = arg_289_1.actors_["1058ui_story"]
			local var_292_26 = 0

			if var_292_26 < arg_289_1.time_ and arg_289_1.time_ <= var_292_26 + arg_292_0 and not isNil(var_292_25) and arg_289_1.var_.characterEffect1058ui_story == nil then
				arg_289_1.var_.characterEffect1058ui_story = var_292_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_27 = 0.0166666666666667

			if var_292_26 <= arg_289_1.time_ and arg_289_1.time_ < var_292_26 + var_292_27 and not isNil(var_292_25) then
				local var_292_28 = (arg_289_1.time_ - var_292_26) / var_292_27

				if arg_289_1.var_.characterEffect1058ui_story and not isNil(var_292_25) then
					local var_292_29 = Mathf.Lerp(0, 0.5, var_292_28)

					arg_289_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1058ui_story.fillRatio = var_292_29
				end
			end

			if arg_289_1.time_ >= var_292_26 + var_292_27 and arg_289_1.time_ < var_292_26 + var_292_27 + arg_292_0 and not isNil(var_292_25) and arg_289_1.var_.characterEffect1058ui_story then
				local var_292_30 = 0.5

				arg_289_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1058ui_story.fillRatio = var_292_30
			end

			local var_292_31 = arg_289_1.actors_["1049ui_story"]
			local var_292_32 = 0

			if var_292_32 < arg_289_1.time_ and arg_289_1.time_ <= var_292_32 + arg_292_0 and not isNil(var_292_31) and arg_289_1.var_.characterEffect1049ui_story == nil then
				arg_289_1.var_.characterEffect1049ui_story = var_292_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_33 = 0.0166666666666667

			if var_292_32 <= arg_289_1.time_ and arg_289_1.time_ < var_292_32 + var_292_33 and not isNil(var_292_31) then
				local var_292_34 = (arg_289_1.time_ - var_292_32) / var_292_33

				if arg_289_1.var_.characterEffect1049ui_story and not isNil(var_292_31) then
					local var_292_35 = Mathf.Lerp(0, 0.5, var_292_34)

					arg_289_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1049ui_story.fillRatio = var_292_35
				end
			end

			if arg_289_1.time_ >= var_292_32 + var_292_33 and arg_289_1.time_ < var_292_32 + var_292_33 + arg_292_0 and not isNil(var_292_31) and arg_289_1.var_.characterEffect1049ui_story then
				local var_292_36 = 0.5

				arg_289_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1049ui_story.fillRatio = var_292_36
			end

			local var_292_37 = arg_289_1.actors_["1049ui_story"].transform
			local var_292_38 = 0

			if var_292_38 < arg_289_1.time_ and arg_289_1.time_ <= var_292_38 + arg_292_0 then
				arg_289_1.var_.moveOldPos1049ui_story = var_292_37.localPosition
			end

			local var_292_39 = 0.001

			if var_292_38 <= arg_289_1.time_ and arg_289_1.time_ < var_292_38 + var_292_39 then
				local var_292_40 = (arg_289_1.time_ - var_292_38) / var_292_39
				local var_292_41 = Vector3.New(0.7, -1.2, -6)

				var_292_37.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1049ui_story, var_292_41, var_292_40)

				local var_292_42 = manager.ui.mainCamera.transform.position - var_292_37.position

				var_292_37.forward = Vector3.New(var_292_42.x, var_292_42.y, var_292_42.z)

				local var_292_43 = var_292_37.localEulerAngles

				var_292_43.z = 0
				var_292_43.x = 0
				var_292_37.localEulerAngles = var_292_43
			end

			if arg_289_1.time_ >= var_292_38 + var_292_39 and arg_289_1.time_ < var_292_38 + var_292_39 + arg_292_0 then
				var_292_37.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_292_44 = manager.ui.mainCamera.transform.position - var_292_37.position

				var_292_37.forward = Vector3.New(var_292_44.x, var_292_44.y, var_292_44.z)

				local var_292_45 = var_292_37.localEulerAngles

				var_292_45.z = 0
				var_292_45.x = 0
				var_292_37.localEulerAngles = var_292_45
			end

			local var_292_46 = 0

			if var_292_46 < arg_289_1.time_ and arg_289_1.time_ <= var_292_46 + arg_292_0 then
				arg_289_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_292_47 = arg_289_1.actors_["1049ui_story"]
			local var_292_48 = 0

			if var_292_48 < arg_289_1.time_ and arg_289_1.time_ <= var_292_48 + arg_292_0 and not isNil(var_292_47) and arg_289_1.var_.characterEffect1049ui_story == nil then
				arg_289_1.var_.characterEffect1049ui_story = var_292_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_49 = 0.0166666666666667

			if var_292_48 <= arg_289_1.time_ and arg_289_1.time_ < var_292_48 + var_292_49 and not isNil(var_292_47) then
				local var_292_50 = (arg_289_1.time_ - var_292_48) / var_292_49

				if arg_289_1.var_.characterEffect1049ui_story and not isNil(var_292_47) then
					local var_292_51 = Mathf.Lerp(0, 0.5, var_292_50)

					arg_289_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1049ui_story.fillRatio = var_292_51
				end
			end

			if arg_289_1.time_ >= var_292_48 + var_292_49 and arg_289_1.time_ < var_292_48 + var_292_49 + arg_292_0 and not isNil(var_292_47) and arg_289_1.var_.characterEffect1049ui_story then
				local var_292_52 = 0.5

				arg_289_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1049ui_story.fillRatio = var_292_52
			end

			local var_292_53 = 0
			local var_292_54 = 0.825

			if var_292_53 < arg_289_1.time_ and arg_289_1.time_ <= var_292_53 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_55 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_56 = arg_289_1:GetWordFromCfg(318031072)
				local var_292_57 = arg_289_1:FormatText(var_292_56.content)

				arg_289_1.text_.text = var_292_57

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_58 = 33
				local var_292_59 = utf8.len(var_292_57)
				local var_292_60 = var_292_58 <= 0 and var_292_54 or var_292_54 * (var_292_59 / var_292_58)

				if var_292_60 > 0 and var_292_54 < var_292_60 then
					arg_289_1.talkMaxDuration = var_292_60

					if var_292_60 + var_292_53 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_60 + var_292_53
					end
				end

				arg_289_1.text_.text = var_292_57
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_61 = math.max(var_292_54, arg_289_1.talkMaxDuration)

			if var_292_53 <= arg_289_1.time_ and arg_289_1.time_ < var_292_53 + var_292_61 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_53) / var_292_61

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_53 + var_292_61 and arg_289_1.time_ < var_292_53 + var_292_61 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play318031073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 318031073
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play318031074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1049ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1049ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, 100, 0)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1049ui_story, var_296_4, var_296_3)

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

			local var_296_9 = arg_293_1.actors_["1058ui_story"].transform
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1.var_.moveOldPos1058ui_story = var_296_9.localPosition
			end

			local var_296_11 = 0.001

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11
				local var_296_13 = Vector3.New(0, 100, 0)

				var_296_9.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1058ui_story, var_296_13, var_296_12)

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

			local var_296_18 = arg_293_1.actors_["1015ui_story"].transform
			local var_296_19 = 0

			if var_296_19 < arg_293_1.time_ and arg_293_1.time_ <= var_296_19 + arg_296_0 then
				arg_293_1.var_.moveOldPos1015ui_story = var_296_18.localPosition
			end

			local var_296_20 = 0.001

			if var_296_19 <= arg_293_1.time_ and arg_293_1.time_ < var_296_19 + var_296_20 then
				local var_296_21 = (arg_293_1.time_ - var_296_19) / var_296_20
				local var_296_22 = Vector3.New(0, -1.15, -6.2)

				var_296_18.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1015ui_story, var_296_22, var_296_21)

				local var_296_23 = manager.ui.mainCamera.transform.position - var_296_18.position

				var_296_18.forward = Vector3.New(var_296_23.x, var_296_23.y, var_296_23.z)

				local var_296_24 = var_296_18.localEulerAngles

				var_296_24.z = 0
				var_296_24.x = 0
				var_296_18.localEulerAngles = var_296_24
			end

			if arg_293_1.time_ >= var_296_19 + var_296_20 and arg_293_1.time_ < var_296_19 + var_296_20 + arg_296_0 then
				var_296_18.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_296_25 = manager.ui.mainCamera.transform.position - var_296_18.position

				var_296_18.forward = Vector3.New(var_296_25.x, var_296_25.y, var_296_25.z)

				local var_296_26 = var_296_18.localEulerAngles

				var_296_26.z = 0
				var_296_26.x = 0
				var_296_18.localEulerAngles = var_296_26
			end

			local var_296_27 = 0

			if var_296_27 < arg_293_1.time_ and arg_293_1.time_ <= var_296_27 + arg_296_0 then
				arg_293_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_296_28 = 0
			local var_296_29 = 0.975

			if var_296_28 < arg_293_1.time_ and arg_293_1.time_ <= var_296_28 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_30 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_31 = arg_293_1:GetWordFromCfg(318031073)
				local var_296_32 = arg_293_1:FormatText(var_296_31.content)

				arg_293_1.text_.text = var_296_32

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_33 = 39
				local var_296_34 = utf8.len(var_296_32)
				local var_296_35 = var_296_33 <= 0 and var_296_29 or var_296_29 * (var_296_34 / var_296_33)

				if var_296_35 > 0 and var_296_29 < var_296_35 then
					arg_293_1.talkMaxDuration = var_296_35

					if var_296_35 + var_296_28 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_35 + var_296_28
					end
				end

				arg_293_1.text_.text = var_296_32
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_36 = math.max(var_296_29, arg_293_1.talkMaxDuration)

			if var_296_28 <= arg_293_1.time_ and arg_293_1.time_ < var_296_28 + var_296_36 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_28) / var_296_36

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_28 + var_296_36 and arg_293_1.time_ < var_296_28 + var_296_36 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play318031074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 318031074
		arg_297_1.duration_ = 8.33

		local var_297_0 = {
			zh = 4.966,
			ja = 8.333
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play318031075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1015ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1015ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, -1.15, -6.2)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1015ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1015ui_story"]
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1015ui_story == nil then
				arg_297_1.var_.characterEffect1015ui_story = var_300_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_11 = 0.200000002980232

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 and not isNil(var_300_9) then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11

				if arg_297_1.var_.characterEffect1015ui_story and not isNil(var_300_9) then
					arg_297_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect1015ui_story then
				arg_297_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_300_13 = 0

			if var_300_13 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_300_15 = arg_297_1.actors_["1199ui_story"].transform
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.var_.moveOldPos1199ui_story = var_300_15.localPosition
			end

			local var_300_17 = 0.001

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17
				local var_300_19 = Vector3.New(0, 100, 0)

				var_300_15.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1199ui_story, var_300_19, var_300_18)

				local var_300_20 = manager.ui.mainCamera.transform.position - var_300_15.position

				var_300_15.forward = Vector3.New(var_300_20.x, var_300_20.y, var_300_20.z)

				local var_300_21 = var_300_15.localEulerAngles

				var_300_21.z = 0
				var_300_21.x = 0
				var_300_15.localEulerAngles = var_300_21
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 then
				var_300_15.localPosition = Vector3.New(0, 100, 0)

				local var_300_22 = manager.ui.mainCamera.transform.position - var_300_15.position

				var_300_15.forward = Vector3.New(var_300_22.x, var_300_22.y, var_300_22.z)

				local var_300_23 = var_300_15.localEulerAngles

				var_300_23.z = 0
				var_300_23.x = 0
				var_300_15.localEulerAngles = var_300_23
			end

			local var_300_24 = arg_297_1.actors_["1093ui_story"].transform
			local var_300_25 = 0

			if var_300_25 < arg_297_1.time_ and arg_297_1.time_ <= var_300_25 + arg_300_0 then
				arg_297_1.var_.moveOldPos1093ui_story = var_300_24.localPosition
			end

			local var_300_26 = 0.001

			if var_300_25 <= arg_297_1.time_ and arg_297_1.time_ < var_300_25 + var_300_26 then
				local var_300_27 = (arg_297_1.time_ - var_300_25) / var_300_26
				local var_300_28 = Vector3.New(0, 100, 0)

				var_300_24.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1093ui_story, var_300_28, var_300_27)

				local var_300_29 = manager.ui.mainCamera.transform.position - var_300_24.position

				var_300_24.forward = Vector3.New(var_300_29.x, var_300_29.y, var_300_29.z)

				local var_300_30 = var_300_24.localEulerAngles

				var_300_30.z = 0
				var_300_30.x = 0
				var_300_24.localEulerAngles = var_300_30
			end

			if arg_297_1.time_ >= var_300_25 + var_300_26 and arg_297_1.time_ < var_300_25 + var_300_26 + arg_300_0 then
				var_300_24.localPosition = Vector3.New(0, 100, 0)

				local var_300_31 = manager.ui.mainCamera.transform.position - var_300_24.position

				var_300_24.forward = Vector3.New(var_300_31.x, var_300_31.y, var_300_31.z)

				local var_300_32 = var_300_24.localEulerAngles

				var_300_32.z = 0
				var_300_32.x = 0
				var_300_24.localEulerAngles = var_300_32
			end

			local var_300_33 = 0
			local var_300_34 = 0.625

			if var_300_33 < arg_297_1.time_ and arg_297_1.time_ <= var_300_33 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_35 = arg_297_1:FormatText(StoryNameCfg[479].name)

				arg_297_1.leftNameTxt_.text = var_300_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_36 = arg_297_1:GetWordFromCfg(318031074)
				local var_300_37 = arg_297_1:FormatText(var_300_36.content)

				arg_297_1.text_.text = var_300_37

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_38 = 25
				local var_300_39 = utf8.len(var_300_37)
				local var_300_40 = var_300_38 <= 0 and var_300_34 or var_300_34 * (var_300_39 / var_300_38)

				if var_300_40 > 0 and var_300_34 < var_300_40 then
					arg_297_1.talkMaxDuration = var_300_40

					if var_300_40 + var_300_33 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_40 + var_300_33
					end
				end

				arg_297_1.text_.text = var_300_37
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031074", "story_v_out_318031.awb") ~= 0 then
					local var_300_41 = manager.audio:GetVoiceLength("story_v_out_318031", "318031074", "story_v_out_318031.awb") / 1000

					if var_300_41 + var_300_33 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_41 + var_300_33
					end

					if var_300_36.prefab_name ~= "" and arg_297_1.actors_[var_300_36.prefab_name] ~= nil then
						local var_300_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_36.prefab_name].transform, "story_v_out_318031", "318031074", "story_v_out_318031.awb")

						arg_297_1:RecordAudio("318031074", var_300_42)
						arg_297_1:RecordAudio("318031074", var_300_42)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_318031", "318031074", "story_v_out_318031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_318031", "318031074", "story_v_out_318031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_43 = math.max(var_300_34, arg_297_1.talkMaxDuration)

			if var_300_33 <= arg_297_1.time_ and arg_297_1.time_ < var_300_33 + var_300_43 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_33) / var_300_43

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_33 + var_300_43 and arg_297_1.time_ < var_300_33 + var_300_43 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play318031075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 318031075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play318031076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1015ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1015ui_story == nil then
				arg_301_1.var_.characterEffect1015ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1015ui_story and not isNil(var_304_0) then
					local var_304_4 = Mathf.Lerp(0, 0.5, var_304_3)

					arg_301_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1015ui_story.fillRatio = var_304_4
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1015ui_story then
				local var_304_5 = 0.5

				arg_301_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1015ui_story.fillRatio = var_304_5
			end

			local var_304_6 = 0
			local var_304_7 = 1.025

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_8 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_9 = arg_301_1:GetWordFromCfg(318031075)
				local var_304_10 = arg_301_1:FormatText(var_304_9.content)

				arg_301_1.text_.text = var_304_10

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 41
				local var_304_12 = utf8.len(var_304_10)
				local var_304_13 = var_304_11 <= 0 and var_304_7 or var_304_7 * (var_304_12 / var_304_11)

				if var_304_13 > 0 and var_304_7 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_10
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play318031076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 318031076
		arg_305_1.duration_ = 6.77

		local var_305_0 = {
			zh = 3.333,
			ja = 6.766
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play318031077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1015ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1015ui_story == nil then
				arg_305_1.var_.characterEffect1015ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1015ui_story and not isNil(var_308_0) then
					arg_305_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1015ui_story then
				arg_305_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_308_4 = 0

			if var_308_4 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_308_5 = 0

			if var_308_5 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_308_6 = 0
			local var_308_7 = 0.3

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[479].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_9 = arg_305_1:GetWordFromCfg(318031076)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031076", "story_v_out_318031.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_318031", "318031076", "story_v_out_318031.awb") / 1000

					if var_308_14 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_6
					end

					if var_308_9.prefab_name ~= "" and arg_305_1.actors_[var_308_9.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_9.prefab_name].transform, "story_v_out_318031", "318031076", "story_v_out_318031.awb")

						arg_305_1:RecordAudio("318031076", var_308_15)
						arg_305_1:RecordAudio("318031076", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_318031", "318031076", "story_v_out_318031.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_318031", "318031076", "story_v_out_318031.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_16 and arg_305_1.time_ < var_308_6 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play318031077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 318031077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play318031078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1015ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1015ui_story == nil then
				arg_309_1.var_.characterEffect1015ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1015ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1015ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1015ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1015ui_story.fillRatio = var_312_5
			end

			local var_312_6 = 0
			local var_312_7 = 1.1

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_8 = arg_309_1:GetWordFromCfg(318031077)
				local var_312_9 = arg_309_1:FormatText(var_312_8.content)

				arg_309_1.text_.text = var_312_9

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 44
				local var_312_11 = utf8.len(var_312_9)
				local var_312_12 = var_312_10 <= 0 and var_312_7 or var_312_7 * (var_312_11 / var_312_10)

				if var_312_12 > 0 and var_312_7 < var_312_12 then
					arg_309_1.talkMaxDuration = var_312_12

					if var_312_12 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_12 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_9
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_13 and arg_309_1.time_ < var_312_6 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play318031078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 318031078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play318031079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.475

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(318031078)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 19
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play318031079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 318031079
		arg_317_1.duration_ = 7

		local var_317_0 = {
			zh = 7,
			ja = 6.266
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
				arg_317_0:Play318031080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1015ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1015ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0, -1.15, -6.2)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1015ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1015ui_story"]
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1015ui_story == nil then
				arg_317_1.var_.characterEffect1015ui_story = var_320_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 and not isNil(var_320_9) then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11

				if arg_317_1.var_.characterEffect1015ui_story and not isNil(var_320_9) then
					arg_317_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect1015ui_story then
				arg_317_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_320_13 = 0

			if var_320_13 < arg_317_1.time_ and arg_317_1.time_ <= var_320_13 + arg_320_0 then
				arg_317_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action3_1")
			end

			local var_320_14 = 0

			if var_320_14 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 then
				arg_317_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_320_15 = 0
			local var_320_16 = 0.55

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_17 = arg_317_1:FormatText(StoryNameCfg[479].name)

				arg_317_1.leftNameTxt_.text = var_320_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_18 = arg_317_1:GetWordFromCfg(318031079)
				local var_320_19 = arg_317_1:FormatText(var_320_18.content)

				arg_317_1.text_.text = var_320_19

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_20 = 22
				local var_320_21 = utf8.len(var_320_19)
				local var_320_22 = var_320_20 <= 0 and var_320_16 or var_320_16 * (var_320_21 / var_320_20)

				if var_320_22 > 0 and var_320_16 < var_320_22 then
					arg_317_1.talkMaxDuration = var_320_22

					if var_320_22 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_22 + var_320_15
					end
				end

				arg_317_1.text_.text = var_320_19
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031079", "story_v_out_318031.awb") ~= 0 then
					local var_320_23 = manager.audio:GetVoiceLength("story_v_out_318031", "318031079", "story_v_out_318031.awb") / 1000

					if var_320_23 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_23 + var_320_15
					end

					if var_320_18.prefab_name ~= "" and arg_317_1.actors_[var_320_18.prefab_name] ~= nil then
						local var_320_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_18.prefab_name].transform, "story_v_out_318031", "318031079", "story_v_out_318031.awb")

						arg_317_1:RecordAudio("318031079", var_320_24)
						arg_317_1:RecordAudio("318031079", var_320_24)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_318031", "318031079", "story_v_out_318031.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_318031", "318031079", "story_v_out_318031.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_25 = math.max(var_320_16, arg_317_1.talkMaxDuration)

			if var_320_15 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_25 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_15) / var_320_25

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_15 + var_320_25 and arg_317_1.time_ < var_320_15 + var_320_25 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318031080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 318031080
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play318031081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1015ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1015ui_story == nil then
				arg_321_1.var_.characterEffect1015ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1015ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1015ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1015ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1015ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.175

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(318031080)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 7
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play318031081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 318031081
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play318031082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1015ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1015ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, 100, 0)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1015ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, 100, 0)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = 0
			local var_328_10 = 0.6

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_11 = arg_325_1:GetWordFromCfg(318031081)
				local var_328_12 = arg_325_1:FormatText(var_328_11.content)

				arg_325_1.text_.text = var_328_12

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_13 = 24
				local var_328_14 = utf8.len(var_328_12)
				local var_328_15 = var_328_13 <= 0 and var_328_10 or var_328_10 * (var_328_14 / var_328_13)

				if var_328_15 > 0 and var_328_10 < var_328_15 then
					arg_325_1.talkMaxDuration = var_328_15

					if var_328_15 + var_328_9 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_15 + var_328_9
					end
				end

				arg_325_1.text_.text = var_328_12
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_10, arg_325_1.talkMaxDuration)

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_9) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_9 + var_328_16 and arg_325_1.time_ < var_328_9 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play318031082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 318031082
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play318031083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.625

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(318031082)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 25
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play318031083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 318031083
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play318031084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 1.025

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:GetWordFromCfg(318031083)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 41
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_8 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_8 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_8

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_8 and arg_333_1.time_ < var_336_0 + var_336_8 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play318031084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 318031084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play318031085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.325

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(318031084)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 13
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_8 and arg_337_1.time_ < var_340_0 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play318031085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 318031085
		arg_341_1.duration_ = 8.4

		local var_341_0 = {
			zh = 4.3,
			ja = 8.4
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play318031086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1049ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1049ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0.7, -1.2, -6)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1049ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0.7, -1.2, -6)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["1049ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1049ui_story == nil then
				arg_341_1.var_.characterEffect1049ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect1049ui_story and not isNil(var_344_9) then
					arg_341_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1049ui_story then
				arg_341_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_344_13 = 0

			if var_344_13 < arg_341_1.time_ and arg_341_1.time_ <= var_344_13 + arg_344_0 then
				arg_341_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_344_14 = 0

			if var_344_14 < arg_341_1.time_ and arg_341_1.time_ <= var_344_14 + arg_344_0 then
				arg_341_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_344_15 = arg_341_1.actors_["1015ui_story"].transform
			local var_344_16 = 0

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 then
				arg_341_1.var_.moveOldPos1015ui_story = var_344_15.localPosition
			end

			local var_344_17 = 0.001

			if var_344_16 <= arg_341_1.time_ and arg_341_1.time_ < var_344_16 + var_344_17 then
				local var_344_18 = (arg_341_1.time_ - var_344_16) / var_344_17
				local var_344_19 = Vector3.New(-0.7, -1.15, -6.2)

				var_344_15.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1015ui_story, var_344_19, var_344_18)

				local var_344_20 = manager.ui.mainCamera.transform.position - var_344_15.position

				var_344_15.forward = Vector3.New(var_344_20.x, var_344_20.y, var_344_20.z)

				local var_344_21 = var_344_15.localEulerAngles

				var_344_21.z = 0
				var_344_21.x = 0
				var_344_15.localEulerAngles = var_344_21
			end

			if arg_341_1.time_ >= var_344_16 + var_344_17 and arg_341_1.time_ < var_344_16 + var_344_17 + arg_344_0 then
				var_344_15.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_344_22 = manager.ui.mainCamera.transform.position - var_344_15.position

				var_344_15.forward = Vector3.New(var_344_22.x, var_344_22.y, var_344_22.z)

				local var_344_23 = var_344_15.localEulerAngles

				var_344_23.z = 0
				var_344_23.x = 0
				var_344_15.localEulerAngles = var_344_23
			end

			local var_344_24 = 0

			if var_344_24 < arg_341_1.time_ and arg_341_1.time_ <= var_344_24 + arg_344_0 then
				arg_341_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_344_25 = 0

			if var_344_25 < arg_341_1.time_ and arg_341_1.time_ <= var_344_25 + arg_344_0 then
				arg_341_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_344_26 = arg_341_1.actors_["1015ui_story"]
			local var_344_27 = 0

			if var_344_27 < arg_341_1.time_ and arg_341_1.time_ <= var_344_27 + arg_344_0 and not isNil(var_344_26) and arg_341_1.var_.characterEffect1015ui_story == nil then
				arg_341_1.var_.characterEffect1015ui_story = var_344_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_28 = 0.200000002980232

			if var_344_27 <= arg_341_1.time_ and arg_341_1.time_ < var_344_27 + var_344_28 and not isNil(var_344_26) then
				local var_344_29 = (arg_341_1.time_ - var_344_27) / var_344_28

				if arg_341_1.var_.characterEffect1015ui_story and not isNil(var_344_26) then
					local var_344_30 = Mathf.Lerp(0, 0.5, var_344_29)

					arg_341_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1015ui_story.fillRatio = var_344_30
				end
			end

			if arg_341_1.time_ >= var_344_27 + var_344_28 and arg_341_1.time_ < var_344_27 + var_344_28 + arg_344_0 and not isNil(var_344_26) and arg_341_1.var_.characterEffect1015ui_story then
				local var_344_31 = 0.5

				arg_341_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1015ui_story.fillRatio = var_344_31
			end

			local var_344_32 = 0
			local var_344_33 = 0.45

			if var_344_32 < arg_341_1.time_ and arg_341_1.time_ <= var_344_32 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_34 = arg_341_1:FormatText(StoryNameCfg[562].name)

				arg_341_1.leftNameTxt_.text = var_344_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_35 = arg_341_1:GetWordFromCfg(318031085)
				local var_344_36 = arg_341_1:FormatText(var_344_35.content)

				arg_341_1.text_.text = var_344_36

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_37 = 18
				local var_344_38 = utf8.len(var_344_36)
				local var_344_39 = var_344_37 <= 0 and var_344_33 or var_344_33 * (var_344_38 / var_344_37)

				if var_344_39 > 0 and var_344_33 < var_344_39 then
					arg_341_1.talkMaxDuration = var_344_39

					if var_344_39 + var_344_32 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_39 + var_344_32
					end
				end

				arg_341_1.text_.text = var_344_36
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031085", "story_v_out_318031.awb") ~= 0 then
					local var_344_40 = manager.audio:GetVoiceLength("story_v_out_318031", "318031085", "story_v_out_318031.awb") / 1000

					if var_344_40 + var_344_32 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_40 + var_344_32
					end

					if var_344_35.prefab_name ~= "" and arg_341_1.actors_[var_344_35.prefab_name] ~= nil then
						local var_344_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_35.prefab_name].transform, "story_v_out_318031", "318031085", "story_v_out_318031.awb")

						arg_341_1:RecordAudio("318031085", var_344_41)
						arg_341_1:RecordAudio("318031085", var_344_41)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_318031", "318031085", "story_v_out_318031.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_318031", "318031085", "story_v_out_318031.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_42 = math.max(var_344_33, arg_341_1.talkMaxDuration)

			if var_344_32 <= arg_341_1.time_ and arg_341_1.time_ < var_344_32 + var_344_42 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_32) / var_344_42

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_32 + var_344_42 and arg_341_1.time_ < var_344_32 + var_344_42 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play318031086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 318031086
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play318031087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1049ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1049ui_story == nil then
				arg_345_1.var_.characterEffect1049ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1049ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1049ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1049ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1049ui_story.fillRatio = var_348_5
			end

			local var_348_6 = 0
			local var_348_7 = 1.15

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(318031086)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 46
				local var_348_11 = utf8.len(var_348_9)
				local var_348_12 = var_348_10 <= 0 and var_348_7 or var_348_7 * (var_348_11 / var_348_10)

				if var_348_12 > 0 and var_348_7 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_13 and arg_345_1.time_ < var_348_6 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play318031087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 318031087
		arg_349_1.duration_ = 5.23

		local var_349_0 = {
			zh = 2.533,
			ja = 5.233
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play318031088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1049ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1049ui_story == nil then
				arg_349_1.var_.characterEffect1049ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1049ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1049ui_story then
				arg_349_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_352_4 = 0
			local var_352_5 = 0.3

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_6 = arg_349_1:FormatText(StoryNameCfg[562].name)

				arg_349_1.leftNameTxt_.text = var_352_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:GetWordFromCfg(318031087)
				local var_352_8 = arg_349_1:FormatText(var_352_7.content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 12
				local var_352_10 = utf8.len(var_352_8)
				local var_352_11 = var_352_9 <= 0 and var_352_5 or var_352_5 * (var_352_10 / var_352_9)

				if var_352_11 > 0 and var_352_5 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031087", "story_v_out_318031.awb") ~= 0 then
					local var_352_12 = manager.audio:GetVoiceLength("story_v_out_318031", "318031087", "story_v_out_318031.awb") / 1000

					if var_352_12 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_4
					end

					if var_352_7.prefab_name ~= "" and arg_349_1.actors_[var_352_7.prefab_name] ~= nil then
						local var_352_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_7.prefab_name].transform, "story_v_out_318031", "318031087", "story_v_out_318031.awb")

						arg_349_1:RecordAudio("318031087", var_352_13)
						arg_349_1:RecordAudio("318031087", var_352_13)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_318031", "318031087", "story_v_out_318031.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_318031", "318031087", "story_v_out_318031.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_14 and arg_349_1.time_ < var_352_4 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play318031088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 318031088
		arg_353_1.duration_ = 4.33

		local var_353_0 = {
			zh = 3.233,
			ja = 4.333
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play318031089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1015ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1015ui_story == nil then
				arg_353_1.var_.characterEffect1015ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1015ui_story and not isNil(var_356_0) then
					arg_353_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1015ui_story then
				arg_353_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_356_4 = arg_353_1.actors_["1049ui_story"]
			local var_356_5 = 0

			if var_356_5 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect1049ui_story == nil then
				arg_353_1.var_.characterEffect1049ui_story = var_356_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_6 = 0.200000002980232

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_6 and not isNil(var_356_4) then
				local var_356_7 = (arg_353_1.time_ - var_356_5) / var_356_6

				if arg_353_1.var_.characterEffect1049ui_story and not isNil(var_356_4) then
					local var_356_8 = Mathf.Lerp(0, 0.5, var_356_7)

					arg_353_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1049ui_story.fillRatio = var_356_8
				end
			end

			if arg_353_1.time_ >= var_356_5 + var_356_6 and arg_353_1.time_ < var_356_5 + var_356_6 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect1049ui_story then
				local var_356_9 = 0.5

				arg_353_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1049ui_story.fillRatio = var_356_9
			end

			local var_356_10 = 0
			local var_356_11 = 0.625

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_12 = arg_353_1:FormatText(StoryNameCfg[479].name)

				arg_353_1.leftNameTxt_.text = var_356_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_13 = arg_353_1:GetWordFromCfg(318031088)
				local var_356_14 = arg_353_1:FormatText(var_356_13.content)

				arg_353_1.text_.text = var_356_14

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_15 = 25
				local var_356_16 = utf8.len(var_356_14)
				local var_356_17 = var_356_15 <= 0 and var_356_11 or var_356_11 * (var_356_16 / var_356_15)

				if var_356_17 > 0 and var_356_11 < var_356_17 then
					arg_353_1.talkMaxDuration = var_356_17

					if var_356_17 + var_356_10 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_17 + var_356_10
					end
				end

				arg_353_1.text_.text = var_356_14
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031088", "story_v_out_318031.awb") ~= 0 then
					local var_356_18 = manager.audio:GetVoiceLength("story_v_out_318031", "318031088", "story_v_out_318031.awb") / 1000

					if var_356_18 + var_356_10 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_18 + var_356_10
					end

					if var_356_13.prefab_name ~= "" and arg_353_1.actors_[var_356_13.prefab_name] ~= nil then
						local var_356_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_13.prefab_name].transform, "story_v_out_318031", "318031088", "story_v_out_318031.awb")

						arg_353_1:RecordAudio("318031088", var_356_19)
						arg_353_1:RecordAudio("318031088", var_356_19)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_318031", "318031088", "story_v_out_318031.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_318031", "318031088", "story_v_out_318031.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_20 = math.max(var_356_11, arg_353_1.talkMaxDuration)

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_20 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_10) / var_356_20

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_10 + var_356_20 and arg_353_1.time_ < var_356_10 + var_356_20 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play318031089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 318031089
		arg_357_1.duration_ = 7.47

		local var_357_0 = {
			zh = 4.366,
			ja = 7.466
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play318031090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1049ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1049ui_story == nil then
				arg_357_1.var_.characterEffect1049ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1049ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1049ui_story then
				arg_357_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_360_4 = arg_357_1.actors_["1015ui_story"]
			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect1015ui_story == nil then
				arg_357_1.var_.characterEffect1015ui_story = var_360_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_6 = 0.200000002980232

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_6 and not isNil(var_360_4) then
				local var_360_7 = (arg_357_1.time_ - var_360_5) / var_360_6

				if arg_357_1.var_.characterEffect1015ui_story and not isNil(var_360_4) then
					local var_360_8 = Mathf.Lerp(0, 0.5, var_360_7)

					arg_357_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1015ui_story.fillRatio = var_360_8
				end
			end

			if arg_357_1.time_ >= var_360_5 + var_360_6 and arg_357_1.time_ < var_360_5 + var_360_6 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect1015ui_story then
				local var_360_9 = 0.5

				arg_357_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1015ui_story.fillRatio = var_360_9
			end

			local var_360_10 = 0
			local var_360_11 = 0.475

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_12 = arg_357_1:FormatText(StoryNameCfg[562].name)

				arg_357_1.leftNameTxt_.text = var_360_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_13 = arg_357_1:GetWordFromCfg(318031089)
				local var_360_14 = arg_357_1:FormatText(var_360_13.content)

				arg_357_1.text_.text = var_360_14

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_15 = 19
				local var_360_16 = utf8.len(var_360_14)
				local var_360_17 = var_360_15 <= 0 and var_360_11 or var_360_11 * (var_360_16 / var_360_15)

				if var_360_17 > 0 and var_360_11 < var_360_17 then
					arg_357_1.talkMaxDuration = var_360_17

					if var_360_17 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_17 + var_360_10
					end
				end

				arg_357_1.text_.text = var_360_14
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031089", "story_v_out_318031.awb") ~= 0 then
					local var_360_18 = manager.audio:GetVoiceLength("story_v_out_318031", "318031089", "story_v_out_318031.awb") / 1000

					if var_360_18 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_18 + var_360_10
					end

					if var_360_13.prefab_name ~= "" and arg_357_1.actors_[var_360_13.prefab_name] ~= nil then
						local var_360_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_13.prefab_name].transform, "story_v_out_318031", "318031089", "story_v_out_318031.awb")

						arg_357_1:RecordAudio("318031089", var_360_19)
						arg_357_1:RecordAudio("318031089", var_360_19)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_318031", "318031089", "story_v_out_318031.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_318031", "318031089", "story_v_out_318031.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_20 = math.max(var_360_11, arg_357_1.talkMaxDuration)

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_20 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_10) / var_360_20

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_10 + var_360_20 and arg_357_1.time_ < var_360_10 + var_360_20 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play318031090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 318031090
		arg_361_1.duration_ = 3.5

		local var_361_0 = {
			zh = 2.066,
			ja = 3.5
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play318031091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1015ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1015ui_story == nil then
				arg_361_1.var_.characterEffect1015ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1015ui_story and not isNil(var_364_0) then
					arg_361_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1015ui_story then
				arg_361_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_364_4 = 0

			if var_364_4 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_364_5 = 0

			if var_364_5 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_364_6 = arg_361_1.actors_["1049ui_story"]
			local var_364_7 = 0

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect1049ui_story == nil then
				arg_361_1.var_.characterEffect1049ui_story = var_364_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_8 = 0.200000002980232

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 and not isNil(var_364_6) then
				local var_364_9 = (arg_361_1.time_ - var_364_7) / var_364_8

				if arg_361_1.var_.characterEffect1049ui_story and not isNil(var_364_6) then
					local var_364_10 = Mathf.Lerp(0, 0.5, var_364_9)

					arg_361_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1049ui_story.fillRatio = var_364_10
				end
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 and not isNil(var_364_6) and arg_361_1.var_.characterEffect1049ui_story then
				local var_364_11 = 0.5

				arg_361_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1049ui_story.fillRatio = var_364_11
			end

			local var_364_12 = 0
			local var_364_13 = 0.275

			if var_364_12 < arg_361_1.time_ and arg_361_1.time_ <= var_364_12 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_14 = arg_361_1:FormatText(StoryNameCfg[479].name)

				arg_361_1.leftNameTxt_.text = var_364_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_15 = arg_361_1:GetWordFromCfg(318031090)
				local var_364_16 = arg_361_1:FormatText(var_364_15.content)

				arg_361_1.text_.text = var_364_16

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_17 = 11
				local var_364_18 = utf8.len(var_364_16)
				local var_364_19 = var_364_17 <= 0 and var_364_13 or var_364_13 * (var_364_18 / var_364_17)

				if var_364_19 > 0 and var_364_13 < var_364_19 then
					arg_361_1.talkMaxDuration = var_364_19

					if var_364_19 + var_364_12 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_19 + var_364_12
					end
				end

				arg_361_1.text_.text = var_364_16
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031090", "story_v_out_318031.awb") ~= 0 then
					local var_364_20 = manager.audio:GetVoiceLength("story_v_out_318031", "318031090", "story_v_out_318031.awb") / 1000

					if var_364_20 + var_364_12 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_20 + var_364_12
					end

					if var_364_15.prefab_name ~= "" and arg_361_1.actors_[var_364_15.prefab_name] ~= nil then
						local var_364_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_15.prefab_name].transform, "story_v_out_318031", "318031090", "story_v_out_318031.awb")

						arg_361_1:RecordAudio("318031090", var_364_21)
						arg_361_1:RecordAudio("318031090", var_364_21)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_318031", "318031090", "story_v_out_318031.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_318031", "318031090", "story_v_out_318031.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_22 = math.max(var_364_13, arg_361_1.talkMaxDuration)

			if var_364_12 <= arg_361_1.time_ and arg_361_1.time_ < var_364_12 + var_364_22 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_12) / var_364_22

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_12 + var_364_22 and arg_361_1.time_ < var_364_12 + var_364_22 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play318031091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 318031091
		arg_365_1.duration_ = 7.87

		local var_365_0 = {
			zh = 2.166,
			ja = 7.866
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play318031092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1049ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1049ui_story == nil then
				arg_365_1.var_.characterEffect1049ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1049ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1049ui_story then
				arg_365_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_368_4 = arg_365_1.actors_["1015ui_story"]
			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 and not isNil(var_368_4) and arg_365_1.var_.characterEffect1015ui_story == nil then
				arg_365_1.var_.characterEffect1015ui_story = var_368_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_6 = 0.200000002980232

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_6 and not isNil(var_368_4) then
				local var_368_7 = (arg_365_1.time_ - var_368_5) / var_368_6

				if arg_365_1.var_.characterEffect1015ui_story and not isNil(var_368_4) then
					local var_368_8 = Mathf.Lerp(0, 0.5, var_368_7)

					arg_365_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1015ui_story.fillRatio = var_368_8
				end
			end

			if arg_365_1.time_ >= var_368_5 + var_368_6 and arg_365_1.time_ < var_368_5 + var_368_6 + arg_368_0 and not isNil(var_368_4) and arg_365_1.var_.characterEffect1015ui_story then
				local var_368_9 = 0.5

				arg_365_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1015ui_story.fillRatio = var_368_9
			end

			local var_368_10 = 0
			local var_368_11 = 0.3

			if var_368_10 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_12 = arg_365_1:FormatText(StoryNameCfg[562].name)

				arg_365_1.leftNameTxt_.text = var_368_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_13 = arg_365_1:GetWordFromCfg(318031091)
				local var_368_14 = arg_365_1:FormatText(var_368_13.content)

				arg_365_1.text_.text = var_368_14

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_15 = 12
				local var_368_16 = utf8.len(var_368_14)
				local var_368_17 = var_368_15 <= 0 and var_368_11 or var_368_11 * (var_368_16 / var_368_15)

				if var_368_17 > 0 and var_368_11 < var_368_17 then
					arg_365_1.talkMaxDuration = var_368_17

					if var_368_17 + var_368_10 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_17 + var_368_10
					end
				end

				arg_365_1.text_.text = var_368_14
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031091", "story_v_out_318031.awb") ~= 0 then
					local var_368_18 = manager.audio:GetVoiceLength("story_v_out_318031", "318031091", "story_v_out_318031.awb") / 1000

					if var_368_18 + var_368_10 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_18 + var_368_10
					end

					if var_368_13.prefab_name ~= "" and arg_365_1.actors_[var_368_13.prefab_name] ~= nil then
						local var_368_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_13.prefab_name].transform, "story_v_out_318031", "318031091", "story_v_out_318031.awb")

						arg_365_1:RecordAudio("318031091", var_368_19)
						arg_365_1:RecordAudio("318031091", var_368_19)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_318031", "318031091", "story_v_out_318031.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_318031", "318031091", "story_v_out_318031.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_20 = math.max(var_368_11, arg_365_1.talkMaxDuration)

			if var_368_10 <= arg_365_1.time_ and arg_365_1.time_ < var_368_10 + var_368_20 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_10) / var_368_20

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_10 + var_368_20 and arg_365_1.time_ < var_368_10 + var_368_20 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play318031092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 318031092
		arg_369_1.duration_ = 8.63

		local var_369_0 = {
			zh = 8.633,
			ja = 8.2
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play318031093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action423")
			end

			local var_372_1 = 0
			local var_372_2 = 1.15

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_3 = arg_369_1:FormatText(StoryNameCfg[562].name)

				arg_369_1.leftNameTxt_.text = var_372_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_4 = arg_369_1:GetWordFromCfg(318031092)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_6 = 46
				local var_372_7 = utf8.len(var_372_5)
				local var_372_8 = var_372_6 <= 0 and var_372_2 or var_372_2 * (var_372_7 / var_372_6)

				if var_372_8 > 0 and var_372_2 < var_372_8 then
					arg_369_1.talkMaxDuration = var_372_8

					if var_372_8 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031092", "story_v_out_318031.awb") ~= 0 then
					local var_372_9 = manager.audio:GetVoiceLength("story_v_out_318031", "318031092", "story_v_out_318031.awb") / 1000

					if var_372_9 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_1
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_out_318031", "318031092", "story_v_out_318031.awb")

						arg_369_1:RecordAudio("318031092", var_372_10)
						arg_369_1:RecordAudio("318031092", var_372_10)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_318031", "318031092", "story_v_out_318031.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_318031", "318031092", "story_v_out_318031.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_11 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_11 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_11

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_11 and arg_369_1.time_ < var_372_1 + var_372_11 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play318031093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 318031093
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play318031094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1049ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1049ui_story == nil then
				arg_373_1.var_.characterEffect1049ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1049ui_story and not isNil(var_376_0) then
					local var_376_4 = Mathf.Lerp(0, 0.5, var_376_3)

					arg_373_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1049ui_story.fillRatio = var_376_4
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1049ui_story then
				local var_376_5 = 0.5

				arg_373_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1049ui_story.fillRatio = var_376_5
			end

			local var_376_6 = 0
			local var_376_7 = 1

			if var_376_6 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:GetWordFromCfg(318031093)
				local var_376_9 = arg_373_1:FormatText(var_376_8.content)

				arg_373_1.text_.text = var_376_9

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 40
				local var_376_11 = utf8.len(var_376_9)
				local var_376_12 = var_376_10 <= 0 and var_376_7 or var_376_7 * (var_376_11 / var_376_10)

				if var_376_12 > 0 and var_376_7 < var_376_12 then
					arg_373_1.talkMaxDuration = var_376_12

					if var_376_12 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_12 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_9
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_13 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_13 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_13

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_13 and arg_373_1.time_ < var_376_6 + var_376_13 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play318031094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 318031094
		arg_377_1.duration_ = 8.13

		local var_377_0 = {
			zh = 8.133,
			ja = 7.4
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play318031095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1049ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1049ui_story == nil then
				arg_377_1.var_.characterEffect1049ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1049ui_story and not isNil(var_380_0) then
					arg_377_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1049ui_story then
				arg_377_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_380_4 = 0

			if var_380_4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_2")
			end

			local var_380_5 = 0

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_6 = 0
			local var_380_7 = 0.625

			if var_380_6 < arg_377_1.time_ and arg_377_1.time_ <= var_380_6 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_8 = arg_377_1:FormatText(StoryNameCfg[562].name)

				arg_377_1.leftNameTxt_.text = var_380_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_9 = arg_377_1:GetWordFromCfg(318031094)
				local var_380_10 = arg_377_1:FormatText(var_380_9.content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_11 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031094", "story_v_out_318031.awb") ~= 0 then
					local var_380_14 = manager.audio:GetVoiceLength("story_v_out_318031", "318031094", "story_v_out_318031.awb") / 1000

					if var_380_14 + var_380_6 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_14 + var_380_6
					end

					if var_380_9.prefab_name ~= "" and arg_377_1.actors_[var_380_9.prefab_name] ~= nil then
						local var_380_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_9.prefab_name].transform, "story_v_out_318031", "318031094", "story_v_out_318031.awb")

						arg_377_1:RecordAudio("318031094", var_380_15)
						arg_377_1:RecordAudio("318031094", var_380_15)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_318031", "318031094", "story_v_out_318031.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_318031", "318031094", "story_v_out_318031.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_7, arg_377_1.talkMaxDuration)

			if var_380_6 <= arg_377_1.time_ and arg_377_1.time_ < var_380_6 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_6) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_6 + var_380_16 and arg_377_1.time_ < var_380_6 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play318031095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 318031095
		arg_381_1.duration_ = 5.43

		local var_381_0 = {
			zh = 2.5,
			ja = 5.433
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play318031096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1049ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1049ui_story == nil then
				arg_381_1.var_.characterEffect1049ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1049ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1049ui_story then
				arg_381_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_384_4 = 0

			if var_384_4 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_384_5 = 0
			local var_384_6 = 0.375

			if var_384_5 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_7 = arg_381_1:FormatText(StoryNameCfg[562].name)

				arg_381_1.leftNameTxt_.text = var_384_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_8 = arg_381_1:GetWordFromCfg(318031095)
				local var_384_9 = arg_381_1:FormatText(var_384_8.content)

				arg_381_1.text_.text = var_384_9

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_10 = 15
				local var_384_11 = utf8.len(var_384_9)
				local var_384_12 = var_384_10 <= 0 and var_384_6 or var_384_6 * (var_384_11 / var_384_10)

				if var_384_12 > 0 and var_384_6 < var_384_12 then
					arg_381_1.talkMaxDuration = var_384_12

					if var_384_12 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_12 + var_384_5
					end
				end

				arg_381_1.text_.text = var_384_9
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031095", "story_v_out_318031.awb") ~= 0 then
					local var_384_13 = manager.audio:GetVoiceLength("story_v_out_318031", "318031095", "story_v_out_318031.awb") / 1000

					if var_384_13 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_5
					end

					if var_384_8.prefab_name ~= "" and arg_381_1.actors_[var_384_8.prefab_name] ~= nil then
						local var_384_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_8.prefab_name].transform, "story_v_out_318031", "318031095", "story_v_out_318031.awb")

						arg_381_1:RecordAudio("318031095", var_384_14)
						arg_381_1:RecordAudio("318031095", var_384_14)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_318031", "318031095", "story_v_out_318031.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_318031", "318031095", "story_v_out_318031.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_15 = math.max(var_384_6, arg_381_1.talkMaxDuration)

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_15 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_5) / var_384_15

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_5 + var_384_15 and arg_381_1.time_ < var_384_5 + var_384_15 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play318031096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 318031096
		arg_385_1.duration_ = 9

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play318031097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = "K13f"

			if arg_385_1.bgs_[var_388_0] == nil then
				local var_388_1 = Object.Instantiate(arg_385_1.paintGo_)

				var_388_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_388_0)
				var_388_1.name = var_388_0
				var_388_1.transform.parent = arg_385_1.stage_.transform
				var_388_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.bgs_[var_388_0] = var_388_1
			end

			local var_388_2 = 2

			if var_388_2 < arg_385_1.time_ and arg_385_1.time_ <= var_388_2 + arg_388_0 then
				local var_388_3 = manager.ui.mainCamera.transform.localPosition
				local var_388_4 = Vector3.New(0, 0, 10) + Vector3.New(var_388_3.x, var_388_3.y, 0)
				local var_388_5 = arg_385_1.bgs_.K13f

				var_388_5.transform.localPosition = var_388_4
				var_388_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_388_6 = var_388_5:GetComponent("SpriteRenderer")

				if var_388_6 and var_388_6.sprite then
					local var_388_7 = (var_388_5.transform.localPosition - var_388_3).z
					local var_388_8 = manager.ui.mainCameraCom_
					local var_388_9 = 2 * var_388_7 * Mathf.Tan(var_388_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_388_10 = var_388_9 * var_388_8.aspect
					local var_388_11 = var_388_6.sprite.bounds.size.x
					local var_388_12 = var_388_6.sprite.bounds.size.y
					local var_388_13 = var_388_10 / var_388_11
					local var_388_14 = var_388_9 / var_388_12
					local var_388_15 = var_388_14 < var_388_13 and var_388_13 or var_388_14

					var_388_5.transform.localScale = Vector3.New(var_388_15, var_388_15, 0)
				end

				for iter_388_0, iter_388_1 in pairs(arg_385_1.bgs_) do
					if iter_388_0 ~= "K13f" then
						iter_388_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_388_16 = 0

			if var_388_16 < arg_385_1.time_ and arg_385_1.time_ <= var_388_16 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_17 = 2

			if var_388_16 <= arg_385_1.time_ and arg_385_1.time_ < var_388_16 + var_388_17 then
				local var_388_18 = (arg_385_1.time_ - var_388_16) / var_388_17
				local var_388_19 = Color.New(0, 0, 0)

				var_388_19.a = Mathf.Lerp(0, 1, var_388_18)
				arg_385_1.mask_.color = var_388_19
			end

			if arg_385_1.time_ >= var_388_16 + var_388_17 and arg_385_1.time_ < var_388_16 + var_388_17 + arg_388_0 then
				local var_388_20 = Color.New(0, 0, 0)

				var_388_20.a = 1
				arg_385_1.mask_.color = var_388_20
			end

			local var_388_21 = 2

			if var_388_21 < arg_385_1.time_ and arg_385_1.time_ <= var_388_21 + arg_388_0 then
				arg_385_1.mask_.enabled = true
				arg_385_1.mask_.raycastTarget = true

				arg_385_1:SetGaussion(false)
			end

			local var_388_22 = 2

			if var_388_21 <= arg_385_1.time_ and arg_385_1.time_ < var_388_21 + var_388_22 then
				local var_388_23 = (arg_385_1.time_ - var_388_21) / var_388_22
				local var_388_24 = Color.New(0, 0, 0)

				var_388_24.a = Mathf.Lerp(1, 0, var_388_23)
				arg_385_1.mask_.color = var_388_24
			end

			if arg_385_1.time_ >= var_388_21 + var_388_22 and arg_385_1.time_ < var_388_21 + var_388_22 + arg_388_0 then
				local var_388_25 = Color.New(0, 0, 0)
				local var_388_26 = 0

				arg_385_1.mask_.enabled = false
				var_388_25.a = var_388_26
				arg_385_1.mask_.color = var_388_25
			end

			local var_388_27 = arg_385_1.actors_["1049ui_story"].transform
			local var_388_28 = 2

			if var_388_28 < arg_385_1.time_ and arg_385_1.time_ <= var_388_28 + arg_388_0 then
				arg_385_1.var_.moveOldPos1049ui_story = var_388_27.localPosition
			end

			local var_388_29 = 0.001

			if var_388_28 <= arg_385_1.time_ and arg_385_1.time_ < var_388_28 + var_388_29 then
				local var_388_30 = (arg_385_1.time_ - var_388_28) / var_388_29
				local var_388_31 = Vector3.New(0, 100, 0)

				var_388_27.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1049ui_story, var_388_31, var_388_30)

				local var_388_32 = manager.ui.mainCamera.transform.position - var_388_27.position

				var_388_27.forward = Vector3.New(var_388_32.x, var_388_32.y, var_388_32.z)

				local var_388_33 = var_388_27.localEulerAngles

				var_388_33.z = 0
				var_388_33.x = 0
				var_388_27.localEulerAngles = var_388_33
			end

			if arg_385_1.time_ >= var_388_28 + var_388_29 and arg_385_1.time_ < var_388_28 + var_388_29 + arg_388_0 then
				var_388_27.localPosition = Vector3.New(0, 100, 0)

				local var_388_34 = manager.ui.mainCamera.transform.position - var_388_27.position

				var_388_27.forward = Vector3.New(var_388_34.x, var_388_34.y, var_388_34.z)

				local var_388_35 = var_388_27.localEulerAngles

				var_388_35.z = 0
				var_388_35.x = 0
				var_388_27.localEulerAngles = var_388_35
			end

			local var_388_36 = arg_385_1.actors_["1049ui_story"]
			local var_388_37 = 2

			if var_388_37 < arg_385_1.time_ and arg_385_1.time_ <= var_388_37 + arg_388_0 and not isNil(var_388_36) and arg_385_1.var_.characterEffect1049ui_story == nil then
				arg_385_1.var_.characterEffect1049ui_story = var_388_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_38 = 0.200000002980232

			if var_388_37 <= arg_385_1.time_ and arg_385_1.time_ < var_388_37 + var_388_38 and not isNil(var_388_36) then
				local var_388_39 = (arg_385_1.time_ - var_388_37) / var_388_38

				if arg_385_1.var_.characterEffect1049ui_story and not isNil(var_388_36) then
					local var_388_40 = Mathf.Lerp(0, 0.5, var_388_39)

					arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1049ui_story.fillRatio = var_388_40
				end
			end

			if arg_385_1.time_ >= var_388_37 + var_388_38 and arg_385_1.time_ < var_388_37 + var_388_38 + arg_388_0 and not isNil(var_388_36) and arg_385_1.var_.characterEffect1049ui_story then
				local var_388_41 = 0.5

				arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1049ui_story.fillRatio = var_388_41
			end

			local var_388_42 = 0
			local var_388_43 = 0.433333333333333

			if var_388_42 < arg_385_1.time_ and arg_385_1.time_ <= var_388_42 + arg_388_0 then
				local var_388_44 = "play"
				local var_388_45 = "music"

				arg_385_1:AudioAction(var_388_44, var_388_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_388_46 = ""
				local var_388_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_388_47 ~= "" then
					if arg_385_1.bgmTxt_.text ~= var_388_47 and arg_385_1.bgmTxt_.text ~= "" then
						if arg_385_1.bgmTxt2_.text ~= "" then
							arg_385_1.bgmTxt_.text = arg_385_1.bgmTxt2_.text
						end

						arg_385_1.bgmTxt2_.text = var_388_47

						arg_385_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_385_1.bgmTxt_.text = var_388_47
						arg_385_1.bgmTxt2_.text = var_388_47
					end

					if arg_385_1.bgmTimer then
						arg_385_1.bgmTimer:Stop()

						arg_385_1.bgmTimer = nil
					end

					if arg_385_1.settingData.show_music_name == 1 then
						arg_385_1.musicController:SetSelectedState("show")
						arg_385_1.musicAnimator_:Play("open", 0, 0)

						if arg_385_1.settingData.music_time ~= 0 then
							arg_385_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_385_1.settingData.music_time), function()
								if arg_385_1 == nil or isNil(arg_385_1.bgmTxt_) then
									return
								end

								arg_385_1.musicController:SetSelectedState("hide")
								arg_385_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_388_48 = 1.26666666666667
			local var_388_49 = 1

			if var_388_48 < arg_385_1.time_ and arg_385_1.time_ <= var_388_48 + arg_388_0 then
				local var_388_50 = "play"
				local var_388_51 = "music"

				arg_385_1:AudioAction(var_388_50, var_388_51, "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten.awb")

				local var_388_52 = ""
				local var_388_53 = manager.audio:GetAudioName("bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten")

				if var_388_53 ~= "" then
					if arg_385_1.bgmTxt_.text ~= var_388_53 and arg_385_1.bgmTxt_.text ~= "" then
						if arg_385_1.bgmTxt2_.text ~= "" then
							arg_385_1.bgmTxt_.text = arg_385_1.bgmTxt2_.text
						end

						arg_385_1.bgmTxt2_.text = var_388_53

						arg_385_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_385_1.bgmTxt_.text = var_388_53
						arg_385_1.bgmTxt2_.text = var_388_53
					end

					if arg_385_1.bgmTimer then
						arg_385_1.bgmTimer:Stop()

						arg_385_1.bgmTimer = nil
					end

					if arg_385_1.settingData.show_music_name == 1 then
						arg_385_1.musicController:SetSelectedState("show")
						arg_385_1.musicAnimator_:Play("open", 0, 0)

						if arg_385_1.settingData.music_time ~= 0 then
							arg_385_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_385_1.settingData.music_time), function()
								if arg_385_1 == nil or isNil(arg_385_1.bgmTxt_) then
									return
								end

								arg_385_1.musicController:SetSelectedState("hide")
								arg_385_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_388_54 = arg_385_1.actors_["1015ui_story"].transform
			local var_388_55 = 2

			if var_388_55 < arg_385_1.time_ and arg_385_1.time_ <= var_388_55 + arg_388_0 then
				arg_385_1.var_.moveOldPos1015ui_story = var_388_54.localPosition
			end

			local var_388_56 = 0.001

			if var_388_55 <= arg_385_1.time_ and arg_385_1.time_ < var_388_55 + var_388_56 then
				local var_388_57 = (arg_385_1.time_ - var_388_55) / var_388_56
				local var_388_58 = Vector3.New(0, 100, 0)

				var_388_54.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1015ui_story, var_388_58, var_388_57)

				local var_388_59 = manager.ui.mainCamera.transform.position - var_388_54.position

				var_388_54.forward = Vector3.New(var_388_59.x, var_388_59.y, var_388_59.z)

				local var_388_60 = var_388_54.localEulerAngles

				var_388_60.z = 0
				var_388_60.x = 0
				var_388_54.localEulerAngles = var_388_60
			end

			if arg_385_1.time_ >= var_388_55 + var_388_56 and arg_385_1.time_ < var_388_55 + var_388_56 + arg_388_0 then
				var_388_54.localPosition = Vector3.New(0, 100, 0)

				local var_388_61 = manager.ui.mainCamera.transform.position - var_388_54.position

				var_388_54.forward = Vector3.New(var_388_61.x, var_388_61.y, var_388_61.z)

				local var_388_62 = var_388_54.localEulerAngles

				var_388_62.z = 0
				var_388_62.x = 0
				var_388_54.localEulerAngles = var_388_62
			end

			if arg_385_1.frameCnt_ <= 1 then
				arg_385_1.dialog_:SetActive(false)
			end

			local var_388_63 = 4
			local var_388_64 = 0.6

			if var_388_63 < arg_385_1.time_ and arg_385_1.time_ <= var_388_63 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				arg_385_1.dialog_:SetActive(true)

				arg_385_1.dialogCg_.alpha = 0

				local var_388_65 = LeanTween.value(arg_385_1.dialog_, 0, 1, 0.3)

				var_388_65:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_385_1.dialogCg_.alpha = arg_391_0
				end))
				var_388_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_385_1.dialog_)
					var_388_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_385_1.duration_ = arg_385_1.duration_ + 0.3

				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_66 = arg_385_1:GetWordFromCfg(318031096)
				local var_388_67 = arg_385_1:FormatText(var_388_66.content)

				arg_385_1.text_.text = var_388_67

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_68 = 24
				local var_388_69 = utf8.len(var_388_67)
				local var_388_70 = var_388_68 <= 0 and var_388_64 or var_388_64 * (var_388_69 / var_388_68)

				if var_388_70 > 0 and var_388_64 < var_388_70 then
					arg_385_1.talkMaxDuration = var_388_70
					var_388_63 = var_388_63 + 0.3

					if var_388_70 + var_388_63 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_70 + var_388_63
					end
				end

				arg_385_1.text_.text = var_388_67
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_71 = var_388_63 + 0.3
			local var_388_72 = math.max(var_388_64, arg_385_1.talkMaxDuration)

			if var_388_71 <= arg_385_1.time_ and arg_385_1.time_ < var_388_71 + var_388_72 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_71) / var_388_72

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_71 + var_388_72 and arg_385_1.time_ < var_388_71 + var_388_72 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play318031097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 318031097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play318031098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 1.075

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_2 = arg_393_1:GetWordFromCfg(318031097)
				local var_396_3 = arg_393_1:FormatText(var_396_2.content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 43
				local var_396_5 = utf8.len(var_396_3)
				local var_396_6 = var_396_4 <= 0 and var_396_1 or var_396_1 * (var_396_5 / var_396_4)

				if var_396_6 > 0 and var_396_1 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_7 and arg_393_1.time_ < var_396_0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play318031098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 318031098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play318031099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.75

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(318031098)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 30
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play318031099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 318031099
		arg_401_1.duration_ = 2.43

		local var_401_0 = {
			zh = 1.999999999999,
			ja = 2.433
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
				arg_401_0:Play318031100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1093ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1093ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, -1.11, -5.88)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1093ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1093ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1093ui_story == nil then
				arg_401_1.var_.characterEffect1093ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect1093ui_story and not isNil(var_404_9) then
					arg_401_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1093ui_story then
				arg_401_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_404_13 = 0

			if var_404_13 < arg_401_1.time_ and arg_401_1.time_ <= var_404_13 + arg_404_0 then
				arg_401_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 then
				arg_401_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_404_15 = 0
			local var_404_16 = 0.2

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_17 = arg_401_1:FormatText(StoryNameCfg[73].name)

				arg_401_1.leftNameTxt_.text = var_404_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_18 = arg_401_1:GetWordFromCfg(318031099)
				local var_404_19 = arg_401_1:FormatText(var_404_18.content)

				arg_401_1.text_.text = var_404_19

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_20 = 8
				local var_404_21 = utf8.len(var_404_19)
				local var_404_22 = var_404_20 <= 0 and var_404_16 or var_404_16 * (var_404_21 / var_404_20)

				if var_404_22 > 0 and var_404_16 < var_404_22 then
					arg_401_1.talkMaxDuration = var_404_22

					if var_404_22 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_22 + var_404_15
					end
				end

				arg_401_1.text_.text = var_404_19
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031099", "story_v_out_318031.awb") ~= 0 then
					local var_404_23 = manager.audio:GetVoiceLength("story_v_out_318031", "318031099", "story_v_out_318031.awb") / 1000

					if var_404_23 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_23 + var_404_15
					end

					if var_404_18.prefab_name ~= "" and arg_401_1.actors_[var_404_18.prefab_name] ~= nil then
						local var_404_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_18.prefab_name].transform, "story_v_out_318031", "318031099", "story_v_out_318031.awb")

						arg_401_1:RecordAudio("318031099", var_404_24)
						arg_401_1:RecordAudio("318031099", var_404_24)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_318031", "318031099", "story_v_out_318031.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_318031", "318031099", "story_v_out_318031.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_25 = math.max(var_404_16, arg_401_1.talkMaxDuration)

			if var_404_15 <= arg_401_1.time_ and arg_401_1.time_ < var_404_15 + var_404_25 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_15) / var_404_25

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_15 + var_404_25 and arg_401_1.time_ < var_404_15 + var_404_25 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play318031100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 318031100
		arg_405_1.duration_ = 4.1

		local var_405_0 = {
			zh = 4.1,
			ja = 3.533
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
				arg_405_0:Play318031101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.45

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[73].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:GetWordFromCfg(318031100)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031100", "story_v_out_318031.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031100", "story_v_out_318031.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_out_318031", "318031100", "story_v_out_318031.awb")

						arg_405_1:RecordAudio("318031100", var_408_9)
						arg_405_1:RecordAudio("318031100", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_318031", "318031100", "story_v_out_318031.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_318031", "318031100", "story_v_out_318031.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play318031101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 318031101
		arg_409_1.duration_ = 8.2

		local var_409_0 = {
			zh = 7.366,
			ja = 8.2
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
				arg_409_0:Play318031102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = "LX0101"

			if arg_409_1.bgs_[var_412_0] == nil then
				local var_412_1 = Object.Instantiate(arg_409_1.paintGo_)

				var_412_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_412_0)
				var_412_1.name = var_412_0
				var_412_1.transform.parent = arg_409_1.stage_.transform
				var_412_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.bgs_[var_412_0] = var_412_1
			end

			local var_412_2 = 2

			if var_412_2 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				local var_412_3 = manager.ui.mainCamera.transform.localPosition
				local var_412_4 = Vector3.New(0, 0, 10) + Vector3.New(var_412_3.x, var_412_3.y, 0)
				local var_412_5 = arg_409_1.bgs_.LX0101

				var_412_5.transform.localPosition = var_412_4
				var_412_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_412_6 = var_412_5:GetComponent("SpriteRenderer")

				if var_412_6 and var_412_6.sprite then
					local var_412_7 = (var_412_5.transform.localPosition - var_412_3).z
					local var_412_8 = manager.ui.mainCameraCom_
					local var_412_9 = 2 * var_412_7 * Mathf.Tan(var_412_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_412_10 = var_412_9 * var_412_8.aspect
					local var_412_11 = var_412_6.sprite.bounds.size.x
					local var_412_12 = var_412_6.sprite.bounds.size.y
					local var_412_13 = var_412_10 / var_412_11
					local var_412_14 = var_412_9 / var_412_12
					local var_412_15 = var_412_14 < var_412_13 and var_412_13 or var_412_14

					var_412_5.transform.localScale = Vector3.New(var_412_15, var_412_15, 0)
				end

				for iter_412_0, iter_412_1 in pairs(arg_409_1.bgs_) do
					if iter_412_0 ~= "LX0101" then
						iter_412_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_412_16 = 0

			if var_412_16 < arg_409_1.time_ and arg_409_1.time_ <= var_412_16 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_17 = 2

			if var_412_16 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_17 then
				local var_412_18 = (arg_409_1.time_ - var_412_16) / var_412_17
				local var_412_19 = Color.New(0, 0, 0)

				var_412_19.a = Mathf.Lerp(0, 1, var_412_18)
				arg_409_1.mask_.color = var_412_19
			end

			if arg_409_1.time_ >= var_412_16 + var_412_17 and arg_409_1.time_ < var_412_16 + var_412_17 + arg_412_0 then
				local var_412_20 = Color.New(0, 0, 0)

				var_412_20.a = 1
				arg_409_1.mask_.color = var_412_20
			end

			local var_412_21 = 2

			if var_412_21 < arg_409_1.time_ and arg_409_1.time_ <= var_412_21 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_22 = 2

			if var_412_21 <= arg_409_1.time_ and arg_409_1.time_ < var_412_21 + var_412_22 then
				local var_412_23 = (arg_409_1.time_ - var_412_21) / var_412_22
				local var_412_24 = Color.New(0, 0, 0)

				var_412_24.a = Mathf.Lerp(1, 0, var_412_23)
				arg_409_1.mask_.color = var_412_24
			end

			if arg_409_1.time_ >= var_412_21 + var_412_22 and arg_409_1.time_ < var_412_21 + var_412_22 + arg_412_0 then
				local var_412_25 = Color.New(0, 0, 0)
				local var_412_26 = 0

				arg_409_1.mask_.enabled = false
				var_412_25.a = var_412_26
				arg_409_1.mask_.color = var_412_25
			end

			local var_412_27 = arg_409_1.actors_["1199ui_story"].transform
			local var_412_28 = 2

			if var_412_28 < arg_409_1.time_ and arg_409_1.time_ <= var_412_28 + arg_412_0 then
				arg_409_1.var_.moveOldPos1199ui_story = var_412_27.localPosition
			end

			local var_412_29 = 0.001

			if var_412_28 <= arg_409_1.time_ and arg_409_1.time_ < var_412_28 + var_412_29 then
				local var_412_30 = (arg_409_1.time_ - var_412_28) / var_412_29
				local var_412_31 = Vector3.New(0, 100, 0)

				var_412_27.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1199ui_story, var_412_31, var_412_30)

				local var_412_32 = manager.ui.mainCamera.transform.position - var_412_27.position

				var_412_27.forward = Vector3.New(var_412_32.x, var_412_32.y, var_412_32.z)

				local var_412_33 = var_412_27.localEulerAngles

				var_412_33.z = 0
				var_412_33.x = 0
				var_412_27.localEulerAngles = var_412_33
			end

			if arg_409_1.time_ >= var_412_28 + var_412_29 and arg_409_1.time_ < var_412_28 + var_412_29 + arg_412_0 then
				var_412_27.localPosition = Vector3.New(0, 100, 0)

				local var_412_34 = manager.ui.mainCamera.transform.position - var_412_27.position

				var_412_27.forward = Vector3.New(var_412_34.x, var_412_34.y, var_412_34.z)

				local var_412_35 = var_412_27.localEulerAngles

				var_412_35.z = 0
				var_412_35.x = 0
				var_412_27.localEulerAngles = var_412_35
			end

			local var_412_36 = arg_409_1.actors_["1199ui_story"]
			local var_412_37 = 2

			if var_412_37 < arg_409_1.time_ and arg_409_1.time_ <= var_412_37 + arg_412_0 and not isNil(var_412_36) and arg_409_1.var_.characterEffect1199ui_story == nil then
				arg_409_1.var_.characterEffect1199ui_story = var_412_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_38 = 0.200000002980232

			if var_412_37 <= arg_409_1.time_ and arg_409_1.time_ < var_412_37 + var_412_38 and not isNil(var_412_36) then
				local var_412_39 = (arg_409_1.time_ - var_412_37) / var_412_38

				if arg_409_1.var_.characterEffect1199ui_story and not isNil(var_412_36) then
					arg_409_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_37 + var_412_38 and arg_409_1.time_ < var_412_37 + var_412_38 + arg_412_0 and not isNil(var_412_36) and arg_409_1.var_.characterEffect1199ui_story then
				arg_409_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_412_40 = 2

			if var_412_40 < arg_409_1.time_ and arg_409_1.time_ <= var_412_40 + arg_412_0 then
				arg_409_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			local var_412_41 = 2

			if var_412_41 < arg_409_1.time_ and arg_409_1.time_ <= var_412_41 + arg_412_0 then
				arg_409_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_412_42 = arg_409_1.actors_["1093ui_story"].transform
			local var_412_43 = 0

			if var_412_43 < arg_409_1.time_ and arg_409_1.time_ <= var_412_43 + arg_412_0 then
				arg_409_1.var_.moveOldPos1093ui_story = var_412_42.localPosition
			end

			local var_412_44 = 0.001

			if var_412_43 <= arg_409_1.time_ and arg_409_1.time_ < var_412_43 + var_412_44 then
				local var_412_45 = (arg_409_1.time_ - var_412_43) / var_412_44
				local var_412_46 = Vector3.New(0, 100, 0)

				var_412_42.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1093ui_story, var_412_46, var_412_45)

				local var_412_47 = manager.ui.mainCamera.transform.position - var_412_42.position

				var_412_42.forward = Vector3.New(var_412_47.x, var_412_47.y, var_412_47.z)

				local var_412_48 = var_412_42.localEulerAngles

				var_412_48.z = 0
				var_412_48.x = 0
				var_412_42.localEulerAngles = var_412_48
			end

			if arg_409_1.time_ >= var_412_43 + var_412_44 and arg_409_1.time_ < var_412_43 + var_412_44 + arg_412_0 then
				var_412_42.localPosition = Vector3.New(0, 100, 0)

				local var_412_49 = manager.ui.mainCamera.transform.position - var_412_42.position

				var_412_42.forward = Vector3.New(var_412_49.x, var_412_49.y, var_412_49.z)

				local var_412_50 = var_412_42.localEulerAngles

				var_412_50.z = 0
				var_412_50.x = 0
				var_412_42.localEulerAngles = var_412_50
			end

			local var_412_51 = arg_409_1.actors_["1093ui_story"]
			local var_412_52 = 0

			if var_412_52 < arg_409_1.time_ and arg_409_1.time_ <= var_412_52 + arg_412_0 and not isNil(var_412_51) and arg_409_1.var_.characterEffect1093ui_story == nil then
				arg_409_1.var_.characterEffect1093ui_story = var_412_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_53 = 0.200000002980232

			if var_412_52 <= arg_409_1.time_ and arg_409_1.time_ < var_412_52 + var_412_53 and not isNil(var_412_51) then
				local var_412_54 = (arg_409_1.time_ - var_412_52) / var_412_53

				if arg_409_1.var_.characterEffect1093ui_story and not isNil(var_412_51) then
					local var_412_55 = Mathf.Lerp(0, 0.5, var_412_54)

					arg_409_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1093ui_story.fillRatio = var_412_55
				end
			end

			if arg_409_1.time_ >= var_412_52 + var_412_53 and arg_409_1.time_ < var_412_52 + var_412_53 + arg_412_0 and not isNil(var_412_51) and arg_409_1.var_.characterEffect1093ui_story then
				local var_412_56 = 0.5

				arg_409_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1093ui_story.fillRatio = var_412_56
			end

			local var_412_57 = arg_409_1.bgs_.LX0101.transform
			local var_412_58 = 2

			if var_412_58 < arg_409_1.time_ and arg_409_1.time_ <= var_412_58 + arg_412_0 then
				arg_409_1.var_.moveOldPosLX0101 = var_412_57.localPosition
			end

			local var_412_59 = 0.001

			if var_412_58 <= arg_409_1.time_ and arg_409_1.time_ < var_412_58 + var_412_59 then
				local var_412_60 = (arg_409_1.time_ - var_412_58) / var_412_59
				local var_412_61 = Vector3.New(0, 1, 8)

				var_412_57.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPosLX0101, var_412_61, var_412_60)
			end

			if arg_409_1.time_ >= var_412_58 + var_412_59 and arg_409_1.time_ < var_412_58 + var_412_59 + arg_412_0 then
				var_412_57.localPosition = Vector3.New(0, 1, 8)
			end

			local var_412_62 = arg_409_1.bgs_.LX0101.transform
			local var_412_63 = 2.01666666666667

			if var_412_63 < arg_409_1.time_ and arg_409_1.time_ <= var_412_63 + arg_412_0 then
				arg_409_1.var_.moveOldPosLX0101 = var_412_62.localPosition
			end

			local var_412_64 = 2.5

			if var_412_63 <= arg_409_1.time_ and arg_409_1.time_ < var_412_63 + var_412_64 then
				local var_412_65 = (arg_409_1.time_ - var_412_63) / var_412_64
				local var_412_66 = Vector3.New(0, 1, 10)

				var_412_62.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPosLX0101, var_412_66, var_412_65)
			end

			if arg_409_1.time_ >= var_412_63 + var_412_64 and arg_409_1.time_ < var_412_63 + var_412_64 + arg_412_0 then
				var_412_62.localPosition = Vector3.New(0, 1, 10)
			end

			local var_412_67 = 4

			if var_412_67 < arg_409_1.time_ and arg_409_1.time_ <= var_412_67 + arg_412_0 then
				arg_409_1.allBtn_.enabled = false
			end

			local var_412_68 = 0.516666666666667

			if arg_409_1.time_ >= var_412_67 + var_412_68 and arg_409_1.time_ < var_412_67 + var_412_68 + arg_412_0 then
				arg_409_1.allBtn_.enabled = true
			end

			local var_412_69 = manager.ui.mainCamera.transform
			local var_412_70 = 2.01666666666667

			if var_412_70 < arg_409_1.time_ and arg_409_1.time_ <= var_412_70 + arg_412_0 then
				local var_412_71 = arg_409_1.var_.effect丽天宫上空1
				local var_412_72
				local var_412_73 = var_412_69

				if not var_412_71 then
					var_412_71 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_412_73)
					var_412_71.name = "丽天宫上空1"
					arg_409_1.var_.effect丽天宫上空1 = var_412_71
				else
					var_412_71.transform:SetParent(var_412_73)
				end

				var_412_71.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_71.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_74 = 4
			local var_412_75 = 0.25

			if var_412_74 < arg_409_1.time_ and arg_409_1.time_ <= var_412_74 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_76 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_76:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_77 = arg_409_1:FormatText(StoryNameCfg[84].name)

				arg_409_1.leftNameTxt_.text = var_412_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_78 = arg_409_1:GetWordFromCfg(318031101)
				local var_412_79 = arg_409_1:FormatText(var_412_78.content)

				arg_409_1.text_.text = var_412_79

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_80 = 10
				local var_412_81 = utf8.len(var_412_79)
				local var_412_82 = var_412_80 <= 0 and var_412_75 or var_412_75 * (var_412_81 / var_412_80)

				if var_412_82 > 0 and var_412_75 < var_412_82 then
					arg_409_1.talkMaxDuration = var_412_82
					var_412_74 = var_412_74 + 0.3

					if var_412_82 + var_412_74 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_82 + var_412_74
					end
				end

				arg_409_1.text_.text = var_412_79
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031101", "story_v_out_318031.awb") ~= 0 then
					local var_412_83 = manager.audio:GetVoiceLength("story_v_out_318031", "318031101", "story_v_out_318031.awb") / 1000

					if var_412_83 + var_412_74 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_83 + var_412_74
					end

					if var_412_78.prefab_name ~= "" and arg_409_1.actors_[var_412_78.prefab_name] ~= nil then
						local var_412_84 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_78.prefab_name].transform, "story_v_out_318031", "318031101", "story_v_out_318031.awb")

						arg_409_1:RecordAudio("318031101", var_412_84)
						arg_409_1:RecordAudio("318031101", var_412_84)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_318031", "318031101", "story_v_out_318031.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_318031", "318031101", "story_v_out_318031.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_85 = var_412_74 + 0.3
			local var_412_86 = math.max(var_412_75, arg_409_1.talkMaxDuration)

			if var_412_85 <= arg_409_1.time_ and arg_409_1.time_ < var_412_85 + var_412_86 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_85) / var_412_86

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_85 + var_412_86 and arg_409_1.time_ < var_412_85 + var_412_86 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "LX0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play318031102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 318031102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play318031103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 1.125

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_2 = arg_415_1:GetWordFromCfg(318031102)
				local var_418_3 = arg_415_1:FormatText(var_418_2.content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 45
				local var_418_5 = utf8.len(var_418_3)
				local var_418_6 = var_418_4 <= 0 and var_418_1 or var_418_1 * (var_418_5 / var_418_4)

				if var_418_6 > 0 and var_418_1 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_7 and arg_415_1.time_ < var_418_0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play318031103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 318031103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play318031104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 1.375

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(318031103)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 55
				local var_422_5 = utf8.len(var_422_3)
				local var_422_6 = var_422_4 <= 0 and var_422_1 or var_422_1 * (var_422_5 / var_422_4)

				if var_422_6 > 0 and var_422_1 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_7 and arg_419_1.time_ < var_422_0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play318031104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 318031104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play318031105(arg_423_1)
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

				local var_426_3 = arg_423_1:GetWordFromCfg(318031104)
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
	Play318031105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 318031105
		arg_427_1.duration_ = 3.8

		local var_427_0 = {
			zh = 3.8,
			ja = 2.566
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play318031106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.45

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[562].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(318031105)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 18
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031105", "story_v_out_318031.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031105", "story_v_out_318031.awb") / 1000

					if var_430_8 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_0
					end

					if var_430_3.prefab_name ~= "" and arg_427_1.actors_[var_430_3.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_3.prefab_name].transform, "story_v_out_318031", "318031105", "story_v_out_318031.awb")

						arg_427_1:RecordAudio("318031105", var_430_9)
						arg_427_1:RecordAudio("318031105", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_318031", "318031105", "story_v_out_318031.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_318031", "318031105", "story_v_out_318031.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_10 and arg_427_1.time_ < var_430_0 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play318031106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 318031106
		arg_431_1.duration_ = 7.8

		local var_431_0 = {
			zh = 5.6,
			ja = 7.8
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play318031107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 0.55

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_2 = arg_431_1:FormatText(StoryNameCfg[562].name)

				arg_431_1.leftNameTxt_.text = var_434_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:GetWordFromCfg(318031106)
				local var_434_4 = arg_431_1:FormatText(var_434_3.content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 22
				local var_434_6 = utf8.len(var_434_4)
				local var_434_7 = var_434_5 <= 0 and var_434_1 or var_434_1 * (var_434_6 / var_434_5)

				if var_434_7 > 0 and var_434_1 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031106", "story_v_out_318031.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031106", "story_v_out_318031.awb") / 1000

					if var_434_8 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_0
					end

					if var_434_3.prefab_name ~= "" and arg_431_1.actors_[var_434_3.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_3.prefab_name].transform, "story_v_out_318031", "318031106", "story_v_out_318031.awb")

						arg_431_1:RecordAudio("318031106", var_434_9)
						arg_431_1:RecordAudio("318031106", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_318031", "318031106", "story_v_out_318031.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_318031", "318031106", "story_v_out_318031.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_10 and arg_431_1.time_ < var_434_0 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play318031107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 318031107
		arg_435_1.duration_ = 4.8

		local var_435_0 = {
			zh = 4.8,
			ja = 4.2
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play318031108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.5

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[84].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:GetWordFromCfg(318031107)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 20
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031107", "story_v_out_318031.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031107", "story_v_out_318031.awb") / 1000

					if var_438_8 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_0
					end

					if var_438_3.prefab_name ~= "" and arg_435_1.actors_[var_438_3.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_3.prefab_name].transform, "story_v_out_318031", "318031107", "story_v_out_318031.awb")

						arg_435_1:RecordAudio("318031107", var_438_9)
						arg_435_1:RecordAudio("318031107", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_318031", "318031107", "story_v_out_318031.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_318031", "318031107", "story_v_out_318031.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_10 and arg_435_1.time_ < var_438_0 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play318031108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 318031108
		arg_439_1.duration_ = 8.4

		local var_439_0 = {
			zh = 6.933,
			ja = 8.4
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play318031109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.875

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[84].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(318031108)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031108", "story_v_out_318031.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031108", "story_v_out_318031.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_318031", "318031108", "story_v_out_318031.awb")

						arg_439_1:RecordAudio("318031108", var_442_9)
						arg_439_1:RecordAudio("318031108", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_318031", "318031108", "story_v_out_318031.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_318031", "318031108", "story_v_out_318031.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play318031109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 318031109
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play318031110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.875

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(318031109)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 35
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_8 and arg_443_1.time_ < var_446_0 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play318031110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 318031110
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play318031111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.75

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[7].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_3 = arg_447_1:GetWordFromCfg(318031110)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 30
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_8 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_8 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_8

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_8 and arg_447_1.time_ < var_450_0 + var_450_8 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play318031111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 318031111
		arg_451_1.duration_ = 2.63

		local var_451_0 = {
			zh = 2.233,
			ja = 2.633
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play318031112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 0.375

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_2 = arg_451_1:FormatText(StoryNameCfg[84].name)

				arg_451_1.leftNameTxt_.text = var_454_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1199")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:GetWordFromCfg(318031111)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_5 = 15
				local var_454_6 = utf8.len(var_454_4)
				local var_454_7 = var_454_5 <= 0 and var_454_1 or var_454_1 * (var_454_6 / var_454_5)

				if var_454_7 > 0 and var_454_1 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031111", "story_v_out_318031.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031111", "story_v_out_318031.awb") / 1000

					if var_454_8 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_0
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_out_318031", "318031111", "story_v_out_318031.awb")

						arg_451_1:RecordAudio("318031111", var_454_9)
						arg_451_1:RecordAudio("318031111", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_318031", "318031111", "story_v_out_318031.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_318031", "318031111", "story_v_out_318031.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_10 and arg_451_1.time_ < var_454_0 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play318031112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 318031112
		arg_455_1.duration_ = 5.37

		local var_455_0 = {
			zh = 2.2,
			ja = 5.366
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play318031113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 0.275

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_2 = arg_455_1:FormatText(StoryNameCfg[479].name)

				arg_455_1.leftNameTxt_.text = var_458_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(318031112)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 11
				local var_458_6 = utf8.len(var_458_4)
				local var_458_7 = var_458_5 <= 0 and var_458_1 or var_458_1 * (var_458_6 / var_458_5)

				if var_458_7 > 0 and var_458_1 < var_458_7 then
					arg_455_1.talkMaxDuration = var_458_7

					if var_458_7 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031112", "story_v_out_318031.awb") ~= 0 then
					local var_458_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031112", "story_v_out_318031.awb") / 1000

					if var_458_8 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_0
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_318031", "318031112", "story_v_out_318031.awb")

						arg_455_1:RecordAudio("318031112", var_458_9)
						arg_455_1:RecordAudio("318031112", var_458_9)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_318031", "318031112", "story_v_out_318031.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_318031", "318031112", "story_v_out_318031.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_10 and arg_455_1.time_ < var_458_0 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play318031113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 318031113
		arg_459_1.duration_ = 9

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play318031114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 2

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				local var_462_1 = manager.ui.mainCamera.transform.localPosition
				local var_462_2 = Vector3.New(0, 0, 10) + Vector3.New(var_462_1.x, var_462_1.y, 0)
				local var_462_3 = arg_459_1.bgs_.K13f

				var_462_3.transform.localPosition = var_462_2
				var_462_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_462_4 = var_462_3:GetComponent("SpriteRenderer")

				if var_462_4 and var_462_4.sprite then
					local var_462_5 = (var_462_3.transform.localPosition - var_462_1).z
					local var_462_6 = manager.ui.mainCameraCom_
					local var_462_7 = 2 * var_462_5 * Mathf.Tan(var_462_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_462_8 = var_462_7 * var_462_6.aspect
					local var_462_9 = var_462_4.sprite.bounds.size.x
					local var_462_10 = var_462_4.sprite.bounds.size.y
					local var_462_11 = var_462_8 / var_462_9
					local var_462_12 = var_462_7 / var_462_10
					local var_462_13 = var_462_12 < var_462_11 and var_462_11 or var_462_12

					var_462_3.transform.localScale = Vector3.New(var_462_13, var_462_13, 0)
				end

				for iter_462_0, iter_462_1 in pairs(arg_459_1.bgs_) do
					if iter_462_0 ~= "K13f" then
						iter_462_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_462_14 = 0

			if var_462_14 < arg_459_1.time_ and arg_459_1.time_ <= var_462_14 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_15 = 2

			if var_462_14 <= arg_459_1.time_ and arg_459_1.time_ < var_462_14 + var_462_15 then
				local var_462_16 = (arg_459_1.time_ - var_462_14) / var_462_15
				local var_462_17 = Color.New(0, 0, 0)

				var_462_17.a = Mathf.Lerp(0, 1, var_462_16)
				arg_459_1.mask_.color = var_462_17
			end

			if arg_459_1.time_ >= var_462_14 + var_462_15 and arg_459_1.time_ < var_462_14 + var_462_15 + arg_462_0 then
				local var_462_18 = Color.New(0, 0, 0)

				var_462_18.a = 1
				arg_459_1.mask_.color = var_462_18
			end

			local var_462_19 = 2

			if var_462_19 < arg_459_1.time_ and arg_459_1.time_ <= var_462_19 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_20 = 2

			if var_462_19 <= arg_459_1.time_ and arg_459_1.time_ < var_462_19 + var_462_20 then
				local var_462_21 = (arg_459_1.time_ - var_462_19) / var_462_20
				local var_462_22 = Color.New(0, 0, 0)

				var_462_22.a = Mathf.Lerp(1, 0, var_462_21)
				arg_459_1.mask_.color = var_462_22
			end

			if arg_459_1.time_ >= var_462_19 + var_462_20 and arg_459_1.time_ < var_462_19 + var_462_20 + arg_462_0 then
				local var_462_23 = Color.New(0, 0, 0)
				local var_462_24 = 0

				arg_459_1.mask_.enabled = false
				var_462_23.a = var_462_24
				arg_459_1.mask_.color = var_462_23
			end

			local var_462_25 = 4
			local var_462_26 = 0.433333333333333

			if var_462_25 < arg_459_1.time_ and arg_459_1.time_ <= var_462_25 + arg_462_0 then
				local var_462_27 = "play"
				local var_462_28 = "effect"

				arg_459_1:AudioAction(var_462_27, var_462_28, "se_story_10", "se_story_10_sword", "")
			end

			local var_462_29 = manager.ui.mainCamera.transform
			local var_462_30 = 1.88333333333333

			if var_462_30 < arg_459_1.time_ and arg_459_1.time_ <= var_462_30 + arg_462_0 then
				local var_462_31 = arg_459_1.var_.effect丽天宫上空1

				if var_462_31 then
					Object.Destroy(var_462_31)

					arg_459_1.var_.effect丽天宫上空1 = nil
				end
			end

			if arg_459_1.frameCnt_ <= 1 then
				arg_459_1.dialog_:SetActive(false)
			end

			local var_462_32 = 4
			local var_462_33 = 0.575

			if var_462_32 < arg_459_1.time_ and arg_459_1.time_ <= var_462_32 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				arg_459_1.dialog_:SetActive(true)

				arg_459_1.dialogCg_.alpha = 0

				local var_462_34 = LeanTween.value(arg_459_1.dialog_, 0, 1, 0.3)

				var_462_34:setOnUpdate(LuaHelper.FloatAction(function(arg_463_0)
					arg_459_1.dialogCg_.alpha = arg_463_0
				end))
				var_462_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_459_1.dialog_)
					var_462_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_459_1.duration_ = arg_459_1.duration_ + 0.3

				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_35 = arg_459_1:GetWordFromCfg(318031113)
				local var_462_36 = arg_459_1:FormatText(var_462_35.content)

				arg_459_1.text_.text = var_462_36

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_37 = 23
				local var_462_38 = utf8.len(var_462_36)
				local var_462_39 = var_462_37 <= 0 and var_462_33 or var_462_33 * (var_462_38 / var_462_37)

				if var_462_39 > 0 and var_462_33 < var_462_39 then
					arg_459_1.talkMaxDuration = var_462_39
					var_462_32 = var_462_32 + 0.3

					if var_462_39 + var_462_32 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_39 + var_462_32
					end
				end

				arg_459_1.text_.text = var_462_36
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_40 = var_462_32 + 0.3
			local var_462_41 = math.max(var_462_33, arg_459_1.talkMaxDuration)

			if var_462_40 <= arg_459_1.time_ and arg_459_1.time_ < var_462_40 + var_462_41 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_40) / var_462_41

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_40 + var_462_41 and arg_459_1.time_ < var_462_40 + var_462_41 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play318031114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 318031114
		arg_465_1.duration_ = 3.07

		local var_465_0 = {
			zh = 2.333,
			ja = 3.066
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
				arg_465_0:Play318031115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.15

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[639].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2113")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:GetWordFromCfg(318031114)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 6
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031114", "story_v_out_318031.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_318031", "318031114", "story_v_out_318031.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_318031", "318031114", "story_v_out_318031.awb")

						arg_465_1:RecordAudio("318031114", var_468_9)
						arg_465_1:RecordAudio("318031114", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_318031", "318031114", "story_v_out_318031.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_318031", "318031114", "story_v_out_318031.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_10 and arg_465_1.time_ < var_468_0 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play318031115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 318031115
		arg_469_1.duration_ = 10.37

		local var_469_0 = {
			zh = 5.4,
			ja = 10.366
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
			arg_469_1.auto_ = false
		end

		function arg_469_1.playNext_(arg_471_0)
			arg_469_1.onStoryFinished_()
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1015ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos1015ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0, -1.15, -6.2)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1015ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["1015ui_story"]
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1015ui_story == nil then
				arg_469_1.var_.characterEffect1015ui_story = var_472_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_11 = 0.200000002980232

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 and not isNil(var_472_9) then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11

				if arg_469_1.var_.characterEffect1015ui_story and not isNil(var_472_9) then
					arg_469_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1015ui_story then
				arg_469_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_472_13 = 0

			if var_472_13 < arg_469_1.time_ and arg_469_1.time_ <= var_472_13 + arg_472_0 then
				arg_469_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_472_14 = 0

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 then
				arg_469_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_472_15 = 0
			local var_472_16 = 0.775

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_17 = arg_469_1:FormatText(StoryNameCfg[479].name)

				arg_469_1.leftNameTxt_.text = var_472_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_18 = arg_469_1:GetWordFromCfg(318031115)
				local var_472_19 = arg_469_1:FormatText(var_472_18.content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_20 = 31
				local var_472_21 = utf8.len(var_472_19)
				local var_472_22 = var_472_20 <= 0 and var_472_16 or var_472_16 * (var_472_21 / var_472_20)

				if var_472_22 > 0 and var_472_16 < var_472_22 then
					arg_469_1.talkMaxDuration = var_472_22

					if var_472_22 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_22 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318031", "318031115", "story_v_out_318031.awb") ~= 0 then
					local var_472_23 = manager.audio:GetVoiceLength("story_v_out_318031", "318031115", "story_v_out_318031.awb") / 1000

					if var_472_23 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_23 + var_472_15
					end

					if var_472_18.prefab_name ~= "" and arg_469_1.actors_[var_472_18.prefab_name] ~= nil then
						local var_472_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_18.prefab_name].transform, "story_v_out_318031", "318031115", "story_v_out_318031.awb")

						arg_469_1:RecordAudio("318031115", var_472_24)
						arg_469_1:RecordAudio("318031115", var_472_24)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_318031", "318031115", "story_v_out_318031.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_318031", "318031115", "story_v_out_318031.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_25 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_25 and arg_469_1.time_ < var_472_15 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play318031057 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 318031057
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play318031058(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.525

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(318031057)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 21
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K01f",
		"TextureConfig/Background/K13f",
		"TextureConfig/Background/LX0101"
	},
	voices = {
		"story_v_out_318031.awb"
	}
}
