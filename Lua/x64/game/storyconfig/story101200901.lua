return {
	Play120091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J13f"

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
				local var_4_5 = arg_1_1.bgs_.J13f

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
					if iter_4_0 ~= "J13f" then
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

			local var_4_22 = 1.5

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_23 = 0.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = (arg_1_1.time_ - var_4_22) / var_4_23
				local var_4_25 = Color.New(1, 1, 1)

				var_4_25.a = Mathf.Lerp(1, 0, var_4_24)
				arg_1_1.mask_.color = var_4_25
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				local var_4_26 = Color.New(1, 1, 1)
				local var_4_27 = 0

				arg_1_1.mask_.enabled = false
				var_4_26.a = var_4_27
				arg_1_1.mask_.color = var_4_26
			end

			local var_4_28 = manager.ui.mainCamera.transform
			local var_4_29 = 1.5

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_28.localPosition
			end

			local var_4_30 = 0.499999999999

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / 0.066
				local var_4_32, var_4_33 = math.modf(var_4_31)

				var_4_28.localPosition = Vector3.New(var_4_33 * 0.13, var_4_33 * 0.13, var_4_33 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				var_4_28.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_34 = 1.66666666666667
			local var_4_35 = 0.766666666666666

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_120_00", "se_story_120_00_machinebattle", "")
			end

			local var_4_38 = 0
			local var_4_39 = 0.466666666666667

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "music"

				arg_1_1:AudioAction(var_4_40, var_4_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_42 = ""
				local var_4_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_43 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_43 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_43

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_43
						arg_1_1.bgmTxt2_.text = var_4_43
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

			local var_4_44 = 0.566666666666667
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 2
			local var_4_51 = 0.075

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_52 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_52:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_53 = arg_1_1:GetWordFromCfg(120091001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 3
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_51 or var_4_51 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_51 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_50 = var_4_50 + 0.3

					if var_4_57 + var_4_50 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_50
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_50 + 0.3
			local var_4_59 = math.max(var_4_51, arg_1_1.talkMaxDuration)

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_59 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_58) / var_4_59

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play120091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play120091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1071ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_12_6 = 0
			local var_12_7 = 0.525

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_8 = arg_9_1:GetWordFromCfg(120091002)
				local var_12_9 = arg_9_1:FormatText(var_12_8.content)

				arg_9_1.text_.text = var_12_9

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_10 = 21
				local var_12_11 = utf8.len(var_12_9)
				local var_12_12 = var_12_10 <= 0 and var_12_7 or var_12_7 * (var_12_11 / var_12_10)

				if var_12_12 > 0 and var_12_7 < var_12_12 then
					arg_9_1.talkMaxDuration = var_12_12

					if var_12_12 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_9
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_13 and arg_9_1.time_ < var_12_6 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play120091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120091003
		arg_13_1.duration_ = 3.5

		local var_13_0 = {
			zh = 2.6,
			ja = 3.5
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
				arg_13_0:Play120091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1071ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1071ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -1.05, -6.2)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1071ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1071ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1071ui_story == nil then
				arg_13_1.var_.characterEffect1071ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.2

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1071ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1071ui_story then
				arg_13_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_16_14 = 0
			local var_16_15 = 0.3

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_16 = arg_13_1:FormatText(StoryNameCfg[384].name)

				arg_13_1.leftNameTxt_.text = var_16_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(120091003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 12
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_15 or var_16_15 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_15 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091003", "story_v_out_120091.awb") ~= 0 then
					local var_16_22 = manager.audio:GetVoiceLength("story_v_out_120091", "120091003", "story_v_out_120091.awb") / 1000

					if var_16_22 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_14
					end

					if var_16_17.prefab_name ~= "" and arg_13_1.actors_[var_16_17.prefab_name] ~= nil then
						local var_16_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_17.prefab_name].transform, "story_v_out_120091", "120091003", "story_v_out_120091.awb")

						arg_13_1:RecordAudio("120091003", var_16_23)
						arg_13_1:RecordAudio("120091003", var_16_23)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_120091", "120091003", "story_v_out_120091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_120091", "120091003", "story_v_out_120091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_24 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_24 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_24

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_24 and arg_13_1.time_ < var_16_14 + var_16_24 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play120091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120091004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1071ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1071ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1071ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = 0
			local var_20_10 = 0.825

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(120091004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 33
				local var_20_14 = utf8.len(var_20_12)
				local var_20_15 = var_20_13 <= 0 and var_20_10 or var_20_10 * (var_20_14 / var_20_13)

				if var_20_15 > 0 and var_20_10 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_9 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_9
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_10, arg_17_1.talkMaxDuration)

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_9) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_9 + var_20_16 and arg_17_1.time_ < var_20_9 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play120091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120091005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.275

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

				local var_24_2 = arg_21_1:GetWordFromCfg(120091005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 51
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
	Play120091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120091006
		arg_25_1.duration_ = 2.47

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1184ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["1184ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos1184ui_story = var_28_5.localPosition

				local var_28_7 = "1184ui_story"

				arg_25_1:ShowWeapon(arg_25_1.var_[var_28_7 .. "Animator"].transform, true)
			end

			local var_28_8 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_6) / var_28_8
				local var_28_10 = Vector3.New(0, -0.97, -6)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1184ui_story, var_28_10, var_28_9)

				local var_28_11 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_11.x, var_28_11.y, var_28_11.z)

				local var_28_12 = var_28_5.localEulerAngles

				var_28_12.z = 0
				var_28_12.x = 0
				var_28_5.localEulerAngles = var_28_12
			end

			if arg_25_1.time_ >= var_28_6 + var_28_8 and arg_25_1.time_ < var_28_6 + var_28_8 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_28_13 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_13.x, var_28_13.y, var_28_13.z)

				local var_28_14 = var_28_5.localEulerAngles

				var_28_14.z = 0
				var_28_14.x = 0
				var_28_5.localEulerAngles = var_28_14
			end

			local var_28_15 = arg_25_1.actors_["1184ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1184ui_story == nil then
				arg_25_1.var_.characterEffect1184ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.2

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect1184ui_story and not isNil(var_28_15) then
					arg_25_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect1184ui_story then
				arg_25_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_28_21 = 0
			local var_28_22 = 0.1

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(120091006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091006", "story_v_out_120091.awb") ~= 0 then
					local var_28_29 = manager.audio:GetVoiceLength("story_v_out_120091", "120091006", "story_v_out_120091.awb") / 1000

					if var_28_29 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_120091", "120091006", "story_v_out_120091.awb")

						arg_25_1:RecordAudio("120091006", var_28_30)
						arg_25_1:RecordAudio("120091006", var_28_30)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_120091", "120091006", "story_v_out_120091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_120091", "120091006", "story_v_out_120091.awb")
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
				actorName = "1184ui_story",
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
	Play120091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120091007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play120091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1184ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1184ui_story == nil then
				arg_29_1.var_.characterEffect1184ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1184ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1184ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1184ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1184ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.075

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(120091007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 3
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play120091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120091008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play120091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1184ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1184ui_story = var_36_0.localPosition

				local var_36_2 = "1184ui_story"

				arg_33_1:ShowWeapon(arg_33_1.var_[var_36_2 .. "Animator"].transform, false)
			end

			local var_36_3 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_3 then
				local var_36_4 = (arg_33_1.time_ - var_36_1) / var_36_3
				local var_36_5 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1184ui_story, var_36_5, var_36_4)

				local var_36_6 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_6.x, var_36_6.y, var_36_6.z)

				local var_36_7 = var_36_0.localEulerAngles

				var_36_7.z = 0
				var_36_7.x = 0
				var_36_0.localEulerAngles = var_36_7
			end

			if arg_33_1.time_ >= var_36_1 + var_36_3 and arg_33_1.time_ < var_36_1 + var_36_3 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_8 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_8.x, var_36_8.y, var_36_8.z)

				local var_36_9 = var_36_0.localEulerAngles

				var_36_9.z = 0
				var_36_9.x = 0
				var_36_0.localEulerAngles = var_36_9
			end

			local var_36_10 = 0
			local var_36_11 = 1

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				local var_36_12 = "play"
				local var_36_13 = "effect"

				arg_33_1:AudioAction(var_36_12, var_36_13, "se_story_120_00", "se_story_120_00_machinedeath", "")
			end

			local var_36_14 = 0
			local var_36_15 = 1.175

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_16 = arg_33_1:GetWordFromCfg(120091008)
				local var_36_17 = arg_33_1:FormatText(var_36_16.content)

				arg_33_1.text_.text = var_36_17

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_18 = 47
				local var_36_19 = utf8.len(var_36_17)
				local var_36_20 = var_36_18 <= 0 and var_36_15 or var_36_15 * (var_36_19 / var_36_18)

				if var_36_20 > 0 and var_36_15 < var_36_20 then
					arg_33_1.talkMaxDuration = var_36_20

					if var_36_20 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_17
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_21 and arg_33_1.time_ < var_36_14 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120091009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.675

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(120091009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 27
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120091010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play120091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.325

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

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

				local var_44_3 = arg_41_1:GetWordFromCfg(120091010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 13
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120091011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.35

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(120091011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 14
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play120091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120091012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play120091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				local var_52_2 = "play"
				local var_52_3 = "effect"

				arg_49_1:AudioAction(var_52_2, var_52_3, "se_story_120_00", "se_story_120_00_datastream", "")
			end

			local var_52_4 = 0
			local var_52_5 = 0.466666666666667

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				local var_52_6 = "play"
				local var_52_7 = "music"

				arg_49_1:AudioAction(var_52_6, var_52_7, "ui_battle", "ui_battle_stopbgm", "")

				local var_52_8 = ""
				local var_52_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_52_9 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_9 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_9

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_9
						arg_49_1.bgmTxt2_.text = var_52_9
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_52_10 = 0
			local var_52_11 = 1.35

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_12 = arg_49_1:GetWordFromCfg(120091012)
				local var_52_13 = arg_49_1:FormatText(var_52_12.content)

				arg_49_1.text_.text = var_52_13

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_14 = 54
				local var_52_15 = utf8.len(var_52_13)
				local var_52_16 = var_52_14 <= 0 and var_52_11 or var_52_11 * (var_52_15 / var_52_14)

				if var_52_16 > 0 and var_52_11 < var_52_16 then
					arg_49_1.talkMaxDuration = var_52_16

					if var_52_16 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_13
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_17 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_17 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_17

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_17 and arg_49_1.time_ < var_52_10 + var_52_17 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120091013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 120091013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play120091014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = manager.ui.mainCamera.transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.shakeOldPos = var_57_0.localPosition
			end

			local var_57_2 = 0.6

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / 0.066
				local var_57_4, var_57_5 = math.modf(var_57_3)

				var_57_0.localPosition = Vector3.New(var_57_5 * 0.13, var_57_5 * 0.13, var_57_5 * 0.13) + arg_54_1.var_.shakeOldPos
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = arg_54_1.var_.shakeOldPos
			end

			local var_57_6 = 0

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.allBtn_.enabled = false
			end

			local var_57_7 = 0.6

			if arg_54_1.time_ >= var_57_6 + var_57_7 and arg_54_1.time_ < var_57_6 + var_57_7 + arg_57_0 then
				arg_54_1.allBtn_.enabled = true
			end

			local var_57_8 = 0
			local var_57_9 = 0.05

			if var_57_8 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_10 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_11 = arg_54_1:GetWordFromCfg(120091013)
				local var_57_12 = arg_54_1:FormatText(var_57_11.content)

				arg_54_1.text_.text = var_57_12

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 2
				local var_57_14 = utf8.len(var_57_12)
				local var_57_15 = var_57_13 <= 0 and var_57_9 or var_57_9 * (var_57_14 / var_57_13)

				if var_57_15 > 0 and var_57_9 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_12
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_16 and arg_54_1.time_ < var_57_8 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play120091014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 120091014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play120091015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(120091014)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 40
				local var_61_5 = utf8.len(var_61_3)
				local var_61_6 = var_61_4 <= 0 and var_61_1 or var_61_1 * (var_61_5 / var_61_4)

				if var_61_6 > 0 and var_61_1 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_7 and arg_58_1.time_ < var_61_0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play120091015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 120091015
		arg_62_1.duration_ = 5.5

		local var_62_0 = {
			zh = 5.5,
			ja = 4.066
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
				arg_62_0:Play120091016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1184ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1184ui_story = var_65_0.localPosition
			end

			local var_65_2 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2
				local var_65_4 = Vector3.New(0, -0.97, -6)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1184ui_story, var_65_4, var_65_3)

				local var_65_5 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_5.x, var_65_5.y, var_65_5.z)

				local var_65_6 = var_65_0.localEulerAngles

				var_65_6.z = 0
				var_65_6.x = 0
				var_65_0.localEulerAngles = var_65_6
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_65_7 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_7.x, var_65_7.y, var_65_7.z)

				local var_65_8 = var_65_0.localEulerAngles

				var_65_8.z = 0
				var_65_8.x = 0
				var_65_0.localEulerAngles = var_65_8
			end

			local var_65_9 = arg_62_1.actors_["1184ui_story"]
			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect1184ui_story == nil then
				arg_62_1.var_.characterEffect1184ui_story = var_65_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_11 = 0.2

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_11 and not isNil(var_65_9) then
				local var_65_12 = (arg_62_1.time_ - var_65_10) / var_65_11

				if arg_62_1.var_.characterEffect1184ui_story and not isNil(var_65_9) then
					arg_62_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_10 + var_65_11 and arg_62_1.time_ < var_65_10 + var_65_11 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect1184ui_story then
				arg_62_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_65_13 = 0

			if var_65_13 < arg_62_1.time_ and arg_62_1.time_ <= var_65_13 + arg_65_0 then
				arg_62_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_65_14 = 0

			if var_65_14 < arg_62_1.time_ and arg_62_1.time_ <= var_65_14 + arg_65_0 then
				arg_62_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_65_15 = 0
			local var_65_16 = 0.1

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				local var_65_17 = "play"
				local var_65_18 = "music"

				arg_62_1:AudioAction(var_65_17, var_65_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_65_19 = ""
				local var_65_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_65_20 ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_20 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_20

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_20
						arg_62_1.bgmTxt2_.text = var_65_20
					end

					if arg_62_1.bgmTimer then
						arg_62_1.bgmTimer:Stop()

						arg_62_1.bgmTimer = nil
					end

					if arg_62_1.settingData.show_music_name == 1 then
						arg_62_1.musicController:SetSelectedState("show")
						arg_62_1.musicAnimator_:Play("open", 0, 0)

						if arg_62_1.settingData.music_time ~= 0 then
							arg_62_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_62_1.settingData.music_time), function()
								if arg_62_1 == nil or isNil(arg_62_1.bgmTxt_) then
									return
								end

								arg_62_1.musicController:SetSelectedState("hide")
								arg_62_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_65_21 = 0.533333333333333
			local var_65_22 = 1

			if var_65_21 < arg_62_1.time_ and arg_62_1.time_ <= var_65_21 + arg_65_0 then
				local var_65_23 = "play"
				local var_65_24 = "music"

				arg_62_1:AudioAction(var_65_23, var_65_24, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_65_25 = ""
				local var_65_26 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_65_26 ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_26 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_26

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_26
						arg_62_1.bgmTxt2_.text = var_65_26
					end

					if arg_62_1.bgmTimer then
						arg_62_1.bgmTimer:Stop()

						arg_62_1.bgmTimer = nil
					end

					if arg_62_1.settingData.show_music_name == 1 then
						arg_62_1.musicController:SetSelectedState("show")
						arg_62_1.musicAnimator_:Play("open", 0, 0)

						if arg_62_1.settingData.music_time ~= 0 then
							arg_62_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_62_1.settingData.music_time), function()
								if arg_62_1 == nil or isNil(arg_62_1.bgmTxt_) then
									return
								end

								arg_62_1.musicController:SetSelectedState("hide")
								arg_62_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_65_27 = 0
			local var_65_28 = 0.675

			if var_65_27 < arg_62_1.time_ and arg_62_1.time_ <= var_65_27 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_29 = arg_62_1:FormatText(StoryNameCfg[6].name)

				arg_62_1.leftNameTxt_.text = var_65_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_30 = arg_62_1:GetWordFromCfg(120091015)
				local var_65_31 = arg_62_1:FormatText(var_65_30.content)

				arg_62_1.text_.text = var_65_31

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_32 = 27
				local var_65_33 = utf8.len(var_65_31)
				local var_65_34 = var_65_32 <= 0 and var_65_28 or var_65_28 * (var_65_33 / var_65_32)

				if var_65_34 > 0 and var_65_28 < var_65_34 then
					arg_62_1.talkMaxDuration = var_65_34

					if var_65_34 + var_65_27 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_34 + var_65_27
					end
				end

				arg_62_1.text_.text = var_65_31
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091015", "story_v_out_120091.awb") ~= 0 then
					local var_65_35 = manager.audio:GetVoiceLength("story_v_out_120091", "120091015", "story_v_out_120091.awb") / 1000

					if var_65_35 + var_65_27 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_35 + var_65_27
					end

					if var_65_30.prefab_name ~= "" and arg_62_1.actors_[var_65_30.prefab_name] ~= nil then
						local var_65_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_30.prefab_name].transform, "story_v_out_120091", "120091015", "story_v_out_120091.awb")

						arg_62_1:RecordAudio("120091015", var_65_36)
						arg_62_1:RecordAudio("120091015", var_65_36)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_120091", "120091015", "story_v_out_120091.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_120091", "120091015", "story_v_out_120091.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_37 = math.max(var_65_28, arg_62_1.talkMaxDuration)

			if var_65_27 <= arg_62_1.time_ and arg_62_1.time_ < var_65_27 + var_65_37 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_27) / var_65_37

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_27 + var_65_37 and arg_62_1.time_ < var_65_27 + var_65_37 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play120091016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 120091016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play120091017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1184ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1184ui_story == nil then
				arg_68_1.var_.characterEffect1184ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1184ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1184ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1184ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1184ui_story.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.25

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_9 = arg_68_1:GetWordFromCfg(120091016)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 10
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
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play120091017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 120091017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play120091018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.3

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(120091017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 12
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play120091018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 120091018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play120091019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1184ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1184ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0, 100, 0)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1184ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, 100, 0)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = 0
			local var_79_10 = 0.975

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_11 = arg_76_1:GetWordFromCfg(120091018)
				local var_79_12 = arg_76_1:FormatText(var_79_11.content)

				arg_76_1.text_.text = var_79_12

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 39
				local var_79_14 = utf8.len(var_79_12)
				local var_79_15 = var_79_13 <= 0 and var_79_10 or var_79_10 * (var_79_14 / var_79_13)

				if var_79_15 > 0 and var_79_10 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_9 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_9
					end
				end

				arg_76_1.text_.text = var_79_12
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_10, arg_76_1.talkMaxDuration)

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_9) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_9 + var_79_16 and arg_76_1.time_ < var_79_9 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play120091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 120091019
		arg_80_1.duration_ = 7.4

		local var_80_0 = {
			zh = 4.3,
			ja = 7.4
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
				arg_80_0:Play120091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1184ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1184ui_story == nil then
				arg_80_1.var_.characterEffect1184ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1184ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1184ui_story then
				arg_80_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1184ui_story"].transform
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.var_.moveOldPos1184ui_story = var_83_4.localPosition
			end

			local var_83_6 = 0.001

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6
				local var_83_8 = Vector3.New(0, -0.97, -6)

				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1184ui_story, var_83_8, var_83_7)

				local var_83_9 = manager.ui.mainCamera.transform.position - var_83_4.position

				var_83_4.forward = Vector3.New(var_83_9.x, var_83_9.y, var_83_9.z)

				local var_83_10 = var_83_4.localEulerAngles

				var_83_10.z = 0
				var_83_10.x = 0
				var_83_4.localEulerAngles = var_83_10
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_83_11 = manager.ui.mainCamera.transform.position - var_83_4.position

				var_83_4.forward = Vector3.New(var_83_11.x, var_83_11.y, var_83_11.z)

				local var_83_12 = var_83_4.localEulerAngles

				var_83_12.z = 0
				var_83_12.x = 0
				var_83_4.localEulerAngles = var_83_12
			end

			local var_83_13 = 0

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_83_14 = 0
			local var_83_15 = 0.475

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_16 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_17 = arg_80_1:GetWordFromCfg(120091019)
				local var_83_18 = arg_80_1:FormatText(var_83_17.content)

				arg_80_1.text_.text = var_83_18

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_19 = 19
				local var_83_20 = utf8.len(var_83_18)
				local var_83_21 = var_83_19 <= 0 and var_83_15 or var_83_15 * (var_83_20 / var_83_19)

				if var_83_21 > 0 and var_83_15 < var_83_21 then
					arg_80_1.talkMaxDuration = var_83_21

					if var_83_21 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_21 + var_83_14
					end
				end

				arg_80_1.text_.text = var_83_18
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091019", "story_v_out_120091.awb") ~= 0 then
					local var_83_22 = manager.audio:GetVoiceLength("story_v_out_120091", "120091019", "story_v_out_120091.awb") / 1000

					if var_83_22 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_14
					end

					if var_83_17.prefab_name ~= "" and arg_80_1.actors_[var_83_17.prefab_name] ~= nil then
						local var_83_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_17.prefab_name].transform, "story_v_out_120091", "120091019", "story_v_out_120091.awb")

						arg_80_1:RecordAudio("120091019", var_83_23)
						arg_80_1:RecordAudio("120091019", var_83_23)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_120091", "120091019", "story_v_out_120091.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_120091", "120091019", "story_v_out_120091.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_24 = math.max(var_83_15, arg_80_1.talkMaxDuration)

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_24 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_24

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_24 and arg_80_1.time_ < var_83_14 + var_83_24 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play120091020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 120091020
		arg_84_1.duration_ = 2.4

		local var_84_0 = {
			zh = 1.966,
			ja = 2.4
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play120091021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1071ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1071ui_story == nil then
				arg_84_1.var_.characterEffect1071ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1071ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1071ui_story then
				arg_84_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1184ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1184ui_story == nil then
				arg_84_1.var_.characterEffect1184ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.2

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1184ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1184ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1184ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1184ui_story.fillRatio = var_87_9
			end

			local var_87_10 = arg_84_1.actors_["1184ui_story"].transform
			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.var_.moveOldPos1184ui_story = var_87_10.localPosition
			end

			local var_87_12 = 0.001

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_11) / var_87_12
				local var_87_14 = Vector3.New(0, 100, 0)

				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1184ui_story, var_87_14, var_87_13)

				local var_87_15 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_15.x, var_87_15.y, var_87_15.z)

				local var_87_16 = var_87_10.localEulerAngles

				var_87_16.z = 0
				var_87_16.x = 0
				var_87_10.localEulerAngles = var_87_16
			end

			if arg_84_1.time_ >= var_87_11 + var_87_12 and arg_84_1.time_ < var_87_11 + var_87_12 + arg_87_0 then
				var_87_10.localPosition = Vector3.New(0, 100, 0)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_10.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_10.localEulerAngles = var_87_18
			end

			local var_87_19 = arg_84_1.actors_["1071ui_story"].transform
			local var_87_20 = 0

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.var_.moveOldPos1071ui_story = var_87_19.localPosition
			end

			local var_87_21 = 0.001

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_21 then
				local var_87_22 = (arg_84_1.time_ - var_87_20) / var_87_21
				local var_87_23 = Vector3.New(0, -1.05, -6.2)

				var_87_19.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1071ui_story, var_87_23, var_87_22)

				local var_87_24 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_24.x, var_87_24.y, var_87_24.z)

				local var_87_25 = var_87_19.localEulerAngles

				var_87_25.z = 0
				var_87_25.x = 0
				var_87_19.localEulerAngles = var_87_25
			end

			if arg_84_1.time_ >= var_87_20 + var_87_21 and arg_84_1.time_ < var_87_20 + var_87_21 + arg_87_0 then
				var_87_19.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_87_26 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_26.x, var_87_26.y, var_87_26.z)

				local var_87_27 = var_87_19.localEulerAngles

				var_87_27.z = 0
				var_87_27.x = 0
				var_87_19.localEulerAngles = var_87_27
			end

			local var_87_28 = 0
			local var_87_29 = 0.275

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_30 = arg_84_1:FormatText(StoryNameCfg[384].name)

				arg_84_1.leftNameTxt_.text = var_87_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_31 = arg_84_1:GetWordFromCfg(120091020)
				local var_87_32 = arg_84_1:FormatText(var_87_31.content)

				arg_84_1.text_.text = var_87_32

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_33 = 11
				local var_87_34 = utf8.len(var_87_32)
				local var_87_35 = var_87_33 <= 0 and var_87_29 or var_87_29 * (var_87_34 / var_87_33)

				if var_87_35 > 0 and var_87_29 < var_87_35 then
					arg_84_1.talkMaxDuration = var_87_35

					if var_87_35 + var_87_28 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_35 + var_87_28
					end
				end

				arg_84_1.text_.text = var_87_32
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091020", "story_v_out_120091.awb") ~= 0 then
					local var_87_36 = manager.audio:GetVoiceLength("story_v_out_120091", "120091020", "story_v_out_120091.awb") / 1000

					if var_87_36 + var_87_28 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_36 + var_87_28
					end

					if var_87_31.prefab_name ~= "" and arg_84_1.actors_[var_87_31.prefab_name] ~= nil then
						local var_87_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_31.prefab_name].transform, "story_v_out_120091", "120091020", "story_v_out_120091.awb")

						arg_84_1:RecordAudio("120091020", var_87_37)
						arg_84_1:RecordAudio("120091020", var_87_37)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_120091", "120091020", "story_v_out_120091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_120091", "120091020", "story_v_out_120091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_38 = math.max(var_87_29, arg_84_1.talkMaxDuration)

			if var_87_28 <= arg_84_1.time_ and arg_84_1.time_ < var_87_28 + var_87_38 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_28) / var_87_38

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_28 + var_87_38 and arg_84_1.time_ < var_87_28 + var_87_38 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play120091021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 120091021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play120091022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1071ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1071ui_story == nil then
				arg_88_1.var_.characterEffect1071ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1071ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1071ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1071ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1071ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.225

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

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(120091021)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 9
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
	Play120091022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 120091022
		arg_92_1.duration_ = 1.23

		local var_92_0 = {
			zh = 0.999999999999,
			ja = 1.233
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
				arg_92_0:Play120091023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1071ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1071ui_story == nil then
				arg_92_1.var_.characterEffect1071ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1071ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1071ui_story then
				arg_92_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_95_4 = 0
			local var_95_5 = 0.075

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_6 = arg_92_1:FormatText(StoryNameCfg[384].name)

				arg_92_1.leftNameTxt_.text = var_95_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:GetWordFromCfg(120091022)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 3
				local var_95_10 = utf8.len(var_95_8)
				local var_95_11 = var_95_9 <= 0 and var_95_5 or var_95_5 * (var_95_10 / var_95_9)

				if var_95_11 > 0 and var_95_5 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091022", "story_v_out_120091.awb") ~= 0 then
					local var_95_12 = manager.audio:GetVoiceLength("story_v_out_120091", "120091022", "story_v_out_120091.awb") / 1000

					if var_95_12 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_4
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_out_120091", "120091022", "story_v_out_120091.awb")

						arg_92_1:RecordAudio("120091022", var_95_13)
						arg_92_1:RecordAudio("120091022", var_95_13)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_120091", "120091022", "story_v_out_120091.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_120091", "120091022", "story_v_out_120091.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_14 and arg_92_1.time_ < var_95_4 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play120091023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 120091023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play120091024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1071ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1071ui_story == nil then
				arg_96_1.var_.characterEffect1071ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1071ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1071ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1071ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1071ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.1

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(120091023)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 4
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play120091024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 120091024
		arg_100_1.duration_ = 4.9

		local var_100_0 = {
			zh = 2.766,
			ja = 4.9
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play120091025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1071ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1071ui_story == nil then
				arg_100_1.var_.characterEffect1071ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1071ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1071ui_story then
				arg_100_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_103_4 = 0
			local var_103_5 = 0.275

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_6 = arg_100_1:FormatText(StoryNameCfg[384].name)

				arg_100_1.leftNameTxt_.text = var_103_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:GetWordFromCfg(120091024)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 11
				local var_103_10 = utf8.len(var_103_8)
				local var_103_11 = var_103_9 <= 0 and var_103_5 or var_103_5 * (var_103_10 / var_103_9)

				if var_103_11 > 0 and var_103_5 < var_103_11 then
					arg_100_1.talkMaxDuration = var_103_11

					if var_103_11 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091024", "story_v_out_120091.awb") ~= 0 then
					local var_103_12 = manager.audio:GetVoiceLength("story_v_out_120091", "120091024", "story_v_out_120091.awb") / 1000

					if var_103_12 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_4
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_out_120091", "120091024", "story_v_out_120091.awb")

						arg_100_1:RecordAudio("120091024", var_103_13)
						arg_100_1:RecordAudio("120091024", var_103_13)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_120091", "120091024", "story_v_out_120091.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_120091", "120091024", "story_v_out_120091.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_14 and arg_100_1.time_ < var_103_4 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play120091025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 120091025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play120091026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1071ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1071ui_story == nil then
				arg_104_1.var_.characterEffect1071ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1071ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1071ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1071ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1071ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 1.025

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(120091025)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 41
				local var_107_11 = utf8.len(var_107_9)
				local var_107_12 = var_107_10 <= 0 and var_107_7 or var_107_7 * (var_107_11 / var_107_10)

				if var_107_12 > 0 and var_107_7 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_13 and arg_104_1.time_ < var_107_6 + var_107_13 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play120091026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 120091026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play120091027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.325

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(120091026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 13
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play120091027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 120091027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play120091028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.925

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(120091027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 37
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
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play120091028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 120091028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play120091029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.675

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(120091028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 27
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play120091029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 120091029
		arg_120_1.duration_ = 6.67

		local var_120_0 = {
			zh = 3.7,
			ja = 6.666
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
				arg_120_0:Play120091030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1184ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1184ui_story == nil then
				arg_120_1.var_.characterEffect1184ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1184ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1184ui_story then
				arg_120_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_123_4 = 0

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_123_5 = arg_120_1.actors_["1071ui_story"].transform
			local var_123_6 = 0

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.var_.moveOldPos1071ui_story = var_123_5.localPosition
			end

			local var_123_7 = 0.001

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_7 then
				local var_123_8 = (arg_120_1.time_ - var_123_6) / var_123_7
				local var_123_9 = Vector3.New(0, 100, 0)

				var_123_5.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1071ui_story, var_123_9, var_123_8)

				local var_123_10 = manager.ui.mainCamera.transform.position - var_123_5.position

				var_123_5.forward = Vector3.New(var_123_10.x, var_123_10.y, var_123_10.z)

				local var_123_11 = var_123_5.localEulerAngles

				var_123_11.z = 0
				var_123_11.x = 0
				var_123_5.localEulerAngles = var_123_11
			end

			if arg_120_1.time_ >= var_123_6 + var_123_7 and arg_120_1.time_ < var_123_6 + var_123_7 + arg_123_0 then
				var_123_5.localPosition = Vector3.New(0, 100, 0)

				local var_123_12 = manager.ui.mainCamera.transform.position - var_123_5.position

				var_123_5.forward = Vector3.New(var_123_12.x, var_123_12.y, var_123_12.z)

				local var_123_13 = var_123_5.localEulerAngles

				var_123_13.z = 0
				var_123_13.x = 0
				var_123_5.localEulerAngles = var_123_13
			end

			local var_123_14 = arg_120_1.actors_["1184ui_story"].transform
			local var_123_15 = 0

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.var_.moveOldPos1184ui_story = var_123_14.localPosition
			end

			local var_123_16 = 0.001

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_16 then
				local var_123_17 = (arg_120_1.time_ - var_123_15) / var_123_16
				local var_123_18 = Vector3.New(0, -0.97, -6)

				var_123_14.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1184ui_story, var_123_18, var_123_17)

				local var_123_19 = manager.ui.mainCamera.transform.position - var_123_14.position

				var_123_14.forward = Vector3.New(var_123_19.x, var_123_19.y, var_123_19.z)

				local var_123_20 = var_123_14.localEulerAngles

				var_123_20.z = 0
				var_123_20.x = 0
				var_123_14.localEulerAngles = var_123_20
			end

			if arg_120_1.time_ >= var_123_15 + var_123_16 and arg_120_1.time_ < var_123_15 + var_123_16 + arg_123_0 then
				var_123_14.localPosition = Vector3.New(0, -0.97, -6)

				local var_123_21 = manager.ui.mainCamera.transform.position - var_123_14.position

				var_123_14.forward = Vector3.New(var_123_21.x, var_123_21.y, var_123_21.z)

				local var_123_22 = var_123_14.localEulerAngles

				var_123_22.z = 0
				var_123_22.x = 0
				var_123_14.localEulerAngles = var_123_22
			end

			local var_123_23 = 0
			local var_123_24 = 0.375

			if var_123_23 < arg_120_1.time_ and arg_120_1.time_ <= var_123_23 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_25 = arg_120_1:FormatText(StoryNameCfg[6].name)

				arg_120_1.leftNameTxt_.text = var_123_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_26 = arg_120_1:GetWordFromCfg(120091029)
				local var_123_27 = arg_120_1:FormatText(var_123_26.content)

				arg_120_1.text_.text = var_123_27

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_28 = 15
				local var_123_29 = utf8.len(var_123_27)
				local var_123_30 = var_123_28 <= 0 and var_123_24 or var_123_24 * (var_123_29 / var_123_28)

				if var_123_30 > 0 and var_123_24 < var_123_30 then
					arg_120_1.talkMaxDuration = var_123_30

					if var_123_30 + var_123_23 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_30 + var_123_23
					end
				end

				arg_120_1.text_.text = var_123_27
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091029", "story_v_out_120091.awb") ~= 0 then
					local var_123_31 = manager.audio:GetVoiceLength("story_v_out_120091", "120091029", "story_v_out_120091.awb") / 1000

					if var_123_31 + var_123_23 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_31 + var_123_23
					end

					if var_123_26.prefab_name ~= "" and arg_120_1.actors_[var_123_26.prefab_name] ~= nil then
						local var_123_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_26.prefab_name].transform, "story_v_out_120091", "120091029", "story_v_out_120091.awb")

						arg_120_1:RecordAudio("120091029", var_123_32)
						arg_120_1:RecordAudio("120091029", var_123_32)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_120091", "120091029", "story_v_out_120091.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_120091", "120091029", "story_v_out_120091.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_33 = math.max(var_123_24, arg_120_1.talkMaxDuration)

			if var_123_23 <= arg_120_1.time_ and arg_120_1.time_ < var_123_23 + var_123_33 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_23) / var_123_33

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_23 + var_123_33 and arg_120_1.time_ < var_123_23 + var_123_33 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play120091030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 120091030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play120091031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1184ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1184ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1184ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = 0
			local var_127_10 = 0.6

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_11 = arg_124_1:GetWordFromCfg(120091030)
				local var_127_12 = arg_124_1:FormatText(var_127_11.content)

				arg_124_1.text_.text = var_127_12

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 24
				local var_127_14 = utf8.len(var_127_12)
				local var_127_15 = var_127_13 <= 0 and var_127_10 or var_127_10 * (var_127_14 / var_127_13)

				if var_127_15 > 0 and var_127_10 < var_127_15 then
					arg_124_1.talkMaxDuration = var_127_15

					if var_127_15 + var_127_9 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_15 + var_127_9
					end
				end

				arg_124_1.text_.text = var_127_12
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_10, arg_124_1.talkMaxDuration)

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_9) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_9 + var_127_16 and arg_124_1.time_ < var_127_9 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play120091031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 120091031
		arg_128_1.duration_ = 3.4

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play120091032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1071ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1071ui_story == nil then
				arg_128_1.var_.characterEffect1071ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1071ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1071ui_story then
				arg_128_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1071ui_story"].transform
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.var_.moveOldPos1071ui_story = var_131_4.localPosition
			end

			local var_131_6 = 0.001

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6
				local var_131_8 = Vector3.New(0, -1.05, -6.2)

				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1071ui_story, var_131_8, var_131_7)

				local var_131_9 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_9.x, var_131_9.y, var_131_9.z)

				local var_131_10 = var_131_4.localEulerAngles

				var_131_10.z = 0
				var_131_10.x = 0
				var_131_4.localEulerAngles = var_131_10
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_131_11 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_11.x, var_131_11.y, var_131_11.z)

				local var_131_12 = var_131_4.localEulerAngles

				var_131_12.z = 0
				var_131_12.x = 0
				var_131_4.localEulerAngles = var_131_12
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_131_14 = 0
			local var_131_15 = 0.1

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_16 = arg_128_1:FormatText(StoryNameCfg[384].name)

				arg_128_1.leftNameTxt_.text = var_131_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_17 = arg_128_1:GetWordFromCfg(120091031)
				local var_131_18 = arg_128_1:FormatText(var_131_17.content)

				arg_128_1.text_.text = var_131_18

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_19 = 4
				local var_131_20 = utf8.len(var_131_18)
				local var_131_21 = var_131_19 <= 0 and var_131_15 or var_131_15 * (var_131_20 / var_131_19)

				if var_131_21 > 0 and var_131_15 < var_131_21 then
					arg_128_1.talkMaxDuration = var_131_21

					if var_131_21 + var_131_14 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_21 + var_131_14
					end
				end

				arg_128_1.text_.text = var_131_18
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091031", "story_v_out_120091.awb") ~= 0 then
					local var_131_22 = manager.audio:GetVoiceLength("story_v_out_120091", "120091031", "story_v_out_120091.awb") / 1000

					if var_131_22 + var_131_14 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_14
					end

					if var_131_17.prefab_name ~= "" and arg_128_1.actors_[var_131_17.prefab_name] ~= nil then
						local var_131_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_17.prefab_name].transform, "story_v_out_120091", "120091031", "story_v_out_120091.awb")

						arg_128_1:RecordAudio("120091031", var_131_23)
						arg_128_1:RecordAudio("120091031", var_131_23)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_120091", "120091031", "story_v_out_120091.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_120091", "120091031", "story_v_out_120091.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_24 = math.max(var_131_15, arg_128_1.talkMaxDuration)

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_24 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_14) / var_131_24

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_14 + var_131_24 and arg_128_1.time_ < var_131_14 + var_131_24 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play120091032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 120091032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play120091033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1071ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1071ui_story == nil then
				arg_132_1.var_.characterEffect1071ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1071ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1071ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1071ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1071ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.05

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[7].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(120091032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 2
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play120091033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 120091033
		arg_136_1.duration_ = 3.27

		local var_136_0 = {
			zh = 3.266,
			ja = 2.933
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play120091034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1071ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1071ui_story == nil then
				arg_136_1.var_.characterEffect1071ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1071ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1071ui_story then
				arg_136_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_139_4 = 0
			local var_139_5 = 0.175

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_6 = arg_136_1:FormatText(StoryNameCfg[384].name)

				arg_136_1.leftNameTxt_.text = var_139_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(120091033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 7
				local var_139_10 = utf8.len(var_139_8)
				local var_139_11 = var_139_9 <= 0 and var_139_5 or var_139_5 * (var_139_10 / var_139_9)

				if var_139_11 > 0 and var_139_5 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091033", "story_v_out_120091.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_120091", "120091033", "story_v_out_120091.awb") / 1000

					if var_139_12 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_4
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_120091", "120091033", "story_v_out_120091.awb")

						arg_136_1:RecordAudio("120091033", var_139_13)
						arg_136_1:RecordAudio("120091033", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_120091", "120091033", "story_v_out_120091.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_120091", "120091033", "story_v_out_120091.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_14 and arg_136_1.time_ < var_139_4 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play120091034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 120091034
		arg_140_1.duration_ = 2.63

		local var_140_0 = {
			zh = 1.5,
			ja = 2.633
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play120091035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.15

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[384].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:GetWordFromCfg(120091034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 6
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091034", "story_v_out_120091.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_120091", "120091034", "story_v_out_120091.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_120091", "120091034", "story_v_out_120091.awb")

						arg_140_1:RecordAudio("120091034", var_143_9)
						arg_140_1:RecordAudio("120091034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_120091", "120091034", "story_v_out_120091.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_120091", "120091034", "story_v_out_120091.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play120091035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 120091035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play120091036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1071ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1071ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1071ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = manager.ui.mainCamera.transform
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.var_.shakeOldPos = var_147_9.localPosition
			end

			local var_147_11 = 0.5

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / 0.066
				local var_147_13, var_147_14 = math.modf(var_147_12)

				var_147_9.localPosition = Vector3.New(var_147_14 * 0.13, var_147_14 * 0.13, var_147_14 * 0.13) + arg_144_1.var_.shakeOldPos
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 then
				var_147_9.localPosition = arg_144_1.var_.shakeOldPos
			end

			local var_147_15 = 0

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			local var_147_16 = 0.5

			if arg_144_1.time_ >= var_147_15 + var_147_16 and arg_144_1.time_ < var_147_15 + var_147_16 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			local var_147_17 = 0
			local var_147_18 = 0.05

			if var_147_17 < arg_144_1.time_ and arg_144_1.time_ <= var_147_17 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_19 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_20 = arg_144_1:GetWordFromCfg(120091035)
				local var_147_21 = arg_144_1:FormatText(var_147_20.content)

				arg_144_1.text_.text = var_147_21

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_22 = 2
				local var_147_23 = utf8.len(var_147_21)
				local var_147_24 = var_147_22 <= 0 and var_147_18 or var_147_18 * (var_147_23 / var_147_22)

				if var_147_24 > 0 and var_147_18 < var_147_24 then
					arg_144_1.talkMaxDuration = var_147_24

					if var_147_24 + var_147_17 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_17
					end
				end

				arg_144_1.text_.text = var_147_21
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_25 = math.max(var_147_18, arg_144_1.talkMaxDuration)

			if var_147_17 <= arg_144_1.time_ and arg_144_1.time_ < var_147_17 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_17) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_17 + var_147_25 and arg_144_1.time_ < var_147_17 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play120091036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 120091036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play120091037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = manager.ui.mainCamera.transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.shakeOldPos = var_151_0.localPosition
			end

			local var_151_2 = 1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / 0.066
				local var_151_4, var_151_5 = math.modf(var_151_3)

				var_151_0.localPosition = Vector3.New(var_151_5 * 0.13, var_151_5 * 0.13, var_151_5 * 0.13) + arg_148_1.var_.shakeOldPos
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = arg_148_1.var_.shakeOldPos
			end

			local var_151_6 = 0

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_7 = 1

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_7 then
				local var_151_8 = (arg_148_1.time_ - var_151_6) / var_151_7
				local var_151_9 = Color.New(1, 1, 1)

				var_151_9.a = Mathf.Lerp(1, 0, var_151_8)
				arg_148_1.mask_.color = var_151_9
			end

			if arg_148_1.time_ >= var_151_6 + var_151_7 and arg_148_1.time_ < var_151_6 + var_151_7 + arg_151_0 then
				local var_151_10 = Color.New(1, 1, 1)
				local var_151_11 = 0

				arg_148_1.mask_.enabled = false
				var_151_10.a = var_151_11
				arg_148_1.mask_.color = var_151_10
			end

			local var_151_12 = 0
			local var_151_13 = 1

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				local var_151_14 = "play"
				local var_151_15 = "effect"

				arg_148_1:AudioAction(var_151_14, var_151_15, "se_story_120_00", "se_story_120_00_swordhit01", "")
			end

			local var_151_16 = 0
			local var_151_17 = 0.075

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_18 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_18:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_148_1.dialogCg_.alpha = arg_152_0
				end))
				var_151_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_19 = arg_148_1:GetWordFromCfg(120091036)
				local var_151_20 = arg_148_1:FormatText(var_151_19.content)

				arg_148_1.text_.text = var_151_20

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_21 = 3
				local var_151_22 = utf8.len(var_151_20)
				local var_151_23 = var_151_21 <= 0 and var_151_17 or var_151_17 * (var_151_22 / var_151_21)

				if var_151_23 > 0 and var_151_17 < var_151_23 then
					arg_148_1.talkMaxDuration = var_151_23
					var_151_16 = var_151_16 + 0.3

					if var_151_23 + var_151_16 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_16
					end
				end

				arg_148_1.text_.text = var_151_20
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_24 = var_151_16 + 0.3
			local var_151_25 = math.max(var_151_17, arg_148_1.talkMaxDuration)

			if var_151_24 <= arg_148_1.time_ and arg_148_1.time_ < var_151_24 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_24) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_24 + var_151_25 and arg_148_1.time_ < var_151_24 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play120091037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 120091037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play120091038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.875

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_2 = arg_154_1:GetWordFromCfg(120091037)
				local var_157_3 = arg_154_1:FormatText(var_157_2.content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 35
				local var_157_5 = utf8.len(var_157_3)
				local var_157_6 = var_157_4 <= 0 and var_157_1 or var_157_1 * (var_157_5 / var_157_4)

				if var_157_6 > 0 and var_157_1 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_7 and arg_154_1.time_ < var_157_0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play120091038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 120091038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play120091039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 1.025

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(120091038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 41
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play120091039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 120091039
		arg_162_1.duration_ = 3.2

		local var_162_0 = {
			zh = 2.366,
			ja = 3.2
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play120091040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = "1075ui_story"

			if arg_162_1.actors_[var_165_0] == nil then
				local var_165_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_165_1) then
					local var_165_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_162_1.stage_.transform)

					var_165_2.name = var_165_0
					var_165_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_162_1.actors_[var_165_0] = var_165_2

					local var_165_3 = var_165_2:GetComponentInChildren(typeof(CharacterEffect))

					var_165_3.enabled = true

					local var_165_4 = GameObjectTools.GetOrAddComponent(var_165_2, typeof(DynamicBoneHelper))

					if var_165_4 then
						var_165_4:EnableDynamicBone(false)
					end

					arg_162_1:ShowWeapon(var_165_3.transform, false)

					arg_162_1.var_[var_165_0 .. "Animator"] = var_165_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_162_1.var_[var_165_0 .. "Animator"].applyRootMotion = true
					arg_162_1.var_[var_165_0 .. "LipSync"] = var_165_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_165_5 = arg_162_1.actors_["1075ui_story"].transform
			local var_165_6 = 0

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.var_.moveOldPos1075ui_story = var_165_5.localPosition
			end

			local var_165_7 = 0.001

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_7 then
				local var_165_8 = (arg_162_1.time_ - var_165_6) / var_165_7
				local var_165_9 = Vector3.New(-0.7, -1.055, -6.16)

				var_165_5.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1075ui_story, var_165_9, var_165_8)

				local var_165_10 = manager.ui.mainCamera.transform.position - var_165_5.position

				var_165_5.forward = Vector3.New(var_165_10.x, var_165_10.y, var_165_10.z)

				local var_165_11 = var_165_5.localEulerAngles

				var_165_11.z = 0
				var_165_11.x = 0
				var_165_5.localEulerAngles = var_165_11
			end

			if arg_162_1.time_ >= var_165_6 + var_165_7 and arg_162_1.time_ < var_165_6 + var_165_7 + arg_165_0 then
				var_165_5.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_165_12 = manager.ui.mainCamera.transform.position - var_165_5.position

				var_165_5.forward = Vector3.New(var_165_12.x, var_165_12.y, var_165_12.z)

				local var_165_13 = var_165_5.localEulerAngles

				var_165_13.z = 0
				var_165_13.x = 0
				var_165_5.localEulerAngles = var_165_13
			end

			local var_165_14 = arg_162_1.actors_["1071ui_story"].transform
			local var_165_15 = 0

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.var_.moveOldPos1071ui_story = var_165_14.localPosition
			end

			local var_165_16 = 0.001

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_16 then
				local var_165_17 = (arg_162_1.time_ - var_165_15) / var_165_16
				local var_165_18 = Vector3.New(0.7, -1.05, -6.2)

				var_165_14.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1071ui_story, var_165_18, var_165_17)

				local var_165_19 = manager.ui.mainCamera.transform.position - var_165_14.position

				var_165_14.forward = Vector3.New(var_165_19.x, var_165_19.y, var_165_19.z)

				local var_165_20 = var_165_14.localEulerAngles

				var_165_20.z = 0
				var_165_20.x = 0
				var_165_14.localEulerAngles = var_165_20
			end

			if arg_162_1.time_ >= var_165_15 + var_165_16 and arg_162_1.time_ < var_165_15 + var_165_16 + arg_165_0 then
				var_165_14.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_165_21 = manager.ui.mainCamera.transform.position - var_165_14.position

				var_165_14.forward = Vector3.New(var_165_21.x, var_165_21.y, var_165_21.z)

				local var_165_22 = var_165_14.localEulerAngles

				var_165_22.z = 0
				var_165_22.x = 0
				var_165_14.localEulerAngles = var_165_22
			end

			local var_165_23 = arg_162_1.actors_["1075ui_story"]
			local var_165_24 = 0

			if var_165_24 < arg_162_1.time_ and arg_162_1.time_ <= var_165_24 + arg_165_0 and not isNil(var_165_23) and arg_162_1.var_.characterEffect1075ui_story == nil then
				arg_162_1.var_.characterEffect1075ui_story = var_165_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_25 = 0.2

			if var_165_24 <= arg_162_1.time_ and arg_162_1.time_ < var_165_24 + var_165_25 and not isNil(var_165_23) then
				local var_165_26 = (arg_162_1.time_ - var_165_24) / var_165_25

				if arg_162_1.var_.characterEffect1075ui_story and not isNil(var_165_23) then
					arg_162_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_24 + var_165_25 and arg_162_1.time_ < var_165_24 + var_165_25 + arg_165_0 and not isNil(var_165_23) and arg_162_1.var_.characterEffect1075ui_story then
				arg_162_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_165_27 = 0

			if var_165_27 < arg_162_1.time_ and arg_162_1.time_ <= var_165_27 + arg_165_0 then
				arg_162_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_165_28 = 0

			if var_165_28 < arg_162_1.time_ and arg_162_1.time_ <= var_165_28 + arg_165_0 then
				arg_162_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_165_29 = arg_162_1.actors_["1071ui_story"]
			local var_165_30 = 0

			if var_165_30 < arg_162_1.time_ and arg_162_1.time_ <= var_165_30 + arg_165_0 and not isNil(var_165_29) and arg_162_1.var_.characterEffect1071ui_story == nil then
				arg_162_1.var_.characterEffect1071ui_story = var_165_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_31 = 0.0166666666666667

			if var_165_30 <= arg_162_1.time_ and arg_162_1.time_ < var_165_30 + var_165_31 and not isNil(var_165_29) then
				local var_165_32 = (arg_162_1.time_ - var_165_30) / var_165_31

				if arg_162_1.var_.characterEffect1071ui_story and not isNil(var_165_29) then
					local var_165_33 = Mathf.Lerp(0, 0.5, var_165_32)

					arg_162_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1071ui_story.fillRatio = var_165_33
				end
			end

			if arg_162_1.time_ >= var_165_30 + var_165_31 and arg_162_1.time_ < var_165_30 + var_165_31 + arg_165_0 and not isNil(var_165_29) and arg_162_1.var_.characterEffect1071ui_story then
				local var_165_34 = 0.5

				arg_162_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1071ui_story.fillRatio = var_165_34
			end

			local var_165_35 = 0
			local var_165_36 = 0.275

			if var_165_35 < arg_162_1.time_ and arg_162_1.time_ <= var_165_35 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_37 = arg_162_1:FormatText(StoryNameCfg[381].name)

				arg_162_1.leftNameTxt_.text = var_165_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_38 = arg_162_1:GetWordFromCfg(120091039)
				local var_165_39 = arg_162_1:FormatText(var_165_38.content)

				arg_162_1.text_.text = var_165_39

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_40 = 11
				local var_165_41 = utf8.len(var_165_39)
				local var_165_42 = var_165_40 <= 0 and var_165_36 or var_165_36 * (var_165_41 / var_165_40)

				if var_165_42 > 0 and var_165_36 < var_165_42 then
					arg_162_1.talkMaxDuration = var_165_42

					if var_165_42 + var_165_35 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_42 + var_165_35
					end
				end

				arg_162_1.text_.text = var_165_39
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091039", "story_v_out_120091.awb") ~= 0 then
					local var_165_43 = manager.audio:GetVoiceLength("story_v_out_120091", "120091039", "story_v_out_120091.awb") / 1000

					if var_165_43 + var_165_35 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_43 + var_165_35
					end

					if var_165_38.prefab_name ~= "" and arg_162_1.actors_[var_165_38.prefab_name] ~= nil then
						local var_165_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_38.prefab_name].transform, "story_v_out_120091", "120091039", "story_v_out_120091.awb")

						arg_162_1:RecordAudio("120091039", var_165_44)
						arg_162_1:RecordAudio("120091039", var_165_44)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_120091", "120091039", "story_v_out_120091.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_120091", "120091039", "story_v_out_120091.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_45 = math.max(var_165_36, arg_162_1.talkMaxDuration)

			if var_165_35 <= arg_162_1.time_ and arg_162_1.time_ < var_165_35 + var_165_45 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_35) / var_165_45

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_35 + var_165_45 and arg_162_1.time_ < var_165_35 + var_165_45 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play120091040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 120091040
		arg_166_1.duration_ = 4.33

		local var_166_0 = {
			zh = 4.066,
			ja = 4.333
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play120091041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1071ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1071ui_story == nil then
				arg_166_1.var_.characterEffect1071ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1071ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1071ui_story then
				arg_166_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_169_4 = arg_166_1.actors_["1075ui_story"]
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1075ui_story == nil then
				arg_166_1.var_.characterEffect1075ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.2

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 and not isNil(var_169_4) then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6

				if arg_166_1.var_.characterEffect1075ui_story and not isNil(var_169_4) then
					local var_169_8 = Mathf.Lerp(0, 0.5, var_169_7)

					arg_166_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1075ui_story.fillRatio = var_169_8
				end
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1075ui_story then
				local var_169_9 = 0.5

				arg_166_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1075ui_story.fillRatio = var_169_9
			end

			local var_169_10 = 0
			local var_169_11 = 0.4

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_12 = arg_166_1:FormatText(StoryNameCfg[384].name)

				arg_166_1.leftNameTxt_.text = var_169_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_13 = arg_166_1:GetWordFromCfg(120091040)
				local var_169_14 = arg_166_1:FormatText(var_169_13.content)

				arg_166_1.text_.text = var_169_14

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 16
				local var_169_16 = utf8.len(var_169_14)
				local var_169_17 = var_169_15 <= 0 and var_169_11 or var_169_11 * (var_169_16 / var_169_15)

				if var_169_17 > 0 and var_169_11 < var_169_17 then
					arg_166_1.talkMaxDuration = var_169_17

					if var_169_17 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_17 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_14
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091040", "story_v_out_120091.awb") ~= 0 then
					local var_169_18 = manager.audio:GetVoiceLength("story_v_out_120091", "120091040", "story_v_out_120091.awb") / 1000

					if var_169_18 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_18 + var_169_10
					end

					if var_169_13.prefab_name ~= "" and arg_166_1.actors_[var_169_13.prefab_name] ~= nil then
						local var_169_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_13.prefab_name].transform, "story_v_out_120091", "120091040", "story_v_out_120091.awb")

						arg_166_1:RecordAudio("120091040", var_169_19)
						arg_166_1:RecordAudio("120091040", var_169_19)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_120091", "120091040", "story_v_out_120091.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_120091", "120091040", "story_v_out_120091.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_20 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_20 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_10) / var_169_20

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_10 + var_169_20 and arg_166_1.time_ < var_169_10 + var_169_20 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play120091041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 120091041
		arg_170_1.duration_ = 7.33

		local var_170_0 = {
			zh = 7.333,
			ja = 6.833
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play120091042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1071ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1071ui_story == nil then
				arg_170_1.var_.characterEffect1071ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect1071ui_story and not isNil(var_173_0) then
					local var_173_4 = Mathf.Lerp(0, 0.5, var_173_3)

					arg_170_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1071ui_story.fillRatio = var_173_4
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1071ui_story then
				local var_173_5 = 0.5

				arg_170_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1071ui_story.fillRatio = var_173_5
			end

			local var_173_6 = arg_170_1.actors_["1075ui_story"]
			local var_173_7 = 0

			if var_173_7 < arg_170_1.time_ and arg_170_1.time_ <= var_173_7 + arg_173_0 and not isNil(var_173_6) and arg_170_1.var_.characterEffect1075ui_story == nil then
				arg_170_1.var_.characterEffect1075ui_story = var_173_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_8 = 0.2

			if var_173_7 <= arg_170_1.time_ and arg_170_1.time_ < var_173_7 + var_173_8 and not isNil(var_173_6) then
				local var_173_9 = (arg_170_1.time_ - var_173_7) / var_173_8

				if arg_170_1.var_.characterEffect1075ui_story and not isNil(var_173_6) then
					arg_170_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_7 + var_173_8 and arg_170_1.time_ < var_173_7 + var_173_8 + arg_173_0 and not isNil(var_173_6) and arg_170_1.var_.characterEffect1075ui_story then
				arg_170_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 then
				arg_170_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_173_11 = 0

			if var_173_11 < arg_170_1.time_ and arg_170_1.time_ <= var_173_11 + arg_173_0 then
				arg_170_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_173_12 = 0
			local var_173_13 = 0.8

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_14 = arg_170_1:FormatText(StoryNameCfg[381].name)

				arg_170_1.leftNameTxt_.text = var_173_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_15 = arg_170_1:GetWordFromCfg(120091041)
				local var_173_16 = arg_170_1:FormatText(var_173_15.content)

				arg_170_1.text_.text = var_173_16

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_17 = 32
				local var_173_18 = utf8.len(var_173_16)
				local var_173_19 = var_173_17 <= 0 and var_173_13 or var_173_13 * (var_173_18 / var_173_17)

				if var_173_19 > 0 and var_173_13 < var_173_19 then
					arg_170_1.talkMaxDuration = var_173_19

					if var_173_19 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_19 + var_173_12
					end
				end

				arg_170_1.text_.text = var_173_16
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091041", "story_v_out_120091.awb") ~= 0 then
					local var_173_20 = manager.audio:GetVoiceLength("story_v_out_120091", "120091041", "story_v_out_120091.awb") / 1000

					if var_173_20 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_20 + var_173_12
					end

					if var_173_15.prefab_name ~= "" and arg_170_1.actors_[var_173_15.prefab_name] ~= nil then
						local var_173_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_15.prefab_name].transform, "story_v_out_120091", "120091041", "story_v_out_120091.awb")

						arg_170_1:RecordAudio("120091041", var_173_21)
						arg_170_1:RecordAudio("120091041", var_173_21)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_120091", "120091041", "story_v_out_120091.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_120091", "120091041", "story_v_out_120091.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_22 = math.max(var_173_13, arg_170_1.talkMaxDuration)

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_22 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_12) / var_173_22

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_12 + var_173_22 and arg_170_1.time_ < var_173_12 + var_173_22 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play120091042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 120091042
		arg_174_1.duration_ = 2.83

		local var_174_0 = {
			zh = 1.333,
			ja = 2.833
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play120091043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1071ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1071ui_story == nil then
				arg_174_1.var_.characterEffect1071ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1071ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1071ui_story then
				arg_174_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_177_4 = arg_174_1.actors_["1075ui_story"]
			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect1075ui_story == nil then
				arg_174_1.var_.characterEffect1075ui_story = var_177_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.2

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 and not isNil(var_177_4) then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6

				if arg_174_1.var_.characterEffect1075ui_story and not isNil(var_177_4) then
					local var_177_8 = Mathf.Lerp(0, 0.5, var_177_7)

					arg_174_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1075ui_story.fillRatio = var_177_8
				end
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 and not isNil(var_177_4) and arg_174_1.var_.characterEffect1075ui_story then
				local var_177_9 = 0.5

				arg_174_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1075ui_story.fillRatio = var_177_9
			end

			local var_177_10 = 0
			local var_177_11 = 0.075

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_12 = arg_174_1:FormatText(StoryNameCfg[384].name)

				arg_174_1.leftNameTxt_.text = var_177_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_13 = arg_174_1:GetWordFromCfg(120091042)
				local var_177_14 = arg_174_1:FormatText(var_177_13.content)

				arg_174_1.text_.text = var_177_14

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_15 = 3
				local var_177_16 = utf8.len(var_177_14)
				local var_177_17 = var_177_15 <= 0 and var_177_11 or var_177_11 * (var_177_16 / var_177_15)

				if var_177_17 > 0 and var_177_11 < var_177_17 then
					arg_174_1.talkMaxDuration = var_177_17

					if var_177_17 + var_177_10 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_17 + var_177_10
					end
				end

				arg_174_1.text_.text = var_177_14
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091042", "story_v_out_120091.awb") ~= 0 then
					local var_177_18 = manager.audio:GetVoiceLength("story_v_out_120091", "120091042", "story_v_out_120091.awb") / 1000

					if var_177_18 + var_177_10 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_18 + var_177_10
					end

					if var_177_13.prefab_name ~= "" and arg_174_1.actors_[var_177_13.prefab_name] ~= nil then
						local var_177_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_13.prefab_name].transform, "story_v_out_120091", "120091042", "story_v_out_120091.awb")

						arg_174_1:RecordAudio("120091042", var_177_19)
						arg_174_1:RecordAudio("120091042", var_177_19)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_120091", "120091042", "story_v_out_120091.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_120091", "120091042", "story_v_out_120091.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_20 = math.max(var_177_11, arg_174_1.talkMaxDuration)

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_20 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_10) / var_177_20

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_10 + var_177_20 and arg_174_1.time_ < var_177_10 + var_177_20 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play120091043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 120091043
		arg_178_1.duration_ = 10.97

		local var_178_0 = {
			zh = 8.3,
			ja = 10.966
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play120091044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.95

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[384].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(120091043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 38
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091043", "story_v_out_120091.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_120091", "120091043", "story_v_out_120091.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_120091", "120091043", "story_v_out_120091.awb")

						arg_178_1:RecordAudio("120091043", var_181_9)
						arg_178_1:RecordAudio("120091043", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_120091", "120091043", "story_v_out_120091.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_120091", "120091043", "story_v_out_120091.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play120091044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 120091044
		arg_182_1.duration_ = 7.1

		local var_182_0 = {
			zh = 7.1,
			ja = 5.3
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play120091045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.65

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[384].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:GetWordFromCfg(120091044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 26
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091044", "story_v_out_120091.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_120091", "120091044", "story_v_out_120091.awb") / 1000

					if var_185_8 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_0
					end

					if var_185_3.prefab_name ~= "" and arg_182_1.actors_[var_185_3.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_3.prefab_name].transform, "story_v_out_120091", "120091044", "story_v_out_120091.awb")

						arg_182_1:RecordAudio("120091044", var_185_9)
						arg_182_1:RecordAudio("120091044", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_120091", "120091044", "story_v_out_120091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_120091", "120091044", "story_v_out_120091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_10 and arg_182_1.time_ < var_185_0 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play120091045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 120091045
		arg_186_1.duration_ = 7.13

		local var_186_0 = {
			zh = 7.133,
			ja = 6.666
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play120091046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1071ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1071ui_story == nil then
				arg_186_1.var_.characterEffect1071ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1071ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1071ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1071ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1071ui_story.fillRatio = var_189_5
			end

			local var_189_6 = arg_186_1.actors_["1075ui_story"]
			local var_189_7 = 0

			if var_189_7 < arg_186_1.time_ and arg_186_1.time_ <= var_189_7 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect1075ui_story == nil then
				arg_186_1.var_.characterEffect1075ui_story = var_189_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_8 = 0.2

			if var_189_7 <= arg_186_1.time_ and arg_186_1.time_ < var_189_7 + var_189_8 and not isNil(var_189_6) then
				local var_189_9 = (arg_186_1.time_ - var_189_7) / var_189_8

				if arg_186_1.var_.characterEffect1075ui_story and not isNil(var_189_6) then
					arg_186_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_7 + var_189_8 and arg_186_1.time_ < var_189_7 + var_189_8 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect1075ui_story then
				arg_186_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_189_11 = 0
			local var_189_12 = 0.925

			if var_189_11 < arg_186_1.time_ and arg_186_1.time_ <= var_189_11 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_13 = arg_186_1:FormatText(StoryNameCfg[381].name)

				arg_186_1.leftNameTxt_.text = var_189_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_14 = arg_186_1:GetWordFromCfg(120091045)
				local var_189_15 = arg_186_1:FormatText(var_189_14.content)

				arg_186_1.text_.text = var_189_15

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_16 = 37
				local var_189_17 = utf8.len(var_189_15)
				local var_189_18 = var_189_16 <= 0 and var_189_12 or var_189_12 * (var_189_17 / var_189_16)

				if var_189_18 > 0 and var_189_12 < var_189_18 then
					arg_186_1.talkMaxDuration = var_189_18

					if var_189_18 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_11
					end
				end

				arg_186_1.text_.text = var_189_15
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091045", "story_v_out_120091.awb") ~= 0 then
					local var_189_19 = manager.audio:GetVoiceLength("story_v_out_120091", "120091045", "story_v_out_120091.awb") / 1000

					if var_189_19 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_11
					end

					if var_189_14.prefab_name ~= "" and arg_186_1.actors_[var_189_14.prefab_name] ~= nil then
						local var_189_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_14.prefab_name].transform, "story_v_out_120091", "120091045", "story_v_out_120091.awb")

						arg_186_1:RecordAudio("120091045", var_189_20)
						arg_186_1:RecordAudio("120091045", var_189_20)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_120091", "120091045", "story_v_out_120091.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_120091", "120091045", "story_v_out_120091.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_12, arg_186_1.talkMaxDuration)

			if var_189_11 <= arg_186_1.time_ and arg_186_1.time_ < var_189_11 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_11) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_11 + var_189_21 and arg_186_1.time_ < var_189_11 + var_189_21 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play120091046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 120091046
		arg_190_1.duration_ = 4.87

		local var_190_0 = {
			zh = 3.933,
			ja = 4.866
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play120091047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1071ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1071ui_story == nil then
				arg_190_1.var_.characterEffect1071ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1071ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1071ui_story then
				arg_190_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_193_4 = arg_190_1.actors_["1075ui_story"]
			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1075ui_story == nil then
				arg_190_1.var_.characterEffect1075ui_story = var_193_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_6 = 0.2

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 and not isNil(var_193_4) then
				local var_193_7 = (arg_190_1.time_ - var_193_5) / var_193_6

				if arg_190_1.var_.characterEffect1075ui_story and not isNil(var_193_4) then
					local var_193_8 = Mathf.Lerp(0, 0.5, var_193_7)

					arg_190_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1075ui_story.fillRatio = var_193_8
				end
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 and not isNil(var_193_4) and arg_190_1.var_.characterEffect1075ui_story then
				local var_193_9 = 0.5

				arg_190_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1075ui_story.fillRatio = var_193_9
			end

			local var_193_10 = 0
			local var_193_11 = 0.4

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_12 = arg_190_1:FormatText(StoryNameCfg[384].name)

				arg_190_1.leftNameTxt_.text = var_193_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_13 = arg_190_1:GetWordFromCfg(120091046)
				local var_193_14 = arg_190_1:FormatText(var_193_13.content)

				arg_190_1.text_.text = var_193_14

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_15 = 16
				local var_193_16 = utf8.len(var_193_14)
				local var_193_17 = var_193_15 <= 0 and var_193_11 or var_193_11 * (var_193_16 / var_193_15)

				if var_193_17 > 0 and var_193_11 < var_193_17 then
					arg_190_1.talkMaxDuration = var_193_17

					if var_193_17 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_17 + var_193_10
					end
				end

				arg_190_1.text_.text = var_193_14
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091046", "story_v_out_120091.awb") ~= 0 then
					local var_193_18 = manager.audio:GetVoiceLength("story_v_out_120091", "120091046", "story_v_out_120091.awb") / 1000

					if var_193_18 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_10
					end

					if var_193_13.prefab_name ~= "" and arg_190_1.actors_[var_193_13.prefab_name] ~= nil then
						local var_193_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_13.prefab_name].transform, "story_v_out_120091", "120091046", "story_v_out_120091.awb")

						arg_190_1:RecordAudio("120091046", var_193_19)
						arg_190_1:RecordAudio("120091046", var_193_19)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_120091", "120091046", "story_v_out_120091.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_120091", "120091046", "story_v_out_120091.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_20 = math.max(var_193_11, arg_190_1.talkMaxDuration)

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_20 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_10) / var_193_20

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_10 + var_193_20 and arg_190_1.time_ < var_193_10 + var_193_20 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play120091047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 120091047
		arg_194_1.duration_ = 4.3

		local var_194_0 = {
			zh = 1.999999999999,
			ja = 4.3
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play120091048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1071ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1071ui_story == nil then
				arg_194_1.var_.characterEffect1071ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1071ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1071ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1071ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1071ui_story.fillRatio = var_197_5
			end

			local var_197_6 = arg_194_1.actors_["1075ui_story"]
			local var_197_7 = 0

			if var_197_7 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1075ui_story == nil then
				arg_194_1.var_.characterEffect1075ui_story = var_197_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_8 = 0.2

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_8 and not isNil(var_197_6) then
				local var_197_9 = (arg_194_1.time_ - var_197_7) / var_197_8

				if arg_194_1.var_.characterEffect1075ui_story and not isNil(var_197_6) then
					arg_194_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_7 + var_197_8 and arg_194_1.time_ < var_197_7 + var_197_8 + arg_197_0 and not isNil(var_197_6) and arg_194_1.var_.characterEffect1075ui_story then
				arg_194_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 then
				arg_194_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_197_11 = 0
			local var_197_12 = 0.225

			if var_197_11 < arg_194_1.time_ and arg_194_1.time_ <= var_197_11 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_13 = arg_194_1:FormatText(StoryNameCfg[381].name)

				arg_194_1.leftNameTxt_.text = var_197_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_14 = arg_194_1:GetWordFromCfg(120091047)
				local var_197_15 = arg_194_1:FormatText(var_197_14.content)

				arg_194_1.text_.text = var_197_15

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_16 = 9
				local var_197_17 = utf8.len(var_197_15)
				local var_197_18 = var_197_16 <= 0 and var_197_12 or var_197_12 * (var_197_17 / var_197_16)

				if var_197_18 > 0 and var_197_12 < var_197_18 then
					arg_194_1.talkMaxDuration = var_197_18

					if var_197_18 + var_197_11 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_18 + var_197_11
					end
				end

				arg_194_1.text_.text = var_197_15
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091047", "story_v_out_120091.awb") ~= 0 then
					local var_197_19 = manager.audio:GetVoiceLength("story_v_out_120091", "120091047", "story_v_out_120091.awb") / 1000

					if var_197_19 + var_197_11 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_19 + var_197_11
					end

					if var_197_14.prefab_name ~= "" and arg_194_1.actors_[var_197_14.prefab_name] ~= nil then
						local var_197_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_14.prefab_name].transform, "story_v_out_120091", "120091047", "story_v_out_120091.awb")

						arg_194_1:RecordAudio("120091047", var_197_20)
						arg_194_1:RecordAudio("120091047", var_197_20)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_120091", "120091047", "story_v_out_120091.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_120091", "120091047", "story_v_out_120091.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_21 = math.max(var_197_12, arg_194_1.talkMaxDuration)

			if var_197_11 <= arg_194_1.time_ and arg_194_1.time_ < var_197_11 + var_197_21 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_11) / var_197_21

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_11 + var_197_21 and arg_194_1.time_ < var_197_11 + var_197_21 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play120091048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 120091048
		arg_198_1.duration_ = 5.27

		local var_198_0 = {
			zh = 5.266,
			ja = 5.066
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play120091049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1071ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1071ui_story == nil then
				arg_198_1.var_.characterEffect1071ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1071ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1071ui_story then
				arg_198_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_201_4 = arg_198_1.actors_["1075ui_story"]
			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 and not isNil(var_201_4) and arg_198_1.var_.characterEffect1075ui_story == nil then
				arg_198_1.var_.characterEffect1075ui_story = var_201_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_6 = 0.2

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 and not isNil(var_201_4) then
				local var_201_7 = (arg_198_1.time_ - var_201_5) / var_201_6

				if arg_198_1.var_.characterEffect1075ui_story and not isNil(var_201_4) then
					local var_201_8 = Mathf.Lerp(0, 0.5, var_201_7)

					arg_198_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1075ui_story.fillRatio = var_201_8
				end
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 and not isNil(var_201_4) and arg_198_1.var_.characterEffect1075ui_story then
				local var_201_9 = 0.5

				arg_198_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1075ui_story.fillRatio = var_201_9
			end

			local var_201_10 = 0
			local var_201_11 = 0.6

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_12 = arg_198_1:FormatText(StoryNameCfg[384].name)

				arg_198_1.leftNameTxt_.text = var_201_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_13 = arg_198_1:GetWordFromCfg(120091048)
				local var_201_14 = arg_198_1:FormatText(var_201_13.content)

				arg_198_1.text_.text = var_201_14

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_15 = 24
				local var_201_16 = utf8.len(var_201_14)
				local var_201_17 = var_201_15 <= 0 and var_201_11 or var_201_11 * (var_201_16 / var_201_15)

				if var_201_17 > 0 and var_201_11 < var_201_17 then
					arg_198_1.talkMaxDuration = var_201_17

					if var_201_17 + var_201_10 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_17 + var_201_10
					end
				end

				arg_198_1.text_.text = var_201_14
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091048", "story_v_out_120091.awb") ~= 0 then
					local var_201_18 = manager.audio:GetVoiceLength("story_v_out_120091", "120091048", "story_v_out_120091.awb") / 1000

					if var_201_18 + var_201_10 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_18 + var_201_10
					end

					if var_201_13.prefab_name ~= "" and arg_198_1.actors_[var_201_13.prefab_name] ~= nil then
						local var_201_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_13.prefab_name].transform, "story_v_out_120091", "120091048", "story_v_out_120091.awb")

						arg_198_1:RecordAudio("120091048", var_201_19)
						arg_198_1:RecordAudio("120091048", var_201_19)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_120091", "120091048", "story_v_out_120091.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_120091", "120091048", "story_v_out_120091.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_20 = math.max(var_201_11, arg_198_1.talkMaxDuration)

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_20 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_10) / var_201_20

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_10 + var_201_20 and arg_198_1.time_ < var_201_10 + var_201_20 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play120091049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 120091049
		arg_202_1.duration_ = 6.83

		local var_202_0 = {
			zh = 4.8,
			ja = 6.833
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play120091050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.65

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[384].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:GetWordFromCfg(120091049)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 26
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091049", "story_v_out_120091.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_120091", "120091049", "story_v_out_120091.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_120091", "120091049", "story_v_out_120091.awb")

						arg_202_1:RecordAudio("120091049", var_205_9)
						arg_202_1:RecordAudio("120091049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_120091", "120091049", "story_v_out_120091.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_120091", "120091049", "story_v_out_120091.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play120091050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 120091050
		arg_206_1.duration_ = 11.7

		local var_206_0 = {
			zh = 9,
			ja = 11.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
			arg_206_1.auto_ = false
		end

		function arg_206_1.playNext_(arg_208_0)
			arg_206_1.onStoryFinished_()
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_209_1 = 0
			local var_209_2 = 0.85

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_3 = arg_206_1:FormatText(StoryNameCfg[384].name)

				arg_206_1.leftNameTxt_.text = var_209_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(120091050)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_6 = 34
				local var_209_7 = utf8.len(var_209_5)
				local var_209_8 = var_209_6 <= 0 and var_209_2 or var_209_2 * (var_209_7 / var_209_6)

				if var_209_8 > 0 and var_209_2 < var_209_8 then
					arg_206_1.talkMaxDuration = var_209_8

					if var_209_8 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120091", "120091050", "story_v_out_120091.awb") ~= 0 then
					local var_209_9 = manager.audio:GetVoiceLength("story_v_out_120091", "120091050", "story_v_out_120091.awb") / 1000

					if var_209_9 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_1
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_out_120091", "120091050", "story_v_out_120091.awb")

						arg_206_1:RecordAudio("120091050", var_209_10)
						arg_206_1:RecordAudio("120091050", var_209_10)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_120091", "120091050", "story_v_out_120091.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_120091", "120091050", "story_v_out_120091.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_11 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_11 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_11

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_11 and arg_206_1.time_ < var_209_1 + var_209_11 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J13f"
	},
	voices = {
		"story_v_out_120091.awb"
	}
}
